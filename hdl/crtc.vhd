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

			r_startaddress_h	<= "100000";	-- r12
			r_startaddress_l	<= x"00";	-- r13

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

end impl;
