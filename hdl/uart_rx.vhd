-- my_uart_tx.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity uart_rx is
	port (
		nrst       : in std_logic;
		clk16mhz   : in std_logic;

		clear      : in  std_logic;                                          -- triggered on rising edge
		data       : out std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
		avail      : out std_logic;
		errorfound : out std_logic;

		rxd        : in  std_logic);
end entity;

architecture impl of uart_rx is
	type t_rxbyte is record
		byte		: std_logic_vector(7 downto 0);
		full		: std_logic;
	end record;

	constant BUFFER_SIZE:	integer := 3;
	type t_rxbuffer is array(0 to BUFFER_SIZE-1) of t_rxbyte; 

	type t_state is ( IDLE, START, RECV, STOP );
begin
	process(clk16mhz, nrst)
		variable	data_out	: t_rxbuffer;

		variable	error_found	: std_logic;
		variable	shift		: std_logic_vector(7 downto 0);
		variable	clkcount	: std_logic_vector(7 downto 0);

		variable	last		: std_logic;

		variable	bits		: std_logic_vector(3 downto 0);
		variable	state		: t_state;

		variable	rxclean, retime	: std_logic;
	begin
		if nrst = '0' then
			clkcount	:= (others=>'0');
			last		:= '0';
			shift		:= (others=>'1');
			bits		:= "0000";
			state		:= IDLE;
			rxclean		:= '0';
			retime		:= '0';
			error_found	:= '0';

			for i in BUFFER_SIZE-1 downto 0 loop
				data_out(i)  .full	:= '0';
				data_out(i)  .byte	:= (others=>'0');
			end loop;

			-- process the incoming bits
		elsif rising_edge(clk16mhz) then
			if clear='1' and last='0' then
				data_out(0).full	:= '0';
				error_found		:= '0';
			end if;
			last := clear;

			-- shift data through the buffer maximum 1 space per clock (to reduce muxes, hopefully)
			for i in BUFFER_SIZE-1 downto 1 loop
				if data_out(i-1).full = '0' and data_out(i).full = '1'  then
					data_out(i-1).byte	:= data_out(i).byte;
					data_out(i-1).full	:= '1';
					data_out(i)  .full	:= '0';
				end if;
			end loop;

			-- process the incoming bits
			if clkcount /= 0 then
				clkcount	:= clkcount - 1;
			else
				clkcount	:= CONV_STD_LOGIC_VECTOR( 139,8);        -- 16MHz/115200 =  138.88

				-- we've reached the next bit
				case state is
					when IDLE =>
						if rxclean='0' then
							bits		:= "1000";
							state 		:= START;				-- skip 1/2 bit
							clkcount	:= CONV_STD_LOGIC_VECTOR( 69,8);	-- 16MHz*0.5/115200=69.44
						else
							clkcount	:= (others=>'0');			-- find next edge
						end if;
	
					when START =>
						if rxclean='0' then
							state		:= RECV;
						else
							state		:= IDLE;
							error_found	:= '1';
						end if;
	
					when RECV =>
						shift			:= rxclean & shift(7 downto 1);		-- shift in the bit
						bits			:= bits - 1;
						if bits = 0 then
							state				:= STOP;
							data_out(BUFFER_SIZE-1).byte	:= shift;
							data_out(BUFFER_SIZE-1).full	:= '1';
						end if;
	
					when STOP =>
						if rxclean='0' then						-- error if we see data
							error_found	:= '1';					-- in the stop bit
						end if;
						state			:= IDLE;				-- back to idle
						clkcount		:= (others=>'0');
		
				end case;
			end if;

			-- retime the input signal twice to remove noise
			rxclean	:= retime;
			retime	:= rxd;

			-- output the available data state
			data		<= data_out(0).byte;
			avail		<= data_out(0).full;
			errorfound	<= error_found;
		end if;
	end process;
end impl;
