-- bench_uarts.vhd

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity bench_uarts is
end bench_uarts;

architecture behavioral of bench_uarts is

    constant SYSCLK_PERIOD : time := 1000 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component uart_tx is
  	port (
     	nrst       : in std_logic;
     	clk16mhz   : in std_logic;
	
     	load       : in std_logic;                                         -- triggered on rising edge
     	data       : in std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
     	empty      : out std_logic;
	
     	txd        : out std_logic);
     end component;
	
     component uart_rx is
  	port (
     	nrst       : in std_logic;
     	clk16mhz   : in std_logic;
	
     	clear      : in  std_logic;                                          -- triggered on rising edge
     	data       : out std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
     	avail      : out std_logic;
	
     	rxd        : in  std_logic);
     end component;
	
	signal	tx_out			: 	std_logic_vector(7 downto 0);
	signal	tx_empty		: 	std_logic;
	signal	tx_load			: 	std_logic;
	signal	tx_txd			: 	std_logic;

	signal	rx_in			: 	std_logic_vector(7 downto 0);
	signal	rx_full			: 	std_logic;
	signal	rx_clear		: 	std_logic;
	signal	rx_rxd			: 	std_logic;

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

    uart_tx_0 : uart_tx port map( nrst=>NSYSRESET, clk16mhz=>SYSCLK, txd=>tx_txd, load=>tx_load, data=>tx_out, empty=>tx_empty );
    uart_rx_0 : uart_rx port map( nrst=>NSYSRESET, clk16mhz=>SYSCLK, rxd=>rx_rxd, clear=>rx_clear, data=>rx_in, avail=>rx_full );

    process (NSYSRESET, SYSCLK)
	    variable	byte	: std_logic_vector(7 downto 0);
	    variable	pause	: std_logic_vector(3 downto 0);
    begin
	if NSYSRESET = '0' then
		tx_out		<= (others=>'0');
		tx_load		<= '0';
		byte		:= (others=>'0');
		pause		:= (others=>'0');
				
		rx_clear	<= '0';
		rx_rxd		<= '1';
		    
	elsif rising_edge(SYSCLK) then

    		-- echo the tx data back through our rx port
    		rx_rxd <= tx_txd;

		-- send the dummy output through the transmit port
		if tx_empty = '1' then
			if pause = 0 then
				tx_out	<= byte;
				byte	:= byte + 1;
				tx_load	<= '1';
				pause	:= "1111";
			else
				pause	:= pause -1;
			end if;
		else
			tx_load	<= '0';
		end if;

		-- check for new data
		if rx_full = '1' then
			report "Received byte " & integer'image(to_integer(ieee.numeric_std.unsigned(rx_in)));
			rx_clear	<= '1';
		else
			rx_clear	<= '0';
		end if;

	    end if;
    end process;
end behavioral;

