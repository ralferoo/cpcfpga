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
        case addr(4 downto 0) is 
            when "00000" => data <= X"21";
            when "00001" => data <= X"00";
            when "00010" => data <= X"80";
            when "00011" => data <= X"01";
            when "00100" => data <= X"fe";
            when "00101" => data <= X"fa";
            when "00110" => data <= X"ed";
            when "00111" => data <= X"49";
            when "01000" => data <= X"0c";
            when "01001" => data <= X"11";
            when "01010" => data <= X"c0";
            when "01011" => data <= X"03";
            when "01100" => data <= X"ed";
            when "01101" => data <= X"51";
            when "01110" => data <= X"ed";
            when "01111" => data <= X"49";
            when "10000" => data <= X"ed";
            when "10001" => data <= X"59";
            when "10010" => data <= X"ed";
            when "10011" => data <= X"69";
            when "10100" => data <= X"7b";
            when "10101" => data <= X"ed";
            when "10110" => data <= X"69";
            when "10111" => data <= X"ed";
            when "11000" => data <= X"a2";
            when "11001" => data <= X"04";
            when "11010" => data <= X"bc";
            when "11011" => data <= X"28";
            when "11100" => data <= X"f8";
            when "11101" => data <= X"c3";
            when "11110" => data <= X"00";
            when "11111" => data <= X"80";

            when others => data <= X"00";
          end case;
    end process;

end impl;
