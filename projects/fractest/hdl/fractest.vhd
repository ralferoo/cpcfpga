-- fractest.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library UNISIM;
use UNISIM.Vcomponents.IBUFG;
use UNISIM.Vcomponents.BUFG;
use UNISIM.Vcomponents.DCM;

entity fractest is
	port(
		clk_48				: in  std_logic;

		sram_address			: out std_logic_vector(18 downto 0);
		sram_data			: inout std_logic_vector(7 downto 0);
		sram_we				: out std_logic;
		sram_oe				: out std_logic;	-- could even tie this low

		joy_in_data			: in  std_logic;
		joy_key_latch			: out std_logic;
		joy_key_clk			: out std_logic;
		key_out_data			: out std_logic;

		scart_r, scart_g, scart_b	: out  std_logic_vector(1 downto 0);
		scart_csync			: out  std_logic;
		scart_audio_left		: out  std_logic;
		scart_audio_right		: out  std_logic
	);
end fractest;

architecture impl of fractest is
	signal clk16				: std_logic;
	signal clk96				: std_logic;
	signal CLK16FX_BUF			: std_logic;
	signal CLK96FX_BUF			: std_logic;
	signal clk48				: std_logic;
	signal GND_BIT				: std_logic;

	-- ditherer
	component dither_rgb4 is port(
		clk96				: in  std_logic;
		red				: in  std_logic_vector(3 downto 0);
		green				: in  std_logic_vector(3 downto 0);
		blue				: in  std_logic_vector(3 downto 0);
		scart_r, scart_g, scart_b	: out  std_logic_vector(1 downto 0));
	end component;

	-- evil hacky code for bootstrapping
	component bootrom_bram is port(
		clk				: in std_logic;
		addr				: in std_logic_vector(13 downto 0);
		data				: out std_logic_vector(7 downto 0)
        );
	end component;
	signal bootrom_data			: std_logic_vector(7 downto 0);
	signal bootrom_addr			: std_logic_vector(13 downto 0);

	signal vde, hde, vsync, hsync		: std_logic;
	signal xcoord				: std_logic_vector(8 downto 0);
	signal ycoord				: std_logic_vector(7 downto 0);
	signal video_rw 			: std_logic;
	signal pixel				: std_logic_vector(7 downto 0);

	signal xcoord_wr			: std_logic_vector(8 downto 0);
	signal ycoord_wr			: std_logic_vector(7 downto 0);
	signal pixel_wr				: std_logic_vector(7 downto 0);
	signal advance_wr			: std_logic;

	signal picture				: std_logic_vector(4 downto 0);

	signal dither_r4, dither_g4, dither_b4	: std_logic_vector(3 downto 0);
	signal video_r4, video_g4, video_b4	: std_logic_vector(3 downto 0);

	signal pause	 			: std_logic;

	signal	frame_count			: std_logic_vector(9 downto 0);
	signal leds				: std_logic_vector(3 downto 0) := (others=>'1');
	component joy_led_shift is port(
			clk16			: in  std_logic;
			joy_in_data		: in  std_logic;
			joy_key_latch		: out std_logic;
			joy_key_clk		: out std_logic;
			key_out_data		: out std_logic;

			tape_motor		: in  std_logic;
			tape_write		: in  std_logic;
			keyrow_addr		: in  std_logic_vector(3 downto 0);

			keycol_data		: out std_logic_vector(7 downto 0);
			sd_wp			: out std_logic;
			tape_read		: out std_logic;

			joystick_1		: out std_logic_vector(6 downto 0);
			joystick_2		: out std_logic_vector(6 downto 0);

			leds			: in std_logic_vector(3 downto 0)
		);
	end component;
	signal	joystick_1			: std_logic_vector(6 downto 0);
	signal	joystick_2			: std_logic_vector(6 downto 0);
begin

	-- video output logic
	dither_r4	<= "0000"  when (vsync='1' or hsync='1' or hde='0' or vde='0') else video_r4;
	dither_g4	<= "0000"  when (vsync='1' or hsync='1' or hde='0' or vde='0') else video_g4;
	dither_b4	<= "0000"  when (vsync='1' or hsync='1' or hde='0' or vde='0') else video_b4;

	dither_0 : dither_rgb4 port map(
		clk96 => clk96, red=>video_r4, green=>video_g4, blue=>video_b4,
--		clk96 => clk96, red=>dither_r4, green=>dither_g4, blue=>dither_b4,
		scart_r=>scart_r, scart_g=>scart_g, scart_b=>scart_b);

	scart_csync	<= vsync nor hsync;

	-- audio output logic
	scart_audio_left		<= '0';
	scart_audio_right		<= '0';

	-- video colour calcs
