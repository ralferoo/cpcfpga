-- bench_spi.vhd

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity bench_spi is
end bench_spi;

architecture behavioral of bench_spi is

	constant SYSCLK_PERIOD : time := 1000 ns;

	signal SYSCLK : std_logic := '0';
	signal NSYSRESET : std_logic := '0';

	component spi is
	port(
		nRESET				: in  std_logic;
		clk16				: in  std_logic;				-- master clock input @ 16 MHz

		-- IO mapping
		write				: in  std_logic_vector(7 downto 0);		-- byte data to write
		read				: out std_logic_vector(7 downto 0);		-- byte data read whilst writing last byte

		-- SPI data lines
		spi_clk				: out  std_logic;				-- connected to SPI clock
		spi_di				: out  std_logic;				-- connected to SPI slave DI
		spi_do				: in   std_logic;				-- connected to SPI slave DO

		-- control
		load				: in  std_logic;				-- begin transfer on rising edge
		busy				: out std_logic;				-- 1 when in a transfer currently
		clock_when_idle			: in  std_logic					-- CPOL&CPHA (mode 0/3 select)
	);
	end component;
	
	signal	read			: 	std_logic_vector(7 downto 0);
	signal	write			: 	std_logic_vector(7 downto 0);
	signal	busy			: 	std_logic;
	signal	load			: 	std_logic;

	signal	spi_di			: 	std_logic;
	signal	spi_do			: 	std_logic;
	signal	spi_clk			: 	std_logic;
	signal	clock_when_idle		: 	std_logic;
begin

	process
		variable vhdl_initial : BOOLEAN := TRUE;

	begin
		if ( vhdl_initial ) then
			-- Assert Reset
			NSYSRESET <= '0';
			wait for ( SYSCLK_PERIOD * 10 );
			
			NSYSRESET <= '1';
			wait;
		end if;
	end process;

	-- 10MHz Clock Driver
	SYSCLK <= not SYSCLK after (SYSCLK_PERIOD / 2.0 );

	spi_0 : spi port map( nRESET=>NSYSRESET, clk16=>SYSCLK, write=>write, read=>read, busy=>busy, load=>load,
				clock_when_idle=>clock_when_idle, spi_clk=>spi_clk, spi_di=>spi_di, spi_do=>spi_do );

	-- echo the tx data back through our rx port
	spi_do <= not spi_di;

	process (NSYSRESET, SYSCLK)
		variable	byte	: std_logic_vector(8 downto 0);
		variable	pause	: std_logic_vector(3 downto 0);
	begin

	-- set the idle clock state
	clock_when_idle	<= byte(8);

	if NSYSRESET = '0' then
		write		<= (others=>'0');
		load		<= '0';
		byte		:= (others=>'0');
		pause		:= (others=>'0');
				
	elsif rising_edge(SYSCLK) then

		-- check for new data
		if busy = '0' then
			report "Received byte " & integer'image(to_integer(ieee.numeric_std.unsigned(read)));
		end if;

		-- send the dummy output through the transmit port
		if busy = '0' then
			if pause = 0 then
				write	<= byte(7 downto 0);
				byte	:= byte + 1;
				load	<= '1';
				pause	:= "1111";
			else
				pause	:= pause -1;
			end if;
		else
			load	<= '0';
		end if;

		end if;
	end process;
end behavioral;

