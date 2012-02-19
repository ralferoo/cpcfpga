-- cpc emulator
--
-- crtc

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity crtc is port(
	nRESET			: in	std_logic;
	--LPSTB
	MA			: out	std_logic_vector(13 downto 0);
	DE			: out	std_logic;
	--CURSOR
	CLK			: in	std_logic;				-- CCLK (1mhz from gate array)
	RW			: in	std_logic;				-- A9
	E			: in	std_logic;				-- IORD' nor IOWR'
	RS			: in	std_logic;				-- A8
	nCS			: in	std_logic;				-- A14
	DIN			: in	std_logic_vector(7 downto 0);
	DOUT			: out	std_logic_vector(7 downto 0);		-- D conflated to DIN and DOUT

	RA			: out	std_logic_vector(3 downto 0);
	HSYNC, VSYNC		: out	std_logic);
end crtc;

architecture impl of crtc is
	
	signal	r_htotal			: std_logic_vector(7 downto 0);		-- r0
	signal	r_hdisp				: std_logic_vector(7 downto 0);		-- r1
	signal	r_hsyncpos			: std_logic_vector(7 downto 0);		-- r2
	signal	r_hsyncwidth			: std_logic_vector(3 downto 0);		-- r3
-- vsyncwidth on later crtcs?

	signal	r_vtotal			: std_logic_vector(6 downto 0);		-- r4
	signal	r_vtotaladjust			: std_logic_vector(4 downto 0);		-- r5
	signal	r_vdisp				: std_logic_vector(6 downto 0);		-- r6
	signal	r_vsyncpos			: std_logic_vector(6 downto 0);		-- r7
	--interlacemode									-- r8

	signal	r_maxscanlinecount		: std_logic_vector(4 downto 0);		-- r9
	--cursorstart,cursorend								-- r10,r11

	signal	r_startaddress_h		: std_logic_vector(5 downto 0);		-- r12 
	signal	r_startaddress_l		: std_logic_vector(7 downto 0);		-- r13 
	--cursor_h/l, lightpen_h/l							-- r14/r15, r16/r17

