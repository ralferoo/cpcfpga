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
	-- t80 from opencores.org
	component T80s is
		generic(
			Mode : integer := 0;	-- 0 => Z80, 1 => Fast Z80, 2 => 8080, 3 => GB
			T2Write : integer := 0;	-- 0 => WR_n active in T3, /=0 => WR_n active in T2
			IOWait : integer := 1	-- 0 => Single cycle I/O, 1 => Std I/O cycle
		);
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
	signal z80_WAIT_n, z80_INT_n, z80_NMI_n, z80_BUSRQ_n					: std_logic;       --  in to   CPU
	signal z80_M1_n, z80_MREQ_n, z80_IORQ_n, z80_RD_n, z80_WR_n, z80_RFSH_n, z80_HALT_n, z80_BUSAK_n	: std_logic;       -- out from CPU
	signal z80_A								: std_logic_vector(15 downto 0);
	signal z80_DI, z80_DO								: std_logic_vector(7 downto 0);
	signal z80_IORD_n, z80_IOWR_n							: std_logic;
	signal z80_clk           : std_logic;

    signal z80_DI_from_mem	: std_logic_vector(7 downto 0);
    signal z80_DI_from_iorq	: std_logic_vector(7 downto 0);
    signal z80_DI_is_from_iorq : std_logic;


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

			-- video output
			video_sync			: out std_logic;				-- 1 when sync pulse needed
			video_red,video_green,video_blue: out std_logic_vector(1 downto 0);		-- 2 bits per colour output
	
			-- sram interface
			sram_address			: out std_logic_vector(18 downto 0);
			sram_data			: inout std_logic_vector(7 downto 0);
			sram_we				: out std_logic;
			sram_ce				: out std_logic;				-- i might tie this low
			sram_oe				: out std_logic					-- could even tie this low
		);
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

	--signal	video_data		: std_logic_vector(7 downto 0);
	signal	video_sync			:     std_logic;				-- 1 when sync pulse needed
	signal	video_red,video_green,video_blue:     std_logic_vector(1 downto 0);		-- 2 bits per colour output

	-----------------------------------------------------------------------------------------------------------------------
	begin

        -- video
        video_sound <= '0';
	process(video_sync, video_red, video_green, video_blue)
	begin
		if video_sync='1' then
			video_sync2	<= "00";
			video_r2	<= "00";
			video_g2	<= "00";
			video_b2	<= "00";
		else
			video_sync2	<= dipsw(0) & (not dipsw(0));
			video_r2	<= video_red;
			video_g2	<= video_green;
			video_b2	<= video_blue;
		end if;
	end process;

        -- z80
        z80 : T80s generic map ( mode=>0, T2Write=>1, IOWait=>1 )
		   port map ( RESET_n=>nRESET, CLK_n=>z80_clk, 
                              WAIT_n=>z80_WAIT_n, INT_n=>z80_INT_n, NMI_n=>z80_NMI_n, BUSRQ_n=>z80_BUSRQ_n,
                              M1_n=>z80_M1_n, MREQ_n=>z80_MREQ_n, IORQ_n=>z80_IORQ_n, RD_n=>z80_RD_n, WR_n=>z80_WR_n, RFSH_n=>z80_RFSH_n, HALT_n=>z80_HALT_n, BUSAK_n=>z80_BUSAK_n,
                              A=>z80_A, DI=>z80_DI, DO=>z80_DO );
	z80_IORD_n <= z80_IORQ_n OR z80_RD_n;
	z80_IOWR_n <= z80_IORQ_n OR z80_WR_n;

        z80_INT_n <=   '1'; --pushsw(1);
        z80_NMI_n <=   '1'; --pushsw(2);
        z80_BUSRQ_n <= '1'; --pushsw(3);

	-- crtc
	crtc_0 : crtc port map( nRESET=>nRESET, MA=>crtc_MA, DE=>crtc_DE, CLK=>crtc_CLK,
				RW=>z80_A(9), E=>crtc_E, RS=>z80_A(8), nCS=>z80_A(14),
				DIN=>z80_DO, DOUT=>crtc_DOUT, RA=>crtc_RA, HSYNC=>crtc_HSYNC, VSYNC=>crtc_VSYNC);
	crtc_E	 <= z80_IORD_n nor z80_IOWR_n;

	-- gate array
	gate_array_0 : gate_array port map (
			nRESET				=> nRESET,
			clk16				=> clk16, 
	
			-- z80 basic functionality
			z80_clk				=> z80_clk,
			z80_din				=> z80_DI_from_mem,
			z80_dout			=> z80_DO,
			z80_a				=> z80_A,
			z80_wr_n			=> z80_WR_n,
	
			-- generation of wait states
			z80_rd_n			=> z80_RD_n,
			z80_m1_n			=> z80_M1_n,
			z80_iorq_n			=> z80_IORQ_n,
			z80_mreq_n			=> z80_MREQ_n,
			z80_wait_n			=> z80_WAIT_n,
	
			video_sync			=> video_sync,
			video_red			=> video_red,
			video_green			=> video_green,
			video_blue			=> video_blue,

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
	    z80_DI <= z80_DI_from_iorq when z80_DI_is_from_iorq='1' else z80_DI_from_mem;

	process(z80_clk,z80_MREQ_n,z80_RD_n)
	begin
		if rising_edge(z80_clk) then
			if z80_MREQ_n = '0' and z80_RD_n = '0' then
--				DI <= (others=>'0'); -- nops for now
--				leds <= not A(7 downto 0);
			end if;
		end if;
	end process;

        -- add switch input to port #fade
        process(nRESET,z80_clk,z80_IORQ_n,z80_RD_n,z80_A)
        begin
            if nRESET = '0' then
	    	z80_DI_is_from_iorq <= '0';
    	        z80_DI_from_iorq <= (others=>'0');
            
	    elsif rising_edge(z80_clk) then
	    	z80_DI_is_from_iorq <= '0';
    	        z80_DI_from_iorq <= (others=>'0');
	    	if z80_IORQ_n = '0' and z80_RD_n = '0' then

			if    z80_A(15 downto 0) = x"FADE" then
			    z80_DI_from_iorq <= not dipsw(7 downto 0);
	    		    z80_DI_is_from_iorq <= '1';

		    	elsif z80_A(15 downto 0) = x"FADD" then
			    z80_DI_from_iorq(7) <= my_uart_tx_empty;          		-- latch the empty flag data
			    z80_DI_from_iorq(3 downto 0) <= not pushsw(3 downto 0);
	    		    z80_DI_is_from_iorq <= '1';

		    	elsif z80_A(14)='0' then
			    z80_DI_from_iorq <= crtc_DOUT;
	    		    z80_DI_is_from_iorq <= '1';
			end if;
		end if;
            end if;
        end process;
	
        -- add LED output to port #fade
        process(nRESET,z80_clk,z80_IORQ_n,z80_WR_n,z80_A)
        begin
            if nRESET = '0' then
                leds		<= (others=>'0');
		my_uart_tx_data	<= (others=>'0');
		my_uart_tx_load <= '0';
            
	    elsif rising_edge(z80_clk) then
		my_uart_tx_load <= '0';

		    if z80_IORQ_n = '0' and z80_WR_n = '0' and z80_A(15 downto 0) = x"FADC" then
			my_uart_tx_data	<= z80_DO;
	    		my_uart_tx_load <= '1';
            
	         elsif z80_IORQ_n = '0' and z80_WR_n = '0' and z80_A(15 downto 0) = x"FADE" then
		        leds <= not z80_DO(7 downto 0);

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
