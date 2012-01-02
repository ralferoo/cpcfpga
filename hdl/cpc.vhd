-- cpc.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cpc is
	port(
		nRESET			: in  std_logic;
		clk16			: in  std_logic;
		pushsw			: in  std_logic_vector(3 downto 0);
		dipsw			: in  std_logic_vector(7 downto 0);

		uart_rx			: in  std_logic;
		uart_tx			: out std_logic;

		dummy			: out std_logic;
		leds			: out std_logic_vector(7 downto 0);

		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_ce			: out std_logic;	                                    -- i might tie this low
		sram_oe			: out std_logic;                                        -- could even tie this low

		video_sync2,video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sound                                 : out  std_logic
	);
end cpc;

architecture impl of cpc is
	-- PLL
	signal clk_divider      : std_logic_vector(15 downto 0);        -- (0)=8mhz, (1)=4mhz, (2)=2mhz, (3)=1mhz
	signal clk4,clk1        : std_logic;
	signal cpuclk           : std_logic;

	-- t80 from opencores.org
	component T80s is
		port(
			RESET_n		: in std_logic;
			CLK_n		: in std_logic;
			WAIT_n		: in std_logic;
			INT_n		: in std_logic;
			NMI_n		: in std_logic;
			BUSRQ_n		: in std_logic;
			M1_n		: out std_logic;
			MREQ_n		: out std_logic;
			IORQ_n		: out std_logic;
			RD_n		: out std_logic;
			WR_n		: out std_logic;
			RFSH_n		: out std_logic;
			HALT_n		: out std_logic;
			BUSAK_n		: out std_logic;
			A		: out std_logic_vector(15 downto 0);
			DI		: in std_logic_vector(7 downto 0);
			DO		: out std_logic_vector(7 downto 0)
		);
	end component;
	signal WAIT_n, INT_n, NMI_n, BUSRQ_n					: std_logic;       --  in to   CPU
	signal M1_n, MREQ_n, IORQ_n, RD_n, WR_n, RFSH_n, HALT_n, BUSAK_n	: std_logic;       -- out from CPU
	signal A								: std_logic_vector(15 downto 0);
	signal DI, DO								: std_logic_vector(7 downto 0);
	signal IORD_n, IOWR_n							: std_logic;

    signal DI_from_mem	: std_logic_vector(7 downto 0);
    signal DI_from_iorq	: std_logic_vector(7 downto 0);
    signal DI_is_from_iorq : std_logic;


    	-- gate array
	component gate_array is
		port(
			nRESET				: in  std_logic;
			clk16				: in  std_logic;				-- master clock input @ 16 MHz
	
			-- z80 basic functionality
			z80_clk				: out std_logic;				-- generated Z80 clock @ 4 MHz
			z80_din				: out std_logic_vector(7 downto 0);		-- data bus input to z80
			z80_dout			: in  std_logic_vector(7 downto 0);		-- data bus output from z80
			z80_a				: in  std_logic_vector(15 downto 0);		-- address bus output from z80
			z80_wr_n			: in  std_logic;				-- used for gate array out
	
			-- generation of wait states
			z80_rd_n			: in  std_logic;				-- used in determining wait flag
			z80_m1_n			: in  std_logic;				-- used in determining wait flag
			z80_iorq_n			: in  std_logic;				-- used in determining wait flag
			z80_mreq_n			: in  std_logic;				-- used in determining wait flag
			z80_wait_n			: out std_logic;				-- determines in the CPU should be paused
	
			-- crtc interface (for screen reading)
			crtc_clk			: out std_logic;				-- generated crtc clock @ 4MHz
			crtc_ma				: in  std_logic_vector(13 downto 0);		-- address generated by crtc
			crtc_ra				: in  std_logic_vector(3 downto 0);		-- address generated by crtc		
			crtc_hsync, crtc_vsync		: in  std_logic;				-- sync pulses from crtc
			crtc_de				: in  std_logic;				-- display enable from crtc

			video_data			: out std_logic_vector(7 downto 0);
	
			-- sram interface
			sram_address			: out std_logic_vector(18 downto 0);
			sram_data			: inout std_logic_vector(7 downto 0);
			sram_we				: out std_logic;
			sram_ce				: out std_logic;				-- i might tie this low
			sram_oe				: out std_logic					-- could even tie this low
		);
	end component;
    
	-- my ram code, obsoleted by gate_array
	component memory_mux is port(
		nrst			: in  std_logic;

		MREQ_n			: in std_logic;
		IORQ_n			: in std_logic;
		RD_n			: in std_logic;
		WR_n			: in std_logic;
		A			: in std_logic_vector(15 downto 0);
		DI			: out std_logic_vector(7 downto 0);		-- these are named as per CPU view
		DO			: in std_logic_vector(7 downto 0);		-- these are named as per CPU view

		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_ce			: out std_logic;				-- i might tie this low
		sram_oe			: out std_logic;				-- could even tie this low

		clk			: in std_logic);
	end component;
	
	-- uart tx
	component my_uart_tx is port (
		nrst       : in std_logic;
		clk16mhz   : in std_logic;

		load       : in std_logic;                                         -- triggered on rising edge
		data       : in std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
		empty      : out std_logic;
			
		txd        : out std_logic);
	end component;

	signal my_uart_tx_empty, my_uart_tx_load : std_logic;
	signal my_uart_tx_data                                      : std_logic_vector(7 downto 0); 
	signal my_uart_tx_txd                                       : std_logic;

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
	signal	crtc_DOUT		: 	std_logic_vector(7 downto 0);

	signal	crtc_DE			: 	std_logic;
	signal	crtc_MA			: 	std_logic_vector(13 downto 0);
	signal	crtc_RA			: 	std_logic_vector(3 downto 0);
	signal	crtc_HSYNC, crtc_VSYNC	: 	std_logic;

	signal	video_data		: std_logic_vector(7 downto 0);

	-----------------------------------------------------------------------------------------------------------------------
	begin
	-- generate the master clock
        process (clk16)
        begin
            if rising_edge(clk16) then
                clk_divider <= clk_divider + 1;
            end if;
        end process;
