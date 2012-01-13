-- Version: 9.1 9.1.0.18

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity bootrom_internal is 
    port(CLK : in std_logic; ADDR : in std_logic_vector(6 downto 
        0); DOUT : out std_logic_vector(7 downto 0)) ;
end bootrom_internal;


architecture DEF_ARCH of  bootrom_internal is

    component UFROMH
    generic (MEMORYFILE:string := ""; ACT_PROGFILE:string := ""
        );

        port(CLK : in std_logic := 'U'; DO0, DO1, DO2, DO3, DO4, 
        DO5, DO6, DO7 : out std_logic;  ADDR0, ADDR1, ADDR2, 
        ADDR3, ADDR4, ADDR5, ADDR6 : in std_logic := 'U') ;
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal U_7_PIN2 : std_logic ;
    begin   

    GND_1_net : GND port map(Y => U_7_PIN2);
    UFROM0 : UFROMH
      generic map(MEMORYFILE => "bootrom_internal.mem",
         ACT_PROGFILE => "bootrom_internal.ufc")

      port map(CLK => CLK, DO0 => DOUT(0), DO1 => DOUT(1), DO2 => 
        DOUT(2), DO3 => DOUT(3), DO4 => DOUT(4), DO5 => DOUT(5), 
        DO6 => DOUT(6), DO7 => DOUT(7), ADDR0 => ADDR(0), 
        ADDR1 => ADDR(1), ADDR2 => ADDR(2), ADDR3 => ADDR(3), 
        ADDR4 => ADDR(4), ADDR5 => ADDR(5), ADDR6 => ADDR(6));
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.0.18
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:IGLOO
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_FROM
-- LPM_HINT:NONE
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/fpga/cpcfpga/smartgen\bootrom_internal
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:UM4X4M1NLPLV
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- MEMFILE:bootrom_internal.mem
-- UFCFILE:bootrom_internal.ufc

-- _End_Comments_

