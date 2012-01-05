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
        case addr(4 downto 0) is 
            when "00000" => data <= X"21";
            when "00001" => data <= X"00";
            when "00010" => data <= X"40";
            when "00011" => data <= X"01";
            when "00100" => data <= X"dd";
            when "00101" => data <= X"fa";
            when "00110" => data <= X"ed";
            when "00111" => data <= X"78";
            when "01000" => data <= X"e6";
            when "01001" => data <= X"40";
            when "01010" => data <= X"28";
            when "01011" => data <= X"0c";
            when "01100" => data <= X"0d";
            when "01101" => data <= X"ed";
            when "01110" => data <= X"78";
            when "01111" => data <= X"57";
            when "10000" => data <= X"e6";
            when "10001" => data <= X"40";
            when "10010" => data <= X"0f";
            when "10011" => data <= X"aa";
            when "10100" => data <= X"ed";
            when "10101" => data <= X"79";
            when "10110" => data <= X"77";
            when "10111" => data <= X"2c";
            when "11000" => data <= X"18";
            when "11001" => data <= X"e9";

            when others => data <= X"00";
          end case;
    end process;

end impl;
