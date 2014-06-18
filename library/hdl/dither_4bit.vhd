-- dither_4bit.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity dither_4bit is port(
		in4			: in  std_logic_vector(3 downto 0);
		dither			: out std_logic_vector(11 downto 0));
end dither_4bit;

architecture impl of dither_4bit is
begin
	dither <=
		"00"&"00"&"00"&"00"&"00"&"00" when in4="0000" else
		"00"&"01"&"01"&"00"&"01"&"01" when in4="0001" else
		"00"&"01"&"01"&"01"&"01"&"01" when in4="0010" else

		"01"&"01"&"01"&"01"&"01"&"01" when in4="0011" else
		"01"&"01"&"01"&"01"&"01"&"10" when in4="0100" else
		"01"&"01"&"10"&"01"&"01"&"10" when in4="0101" else
		"01"&"10"&"01"&"10"&"01"&"10" when in4="0110" else
		"01"&"10"&"10"&"01"&"10"&"10" when in4="0111" else
		"01"&"10"&"10"&"10"&"10"&"10" when in4="1000" else

		"10"&"10"&"10"&"10"&"10"&"10" when in4="1001" else
		"10"&"10"&"10"&"10"&"10"&"11" when in4="1010" else
		"10"&"10"&"11"&"10"&"10"&"11" when in4="1011" else
		"10"&"11"&"10"&"11"&"10"&"11" when in4="1100" else
		"10"&"11"&"11"&"10"&"11"&"11" when in4="1101" else
		"10"&"11"&"11"&"11"&"11"&"11" when in4="1110" else
		"11"&"11"&"11"&"11"&"11"&"11"; -- when in4="1111" else

end impl;

-- there are probably sufficient other intermediate colours to make
-- a 5 bit DAC, but it's not really needed now