begin
	-- this process deals with the CPU side of things, clocked on E just because there's no point trying to do it
	-- on a mclk boundary as that's the pixel clock not CPU clock and no point introducing the CPU clock to the
	-- model as the data bus is guaranteed to be fine with E goes high
	process(nRESET, E, RW, RS, nCS,DIN)
		variable	sel_register	: std_logic_vector(4 downto 0);
		variable	outvalue	: std_logic_vector(7 downto 0);
	begin
		if nRESET='0' then
			-- these initial values from default CPC config
			r_htotal		<= x"3f";	-- r0
			r_hdisp			<= x"28";	-- r1
			r_hsyncpos		<= x"2e";	-- r2
			r_hsyncwidth		<= x"e";	-- r3

			r_vtotal		<= "0100110";	-- r4
			r_vtotaladjust		<= "00000";	-- r5
			r_vdisp			<= "0011001";	-- r6
			r_vsyncpos		<= "0011110";	-- r7

			r_maxscanlinecount	<= "00111";	-- r9

			r_startaddress_h	<= "110000";	-- r12		-- start reading from #c000
			r_startaddress_l	<= x"00";	-- r13

			DOUT 			<= (others=>'0');

			sel_register		:= (others=>'0');

		elsif rising_edge(E) then				-- even though we want to falling edge of IORQ, E is positive enable

			if nCS='0' and RW='1' then			-- A14/A8
				outvalue := (others=>'0');
				if RS='1' then				-- RS='0' (A9) (BE00) means read status register which isn't implemented
									-- RS='1' (A9) (BF00) means read register
									-- 6845 datasheet defines r12-r17 as readable, only r12-r13 make sense
					case sel_register is
						when "01100" => outvalue(5 downto 0)	:= r_startaddress_h;
						when "01101" => outvalue	 	:= r_startaddress_l;
						when others  =>
					end case;
				end if;
				DOUT <= outvalue;

			elsif nCS='0' and RW='0' then			-- A14/A8
				if RS='0' then				-- RS='0' (A9) (BC00) means set register
					sel_register := DIN(4 downto 0);
				else
					case sel_register is
						when "00000" => r_htotal		<= DIN(7 downto 0);	-- r0
						when "00001" => r_hdisp			<= DIN(7 downto 0);	-- r1
						when "00010" => r_hsyncpos		<= DIN(7 downto 0);	-- r2
						when "00011" => r_hsyncwidth		<= DIN(3 downto 0);	-- r3

						when "00100" => r_vtotal		<= DIN(6 downto 0);	-- r4
						when "00101" => r_vtotaladjust		<= DIN(4 downto 0);	-- r5
						when "00110" => r_vdisp			<= DIN(6 downto 0);	-- r6
						when "00111" => r_vsyncpos		<= DIN(6 downto 0);	-- r7

						when "01001" => r_maxscanlinecount	<= DIN(4 downto 0);	-- r9

						when "01100" => r_startaddress_h	<= DIN(5 downto 0);	-- r12
						when "01101" => r_startaddress_l	<= DIN(7 downto 0);	-- r13
						when others  =>
					end case;
				end if;
			end if;
		end if;
	end process;

	-- this process is clocked on the pixel clock...
	process(nRESET, CLK, r_startaddress_h, r_startaddress_l)
		variable	v_hpos		: std_logic_vector(7 downto 0);		-- current char
		variable	v_hdisp		: std_logic;				-- display enabled (horizontally)
		variable	v_hsynccount	: std_logic_vector(3 downto 0);		-- counter before we turn off hsync
		variable	v_hsync		: std_logic;				-- is the hsync enabled currently

		variable	v_vpos		: std_logic_vector(6 downto 0);		-- current character line
		variable	v_vdisp		: std_logic;				-- display enabled (vertically)

		variable	v_rpos		: std_logic_vector(3 downto 0);		-- current row within a character

		variable	v_ma		: std_logic_vector(13 downto 0);	-- current MA address
		variable	v_ma_this_line	: std_logic_vector(13 downto 0);	-- MA address for the beginning of this line

		variable	v_vsynccount	: std_logic_vector(3 downto 0);		-- counter before we turn off vsync
		variable	v_vsync		: std_logic;				-- is the vsync enabled currently

		variable	v_inadjust	: std_logic;				-- in adjustment row

		--- copy of the above, but for next value
		variable	n_hpos		: std_logic_vector(7 downto 0);		-- current char
		variable	n_hdisp		: std_logic;				-- display enabled (horizontally)
		variable	n_vpos		: std_logic_vector(6 downto 0);		-- current character line
		variable	n_vdisp		: std_logic;				-- display enabled (vertically)
		variable	n_rpos		: std_logic_vector(3 downto 0);		-- current row within a character
		variable	n_ma		: std_logic_vector(13 downto 0);	-- current MA address
		variable	n_ma_this_line	: std_logic_vector(13 downto 0);	-- MA address for the beginning of this line

		variable	n_hsynccount	: std_logic_vector(3 downto 0);		-- counter before we turn off hsync
		variable	n_hsync		: std_logic;				-- is the hsync enabled currently

		variable	n_vsynccount	: std_logic_vector(3 downto 0);		-- counter before we turn off vsync
		variable	n_vsync		: std_logic;				-- is the vsync enabled currently

		variable	n_inadjust	: std_logic;				-- in adjustment row

		variable	maxscanlinecount : std_logic_vector(4 downto 0);
		variable	reached_maxscanlinecount : std_logic;
		variable	islastline	: std_logic;
			

	begin
		if nRESET='0' then
			v_hpos			:= (others=>'0');
			v_vpos			:= (others=>'0');
			v_rpos			:= (others=>'0');
			v_hdisp			:= '1';
			v_vdisp			:= '1';
			v_ma			:= r_startaddress_h & r_startaddress_l;
			v_ma_this_line		:= v_ma;

			v_hsynccount		:= (others=>'0');
			v_hsync			:= '0';
			v_vsynccount		:= (others=>'0');
			v_vsync			:= '0';
			v_inadjust		:= '0';

			MA 			<= (others=>'0');
			RA 			<= (others=>'0');
			DE			<= '0';
			HSYNC			<= '0';
			VSYNC			<= '0';

		elsif falling_edge(CLK) then							-- figure 6, everything is updated in response to fall edge
			-- copy all signals locally, so we avoid latches
			n_hpos			:= v_hpos;
			n_hdisp			:= v_hdisp;
			n_vpos			:= v_vpos;
			n_vdisp			:= v_vdisp;
			n_rpos			:= v_rpos;
			n_ma			:= v_ma;
			n_ma_this_line		:= v_ma_this_line;
			n_hsynccount		:= v_hsynccount;
			n_hsync			:= v_hsync;

			n_vsynccount		:= v_vsynccount;
			n_vsync			:= v_vsync;
			n_inadjust		:= v_inadjust;

			-- if we're still in the middle of a line, process line contents
			if n_hpos /= r_htotal then
				n_hpos			:= n_hpos + 1;				-- update the character position
				n_ma			:= n_ma + ("0"&n_hdisp);		-- only update if we're still display things though (we'll use this later)

				-- check to see if we need to start a hsync
				if n_hpos = r_hsyncpos then
					n_hsync		:= '1';					-- start vsync
					n_hsynccount	:= r_hsyncwidth;			-- repeat for this length
				end if;

				-- count down the hsync counter, clear hsync if it's zero
				if n_hsynccount = 0 then
					n_hsync		:= '0';					-- this order makes it so if sync width=0, no sync is generated
				else
					n_hsynccount	:= n_hsynccount - 1;
				end if;

			else -- reached horiz total

				-- determine end row of this character line
				if n_inadjust ='1' then
					maxscanlinecount	:= r_vtotaladjust;
				else
					maxscanlinecount	:= r_maxscanlinecount;
				end if;

				-- check to see if we are staying within a character line or progressing to the next
				reached_maxscanlinecount := '0';
				if n_rpos=maxscanlinecount then
					reached_maxscanlinecount := '1';
				end if;

				-- update ma, or "start of line" ma if we've reached a new character row (and hit hdisp)
				if (reached_maxscanlinecount='0' or n_hdisp='1') then
					n_ma		:= n_ma_this_line;			-- reset ma back to the start of this character line
				else
					n_ma_this_line	:= n_ma;				-- instead, update the "start of line" ma with our current value
				end if;

				-- reset counters
				n_hpos			:= (others=>'0');			-- reset the horiz count to 0
				n_hdisp			:= '1';					-- re-enable horiz output

				-- count down the pulses in the vsync pulse
				n_vsynccount	:= n_vsynccount - 1;
				if n_vsynccount = 0 then
					n_vsync	:= '0';						-- clear the vsync pulse when it gets low enough
				end if;

				-- update row line counter
				if reached_maxscanlinecount='0' then
					n_rpos			:= n_rpos + 1;			-- increment character row count
				else
					n_rpos			:= (others=>'0');		-- reset the row count to 0

					islastline		:= '0';
					if n_vpos=r_vtotal then
						islastline	:= '1';
					end if;

					if  n_inadjust ='1' or (islastline='1' and r_vtotaladjust=0) then
						n_inadjust	:= '0';				-- clear adjust flag
						n_vdisp		:= '1';				-- re-enable vertical display
						n_vpos		:= (others=>'0');		-- go back to character line

						-- if r1>r0, WinCPC: repeats the same character line over and over, but continues doing character lines OK
						--			however at the start of the frame, it resets MA to the values in r12&r13
						--		i.e. out &bc00,1:out &bd00,65
						-- on my 464 it keeps outputting the "current" line over and over, never re-reading r12&r13. not sure what crtc type.
						--
						-- i'm doing wincpc's behaviour, but can be fixed by moving the n_ma block above below here
						n_ma_this_line	:= r_startaddress_h & r_startaddress_l;	-- start of screen
						n_ma		:= r_startaddress_h & r_startaddress_l;	-- start of screen

					else
						n_inadjust	:= islastline;		-- set adjust flag if we have an adjustment line
						n_vpos		:= n_vpos + 1;			-- progress to next line
					end if;

					-- do the vsync pulse if required
					if n_vpos = r_vsyncpos then
						n_vsync		:= '1';
						n_vsynccount	:= (others=>'0');		-- later crtc use top of r3
					end if;

				end if;

			end if;

			-- check if still in visible region
			if n_vpos = r_vdisp then
				n_vdisp		:= '0';					-- no longer displaying data
			end if;
			if n_hpos = r_hdisp then
				n_hdisp		:= '0';					-- no longer displaying data
			end if;

			-- commit new values of all signals
			v_hpos			:= n_hpos;
			v_hdisp			:= n_hdisp;
			v_vpos			:= n_vpos;
			v_vdisp			:= n_vdisp;
			v_rpos			:= n_rpos;
			v_ma			:= n_ma;
			v_ma_this_line		:= n_ma_this_line;
			v_hsynccount		:= n_hsynccount;
			v_hsync			:= n_hsync;

			v_vsynccount		:= n_vsynccount;
			v_vsync			:= n_vsync;
			v_inadjust		:= n_inadjust;

			-- and copy relevant things to the signals
			MA 			<= n_ma;
			RA 			<= n_rpos;
			DE			<= n_vdisp and n_hdisp;
			HSYNC			<= n_hsync;
			VSYNC			<= n_vsync;
		end if;
	end process;


end impl;
