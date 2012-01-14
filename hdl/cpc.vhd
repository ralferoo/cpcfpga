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

		rxd			: in  std_logic;
		txd			: out std_logic;

		dummy			: out std_logic;
		leds			: out std_logic_vector(5 downto 0);

		ps2_clock		: inout std_logic;
		ps2_data		: inout std_logic;

		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_ce			: out std_logic;	                                    -- i might tie this low
		sram_oe			: out std_logic;                                        -- could even tie this low

		bootrom_addr        	: out std_logic_vector(13 downto 0);		-- address set here
		bootrom_data        	: in  std_logic_vector(7 downto 0);		-- data becomes available here
		bootrom_clk        	: out std_logic;				-- clock for bootrom

		spi_clk			: out  std_logic;				-- connected to SPI clock
		spi_di			: out  std_logic;				-- connected to SPI slave DI
		spi_do			: in   std_logic;				-- connected to SPI slave DO
		spi_flash_cs		: out  std_logic;				-- connected to flash rom CS

		video_sync2,video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sound                                 : out  std_logic
	);
end cpc;

architecture impl of cpc is
	signal video_sound2 		: std_logic;			-- should be in entity definition

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

			-- interrupt generation
			z80_int_n			: out std_logic;				-- interrupt acknowledge

			-- psg interface
			psg_clk				: out std_logic;				-- generated psg clock @ 1MHz
	
			-- crtc interface (for screen reading)
			crtc_clk			: out std_logic;				-- generated crtc clock @ 1MHz
			crtc_ma				: in  std_logic_vector(13 downto 0);		-- address generated by crtc
			crtc_ra				: in  std_logic_vector(3 downto 0);		-- address generated by crtc		
			crtc_hsync, crtc_vsync		: in  std_logic;				-- sync pulses from crtc
			crtc_de				: in  std_logic;				-- display enable from crtc

			-- video output
			video_sync			: out std_logic;				-- 1 when sync pulse needed
			video_red,video_green,video_blue: out std_logic_vector(1 downto 0);		-- 2 bits per colour output

			-- bootrom interface
        		bootrom_addr        		: out std_logic_vector(13 downto 0);		-- address set here
        		bootrom_data        		: in  std_logic_vector(7 downto 0);		-- data becomes available here
	
			-- sram interface
			sram_address			: out std_logic_vector(18 downto 0);
			sram_data			: inout std_logic_vector(7 downto 0);
			sram_we				: out std_logic;
			sram_ce				: out std_logic;				-- i might tie this low
			sram_oe				: out std_logic					-- could even tie this low
		);
	end component;
    
	-- uart
	component uart_tx is port (
		nrst       : in std_logic;
		clk16mhz   : in std_logic;

		load       : in std_logic;                                         -- triggered on rising edge
		data       : in std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
		empty      : out std_logic;
			
		txd        : out std_logic);
	end component;

	signal uart_tx_empty, uart_tx_load			: std_logic;
	signal uart_tx_data					: std_logic_vector(7 downto 0); 
	signal uart_tx_txd					: std_logic;

	component uart_rx is
		port (
			nrst       : in std_logic;
			clk16mhz   : in std_logic;

			clear      : in  std_logic;                                          -- triggered on rising edge
			data       : out std_logic_vector(7 downto 0);                      -- must be latchable as load goes high
			avail      : out std_logic;
			errorfound : out std_logic;

			rxd        : in  std_logic);
	end component;

	signal uart_rx_avail, uart_rx_clear, uart_rx_error	: std_logic;
	signal uart_rx_data					: std_logic_vector(7 downto 0); 
	signal uart_rx_rxd					: std_logic;

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

	-- SPI (for rom and SD card access)
	component spi is
	port(
		nRESET				: in  std_logic;
		clk16				: in  std_logic;				-- master clock input @ 16 MHz

		-- IO mapping
		write				: in  std_logic_vector(7 downto 0);		-- byte data to write
		read				: out std_logic_vector(7 downto 0);		-- byte data read whilst writing last byte

		-- SPI data lines
		spi_clk				: out  std_logic;				-- connected to SPI clock
		spi_di				: out  std_logic;				-- connected to SPI slave DI
		spi_do				: in   std_logic;				-- connected to SPI slave DO

		-- control
		load				: in  std_logic;				-- begin transfer on rising edge
		busy				: out std_logic;				-- 1 when in a transfer currently
		clock_when_idle			: in  std_logic					-- CPOL&CPHA (mode 0/3 select)
	);
	end component;
	signal	spi_write			: 	std_logic_vector(7 downto 0);
	signal	spi_read			: 	std_logic_vector(7 downto 0);
	signal	spi_busy			: 	std_logic;
	signal	spi_load			: 	std_logic;
	signal	spi_clock_when_idle		: 	std_logic;
	signal	spi_sd_cs			: 	std_logic;

	-- ppi
	component ppi8255 is
	port(
		nRESET				: in  std_logic;

		-- z80 interface
		rd_n				: in  std_logic;
		wr_n				: in  std_logic;
		cs_n				: in  std_logic;
		a				: in  std_logic_vector(1 downto 0);
		din				: in  std_logic_vector(7 downto 0);
		dout				: out std_logic_vector(7 downto 0);

		-- cpc specific ports out
		psg_databus_out			: in  std_logic_vector(7 downto 0);
		psg_databus_in			: out std_logic_vector(7 downto 0);
		psg_bdir_bc1			: out std_logic_vector(1 downto 0);
		keyboard_row			: out std_logic_vector(3 downto 0);

		cas_in				: in  std_logic;
		cas_out, cas_motor		: out std_logic;
		vsync				: in std_logic
	);
	end component;
	signal	ppi_dout			: std_logic_vector(7 downto 0);

	-- tape
	signal	cas_in				: std_logic;
	signal	cas_out, cas_motor		: std_logic;


	-- psg
	component ay8912 is port(
		nRESET				: in	std_logic;
		clk				: in	std_logic;
		
		-- z80 databus interface
		bdir_bc1			: in	std_logic_vector(1 downto 0);			-- bc2, a8 are pulled high, so won't bother
		din				: in	std_logic_vector(7 downto 0);
		dout				: out	std_logic_vector(7 downto 0);
	
		-- io port a (keyboard)
		io_a				: in	std_logic_vector(7 downto 0);			-- really this should be inout, but cpc is input
	
		-- sound
		pwm_left, pwm_right		: out	std_logic);
	end component;
	signal	psg_clk				: std_logic;
	signal	psg_databus_in			: std_logic_vector(7 downto 0);
	signal	psg_databus_out			: std_logic_vector(7 downto 0);
	signal	psg_bdir_bc1			: std_logic_vector(1 downto 0);
	signal	psg_dout			: std_logic_vector(7 downto 0);

	-- keyboard
	component ps2input is port(
		nRESET				: in	std_logic;
		clk				: in	std_logic;					-- 1mhz clock
	
		-- ps/2 keyboard interface
		ps2_clock			: inout std_logic;
		ps2_data			: inout std_logic;
	
		-- receive matrix
		keyboard_row			: in	std_logic_vector(3 downto 0);
		keyboard_column			: out	std_logic_vector(7 downto 0);	

		-- joystick special
		joystick_1			: in	std_logic_vector(5 downto 0);
		joystick_2			: in	std_logic_vector(5 downto 0) );
	end component;

	signal	keyboard_row			: std_logic_vector(3 downto 0);
	signal	keyboard_column			: std_logic_vector(7 downto 0);
	signal	joystick_1			: std_logic_vector(5 downto 0);
	signal	joystick_2			: std_logic_vector(5 downto 0);

	-----------------------------------------------------------------------------------------------------------------------
	begin

        -- video
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

        --z80_INT_n <=   '1'; --pushsw(1);
        z80_NMI_n <=   '1'; --pushsw(2);
        z80_BUSRQ_n <= '1'; --pushsw(3);

	-- crtc
	crtc_0 : crtc port map( nRESET=>nRESET, MA=>crtc_MA, DE=>crtc_DE, CLK=>crtc_CLK,
				RW=>z80_A(9), E=>crtc_E, RS=>z80_A(8), nCS=>z80_A(14),
				DIN=>z80_DO, DOUT=>crtc_DOUT, RA=>crtc_RA, HSYNC=>crtc_HSYNC, VSYNC=>crtc_VSYNC);
	crtc_E	 <= z80_IORD_n nand z80_IOWR_n;

	-- ppi 8255
	ppi_0 : ppi8255 port map ( nRESET=>nRESET, rd_n => z80_iord_n, wr_n => z80_iowr_n,
				   cs_n => z80_a(11), a => z80_a(9 downto 8),
				   din => z80_DO, dout=>ppi_dout,
				   psg_databus_in => psg_databus_in, psg_databus_out => psg_databus_out,
				   psg_bdir_bc1 => psg_bdir_bc1, 
				   keyboard_row => keyboard_row, cas_in => cas_in, cas_out => cas_out, cas_motor => cas_motor, vsync => crtc_vsync );
	cas_in <= '0';

	-- ay 8912 psg
	psg_0 : ay8912 port map (nRESET => nRESET, clk=>psg_clk, bdir_bc1=>psg_bdir_bc1, din=>psg_databus_in, dout=>psg_databus_out,
				 io_a=>keyboard_column, pwm_left=>video_sound, pwm_right=>video_sound2 );

	-- keyboard
	kbd_0 : ps2input port map ( nRESET=>nRESET, clk=>psg_clk,
				    	ps2_clock=>ps2_clock, ps2_data=>ps2_data,
					keyboard_row=>keyboard_row, keyboard_column=>keyboard_column,
					joystick_1=>joystick_1, joystick_2=>joystick_2 );
	process(pushsw)
	begin
		joystick_1 <= dipsw(1 downto 0) & pushsw;
		joystick_2 <= (others=>'1');
