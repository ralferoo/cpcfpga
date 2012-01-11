-- bench_cpc_bootrom.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity bench_cpc_bootrom is
    port(
        addr        : in  std_logic_vector(13 downto 0);
        data        : out std_logic_vector(7 downto 0)
    );
end bench_cpc_bootrom;

architecture impl of bench_cpc_bootrom is

begin
process (addr)
    begin
        case addr(6 downto 0) is 
            when "0000000" => data <= X"f3";
            when "0000001" => data <= X"ed";
            when "0000010" => data <= X"56";
            when "0000011" => data <= X"21";
            when "0000100" => data <= X"fb";
            when "0000101" => data <= X"c9";
            when "0000110" => data <= X"22";
            when "0000111" => data <= X"38";
            when "0001000" => data <= X"00";
            when "0001001" => data <= X"fb";
            when "0001010" => data <= X"18";
            when "0001011" => data <= X"2e";
            when "0001100" => data <= X"00";
            when "0001101" => data <= X"00";
            when "0001110" => data <= X"00";
            when "0001111" => data <= X"00";
            when "0010000" => data <= X"00";
            when "0010001" => data <= X"00";
            when "0010010" => data <= X"00";
            when "0010011" => data <= X"00";
            when "0010100" => data <= X"00";
            when "0010101" => data <= X"00";
            when "0010110" => data <= X"00";
            when "0010111" => data <= X"00";
            when "0011000" => data <= X"00";
            when "0011001" => data <= X"00";
            when "0011010" => data <= X"00";
            when "0011011" => data <= X"00";
            when "0011100" => data <= X"00";
            when "0011101" => data <= X"00";
            when "0011110" => data <= X"00";
            when "0011111" => data <= X"00";
            when "0100000" => data <= X"00";
            when "0100001" => data <= X"00";
            when "0100010" => data <= X"00";
            when "0100011" => data <= X"00";
            when "0100100" => data <= X"00";
            when "0100101" => data <= X"00";
            when "0100110" => data <= X"00";
            when "0100111" => data <= X"00";
            when "0101000" => data <= X"00";
            when "0101001" => data <= X"00";
            when "0101010" => data <= X"00";
            when "0101011" => data <= X"00";
            when "0101100" => data <= X"00";
            when "0101101" => data <= X"00";
            when "0101110" => data <= X"00";
            when "0101111" => data <= X"00";
            when "0110000" => data <= X"00";
            when "0110001" => data <= X"00";
            when "0110010" => data <= X"00";
            when "0110011" => data <= X"00";
            when "0110100" => data <= X"00";
            when "0110101" => data <= X"00";
            when "0110110" => data <= X"00";
            when "0110111" => data <= X"00";
            when "0111000" => data <= X"fb";
            when "0111001" => data <= X"c9";
            when "0111010" => data <= X"00";
            when "0111011" => data <= X"00";
            when "0111100" => data <= X"00";
            when "0111101" => data <= X"00";
            when "0111110" => data <= X"00";
            when "0111111" => data <= X"00";
            when "1000000" => data <= X"00";
            when "1000001" => data <= X"00";
            when "1000010" => data <= X"00";
            when "1000011" => data <= X"00";
            when "1000100" => data <= X"00";
            when "1000101" => data <= X"06";
            when "1000110" => data <= X"f5";
            when "1000111" => data <= X"ed";
            when "1001000" => data <= X"78";
            when "1001001" => data <= X"0f";
            when "1001010" => data <= X"9f";
            when "1001011" => data <= X"01";
            when "1001100" => data <= X"de";
            when "1001101" => data <= X"fa";
            when "1001110" => data <= X"ed";
            when "1001111" => data <= X"79";
            when "1010000" => data <= X"00";
            when "1010001" => data <= X"00";
            when "1010010" => data <= X"00";
            when "1010011" => data <= X"00";
            when "1010100" => data <= X"00";
            when "1010101" => data <= X"00";
            when "1010110" => data <= X"00";
            when "1010111" => data <= X"00";
            when "1011000" => data <= X"00";
            when "1011001" => data <= X"00";
            when "1011010" => data <= X"00";
            when "1011011" => data <= X"00";
            when "1011100" => data <= X"00";
            when "1011101" => data <= X"00";
            when "1011110" => data <= X"00";
            when "1011111" => data <= X"00";
            when "1100000" => data <= X"00";
            when "1100001" => data <= X"01";
            when "1100010" => data <= X"00";
            when "1100011" => data <= X"7f";
            when "1100100" => data <= X"14";
            when "1100101" => data <= X"b2";
            when "1100110" => data <= X"e6";
            when "1100111" => data <= X"1f";
            when "1101000" => data <= X"f6";
            when "1101001" => data <= X"40";
            when "1101010" => data <= X"ed";
            when "1101011" => data <= X"49";
            when "1101100" => data <= X"ed";
            when "1101101" => data <= X"79";
            when "1101110" => data <= X"18";
            when "1101111" => data <= X"ca";

            when others => data <= X"00";
          end case;
    end process;

end impl;