--	video_r4 <= "0000" when picture(4 downto 2)="101" else xcoord(7 downto 4);
--	video_g4 <= "0000" when picture(4 downto 2)="110" else ycoord(6 downto 3);
--	video_b4 <= "0000" when picture(4 downto 2)="100" else
--		xcoord(7 downto 4) when picture(4 downto 2)="101" else
--		ycoord(6 downto 3) when picture(4 downto 2)="110" else
--		xcoord(3 downto 2) & ycoord(2 downto 1) when picture(4 downto 2)="111" else
--		picture(3 downto 0);

	video_r4 <= pixel(4 downto 1) when pixel(7)='1' else "0000";
	video_g4 <= pixel(4 downto 1) when pixel(6)='1' else "0000";
	video_b4 <= pixel(4 downto 1) when pixel(5)='1' else "0000";
	--video_b4 <= pixel(7 downto 4);

	-- RG, GB, RB, mix
	-- 0    r=x, g=y, b=count
	-- 1 00 r=x, g=y, b=0
	-- 1 01 r=0, g=y, b=x
	-- 1 10 r=x, g=0, b=y
	-- 1 11 r=x, g=y, b=mix

	filler:process(clk16)
		variable last_vsync		: std_logic := '0';
		variable count			: std_logic_vector(8 downto 0);
		variable newx			: std_logic_vector(9 downto 0);
		variable newy			: std_logic_vector(8 downto 0);
		variable x			: std_logic_vector(8 downto 0);
		variable y			: std_logic_vector(7 downto 0);
		variable byte			: std_logic_vector(7 downto 0);

		variable lfsr1			: std_logic_vector(14 downto 0) := "000000000000000";
		variable lfsr2			: std_logic_vector(14 downto 0) := "010010010101110";
		variable feedback1		: std_logic := '0';
		variable feedback2		: std_logic := '0';
		variable sel			: std_logic_vector(1 downto 0);
		variable col			: std_logic_vector(2 downto 0);

	begin
		if rising_edge(clk16) then
--			if vsync='1' and last_vsync='0' then

			if joystick_1(2)='0' or joystick_2(2)='0' then
				xcoord_wr			<= x;
				ycoord_wr			<= y;
				pixel_wr			<= x(7 downto 0) xor frame_count(7 downto 0);
			elsif joystick_1(1)='0' or joystick_2(1)='0' then
				xcoord_wr			<= x;
				ycoord_wr			<= y;
				pixel_wr			<= col & "11111";
				if col = "111" then
					col			:= "001";
				else
					col			:= col+1;
				end if;
			elsif joystick_1(0)='0' or joystick_2(0)='0' then
				xcoord_wr			<= x;
				ycoord_wr			<= frame_count(7 downto 0);
				pixel_wr			<= x(7 downto 0) xor frame_count(7 downto 0);
			else
				case frame_count(8 downto 7) is
					when "00" =>
						xcoord_wr	<= "01" & frame_count(6 downto 0);
						ycoord_wr	<= "01000000";
					when "01" =>
						xcoord_wr	<= "100000000";
						ycoord_wr	<= frame_count(6) & not frame_count(6) & frame_count(5 downto 0);
					when "10" =>
						xcoord_wr	<= "01" & not frame_count(6 downto 0);
						ycoord_wr	<= "11000000";
					when others =>
						xcoord_wr	<= "010000000";
						ycoord_wr	<= not frame_count(6) & frame_count(6) & not frame_count(5 downto 0);
				end case;
				pixel_wr			<= frame_count(5 downto 3) &"11111";
			end if;

			if advance_wr='1' then
				if joystick_1(1)='0' or joystick_2(1)='0' then

					-- feedback loop
					feedback1		:= not lfsr1(14);
					lfsr1			:= (lfsr1(13) xor feedback1) & lfsr1(12 downto 5) & (lfsr1(4) xor feedback1) & lfsr1(3 downto 2) & (lfsr1(1) xor feedback1) & lfsr1(0) & lfsr1(14);

					feedback2		:= not lfsr2(14);
					lfsr2			:= (lfsr2(13) xor feedback2) & lfsr2(12 downto 5) & (lfsr2(4) xor feedback2) & lfsr2(3 downto 2) & (lfsr2(1) xor feedback2) & lfsr2(0) & lfsr2(14);

					sel			:= lfsr1(0) & lfsr2(0);
					case sel is
					when "00" =>
						newx		:= "0101101111";
						newy		:= "011111111";
					when "01" =>
						newx		:= "0000000000";
						newy		:= "011111111";
					when "10" =>
						newx		:= "0010111000";
						newy		:= "000000000";
					when others =>
						newx		:= "0" & x;
						newy		:= "0" & y;
					end case;

					newx			:= newx + x;
					newy			:= newy + y;

					x			:= newx(9 downto 1);
					y			:= newy(8 downto 1);
				else
					if x="101101111" then
						x		:= (others=>'0');
						y		:= y+1;
					else
						x		:= x+1;
					end if;
				end if;
			end if;
			last_vsync			:= vsync;
		end if;
	end process;

	-- update screen memory or allow store
	memory_arbiter:process(clk16)
		variable pixel_local		: std_logic_vector(7 downto 0);
	begin
		if rising_edge(clk16) then
			if vde='1' and hde='1' then
				if video_rw='0' then
					sram_address		<= (others=>'0');
					sram_address(8 downto 0)<= xcoord;
					sram_address(16 downto 9)<= ycoord;
					sram_data		<= (others=>'Z');
					sram_we			<= '1';
					sram_oe			<= '0';
				else
					pixel_local		:= sram_data;
					pixel			<= sram_data;
					if pause = '1' then
						sram_data	<= (others=>'Z');
						sram_we		<= '1';
						sram_oe		<= '1';
					else
						if pixel_local(3 downto 0) /= "0000" then
							pixel_local(3 downto 0) := pixel_local(3 downto 0) - 1;
						else
							pixel_local	:= (others=>'0');
						end if;
	--					pixel_local		:= pixel_local-1;
						sram_data		<= pixel_local;
						sram_oe			<= '1';
						sram_we			<= '0';
					end if;
				end if;
				advance_wr			<= '0';
			else
				if video_rw='1' then
					pixel			<= (others=>'0');
				end if;