--		if keyboard_row = "1001" then
--			keyboard_column <= "1111" & pushsw;		-- map push buttons to joystick directions
--		else
--			keyboard_column <= (others=>'1');
--		end if;
	end process;

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

			-- interrupt generation
			z80_int_n			=> z80_INT_n,
	
			video_sync			=> video_sync,
			video_red			=> video_red,
			video_green			=> video_green,
			video_blue			=> video_blue,

			-- initial boot rom
			bootrom_addr			=> bootrom_addr,
			bootrom_data			=> bootrom_data,

			-- psg clock
			psg_clk				=> psg_clk, 

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
	    bootrom_clk <= z80_clk;

        -- add switch input to port #fade
        process(nRESET,z80_clk,z80_IORQ_n,z80_RD_n,z80_A)
        begin
            if nRESET = '0' then
		uart_rx_clear <= '0';
	    	z80_DI_is_from_iorq <= '0';
    	        z80_DI_from_iorq <= (others=>'0');
            
	    elsif rising_edge(z80_clk) then
		uart_rx_clear <= '0';
	    	z80_DI_is_from_iorq <= '0';
    	        z80_DI_from_iorq <= (others=>'0');

	    	if z80_IORQ_n = '0' and z80_RD_n = '0' then

			if    z80_A(15 downto 0) = x"FADE" then				-- dip switches
				z80_DI_from_iorq <= not dipsw(7 downto 0);
				z80_DI_is_from_iorq <= '1';
            
		    	elsif z80_A(15 downto 0) = x"FADD" then
				z80_DI_from_iorq(7) <= uart_tx_empty;       		-- uart status and push buttons
				z80_DI_from_iorq(6) <= uart_rx_avail;        
				z80_DI_from_iorq(5) <= uart_rx_error;         
	
				z80_DI_from_iorq(3 downto 0) <= not pushsw(3 downto 0);
				z80_DI_is_from_iorq <= '1';

		    	elsif z80_A(15 downto 0) = x"FADC" then				-- uart data
				z80_DI_from_iorq <= uart_rx_data;
				z80_DI_is_from_iorq <= '1';
				uart_rx_clear <= '1';

		    	elsif z80_A(14)='0' then					-- crtc
				z80_DI_from_iorq <= crtc_DOUT;
				z80_DI_is_from_iorq <= '1';

		    	elsif z80_A(11)='0' then					-- ppi
				z80_DI_from_iorq <= ppi_DOUT;
				z80_DI_is_from_iorq <= '1';

		    	elsif z80_A(15 downto 8) = x"FF" or				-- spi data
		    	      z80_A(15 downto 0) = x"FEFF" then				-- spi peek
				z80_DI_from_iorq <= spi_read;
				z80_DI_is_from_iorq <= '1';
			end if;
		end if;
            end if;
        end process;
	
        -- add SPI output to port #ffxx
	-- note, this is a special case as just reading from the port also triggers a dummy transfer, although we need to be
	-- careful as the "dummy" byte might actually be useful!
	process(nRESET,z80_clk,z80_IORQ_n,z80_WR_n,z80_RD_n,z80_A,z80_DO)
	begin
		if nRESET = '0' then
			spi_write		<= (others=>'0');
			spi_load 		<= '0';
            
		elsif z80_IORQ_n = '0' and z80_A(15 downto 8) = x"FF" then
			if z80_RD_n='0' then
				spi_write	<= z80_A(7 downto 0);			-- when reading SPI port, C specifies output byte
				spi_load	<= '1';
			elsif z80_WR_n='0' then
				spi_write	<= z80_DO;				-- when writing, output byte is on databus
				spi_load	<= '1';
			else
				spi_load	<= '0';					-- reset port for next byte
			end if;
		else
			spi_load		<= '0';					-- reset port for next byte
		end if;
        end process;

        -- add LED output to port #fade
        process(nRESET,z80_clk,z80_IORQ_n,z80_WR_n,z80_A)
        begin
		if nRESET = '0' then
			leds			<= (others=>'0');
			uart_tx_data		<= (others=>'0');
			uart_tx_load		<= '0';

			spi_clock_when_idle	<= '1';					-- default clock state when idle
			spi_flash_cs		<= '1';					-- rom enable
			spi_sd_cs		<= '1';					-- sd card enable
            
		elsif rising_edge(z80_clk) then
			uart_tx_load <= '0';

			if z80_IORQ_n = '0' and z80_WR_n = '0' and z80_A(15 downto 0) = x"FADC" then		-- uart tx
				uart_tx_data	<= z80_DO;
				uart_tx_load <= '1';
            
			elsif z80_IORQ_n = '0' and z80_WR_n = '0' and z80_A(15 downto 0) = x"FADE" then		-- leds
				leds <= not z80_DO(5 downto 0);

			elsif z80_IORQ_n = '0' and z80_WR_n = '0' and z80_A(15 downto 0) = x"FEFF" then		-- spi config
				spi_clock_when_idle<= z80_DO(7);
				spi_flash_cs	<= z80_DO(0);
				spi_sd_cs	<= z80_DO(1);

			end if;
		end if;
        end process;
	
        -- use dummy pins
        dummy <= dipsw   (0) xor dipsw   (1) xor dipsw   (2) xor dipsw   (3) xor dipsw   (4) xor dipsw   (5) xor dipsw   (6) xor dipsw   (7) xor 
                 pushsw  (0) xor pushsw  (1) xor pushsw  (2) xor pushsw  (3);

        -- uart
        uart_tx_0  : uart_tx port map( nrst=>nreset, clk16mhz=>clk16, txd=>uart_tx_txd , load=>uart_tx_load , data=>uart_tx_data , empty=>uart_tx_empty );
        txd <= uart_tx_txd;

        uart_rx_0  : uart_rx port map( nrst=>nreset, clk16mhz=>clk16, rxd=>uart_rx_rxd , avail=>uart_rx_avail , data=>uart_rx_data , clear=>uart_rx_clear, errorfound=>uart_rx_error );
	uart_rx_rxd <= rxd;

	-- spi
	spi_0 : spi port map( nRESET=>nreset, clk16=>clk16, read=>spi_read, write=>spi_write, busy=>spi_busy, load=>spi_load,
				clock_when_idle=>spi_clock_when_idle, spi_clk=>spi_clk, spi_di=>spi_di, spi_do=>spi_do );

end impl;
