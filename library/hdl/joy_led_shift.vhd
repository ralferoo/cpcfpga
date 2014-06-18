-- joy_led_shift.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity joy_led_shift is
	port(
		clk16			: in  std_logic;

		joy_in_data		: in  std_logic;
		joy_key_latch		: out std_logic;
		joy_key_clk		: out std_logic;
		key_out_data		: out std_logic;

		joystick_1		: out std_logic_vector(6 downto 0);
		joystick_2		: out std_logic_vector(6 downto 0);

		tape_motor		: in  std_logic;
		tape_write		: in  std_logic;
		keyrow_addr		: in  std_logic_vector(3 downto 0);

		keycol_data		: out std_logic_vector(7 downto 0);
		sd_wp			: out std_logic;
		tape_read		: out std_logic;

		leds			: in  std_logic_vector(3 downto 0)
	);
end joy_led_shift;

-- inputs (furthest from fpga first)
--	keycol_0	keycol_1	keycol_2	keycol_3	joy1_fire1	joy1_left	joy1_right	joy1_spare
--	keycol_4	keycol_5	keycol_6	keycol_7	joy0_spare	joy1_up		joy1_fire2	joy1_down
--	tape_read	joy0_right	joy0_left	sd_wp		joy0_up		joy0_fire2	joy0_down	joy0_fire1
--
-- outputs (closest to fpga first):
--	0		1		2		3		4		5		6		7
-- +0	tape_motor	keyrow_1	keyrow_0	tape_write	led5		led4		led3		led2
-- +8	keyrow_2	keyrow_9	keyrow_8	keyrow_7	keyrow_6	keyrow_5	keyrow_4	keyrow_3

-- 74166 (PISO):
--	SH/LD'=0 when CLK 0->1 causes latch, QH' is immediately latched value
--	SH/LD'=1 when CLK 0->1 causes shift, QH' is changed on CLK 0->1 to reflect previous QG

-- 74595 (SIPO)
--	SRCLK 0->1 causes shift
--	RCLK  0->1 causes latch

--								joy_in	key_out
-- LATCH=0, CLK=0
-- LATCH=0, CLK=1	causes input data to be latched
-- LATCH=1, CLK=0	causes output data to be latched	h on QH	output QH
-- LATCH=1, CLK=1	shift regs transition
-- LATCH=1, CLK=0						g on QH output QG

architecture impl of joy_led_shift is
	signal	read_data	: std_logic_vector(23 downto 0) := (others=>'1');
	signal	write_data	: std_logic_vector(23 downto 0) := (others=>'1');

	signal	latch_reg	: std_logic_vector(23 downto 0)	:= x"fffffe";
	signal	clock_reg	: std_logic			:= '1';

	begin

	write_data(15)		<= '0' when keyrow_addr="0011" else '1';
	write_data(14)		<= '0' when keyrow_addr="0100" else '1';
	write_data(13)		<= '0' when keyrow_addr="0101" else '1';
	write_data(12)		<= '0' when keyrow_addr="0110" else '1';
	write_data(11)		<= '0' when keyrow_addr="0111" else '1';
	write_data(10)		<= '0' when keyrow_addr="1000" else '1';
	write_data(9)		<= '0' when keyrow_addr="1001" else '1';
	write_data(8)		<= '0' when keyrow_addr="0010" else '1';
	write_data(7 downto 4)	<= leds;
	write_data(3)		<= tape_write;
	write_data(2)		<= '0' when keyrow_addr="0000" else '1';
	write_data(1)		<= '0' when keyrow_addr="0001" else '1';
	write_data(0)		<= tape_motor;

--	0		1		2		3		4		5		6		7
--	keycol_0	keycol_1	keycol_2	keycol_3	joy1_fire1	joy1_left	joy1_right	joy1_spare
--	8		9		10		11		12		13		14		15
--	keycol_4	keycol_5	keycol_6	keycol_7	joy0_spare	joy1_up		joy1_fire2	joy1_down
--	16		17		18		19		20		21		22		23
--	tape_read	joy0_right	joy0_left	sd_wp		joy0_up		joy0_fire2	joy0_down	joy0_fire1

-- joy1 seems fine, joy2 might have bad connections - not working: G (Joy2 fire) 	T (Joy2 right) 	R (Joy2 left)
-- these are all in the top section

--			   fire3	fire1	       fire2	     right	   left		 down	       up
	joystick_1	<= read_data(12)&read_data(23)&read_data(21)&read_data(17)&read_data(18)&read_data(22)&read_data(20);
	joystick_2	<= read_data( 7)&read_data( 4)&read_data(14)&read_data( 6)&read_data( 5)&read_data(15)&read_data(13);

	keycol_data	<= read_data(11)&read_data(10)&read_data( 9)&read_data( 8)&read_data( 3)&read_data( 2)&read_data( 1)&read_data( 0);
	sd_wp		<= read_data(19);
	tape_read	<= read_data(16);

	process(clk16)
		variable shift_out	: std_logic_vector(23 downto 0) := (others=>'1');
		variable shift_in	: std_logic_vector(23 downto 0) := (others=>'1');
	begin
		if rising_edge(clk16) then
			if clock_reg = '1' then
				joy_key_latch		<= latch_reg(23);
				latch_reg		<= latch_reg(22 downto 0) & latch_reg(23);
			else	-- clock_reg='0'
				if latch_reg(0) = '0' then		-- about to send a latch
					shift_out	:= write_data;
				else
					shift_out	:= shift_out(22 downto 0) & shift_in (23);
				end if;

				shift_in		:= shift_in (22 downto 0) & joy_in_data;
				key_out_data		<= shift_out(23);

				if latch_reg(0) = '0' then		-- about to send a latch
					read_data	<= shift_in;
				end if;
				
			end if;
			joy_key_clk			<= not clock_reg;
			clock_reg			<= not clock_reg;
		end if;
	end process;

end impl;
