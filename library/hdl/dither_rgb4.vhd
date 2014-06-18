-- dither_rgb4.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity dither_rgb4 is port(
		clk96				: in  std_logic;
		red				: in  std_logic_vector(3 downto 0);
		green				: in  std_logic_vector(3 downto 0);
		blue				: in  std_logic_vector(3 downto 0);
		scart_r, scart_g, scart_b	: out  std_logic_vector(1 downto 0));
end dither_rgb4;

architecture impl of dither_rgb4 is

	-- 4-bit dither function
	component dither_4bit is port(
		in4				: in  std_logic_vector(3 downto 0);
		dither				: out std_logic_vector(11 downto 0));
	end component;

	type dither_states is (DITHERSTATE1,DITHERSTATE2,DITHERSTATE3,DITHERSTATE4,DITHERSTATE5,DITHERSTATE6);
	signal dither_raw			: std_logic_vector(35 downto 0);
begin
	-- dither individual components
	dither_unit_r: dither_4bit port map( in4=>red  ,dither=>dither_raw(35 downto 24) );
	dither_unit_g: dither_4bit port map( in4=>green,dither=>dither_raw(23 downto 12) );
	dither_unit_b: dither_4bit port map( in4=>blue ,dither=>dither_raw(11 downto  0) );

	-- select dither components
	dither_logic:process(clk96)
		variable dither_state : dither_states := DITHERSTATE1;
	begin
		if rising_edge(clk96) then
			case dither_state is
				when DITHERSTATE1 =>
					scart_r		<= dither_raw(35 downto 34);
					scart_g		<= dither_raw(23 downto 22);
					scart_b		<= dither_raw(11 downto 10);
					dither_state	:= DITHERSTATE2;
				when DITHERSTATE2 =>
					scart_r		<= dither_raw(33 downto 32);
					scart_g		<= dither_raw(21 downto 20);
					scart_b		<= dither_raw( 9 downto  8);
					dither_state	:= DITHERSTATE3;
				when DITHERSTATE3 =>
					scart_r		<= dither_raw(31 downto 30);
					scart_g		<= dither_raw(19 downto 18);
					scart_b		<= dither_raw( 7 downto  6);
					dither_state	:= DITHERSTATE4;
				when DITHERSTATE4 =>
					scart_r		<= dither_raw(29 downto 28);
					scart_g		<= dither_raw(17 downto 16);
					scart_b		<= dither_raw( 5 downto  4);
					dither_state	:= DITHERSTATE5;
				when DITHERSTATE5 =>
					scart_r		<= dither_raw(27 downto 26);
					scart_g		<= dither_raw(15 downto 14);
					scart_b		<= dither_raw( 3 downto  2);
					dither_state	:= DITHERSTATE6;
				when DITHERSTATE6 =>
					scart_r		<= dither_raw(25 downto 24);
					scart_g		<= dither_raw(13 downto 12);
					scart_b		<= dither_raw( 1 downto  0);
					dither_state	:= DITHERSTATE1;
			end case;
		end if;
	end process;
end impl;
