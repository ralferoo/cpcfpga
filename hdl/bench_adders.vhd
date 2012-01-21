library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity bench_adders is
-- empty
end bench_adders;

architecture impl of bench_adders is

	-- PLL
	constant SYSCLK_PERIOD : time := 62.5 ns;

	signal 		nRESET			: std_logic;
	signal 		clk16			: std_logic := '0';

	component clock_divider is
		port	(
			clk		: in  std_logic;
			load		: in  std_logic;
			divisor		: in  std_logic_vector;
			output		: out std_logic);
	end component;


	signal div_load : std_logic;

	signal div_out_0 : std_logic;
	signal div_out_1 : std_logic;
	signal div_out_2 : std_logic;
	signal div_out_3 : std_logic;
	signal div_out_4 : std_logic;
	signal div_out_5 : std_logic;
	signal div_out_6 : std_logic;
	signal div_out_7 : std_logic;
	signal div_out_8 : std_logic;
	signal div_out_9 : std_logic;
	signal div_out_10 : std_logic;
	signal div_out_11 : std_logic;
	signal div_out_12 : std_logic;
	signal div_out_13 : std_logic;
	signal div_out_14 : std_logic;
	signal div_out_15 : std_logic;
	signal div_out_16 : std_logic;

	begin

	-- clock and reset
	clk16 <= not clk16 after (SYSCLK_PERIOD / 2.0 );
	process
		variable vhdl_initial : BOOLEAN := TRUE;
	begin
		if ( vhdl_initial ) then
			-- Assert Reset
			nRESET <= '0';
			wait for ( SYSCLK_PERIOD * 30 );
            
			nRESET <= '1';
			wait;
		end if;
	end process;


	div_load <= not nRESET;
	div_0: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"000", output=>div_out_0);
	div_1: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"001", output=>div_out_1);
	div_2: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"010", output=>div_out_2);
	div_3: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"011", output=>div_out_3);
	div_4: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"100", output=>div_out_4);
	div_5: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"101", output=>div_out_5);
	div_6: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"110", output=>div_out_6);
	div_7: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"111", output=>div_out_7);
	div_8: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1000", output=>div_out_8);
	div_9: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1001", output=>div_out_9);
	div_10: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1010", output=>div_out_10);
	div_11: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1011", output=>div_out_11);
	div_12: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1100", output=>div_out_12);
	div_13: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1101", output=>div_out_13);
	div_14: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1110", output=>div_out_14);
	div_15: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"1111", output=>div_out_15);
	div_16: clock_divider port map( clk=>clk16, load=>div_load, divisor=>"10000", output=>div_out_16);

	-- test bed
	process(clk16,nRESET)
	begin
		if nRESET = '0' then
		elsif rising_edge(clk16) then
		end if;
	end process;
	
end impl;

