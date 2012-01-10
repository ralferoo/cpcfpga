-- spiload.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity spiload is
    port(
        addr        : in  std_logic_vector(13 downto 0);
        data        : out std_logic_vector(7 downto 0)
    );
end spiload;

architecture impl of spiload is

begin
process (addr)
    begin
        case addr(5 downto 0) is 
            when "000000" => data <= X"01";
            when "000001" => data <= X"de";
            when "000010" => data <= X"fa";
            when "000011" => data <= X"dd";
            when "000100" => data <= X"7d";
            when "000101" => data <= X"dd";
            when "000110" => data <= X"23";
            when "000111" => data <= X"ed";
            when "001000" => data <= X"79";
            when "001001" => data <= X"3e";
            when "001010" => data <= X"7e";
            when "001011" => data <= X"0e";
            when "001100" => data <= X"dc";
            when "001101" => data <= X"ed";
            when "001110" => data <= X"79";
            when "001111" => data <= X"11";
            when "010000" => data <= X"07";
            when "010001" => data <= X"03";
            when "010010" => data <= X"21";
            when "010011" => data <= X"00";
            when "010100" => data <= X"c0";
            when "010101" => data <= X"01";
            when "010110" => data <= X"ff";
            when "010111" => data <= X"fe";
            when "011000" => data <= X"ed";
            when "011001" => data <= X"49";
            when "011010" => data <= X"ed";
            when "011011" => data <= X"41";
            when "011100" => data <= X"04";
            when "011101" => data <= X"ed";
            when "011110" => data <= X"51";
            when "011111" => data <= X"ed";
            when "100000" => data <= X"59";
            when "100001" => data <= X"ed";
            when "100010" => data <= X"61";
            when "100011" => data <= X"ed";
            when "100100" => data <= X"69";
            when "100101" => data <= X"2b";
            when "100110" => data <= X"ed";
            when "100111" => data <= X"78";
            when "101000" => data <= X"77";
            when "101001" => data <= X"23";
            when "101010" => data <= X"7c";
            when "101011" => data <= X"b5";
            when "101100" => data <= X"20";
            when "101101" => data <= X"f8";
            when "101110" => data <= X"05";
            when "101111" => data <= X"ed";
            when "110000" => data <= X"49";
            when "110001" => data <= X"c3";
            when "110010" => data <= X"00";
            when "110011" => data <= X"c0";

            when others => data <= X"00";
          end case;
    end process;

end impl;
