-- bootrom_homeboard.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity bootrom_homeboard is
    port(
	clk		: in  std_logic;
        addr		: in  std_logic_vector(13 downto 0);
        data		: out std_logic_vector(7 downto 0)
    );
end bootrom_homeboard;

architecture impl of bootrom_homeboard is


begin


process (addr)
    begin

	        case addr(8 downto 0) is 
                    when "000000000" => data <= X"01";
                    when "000000001" => data <= X"b6";
                    when "000000010" => data <= X"fa";
                    when "000000011" => data <= X"3e";
                    when "000000100" => data <= X"7f";
                    when "000000101" => data <= X"ed";
                    when "000000110" => data <= X"79";
                    when "000000111" => data <= X"01";
                    when "000001000" => data <= X"00";
                    when "000001001" => data <= X"bc";
                    when "000001010" => data <= X"ed";
                    when "000001011" => data <= X"49";
                    when "000001100" => data <= X"01";
                    when "000001101" => data <= X"3f";
                    when "000001110" => data <= X"bd";
                    when "000001111" => data <= X"ed";
                    when "000010000" => data <= X"49";
                    when "000010001" => data <= X"01";
                    when "000010010" => data <= X"01";
                    when "000010011" => data <= X"bc";
                    when "000010100" => data <= X"ed";
                    when "000010101" => data <= X"49";
                    when "000010110" => data <= X"01";
                    when "000010111" => data <= X"28";
                    when "000011000" => data <= X"bd";
                    when "000011001" => data <= X"ed";
                    when "000011010" => data <= X"49";
                    when "000011011" => data <= X"01";
                    when "000011100" => data <= X"02";
                    when "000011101" => data <= X"bc";
                    when "000011110" => data <= X"ed";
                    when "000011111" => data <= X"49";
                    when "000100000" => data <= X"01";
                    when "000100001" => data <= X"2e";
                    when "000100010" => data <= X"bd";
                    when "000100011" => data <= X"ed";
                    when "000100100" => data <= X"49";
                    when "000100101" => data <= X"01";
                    when "000100110" => data <= X"03";
                    when "000100111" => data <= X"bc";
                    when "000101000" => data <= X"ed";
                    when "000101001" => data <= X"49";
                    when "000101010" => data <= X"01";
                    when "000101011" => data <= X"8e";
                    when "000101100" => data <= X"bd";
                    when "000101101" => data <= X"ed";
                    when "000101110" => data <= X"49";
                    when "000101111" => data <= X"01";
                    when "000110000" => data <= X"04";
                    when "000110001" => data <= X"bc";
                    when "000110010" => data <= X"ed";
                    when "000110011" => data <= X"49";
                    when "000110100" => data <= X"01";
                    when "000110101" => data <= X"26";
                    when "000110110" => data <= X"bd";
                    when "000110111" => data <= X"ed";
                    when "000111000" => data <= X"49";
                    when "000111001" => data <= X"01";
                    when "000111010" => data <= X"05";
                    when "000111011" => data <= X"bc";
                    when "000111100" => data <= X"ed";
                    when "000111101" => data <= X"49";
                    when "000111110" => data <= X"01";
                    when "000111111" => data <= X"00";
                    when "001000000" => data <= X"bd";
                    when "001000001" => data <= X"ed";
                    when "001000010" => data <= X"49";
                    when "001000011" => data <= X"01";
                    when "001000100" => data <= X"06";
                    when "001000101" => data <= X"bc";
                    when "001000110" => data <= X"ed";
                    when "001000111" => data <= X"49";
                    when "001001000" => data <= X"01";
                    when "001001001" => data <= X"19";
                    when "001001010" => data <= X"bd";
                    when "001001011" => data <= X"ed";
                    when "001001100" => data <= X"49";
                    when "001001101" => data <= X"01";
                    when "001001110" => data <= X"07";
                    when "001001111" => data <= X"bc";
                    when "001010000" => data <= X"ed";
                    when "001010001" => data <= X"49";
                    when "001010010" => data <= X"01";
                    when "001010011" => data <= X"1e";
                    when "001010100" => data <= X"bd";
                    when "001010101" => data <= X"ed";
                    when "001010110" => data <= X"49";
                    when "001010111" => data <= X"01";
                    when "001011000" => data <= X"08";
                    when "001011001" => data <= X"bc";
                    when "001011010" => data <= X"ed";
                    when "001011011" => data <= X"49";
                    when "001011100" => data <= X"01";
                    when "001011101" => data <= X"00";
                    when "001011110" => data <= X"bd";
                    when "001011111" => data <= X"ed";
                    when "001100000" => data <= X"49";
                    when "001100001" => data <= X"01";
                    when "001100010" => data <= X"09";
                    when "001100011" => data <= X"bc";
                    when "001100100" => data <= X"ed";
                    when "001100101" => data <= X"49";
                    when "001100110" => data <= X"01";
                    when "001100111" => data <= X"07";
                    when "001101000" => data <= X"bd";
                    when "001101001" => data <= X"ed";
                    when "001101010" => data <= X"49";
                    when "001101011" => data <= X"01";
                    when "001101100" => data <= X"0a";
                    when "001101101" => data <= X"bc";
                    when "001101110" => data <= X"ed";
                    when "001101111" => data <= X"49";
                    when "001110000" => data <= X"01";
                    when "001110001" => data <= X"00";
                    when "001110010" => data <= X"bd";
                    when "001110011" => data <= X"ed";
                    when "001110100" => data <= X"49";
                    when "001110101" => data <= X"01";
                    when "001110110" => data <= X"0b";
                    when "001110111" => data <= X"bc";
                    when "001111000" => data <= X"ed";
                    when "001111001" => data <= X"49";
                    when "001111010" => data <= X"01";
                    when "001111011" => data <= X"00";
                    when "001111100" => data <= X"bd";
                    when "001111101" => data <= X"ed";
                    when "001111110" => data <= X"49";
                    when "001111111" => data <= X"01";
                    when "010000000" => data <= X"0c";
                    when "010000001" => data <= X"bc";
                    when "010000010" => data <= X"ed";
                    when "010000011" => data <= X"49";
                    when "010000100" => data <= X"01";
                    when "010000101" => data <= X"30";
                    when "010000110" => data <= X"bd";
                    when "010000111" => data <= X"ed";
                    when "010001000" => data <= X"49";
                    when "010001001" => data <= X"01";
                    when "010001010" => data <= X"0d";
                    when "010001011" => data <= X"bc";
                    when "010001100" => data <= X"ed";
                    when "010001101" => data <= X"49";
                    when "010001110" => data <= X"01";
                    when "010001111" => data <= X"00";
                    when "010010000" => data <= X"bd";
                    when "010010001" => data <= X"ed";
                    when "010010010" => data <= X"49";
                    when "010010011" => data <= X"01";
                    when "010010100" => data <= X"81";
                    when "010010101" => data <= X"7f";
                    when "010010110" => data <= X"ed";
                    when "010010111" => data <= X"49";
                    when "010011000" => data <= X"11";
                    when "010011001" => data <= X"44";
                    when "010011010" => data <= X"00";
                    when "010011011" => data <= X"ed";
                    when "010011100" => data <= X"51";
                    when "010011101" => data <= X"ed";
                    when "010011110" => data <= X"59";
                    when "010011111" => data <= X"11";
                    when "010100000" => data <= X"4a";
                    when "010100001" => data <= X"01";
                    when "010100010" => data <= X"ed";
                    when "010100011" => data <= X"51";
                    when "010100100" => data <= X"ed";
                    when "010100101" => data <= X"59";
                    when "010100110" => data <= X"11";
                    when "010100111" => data <= X"53";
                    when "010101000" => data <= X"02";
                    when "010101001" => data <= X"ed";
                    when "010101010" => data <= X"51";
                    when "010101011" => data <= X"ed";
                    when "010101100" => data <= X"59";
                    when "010101101" => data <= X"11";
                    when "010101110" => data <= X"4c";
                    when "010101111" => data <= X"03";
                    when "010110000" => data <= X"ed";
                    when "010110001" => data <= X"51";
                    when "010110010" => data <= X"ed";
                    when "010110011" => data <= X"59";
                    when "010110100" => data <= X"21";
                    when "010110101" => data <= X"00";
                    when "010110110" => data <= X"c0";
                    when "010110111" => data <= X"1e";
                    when "010111000" => data <= X"00";
                    when "010111001" => data <= X"d9";
                    when "010111010" => data <= X"21";
                    when "010111011" => data <= X"00";
                    when "010111100" => data <= X"c0";
                    when "010111101" => data <= X"01";
                    when "010111110" => data <= X"de";
                    when "010111111" => data <= X"fa";
                    when "011000000" => data <= X"ed";
                    when "011000001" => data <= X"59";
                    when "011000010" => data <= X"7b";
                    when "011000011" => data <= X"85";
                    when "011000100" => data <= X"84";
                    when "011000101" => data <= X"4a";
                    when "011000110" => data <= X"7b";
                    when "011000111" => data <= X"cb";
                    when "011001000" => data <= X"19";
                    when "011001001" => data <= X"1f";
                    when "011001010" => data <= X"cb";
                    when "011001011" => data <= X"19";
                    when "011001100" => data <= X"1f";
                    when "011001101" => data <= X"cb";
                    when "011001110" => data <= X"19";
                    when "011001111" => data <= X"1f";
                    when "011010000" => data <= X"77";
                    when "011010001" => data <= X"23";
                    when "011010010" => data <= X"7c";
                    when "011010011" => data <= X"b5";
                    when "011010100" => data <= X"20";
                    when "011010101" => data <= X"e7";
                    when "011010110" => data <= X"26";
                    when "011010111" => data <= X"c0";
                    when "011011000" => data <= X"13";
                    when "011011001" => data <= X"18";
                    when "011011010" => data <= X"e2";
                    when "011011011" => data <= X"0d";
                    when "011011100" => data <= X"0d";
                    when "011011101" => data <= X"ed";
                    when "011011110" => data <= X"51";
                    when "011011111" => data <= X"d9";
                    when "011100000" => data <= X"73";
                    when "011100001" => data <= X"23";
                    when "011100010" => data <= X"1c";
                    when "011100011" => data <= X"7c";
                    when "011100100" => data <= X"b5";
                    when "011100101" => data <= X"20";
                    when "011100110" => data <= X"04";
                    when "011100111" => data <= X"21";
                    when "011101000" => data <= X"00";
                    when "011101001" => data <= X"c0";
                    when "011101010" => data <= X"1c";
                    when "011101011" => data <= X"d9";
                    when "011101100" => data <= X"21";
                    when "011101101" => data <= X"c8";
                    when "011101110" => data <= X"00";
                    when "011101111" => data <= X"2b";
                    when "011110000" => data <= X"7c";
                    when "011110001" => data <= X"b5";
                    when "011110010" => data <= X"20";
                    when "011110011" => data <= X"fb";
                    when "011110100" => data <= X"18";
                    when "011110101" => data <= X"c7";
                    when "011110110" => data <= X"11";
                    when "011110111" => data <= X"07";
                    when "011111000" => data <= X"03";
                    when "011111001" => data <= X"21";
                    when "011111010" => data <= X"00";
                    when "011111011" => data <= X"c0";
                    when "011111100" => data <= X"01";
                    when "011111101" => data <= X"ff";
                    when "011111110" => data <= X"fe";
                    when "011111111" => data <= X"ed";
                    when "100000000" => data <= X"41";
                    when "100000001" => data <= X"04";
                    when "100000010" => data <= X"ed";
                    when "100000011" => data <= X"51";
                    when "100000100" => data <= X"ed";
                    when "100000101" => data <= X"59";
                    when "100000110" => data <= X"ed";
                    when "100000111" => data <= X"61";
                    when "100001000" => data <= X"ed";
                    when "100001001" => data <= X"69";
                    when "100001010" => data <= X"af";
                    when "100001011" => data <= X"2b";
                    when "100001100" => data <= X"ed";
                    when "100001101" => data <= X"a2";
                    when "100001110" => data <= X"04";
                    when "100001111" => data <= X"bc";
                    when "100010000" => data <= X"20";
                    when "100010001" => data <= X"fa";
                    when "100010010" => data <= X"c3";
                    when "100010011" => data <= X"00";
                    when "100010100" => data <= X"c0";

	            when others => data <= X"00";
        	  end case;


    end process;

end impl;
