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
        case addr(3 downto 0) is 
            when "0000" => data <= X"01";
            when "0001" => data <= X"de";
            when "0010" => data <= X"fa";
            when "0011" => data <= X"ed";
            when "0100" => data <= X"79";
            when "0101" => data <= X"c6";
            when "0110" => data <= X"05";
            when "0111" => data <= X"18";
            when "1000" => data <= X"f7";

            when others => data <= X"00";
          end case;
    end process;

end impl;
