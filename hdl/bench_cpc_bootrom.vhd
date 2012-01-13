-- bench_cpc_bootrom.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity bench_cpc_bootrom is
    port(
	clk		: in  std_logic;
        addr		: in  std_logic_vector(13 downto 0);
        data		: out std_logic_vector(7 downto 0)
    );
end bench_cpc_bootrom;

architecture impl of bench_cpc_bootrom is


begin


process (addr)
    begin

	        case addr(7 downto 0) is 
                    when "00000000" => data <= X"18";
                    when "00000001" => data <= X"53";
                    when "00000010" => data <= X"f3";
                    when "00000011" => data <= X"01";
                    when "00000100" => data <= X"8d";
                    when "00000101" => data <= X"7f";
                    when "00000110" => data <= X"ed";
                    when "00000111" => data <= X"49";
                    when "00001000" => data <= X"21";
                    when "00001001" => data <= X"19";
                    when "00001010" => data <= X"00";
                    when "00001011" => data <= X"11";
                    when "00001100" => data <= X"19";
                    when "00001101" => data <= X"00";
                    when "00001110" => data <= X"01";
                    when "00001111" => data <= X"3a";
                    when "00010000" => data <= X"00";
                    when "00010001" => data <= X"ed";
                    when "00010010" => data <= X"b0";
                    when "00010011" => data <= X"01";
                    when "00010100" => data <= X"fe";
                    when "00010101" => data <= X"fe";
                    when "00010110" => data <= X"af";
                    when "00010111" => data <= X"ed";
                    when "00011000" => data <= X"79";
                    when "00011001" => data <= X"3e";
                    when "00011010" => data <= X"69";
                    when "00011011" => data <= X"21";
                    when "00011100" => data <= X"00";
                    when "00011101" => data <= X"c0";
                    when "00011110" => data <= X"77";
                    when "00011111" => data <= X"5e";
                    when "00100000" => data <= X"16";
                    when "00100001" => data <= X"c0";
                    when "00100010" => data <= X"ed";
                    when "00100011" => data <= X"51";
                    when "00100100" => data <= X"23";
                    when "00100101" => data <= X"77";
                    when "00100110" => data <= X"5e";
                    when "00100111" => data <= X"01";
                    when "00101000" => data <= X"85";
                    when "00101001" => data <= X"7f";
                    when "00101010" => data <= X"ed";
                    when "00101011" => data <= X"49";
                    when "00101100" => data <= X"23";
                    when "00101101" => data <= X"77";
                    when "00101110" => data <= X"5e";
                    when "00101111" => data <= X"01";
                    when "00110000" => data <= X"fe";
                    when "00110001" => data <= X"fe";
                    when "00110010" => data <= X"af";
                    when "00110011" => data <= X"ed";
                    when "00110100" => data <= X"79";
                    when "00110101" => data <= X"23";
                    when "00110110" => data <= X"77";
                    when "00110111" => data <= X"5e";
                    when "00111000" => data <= X"18";
                    when "00111001" => data <= X"fe";
                    when "00111010" => data <= X"11";
                    when "00111011" => data <= X"00";
                    when "00111100" => data <= X"40";
                    when "00111101" => data <= X"d5";
                    when "00111110" => data <= X"21";
                    when "00111111" => data <= X"47";
                    when "01000000" => data <= X"00";
                    when "01000001" => data <= X"01";
                    when "01000010" => data <= X"06";
                    when "01000011" => data <= X"00";
                    when "01000100" => data <= X"ed";
                    when "01000101" => data <= X"b0";
                    when "01000110" => data <= X"c9";
                    when "01000111" => data <= X"2a";
                    when "01001000" => data <= X"19";
                    when "01001001" => data <= X"00";
                    when "01001010" => data <= X"01";
                    when "01001011" => data <= X"fe";
                    when "01001100" => data <= X"00";
                    when "01001101" => data <= X"2a";
                    when "01001110" => data <= X"19";
                    when "01001111" => data <= X"00";
                    when "01010000" => data <= X"01";
                    when "01010001" => data <= X"fe";
                    when "01010010" => data <= X"00";
                    when "01010011" => data <= X"00";
                    when "01010100" => data <= X"00";
                    when "01010101" => data <= X"f3";
                    when "01010110" => data <= X"ed";
                    when "01010111" => data <= X"56";
                    when "01011000" => data <= X"21";
                    when "01011001" => data <= X"fb";
                    when "01011010" => data <= X"c9";
                    when "01011011" => data <= X"22";
                    when "01011100" => data <= X"38";
                    when "01011101" => data <= X"00";
                    when "01011110" => data <= X"fb";
                    when "01011111" => data <= X"18";
                    when "01100000" => data <= X"02";
                    when "01100001" => data <= X"fb";
                    when "01100010" => data <= X"c9";
                    when "01100011" => data <= X"00";
                    when "01100100" => data <= X"00";
                    when "01100101" => data <= X"00";
                    when "01100110" => data <= X"00";
                    when "01100111" => data <= X"00";
                    when "01101000" => data <= X"00";
                    when "01101001" => data <= X"00";
                    when "01101010" => data <= X"00";
                    when "01101011" => data <= X"00";
                    when "01101100" => data <= X"00";
                    when "01101101" => data <= X"00";
                    when "01101110" => data <= X"00";
                    when "01101111" => data <= X"06";
                    when "01110000" => data <= X"f5";
                    when "01110001" => data <= X"ed";
                    when "01110010" => data <= X"78";
                    when "01110011" => data <= X"0f";
                    when "01110100" => data <= X"9f";
                    when "01110101" => data <= X"01";
                    when "01110110" => data <= X"de";
                    when "01110111" => data <= X"fa";
                    when "01111000" => data <= X"ed";
                    when "01111001" => data <= X"79";
                    when "01111010" => data <= X"00";
                    when "01111011" => data <= X"00";
                    when "01111100" => data <= X"00";
                    when "01111101" => data <= X"00";
                    when "01111110" => data <= X"00";
                    when "01111111" => data <= X"00";
                    when "10000000" => data <= X"00";
                    when "10000001" => data <= X"00";
                    when "10000010" => data <= X"00";
                    when "10000011" => data <= X"00";
                    when "10000100" => data <= X"00";
                    when "10000101" => data <= X"00";
                    when "10000110" => data <= X"00";
                    when "10000111" => data <= X"00";
                    when "10001000" => data <= X"00";
                    when "10001001" => data <= X"00";
                    when "10001010" => data <= X"00";
                    when "10001011" => data <= X"01";
                    when "10001100" => data <= X"00";
                    when "10001101" => data <= X"7f";
                    when "10001110" => data <= X"14";
                    when "10001111" => data <= X"b2";
                    when "10010000" => data <= X"e6";
                    when "10010001" => data <= X"1f";
                    when "10010010" => data <= X"f6";
                    when "10010011" => data <= X"40";
                    when "10010100" => data <= X"ed";
                    when "10010101" => data <= X"49";
                    when "10010110" => data <= X"ed";
                    when "10010111" => data <= X"79";
                    when "10011000" => data <= X"18";
                    when "10011001" => data <= X"c9";

	            when others => data <= X"00";
        	  end case;


    end process;

end impl;
