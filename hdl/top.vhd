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

    leds <= (buttons(7) xor clock ) & buttons(6 downto 4) & (buttons(3 downto 0) xor pushsw);

end DEF_ARCH;

