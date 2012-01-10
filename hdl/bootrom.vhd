-- bootrom.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity bootrom is
    port(
        addr        : in  std_logic_vector(13 downto 0);
        data        : out std_logic_vector(7 downto 0)
    );
end bootrom;

architecture impl of bootrom is

begin
process (addr)
	begin
		if addr(7)='0' then
			data <= X"f3";				-- fill lower half with DI instructions
		else
			case addr(6 downto 0) is 
                                when "0000000" => data <= X"01";
                                when "0000001" => data <= X"de";
                                when "0000010" => data <= X"fa";
                                when "0000011" => data <= X"dd";
                                when "0000100" => data <= X"7d";
                                when "0000101" => data <= X"dd";
                                when "0000110" => data <= X"23";
                                when "0000111" => data <= X"ed";
                                when "0001000" => data <= X"79";
                                when "0001001" => data <= X"3e";
                                when "0001010" => data <= X"7e";
                                when "0001011" => data <= X"0e";
                                when "0001100" => data <= X"dc";
                                when "0001101" => data <= X"ed";
                                when "0001110" => data <= X"79";
                                when "0001111" => data <= X"01";
                                when "0010000" => data <= X"ff";
                                when "0010001" => data <= X"fe";
                                when "0010010" => data <= X"ed";
                                when "0010011" => data <= X"49";
                                when "0010100" => data <= X"ed";
                                when "0010101" => data <= X"62";
                                when "0010110" => data <= X"2b";
                                when "0010111" => data <= X"7c";
                                when "0011000" => data <= X"b5";
                                when "0011001" => data <= X"20";
                                when "0011010" => data <= X"fb";
                                when "0011011" => data <= X"3e";
                                when "0011100" => data <= X"ab";
                                when "0011101" => data <= X"ed";
                                when "0011110" => data <= X"41";
                                when "0011111" => data <= X"04";
                                when "0100000" => data <= X"ed";
                                when "0100001" => data <= X"79";
                                when "0100010" => data <= X"ed";
                                when "0100011" => data <= X"79";
                                when "0100100" => data <= X"ed";
                                when "0100101" => data <= X"79";
                                when "0100110" => data <= X"ed";
                                when "0100111" => data <= X"79";
                                when "0101000" => data <= X"ed";
                                when "0101001" => data <= X"79";
                                when "0101010" => data <= X"05";
                                when "0101011" => data <= X"ed";
                                when "0101100" => data <= X"41";
                                when "0101101" => data <= X"2b";
                                when "0101110" => data <= X"7c";
                                when "0101111" => data <= X"b5";
                                when "0110000" => data <= X"20";
                                when "0110001" => data <= X"fb";
                                when "0110010" => data <= X"11";
                                when "0110011" => data <= X"07";
                                when "0110100" => data <= X"03";
                                when "0110101" => data <= X"21";
                                when "0110110" => data <= X"00";
                                when "0110111" => data <= X"c0";
                                when "0111000" => data <= X"f9";
                                when "0111001" => data <= X"e5";
                                when "0111010" => data <= X"ed";
                                when "0111011" => data <= X"41";
                                when "0111100" => data <= X"04";
                                when "0111101" => data <= X"ed";
                                when "0111110" => data <= X"51";
                                when "0111111" => data <= X"ed";
                                when "1000000" => data <= X"59";
                                when "1000001" => data <= X"ed";
                                when "1000010" => data <= X"61";
                                when "1000011" => data <= X"ed";
                                when "1000100" => data <= X"69";
                                when "1000101" => data <= X"ed";
                                when "1000110" => data <= X"78";
                                when "1000111" => data <= X"ed";
                                when "1001000" => data <= X"78";
                                when "1001001" => data <= X"77";
                                when "1001010" => data <= X"23";
                                when "1001011" => data <= X"cd";
                                when "1001100" => data <= X"d6";
                                when "1001101" => data <= X"00";
                                when "1001110" => data <= X"7c";
                                when "1001111" => data <= X"b5";
                                when "1010000" => data <= X"20";
                                when "1010001" => data <= X"f5";
                                when "1010010" => data <= X"05";
                                when "1010011" => data <= X"ed";
                                when "1010100" => data <= X"49";
                                when "1010101" => data <= X"c9";
                                when "1010110" => data <= X"f5";
                                when "1010111" => data <= X"1f";
                                when "1011000" => data <= X"1f";
                                when "1011001" => data <= X"1f";
                                when "1011010" => data <= X"1f";
                                when "1011011" => data <= X"e6";
                                when "1011100" => data <= X"0f";
                                when "1011101" => data <= X"fe";
                                when "1011110" => data <= X"0a";
                                when "1011111" => data <= X"de";
                                when "1100000" => data <= X"69";
                                when "1100001" => data <= X"27";
                                when "1100010" => data <= X"cd";
                                when "1100011" => data <= X"ed";
                                when "1100100" => data <= X"00";
                                when "1100101" => data <= X"f1";
                                when "1100110" => data <= X"e6";
                                when "1100111" => data <= X"0f";
                                when "1101000" => data <= X"fe";
                                when "1101001" => data <= X"0a";
                                when "1101010" => data <= X"de";
                                when "1101011" => data <= X"69";
                                when "1101100" => data <= X"27";
                                when "1101101" => data <= X"c5";
                                when "1101110" => data <= X"01";
                                when "1101111" => data <= X"dd";
                                when "1110000" => data <= X"fa";
                                when "1110001" => data <= X"ed";
                                when "1110010" => data <= X"70";
                                when "1110011" => data <= X"f2";
                                when "1110100" => data <= X"f1";
                                when "1110101" => data <= X"00";
                                when "1110110" => data <= X"0d";
                                when "1110111" => data <= X"ed";
                                when "1111000" => data <= X"79";
                                when "1111001" => data <= X"c1";
                                when "1111010" => data <= X"c9";

				when others => data <= X"00";
			end case;
		end if;
	end process;
end impl;
