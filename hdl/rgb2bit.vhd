-- rgb2bit.vhd

library IEEE;
use ieee.std_logic_1164.all;


entity rgb2bit is
    port(
        clk128      : in std_logic;
        clk         : in std_logic;
        rgb_in      : in std_logic_vector(5 downto 0);
        r_out       : out std_logic;
        g_out       : out std_logic;
        b_out       : out std_logic
    );
end rgb2bit;

architecture DEF_ARCH of rgb2bit is

    component dac2bit is
        port(
            clk128      : in std_logic;
            data        : in std_logic_vector(1 downto 0);
            bitstream   : out std_logic
        );
    end component;

    signal rgb : std_logic_vector(5 downto 0);

    begin

        r_dac: dac2bit port map ( clk128 => clk128, data => rgb(5 downto 4), bitstream => r_out);
        g_dac: dac2bit port map ( clk128 => clk128, data => rgb(3 downto 2), bitstream => g_out);
        b_dac: dac2bit port map ( clk128 => clk128, data => rgb(1 downto 0), bitstream => b_out);

        process(clk, rgb_in)
        begin
            if rising_edge(clk) then
                rgb <= rgb_in;
            end if;
        end process;

    end DEF_ARCH;



