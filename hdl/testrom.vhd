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
            when "00000" => data <= X"21";
            when "00001" => data <= X"00";
            when "00010" => data <= X"00";
            when "00011" => data <= X"1e";
            when "00100" => data <= X"00";
            when "00101" => data <= X"01";
            when "00110" => data <= X"de";
            when "00111" => data <= X"fa";
            when "01000" => data <= X"23";
            when "01001" => data <= X"ed";
            when "01010" => data <= X"61";
            when "01011" => data <= X"0d";
            when "01100" => data <= X"ed";
            when "01101" => data <= X"78";
            when "01110" => data <= X"17";
            when "01111" => data <= X"30";
            when "10000" => data <= X"f4";
            when "10001" => data <= X"0d";
            when "10010" => data <= X"1c";
            when "10011" => data <= X"ed";
            when "10100" => data <= X"59";
            when "10101" => data <= X"18";
            when "10110" => data <= X"ee";

            when others => data <= X"00";
          end case;
    end process;

end impl;
