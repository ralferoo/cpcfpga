-- dac2bit.vhd

library IEEE;
use ieee.std_logic_1164.all;


entity dac2bit is
    port(
        clk128      : in std_logic;
        data        : in std_logic_vector(1 downto 0);
        bitstream   : out std_logic
    );
end dac2bit;

architecture DEF_ARCH of dac2bit is

signal selector : std_logic;

begin
    process(clk128, data)
    begin
        if rising_edge(clk128) then

            bitstream <= ( data(0) and selector ) or ( data(1) and not selector );
            selector  <= not selector;

        end if;
    end process;

end DEF_ARCH;



