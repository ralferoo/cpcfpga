-- pwm.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pwm is
port(
clock       : in std_logic;
pwmin       : in std_logic_vector(15 downto 0);
pwmout      : out std_logic
);
end pwm;

architecture pwm_basic of pwm is

signal accum  : std_logic_vector(16 downto 0);

begin
    process (clock, pwmin)
    begin
        if rising_edge(clock) then
            accum <= ("0" & accum(15 downto 0)) + ("0" & pwmin);
        end if;
    end process;

    pwmout <= accum(16);

end pwm_basic;