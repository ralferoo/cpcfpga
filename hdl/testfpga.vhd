library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity testfpga is
    Port ( 
	joy0: in std_logic_vector( 5 downto 0 );	
	joy1: in std_logic_vector( 5 downto 0 );	
	gpio: inout std_logic_vector( 7 downto 0 );
	exp: inout std_logic_vector( 2 downto 0 );
	hdr_mosi: inout std_logic;
	hdr_miso: inout std_logic;
	hdr_sel : inout std_logic;
	hdr_sclk: inout std_logic 
);
end testfpga;

architecture impl of testfpga is

begin
	gpio(5 downto 0) <= joy0;
	gpio(7 downto 6) <= joy1(5 downto 4);
	hdr_mosi <= joy1(3);
	hdr_miso <= joy1(2);
	hdr_sel  <= joy1(1);
	hdr_sclk <= joy1(0);

end impl;

