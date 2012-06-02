library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testfpga is
    Port ( 
	joy0: in std_logic_vector( 5 downto 0 );	
	joy1: in std_logic_vector( 5 downto 0 );	
	gpio: out std_logic_vector( 7 downto 0 );
	exp: out std_logic_vector( 2 downto 0 );
	hdr_mosi: out std_logic;
	hdr_miso: out std_logic;
	hdr_sel : out std_logic;
	hdr_sclk: out std_logic;
	hdr_spare: out std_logic;
	clk16: in std_logic
);
end testfpga;

architecture impl of testfpga is

	signal accum : std_logic_vector(21 downto 0);

begin
	gpio(5 downto 0) <= joy0;
	gpio(7 downto 6) <= joy1(5 downto 4);
	hdr_mosi <= joy1(3);
	hdr_miso <= joy1(2);
	hdr_sel  <= joy1(1);
	hdr_sclk <= joy1(0);

	hdr_spare <= accum(21);

	process(clk16)
	begin
		if rising_edge(clk16) then
			accum <= accum + 1;
		end if;
	end process;

end impl;