--	cpuclk <=    clk_divider(1) when dipsw(7 downto 6)="00"
--		else clk_divider(7) when dipsw(7 downto 6)="01"
--		else clk_divider(11) when dipsw(7 downto 6)="10"
--		else clk_divider(15);
	clk4 <= clk_divider(1);
	clk1 <= clk_divider(3);

        -- video
        video_sound <= '0';
	process(crtc_HSYNC, crtc_VSYNC, crtc_DE, crtc_MA, crtc_RA)
	begin
		if crtc_HSYNC='1' or crtc_VSYNC='1' then
			video_sync2	<= "00";
			video_r2	<= "00";
			video_g2	<= "00";
			video_b2	<= "00";
		elsif crtc_DE='0' then
			video_sync2	<= dipsw(0) & (not dipsw(0));
			video_r2	<= "00";
			video_g2	<= "00";
			video_b2	<= "00";
		else
			video_sync2	<= (crtc_MA(5) or crtc_MA(0)) & (crtc_MA(6) or not crtc_MA(0)); --dipsw(0) & (not dipsw(0));
			video_r2	<= video_data(5 downto 4);
			video_g2	<= video_data(3 downto 2);
			video_b2	<= video_data(1 downto 0);
--			video_r2	<= crtc_RA(2 downto 1);
--			video_g2	<= crtc_MA(2 downto 1);
--			video_b2	<= crtc_MA(4 downto 3);
		end if;
	end process;

        -- z80
        z80 : T80s port map ( RESET_n=>nRESET, CLK_n=>cpuclk, 
                              WAIT_n=>WAIT_n, INT_n=>INT_n, NMI_n=>NMI_n, BUSRQ_n=>BUSRQ_n,
                              M1_n=>M1_n, MREQ_n=>MREQ_n, IORQ_n=>IORQ_n, RD_n=>RD_n, WR_n=>WR_n, RFSH_n=>RFSH_n, HALT_n=>HALT_n, BUSAK_n=>BUSAK_n,
                              A=>A, DI=>DI, DO=>DO );
	IORD_n <= IORQ_n OR RD_n;
	IOWR_n <= IORQ_n OR WR_n;

--        WAIT_n <=  '1'; --pushsw(0) and (nWAIT_uart_tx or not pushsw(3));
        INT_n <=   '1'; --pushsw(1);
        NMI_n <=   '1'; --pushsw(2);
        BUSRQ_n <= '1'; --pushsw(3);

	-- crtc
	crtc_0 : crtc port map( nRESET=>nRESET, MA=>crtc_MA, DE=>crtc_DE, CLK=>crtc_CLK,
				RW=>A(9), E=>crtc_E, RS=>A(8), nCS=>A(14),
				DIN=>DO, DOUT=>crtc_DOUT, RA=>crtc_RA, HSYNC=>crtc_HSYNC, VSYNC=>crtc_VSYNC);
	crtc_E	 <= IORD_n nor IOWR_n;
