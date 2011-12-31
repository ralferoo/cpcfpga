-- testrom.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity testrom is
    port(
        addr        : std_logic_vector(13 downto 0);
        data        : out std_logic_vector(7 downto 0)
    );
end testrom;

architecture impl of testrom is

begin
process (addr)
    begin
        case addr(4 downto 0) is 
            when "00000" => data <= X"01";
            when "00001" => data <= X"de";
            when "00010" => data <= X"fa";
            when "00011" => data <= X"7d";
            when "00100" => data <= X"ed";
            when "00101" => data <= X"79";
            when "00110" => data <= X"c6";
            when "00111" => data <= X"05";
            when "01000" => data <= X"6f";
            when "01001" => data <= X"0d";
            when "01010" => data <= X"ed";
            when "01011" => data <= X"78";
            when "01100" => data <= X"17";
            when "01101" => data <= X"30";
            when "01110" => data <= X"f1";
            when "01111" => data <= X"0d";
            when "10000" => data <= X"24";
            when "10001" => data <= X"ed";
            when "10010" => data <= X"61";
            when "10011" => data <= X"18";
            when "10100" => data <= X"eb";

            when others => data <= X"00";
          end case;
    end process;

end impl;