--				if video_rw='0' then
--					sram_data		<= (others=>'Z');
--					sram_we			<= '1';
--					sram_oe			<= '1';
--					advance_wr		<= '0';
--				else
					sram_data		<= pixel_wr;
					sram_address(8 downto 0)<= xcoord_wr;
					sram_address(16 downto 9)<= ycoord_wr;
					sram_oe			<= '1';
					sram_we			<= '0';
					advance_wr		<= '1';
--				end if;
			end if;
		end if;
	end process;

	-- frame logic
	frame_counter:process(clk16)
		variable	last_vsync	: std_logic := '0';
		variable	frame_counter	: std_logic_vector(9 downto 0);
	begin
		if rising_edge(clk16) then
			picture			<= frame_counter(9 downto 5);
			if vsync='1' and last_vsync='0' then
--				if joystick_1(4)='1' and joystick_2(4)='1' then
					frame_counter	:= frame_counter + 1;
					frame_count	<= frame_counter;
					leds		<= not frame_counter(7 downto 4);
--				end if;
			end if;
			last_vsync		:= vsync;
		end if;
	end process;

	-- video clock
	video_clock:process(clk16)
		variable	div3		: std_logic_vector(2 downto 0) := "001";
		variable	counter		: std_logic_vector(18 downto 0);
	 	-- bits 0	sub pixel counter (16MHz)
		-- bits 1-9	0..511 pixel counter (8MHz)
		-- bits 10-18	0..311 line counter (15.625kHz)
	begin
		if rising_edge(clk16) then
			-- counter, maybe overriden by end of screen below
--			if div3(0) = '1' then

			-- update counter
			counter		:= counter + 1;
--			end if;
--			div3			:= div3(1 downto 0) & div3(2);

			-- vertical timing
			case counter(18 downto 10) is