--	crtc_CLK <= clk1;

	-- gate array
	gate_array_0 : gate_array port map (
			nRESET				=> nRESET,
			clk16				=> clk16, 
	
			-- z80 basic functionality
			z80_clk				=> cpuclk,
			z80_din				=> DI_from_mem,
			z80_dout			=> DO,
			z80_a				=> A,
			z80_wr_n			=> WR_n,
	
			-- generation of wait states
			z80_rd_n			=> RD_n,
			z80_m1_n			=> M1_n,
			z80_iorq_n			=> IORQ_n,
			z80_mreq_n			=> MREQ_n,
			z80_wait_n			=> WAIT_n,
	
			video_data			=> video_data,

			-- crtc interface (for screen reading)
			crtc_clk			=> crtc_CLK,
			crtc_ma				=> crtc_MA,
			crtc_ra				=> crtc_RA,
			crtc_hsync			=> crtc_HSYNC,
			crtc_vsync			=> crtc_VSYNC,
			crtc_de				=> crtc_DE,
	
			-- sram interface
			sram_address=>sram_address, sram_data=>sram_data, sram_we=>sram_we, sram_ce=>sram_ce, sram_oe=>sram_oe );

        -- memory
--        memory : memory_mux port map ( nrst=>nRESET, clk=>clk16, 
--            MREQ_n=>MREQ_n, IORQ_n=>IORQ_n, RD_n=>RD_n, WR_n=>WR_n, A=>A, DI=>DI_from_mem, DO=>DO,
--            sram_address=>sram_address, sram_data=>sram_data, sram_we=>sram_we, sram_ce=>sram_ce, sram_oe=>sram_oe );

	    DI <= DI_from_iorq when DI_is_from_iorq='1' else DI_from_mem;

	process(cpuclk,MREQ_n,RD_n)
	begin
		if rising_edge(cpuclk) then
			if MREQ_n = '0' and RD_n = '0' then
--				DI <= (others=>'0'); -- nops for now
--				leds <= not A(7 downto 0);
			end if;
		end if;
	end process;

        -- add switch input to port #fade
        process(nRESET,cpuclk,IORQ_n,RD_n,A)
        begin
            if nRESET = '0' then
	    	DI_is_from_iorq <= '0';
    	        DI_from_iorq <= (others=>'0');
            
	    elsif rising_edge(cpuclk) then
	    	DI_is_from_iorq <= '0';
    	        DI_from_iorq <= (others=>'0');
	    	if IORQ_n = '0' and RD_n = '0' then

			if    A(15 downto 0) = x"FADE" then
			    DI_from_iorq <= not dipsw(7 downto 0);
	    		    DI_is_from_iorq <= '1';

		    	elsif A(15 downto 0) = x"FADD" then
			    DI_from_iorq(7) <= my_uart_tx_empty;          		-- latch the empty flag data
			    DI_from_iorq(3 downto 0) <= not pushsw(3 downto 0);
	    		    DI_is_from_iorq <= '1';

		    	elsif A(14)='0' then
			    DI_from_iorq <= crtc_DOUT;
	    		    DI_is_from_iorq <= '1';
			end if;
		end if;
            end if;
        end process;
	
        -- add LED output to port #fade
        process(nRESET,cpuclk,IORQ_n,WR_n,A)
        begin
            if nRESET = '0' then
                leds		<= (others=>'0');
		my_uart_tx_data	<= (others=>'0');
		my_uart_tx_load <= '0';
            
	    elsif rising_edge(cpuclk) then
		my_uart_tx_load <= '0';

		    if IORQ_n = '0' and WR_n = '0' and A(15 downto 0) = x"FADC" then
			my_uart_tx_data	<= DO;
	    		my_uart_tx_load <= '1';
            
	         elsif IORQ_n = '0' and WR_n = '0' and A(15 downto 0) = x"FADE" then
		        leds <= not DO(7 downto 0);

		end if;
            end if;
        end process;
	
        -- use dummy pins
        dummy <= dipsw   (0) xor dipsw   (1) xor dipsw   (2) xor dipsw   (3) xor dipsw   (4) xor dipsw   (5) xor dipsw   (6) xor dipsw   (7) xor 
                 pushsw  (0) xor pushsw  (1) xor pushsw  (2) xor pushsw  (3) xor
                 uart_rx xor nRESET;

        -- uart echo
        my_tx  : my_uart_tx port map( nrst=>nreset, clk16mhz=>clk16, txd=>my_uart_tx_txd , load=>my_uart_tx_load , data=>my_uart_tx_data , empty=>my_uart_tx_empty );
        uart_tx <= my_uart_tx_txd;

end impl;
