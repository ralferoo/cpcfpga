-- spi.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- the SPI interface is basically like a glorified serial port
-- the system controls the clock and read/writes data at the same time
--
-- data is written by both sides on the falling edge of clock
-- data is read    by both sides on the rising  edge of clock
--
entity spi is
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
end spi;

architecture impl of spi is
		signal		working		: std_logic;
		signal		shiftin		: std_logic_vector(7 downto 0);			-- bits received
begin
		spi_clk				<= clk16 when working='1' else clock_when_idle;

	process(nRESET,clk16) is
		variable	last		: std_logic;					-- copy of load flag so we can watch edge
		variable	startload	: std_logic;					-- cached copy of load flag

		variable	bit_out		: std_logic;

		variable	cached		: std_logic_vector(7 downto 0);			-- bits to transmit (latched on load rise)
		variable	shiftout	: std_logic_vector(7 downto 0);			-- bits to transmit
		variable	bits		: std_logic_vector(2 downto 0);			-- bit count processed (mod 8)
		variable	recvd		: std_logic_vector(7 downto 0);			-- bits received

		-- these variables hold the *new* copies

		variable	n_last		: std_logic;					-- copy of load flag so we can watch edge
		variable	n_startload	: std_logic;					-- cached copy of load flag
		variable	n_working	: std_logic;

		variable	n_bit_out	: std_logic;

		variable	n_cached	: std_logic_vector(7 downto 0);			-- bits to transmit (latched on load rise)
		variable	n_shiftout	: std_logic_vector(7 downto 0);			-- bits to transmit
		variable	n_shiftin	: std_logic_vector(7 downto 0);			-- bits received
		variable	n_bits		: std_logic_vector(2 downto 0);			-- bit count processed (mod 8)
		variable	n_recvd		: std_logic_vector(7 downto 0);			-- bits received

	-- now we've defined our procedures, the main process is fairly simple
	begin
		if nRESET='0' then
			-- reset SPI controller state
			last				:= '0';
			startload			:= '0';
			working				<= '0';

			bit_out				:= '0';

			cached				:= (others=>'0');
			shiftout			:= (others=>'0');
			bits				:= (others=>'0');
			recvd				:= (others=>'0');

		elsif falling_edge(clk16) then							-- send a bit of data out
			-- copy the variables into the new settings
			n_last				:= last;
			n_startload			:= startload;
			n_working			:= working;
			n_bit_out			:= bit_out;
			n_cached			:= cached;
			n_shiftout			:= shiftout;
			n_shiftin			:= shiftin;
			n_bits				:= bits;
			n_recvd				:= recvd;

			-- first check to see if there's data waiting
			if load='1' and n_last='0' then
				n_startload	:= '1';
				n_cached	:= write;
			end if;
			n_last			:= load;
	
			-- check to see if we've finished the previous bit
			if n_working='1' and n_bits="000" then
				n_working	:='0';
				n_recvd		:= shiftin;
			end if;

			-- check to see if we're starting a new transfer
			if n_working='0' and n_startload='1' then
				n_shiftout	:= n_cached;
				n_working	:= '1';
				n_startload	:= '0';
				n_bits 		:= (others=>'0');
			end if;
	
			-- shift out a bit
			if n_working='1' then
				n_bit_out	:= n_shiftout(7);				-- shift out the data
				n_shiftout	:= n_shiftout(6 downto 0) & '0';
				n_bits		:= n_bits + 1;				-- count down the bits until we're finished
			end if;

			-- copy the variables from the new settings
			last				:= n_last;
			startload			:= n_startload;
			working				<= n_working;
			bit_out				:= n_bit_out;
			cached				:= n_cached;
			shiftout			:= n_shiftout;
			bits				:= n_bits;
			recvd				:= n_recvd;

		end if;

		-- update ports
		spi_di				<= bit_out;
		read				<= recvd;
		busy				<= working or startload;
	end process;

	-- read process 
	process(nRESET,clk16) is
	begin
		if nRESET='0' then
			shiftin				<= (others=>'0');
		else
			if rising_edge(clk16) then						-- read a bit of data into the shift register
				shiftin			<= shiftin(6 downto 0) & spi_do;
			end if;
		end if;
	end process;

end impl;
