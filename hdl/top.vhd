-- top.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
--use work.pwm.all;

entity top is
port(
clock       : in std_logic;
pushsw      : in std_logic_vector(3 downto 0);
buttons     : in std_logic_vector(7 downto 0);
leds        : out std_logic_vector(7 downto 0);
pwmoutleft  : out std_logic;
pwmoutright : out std_logic
);
end top;

architecture DEF_ARCH of top is
begin

    leds <= pushsw & (buttons(7) xor buttons(6) xor clock ) & (buttons(5 downto 3) xor buttons(2 downto 0));

end DEF_ARCH;

