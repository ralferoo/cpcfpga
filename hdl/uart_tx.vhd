-- my_uart_tx.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uart_tx is
	port (
		nrst       : in std_logic;
		clk16mhz   : in std_logic;
			
		load       : in std_logic;                                         -- triggered on rising edge
		data       : in std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
		empty      : out std_logic;
			
		txd        : out std_logic);
end entity;

architecture impl of uart_tx is
begin
	process(clk16mhz, nrst)
		variable	clkcount	: std_logic_vector(7 downto 0);
		variable	shift		: std_logic_vector(8 downto 0);

		variable	last		: std_logic;
		variable	isempty		: std_logic;
		variable	reqd		: std_logic;
		variable	cached		: std_logic_vector(7 downto 0);

		variable	bits		: std_logic_vector(3 downto 0);

	begin
		if nrst = '0' then
			clkcount	:= (others=>'0');
			isempty		:= '1';
			last		:= '0';
			reqd		:= '0';
			shift		:= (others=>'1');
			bits		:= "0000";
			cached		:= (others=>'0');

			txd		<= '1';
			empty		<= '1';
        
		elsif rising_edge(clk16mhz) then
			if load='1' and last='0' then
				reqd		:= '1';
				cached		:= data;
			end if;
			last := load;

			if clkcount /= 0 then
				clkcount	:= clkcount - 1;
			else
				--clkcount	:= CONV_STD_LOGIC_VECTOR(1666,11);       -- 16MHz/  9600 = 1666.67
				clkcount	:= CONV_STD_LOGIC_VECTOR( 139,8);        -- 16MHz/115200 =  138.88
				shift		:= '1' & shift(8 downto 1);

				if bits /= 0 then
					bits	:= bits - 1;
				elsif reqd = '1' then
					bits	:= "1010";
					shift	:= cached & '0';			-- stop bit '1' can be optimised away
					reqd	:= '0';
					isempty := '0';
				else
					isempty := '1';
				end if;
			end if;

			txd	<= shift(0);
			empty	<= isempty and not reqd;
		end if;
	end process;
end impl;
