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
		din				: in  std_logic_vector(7 downto 0);		-- byte data to write
		dout				: out std_logic_vector(7 downto 0);		-- byte data read whilst writing last byte

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
begin
	process(nRESET,clk16) is
		variable	last		: std_logic;					-- copy of load flag so we can watch edge
		variable	startload	: std_logic;					-- cached copy of load flag
		variable	working		: std_logic;

		variable	bit_out		: std_logic;
		variable	clk_out		: std_logic;

		variable	cached		: std_logic_vector(7 downto 0);			-- bits to transmit (latched on load rise)
		variable	shiftout	: std_logic_vector(7 downto 0);			-- bits to transmit
		variable	shiftin		: std_logic_vector(7 downto 0);			-- bits received
		variable	bits		: std_logic_vector(2 downto 0);			-- bit count processed (mod 8)
		variable	recvd		: std_logic_vector(7 downto 0);			-- bits received

		-- these variables hold the *new* copies

		variable	n_last		: std_logic;					-- copy of load flag so we can watch edge
		variable	n_startload	: std_logic;					-- cached copy of load flag
		variable	n_working	: std_logic;

		variable	n_bit_out	: std_logic;
		variable	n_clk_out	: std_logic;

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
			working				:= '0';

			bit_out				:= '0';
			clk_out				:= '0';

			cached				:= (others=>'0');
			shiftout			:= (others=>'0');
			shiftin				:= (others=>'0');
			bits				:= (others=>'0');
			recvd				:= (others=>'0');

		else
			-- copy the variables into the new settings
			n_last				:= last;
			n_startload			:= startload;
			n_working			:= working;
			n_bit_out			:= bit_out;
			n_clk_out			:= clk_out;
			n_cached			:= cached;
			n_shiftout			:= shiftout;
			n_shiftin			:= shiftin;
			n_bits				:= bits;
			n_recvd				:= recvd;

			if falling_edge(clk16) then							-- send a bit of data out
				-- first check to see if there's data waiting
				if load='1' and n_last='0' then
					n_startload	:= '1';
					n_cached	:= din;
				end if;
				n_last			:= load;
	
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
					n_clk_out	:= '0';					-- clock pulse
				else
					n_clk_out	:= clock_when_idle;
				end if;
	
			elsif rising_edge(clk16) then							-- read a bit of data out
				-- shift in a bit
				if working='1' then
					n_shiftin	:= n_shiftin(6 downto 0) & spi_do;	-- shift in the data
					n_clk_out	:= '1';					-- clock pulse
	
					n_bits		:= n_bits + 1;				-- count down the bits until we're finished
					if bits = "111" then
						n_working:= '0';
						n_recvd	:= n_shiftin;				-- latch the finished data
					end if;
				else
					n_clk_out	:= clock_when_idle;
				end if;
	
			end if;

			-- copy the variables from the new settings
			last				:= n_last;
			startload			:= n_startload;
			working				:= n_working;
			bit_out				:= n_bit_out;
			clk_out				:= n_clk_out;
			cached				:= n_cached;
			shiftout			:= n_shiftout;
			shiftin				:= n_shiftin;
			bits				:= n_bits;
			recvd				:= n_recvd;

		end if;

		-- update ports
		spi_di				<= bit_out;
		spi_clk				<= clk_out;
		dout				<= recvd;
		busy				<= working or startload;
	end process;

end impl;
