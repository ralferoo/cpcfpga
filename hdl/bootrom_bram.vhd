-- bootrom_bram.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;
-- synthesis translate_off
LIBRARY XilinxCoreLib;
-- synthesis translate_on

entity bootrom_bram is
    port(
	clk		: in  std_logic;
        addr		: in  std_logic_vector(13 downto 0);
        data		: out std_logic_vector(7 downto 0)
    );
end bootrom_bram;

architecture impl of bootrom_bram is

	component RAMB16_S9 
-- pragma translate_off
--  generic (
-- "Read during Write" attribute for functional simulation
--	WRITE_MODE : string := "READ_FIRST" ; -- WRITE_FIRST(default)/ READ_FIRST/ NO_CHANGE
-- RAM initialization ("0" by default) for functional simulation: see example
--	);
-- pragma translate_on
		port (
			DI     : in std_logic_vector (7 downto 0);
			DIP    : in std_logic_vector (0 downto 0);
			ADDR   : in std_logic_vector (10 downto 0);
			EN     : in std_logic;
			WE     : in std_logic;
			SSR    : in std_logic;
			CLK    : in std_logic;
			DO     : out std_logic_vector (7 downto 0);
			DOP    : out std_logic_vector (0 downto 0)
		); 
	end component;

	signal dout	: std_logic_vector(7 downto 0);
	signal doutp	: std_logic_vector(0 downto 0);

begin

	bootrom_u0 : RAMB16_S9 port map (
		DI => (others=>'0'), DIP => "0",
		ADDR => addr(10 downto 0), EN => '1', WE => '0', SSR => '1',
		CLK => clk, DO => dout, DOP => doutp);

	data <= dout when addr(13)='1' else (others=>doutp(0));

end impl;
