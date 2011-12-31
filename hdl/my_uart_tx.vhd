-- my_uart_tx.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity my_uart_tx is
  port (
     nrst       : in std_logic;
     clk16mhz   : in std_logic;

     load       : in std_logic;                                         -- triggered on rising edge
     data       : in std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
     empty      : out std_logic;

     txd        : out std_logic);
end entity;

architecture impl of my_uart_tx is
    signal  clkcount : std_logic_vector(10 downto 0);
    signal  shift : std_logic_vector(9 downto 0);

    signal  reqd       : std_logic;
    signal  isempty    : std_logic;

    signal  cached     : std_logic_vector(7 downto 0);

begin
    -- process data
    process(clk16mhz, nrst)
    begin
        if nrst = '0' then
            clkcount    <= (others=>'0');
            isempty     <= '1';
              empty     <= '1';
            reqd        <= '0';
            shift       <= (others=>'1');
        
        elsif rising_edge(clk16mhz) then
            if load='1' and reqd='0' then
                reqd        <= '1';
                empty       <= '0';
                cached      <= data;
            end if;

            if clkcount /= 0 then
                clkcount    <= clkcount + 1;
                  empty     <= '0';
            elsif isempty='0' then
                clkcount    <= CONV_STD_LOGIC_VECTOR(382,11);       -- 16MHz/9600 = 1666.67

                isempty     <= shift(9) and shift(8) and shift(7) and shift(6) and shift(5) and shift(4) and shift(3) and shift(2) and shift(1) and shift(0);
                  empty     <= shift(9) and shift(8) and shift(7) and shift(6) and shift(5) and shift(4) and shift(3) and shift(2) and shift(1) and shift(0) and not load;
                txd         <= shift(0);
                shift       <= "1" & shift(9 downto 1);
            else
                if load='0' and reqd='1' then               -- i.e. wait for falling edge of load
                clkcount    <= CONV_STD_LOGIC_VECTOR(382,11);       -- 16MHz/9600 = 1666.67
                    txd     <= '1';                         -- start bit
                    shift   <= '0' & cached & '0';          -- data plus stop bit
                    isempty <= '0';
                      empty <= '0';                         -- signal to external user that we're not empty
                       reqd <= '0';                         -- clear request flag
                else
                  empty     <= (not load) and (not reqd);   -- decide if we can accept data again now
                end if;
                txd         <= '1';                         -- start bit
            end if;
        end if;
    end process;
end impl;
