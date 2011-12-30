-- Version: 9.1 9.1.0.18

library ieee;
use ieee.std_logic_1164.all;
library igloo;
use igloo.all;

entity PLL16mhz is 
    port(POWERDOWN, CLKA : in std_logic;  LOCK, GLA : out 
        std_logic) ;
end PLL16mhz;


architecture DEF_ARCH of  PLL16mhz is

    component PLL
    generic (VCOFREQUENCY:real := 0.0);

        port(CLKA, EXTFB, POWERDOWN : in std_logic := 'U'; GLA, 
        LOCK, GLB, YB, GLC, YC : out std_logic;  OADIV0, OADIV1, 
        OADIV2, OADIV3, OADIV4, OAMUX0, OAMUX1, OAMUX2, DLYGLA0, 
        DLYGLA1, DLYGLA2, DLYGLA3, DLYGLA4, OBDIV0, OBDIV1, 
        OBDIV2, OBDIV3, OBDIV4, OBMUX0, OBMUX1, OBMUX2, DLYYB0, 
        DLYYB1, DLYYB2, DLYYB3, DLYYB4, DLYGLB0, DLYGLB1, DLYGLB2, 
        DLYGLB3, DLYGLB4, OCDIV0, OCDIV1, OCDIV2, OCDIV3, OCDIV4, 
        OCMUX0, OCMUX1, OCMUX2, DLYYC0, DLYYC1, DLYYC2, DLYYC3, 
        DLYYC4, DLYGLC0, DLYGLC1, DLYGLC2, DLYGLC3, DLYGLC4, 
        FINDIV0, FINDIV1, FINDIV2, FINDIV3, FINDIV4, FINDIV5, 
        FINDIV6, FBDIV0, FBDIV1, FBDIV2, FBDIV3, FBDIV4, FBDIV5, 
        FBDIV6, FBDLY0, FBDLY1, FBDLY2, FBDLY3, FBDLY4, FBSEL0, 
        FBSEL1, XDLYSEL, VCOSEL0, VCOSEL1, VCOSEL2 : in std_logic := 
        'U') ;
    end component;

    component PLLINT
        port(A : in std_logic := 'U'; Y : out std_logic) ;
    end component;

    component VCC
        port( Y : out std_logic);
    end component;

    component GND
        port( Y : out std_logic);
    end component;

    signal CLKAP, VCC_1_net, GND_1_net : std_logic ;
    begin   

    VCC_2_net : VCC port map(Y => VCC_1_net);
    GND_2_net : GND port map(Y => GND_1_net);
    Core : PLL
      generic map(VCOFREQUENCY => 80.000)

      port map(CLKA => CLKAP, EXTFB => GND_1_net, POWERDOWN => 
        POWERDOWN, GLA => GLA, LOCK => LOCK, GLB => OPEN , YB => 
        OPEN , GLC => OPEN , YC => OPEN , OADIV0 => GND_1_net, 
        OADIV1 => GND_1_net, OADIV2 => VCC_1_net, OADIV3 => 
        GND_1_net, OADIV4 => GND_1_net, OAMUX0 => GND_1_net, 
        OAMUX1 => GND_1_net, OAMUX2 => VCC_1_net, DLYGLA0 => 
        GND_1_net, DLYGLA1 => GND_1_net, DLYGLA2 => GND_1_net, 
        DLYGLA3 => GND_1_net, DLYGLA4 => GND_1_net, OBDIV0 => 
        GND_1_net, OBDIV1 => GND_1_net, OBDIV2 => GND_1_net, 
        OBDIV3 => GND_1_net, OBDIV4 => GND_1_net, OBMUX0 => 
        GND_1_net, OBMUX1 => GND_1_net, OBMUX2 => GND_1_net, 
        DLYYB0 => GND_1_net, DLYYB1 => GND_1_net, DLYYB2 => 
        GND_1_net, DLYYB3 => GND_1_net, DLYYB4 => GND_1_net, 
        DLYGLB0 => GND_1_net, DLYGLB1 => GND_1_net, DLYGLB2 => 
        GND_1_net, DLYGLB3 => GND_1_net, DLYGLB4 => GND_1_net, 
        OCDIV0 => GND_1_net, OCDIV1 => GND_1_net, OCDIV2 => 
        GND_1_net, OCDIV3 => GND_1_net, OCDIV4 => GND_1_net, 
        OCMUX0 => GND_1_net, OCMUX1 => GND_1_net, OCMUX2 => 
        GND_1_net, DLYYC0 => GND_1_net, DLYYC1 => GND_1_net, 
        DLYYC2 => GND_1_net, DLYYC3 => GND_1_net, DLYYC4 => 
        GND_1_net, DLYGLC0 => GND_1_net, DLYGLC1 => GND_1_net, 
        DLYGLC2 => GND_1_net, DLYGLC3 => GND_1_net, DLYGLC4 => 
        GND_1_net, FINDIV0 => VCC_1_net, FINDIV1 => VCC_1_net, 
        FINDIV2 => GND_1_net, FINDIV3 => GND_1_net, FINDIV4 => 
        GND_1_net, FINDIV5 => GND_1_net, FINDIV6 => GND_1_net, 
        FBDIV0 => VCC_1_net, FBDIV1 => VCC_1_net, FBDIV2 => 
        VCC_1_net, FBDIV3 => VCC_1_net, FBDIV4 => GND_1_net, 
        FBDIV5 => GND_1_net, FBDIV6 => GND_1_net, FBDLY0 => 
        GND_1_net, FBDLY1 => GND_1_net, FBDLY2 => GND_1_net, 
        FBDLY3 => GND_1_net, FBDLY4 => GND_1_net, FBSEL0 => 
        VCC_1_net, FBSEL1 => GND_1_net, XDLYSEL => GND_1_net, 
        VCOSEL0 => GND_1_net, VCOSEL1 => GND_1_net, VCOSEL2 => 
        VCC_1_net);
    pllint1 : PLLINT
      port map(A => CLKA, Y => CLKAP);
end DEF_ARCH;

-- _Disclaimer: Please leave the following comments in the file, they are for internal purposes only._


-- _GEN_File_Contents_

-- Version:9.1.0.18
-- ACTGENU_CALL:1
-- BATCH:T
-- FAM:IGLOO
-- OUTFORMAT:VHDL
-- LPMTYPE:LPM_PLL_STATIC
-- LPM_HINT:NONE
-- INSERT_PAD:NO
-- INSERT_IOREG:NO
-- GEN_BHV_VHDL_VAL:F
-- GEN_BHV_VERILOG_VAL:F
-- MGNTIMER:F
-- MGNCMPL:T
-- DESDIR:C:/fpga/cpcfpga/smartgen\PLL16mhz
-- GEN_BEHV_MODULE:T
-- SMARTGEN_DIE:UM4X4M1NLPLV
-- SMARTGEN_PACKAGE:vq100
-- AGENIII_IS_SUBPROJECT_LIBERO:T
-- FIN:20.000000
-- CLKASRC:1
-- FBDLY:1
-- FBMUX:1
-- XDLYSEL:0
-- PRIMFREQ:16.000000
-- PPHASESHIFT:0
-- DLYAVAL:1
-- OAMUX:4
-- POWERDOWN_POLARITY:0
-- LOCK_POLARITY:1
-- LOCK_CTL:0
-- VOLTAGE:1.5

-- _End_Comments_