--				when "000000000" =>
				when "100000000" =>	-- 200 / #19 + 4
					vde	<= '0';
				when "100010000" =>	-- 240 / #1e + 4
					vsync	<= '1';
				when "100101000" =>	-- 248 / #1f
					vsync	<= '0';
				when "100111000" =>	-- 312
					counter(18 downto 10) := (others=>'0');
					vde	<= '1';
				when others => null;
			end case;
			ycoord	<= counter(17 downto 10);

			-- horizontal timing
			case counter(9 downto 1) is
				when "000000000" =>
					hde	<= '1';
				when "101110000" =>	-- 320 / #2e 46*8
					hde	<= '0';
				when "110010100" =>	-- 368 / #2e
					hsync	<= '1';
				when "111001100" =>	-- 480 / #3c
					hsync	<= '0';
				when others => null;
			end case;
			xcoord	<= counter(9 downto 1);

			-- for rewrite
			video_rw <= counter(0);
		end if;
	end process;

	-- dcm
	GND_BIT <= '0';
	CLK96FX_BUFG_INST	:  BUFG port map (I=>CLK96FX_BUF, O=>clk96);
	CLK16FX_BUFG_INST	:  BUFG port map (I=>CLK16FX_BUF, O=>clk16);
	CLKIN_IBUFG_INST	: IBUFG port map (I=>clk_48, O=>clk48);

	DCM_INST96 : DCM
	generic map( CLK_FEEDBACK => "NONE",
		CLKDV_DIVIDE => 2.0,
		CLKFX_DIVIDE => 1,
		CLKFX_MULTIPLY => 2,			-- important bit: multiplies 48MHz by 2 for 96MHz
		CLKIN_DIVIDE_BY_2 => FALSE,
		CLKIN_PERIOD => 62.500,
		CLKOUT_PHASE_SHIFT => "NONE",
		DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
		DFS_FREQUENCY_MODE => "LOW",
		DLL_FREQUENCY_MODE => "LOW",
		DUTY_CYCLE_CORRECTION => TRUE,
		FACTORY_JF => x"8080",
		PHASE_SHIFT => 0,
		STARTUP_WAIT => FALSE)
	port map (CLKFB=>GND_BIT,
		CLKIN=>clk48,
		DSSEN=>GND_BIT,
		PSCLK=>GND_BIT,
		PSEN=>GND_BIT,
		PSINCDEC=>GND_BIT,
		RST=>GND_BIT,
		CLKDV=>open,
		CLKFX=>CLK96FX_BUF,
		CLKFX180=>open, --CLKFX180_BUF,
		CLK0=>open,
		CLK2X=>open,
		CLK2X180=>open,
		CLK90=>open,
		CLK180=>open,
		CLK270=>open,
		LOCKED=>open, --LOCKED_OUT,
		PSDONE=>open,
		STATUS=>open);


	DCM_INST16 : DCM
	generic map( CLK_FEEDBACK => "NONE",
		CLKDV_DIVIDE => 2.0,
		CLKFX_DIVIDE => 6,			-- important bit: divides 48MHz by 3 for 16MHz
		CLKFX_MULTIPLY => 2,
		CLKIN_DIVIDE_BY_2 => FALSE,
		CLKIN_PERIOD => 62.500,
		CLKOUT_PHASE_SHIFT => "NONE",
		DESKEW_ADJUST => "SYSTEM_SYNCHRONOUS",
		DFS_FREQUENCY_MODE => "LOW",
		DLL_FREQUENCY_MODE => "LOW",
		DUTY_CYCLE_CORRECTION => TRUE,
		FACTORY_JF => x"8080",
		PHASE_SHIFT => 0,
		STARTUP_WAIT => FALSE)
	port map (CLKFB=>GND_BIT,
		CLKIN=>clk48,
		DSSEN=>GND_BIT,
		PSCLK=>GND_BIT,
		PSEN=>GND_BIT,
		PSINCDEC=>GND_BIT,
		RST=>GND_BIT,
		CLKDV=>open,
		CLKFX=>CLK16FX_BUF,
		CLKFX180=>open, --CLKFX180_BUF,
		CLK0=>open,
		CLK2X=>open,
		CLK2X180=>open,
		CLK90=>open,
		CLK180=>open,
		CLK270=>open,
		LOCKED=>open, --LOCKED_OUT,
		PSDONE=>open,
		STATUS=>open);

	-- bootrom dummy cycle through data
	process(clk96)
	begin
		if rising_edge(clk96) then
			bootrom_addr			<= (others=>'0');
			bootrom_addr(10 downto 8)	<= bootrom_data(2 downto 0);
			bootrom_addr(7 downto 0)	<= bootrom_data;
		end if;
	end process;
	bootrom_0 : bootrom_bram port map( clk=>clk96, addr=>bootrom_addr, data=>bootrom_data );

	-- joystick, keyboard & leds
	joyled0 : joy_led_shift port map (
			clk16 => clk16,
			joy_in_data => joy_in_data,
			joy_key_latch => joy_key_latch,
			joy_key_clk => joy_key_clk,
			key_out_data => key_out_data,
			joystick_1=>joystick_1, joystick_2=>joystick_2,
			keyrow_addr=>(others=>'1'),
			tape_write=>'0', tape_motor=>'0',
--			tape_read=>cas_in,
			leds => leds);

	pause <= joystick_1(4) nand joystick_2(4);
end impl;
