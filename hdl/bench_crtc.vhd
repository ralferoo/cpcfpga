-- bench_crtc.vhd

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity bench_crtc is
end bench_crtc;

architecture behavioral of bench_crtc is

    constant SYSCLK_PERIOD : time := 1000 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';


	-- crtc
	component crtc is port(
		nRESET			: in	std_logic;
		MA			: out	std_logic_vector(13 downto 0);
		DE			: out	std_logic;
		CLK			: in	std_logic;				-- CCLK (1mhz from gate array)
		RW			: in	std_logic;				-- A9
		E			: in	std_logic;				-- IORD' nor IOWR'
		RS			: in	std_logic;				-- A8
		nCS			: in	std_logic;				-- A14
		DIN			: in	std_logic_vector(7 downto 0);
		DOUT			: out	std_logic_vector(7 downto 0);		-- D conflated to DIN and DOUT
		RA			: out	std_logic_vector(3 downto 0);
		HSYNC, VSYNC		: out	std_logic);
	end component;
	signal	crtc_E			: 	std_logic;				-- IORD' nor IOWR'
	signal	crtc_CLK		: 	std_logic;
	signal	crtc_DIN		: 	std_logic_vector(7 downto 0);
	signal	crtc_DOUT		: 	std_logic_vector(7 downto 0);

	signal	crtc_DE			: 	std_logic;
	signal	crtc_MA			: 	std_logic_vector(13 downto 0);
	signal	crtc_RA			: 	std_logic_vector(3 downto 0);
	signal	crtc_HSYNC, crtc_VSYNC	: 	std_logic;

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


   	crtc_0 : crtc port map( nRESET=>NSYSRESET, MA=>crtc_MA, DE=>crtc_DE, CLK=>crtc_CLK,
				RW=>'1', E=>crtc_E, RS=>'0', nCS=>'0',
				DIN=>crtc_DIN, DOUT=>crtc_DOUT, RA=>crtc_RA, HSYNC=>crtc_HSYNC, VSYNC=>crtc_VSYNC);
	crtc_DIN <= (others=>'0');
	crtc_E	 <= '0';
	crtc_CLK <= SYSCLK;

    process(SYSCLK,NSYSRESET,crtc_HSYNC,crtc_VSYNC,crtc_DE,crtc_MA,crtc_RA)
    begin
        if NSYSRESET = '0' then

        elsif rising_edge(SYSCLK) then


        end if;
    end process;

end behavioral;

