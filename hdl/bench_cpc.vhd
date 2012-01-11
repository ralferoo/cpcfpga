-- cpc.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity bench_cpc is
-- empty
end bench_cpc;

architecture impl of bench_cpc is

	-- PLL
	constant SYSCLK_PERIOD : time := 62.5 ns;

	-- fake memory
	type memory is array(0 to 255) of std_logic_vector(7 downto 0);
	
	component cpc is port (
		nRESET			: in  std_logic;
		clk16			: in  std_logic;
		pushsw			: in  std_logic_vector(3 downto 0);
		dipsw			: in  std_logic_vector(7 downto 0);
		rxd			: in  std_logic;
		txd			: out std_logic;
		dummy			: out std_logic;
		leds			: out std_logic_vector(7 downto 0);
		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_ce			: out std_logic;
		sram_oe			: out std_logic;
		bootrom_addr        	: out std_logic_vector(13 downto 0);
		bootrom_data        	: in  std_logic_vector(7 downto 0);
		spi_clk			: out  std_logic;
		spi_di			: out  std_logic;
		spi_do			: in   std_logic;
		spi_flash_cs		: out  std_logic;
		video_sync2,video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sound                                 : out  std_logic
	);
	end component;

	signal 		nRESET			: std_logic;
	signal 		clk16			: std_logic := '0';
	signal 		pushsw			: std_logic_vector(3 downto 0);
	signal 		dipsw			: std_logic_vector(7 downto 0);
	signal 		rxd			: std_logic;
	signal 		txd			: std_logic;
	signal 		dummy			: std_logic;
	signal 		leds			: std_logic_vector(7 downto 0);
	signal 		sram_address		: std_logic_vector(18 downto 0);
	signal 		sram_data		: std_logic_vector(7 downto 0);
	signal 		sram_we			: std_logic;
	signal 		sram_ce			: std_logic;
	signal 		sram_oe			: std_logic;
	signal 		bootrom_addr        	: std_logic_vector(13 downto 0);
	signal 		bootrom_data        	: std_logic_vector(7 downto 0);
	signal 		spi_clk			: std_logic;
	signal 		spi_di			: std_logic;
	signal 		spi_do			: std_logic;
	signal 		spi_flash_cs		: std_logic;
	signal 		video_sync2,video_r2,video_g2,video_b2      : std_logic_vector(1 downto 0);
	signal 		video_sound                                 : std_logic;

	-- evil hacky code for bootstrapping
	component bench_cpc_bootrom is port(
		addr				: in std_logic_vector(13 downto 0);
		data				: out std_logic_vector(7 downto 0)
        );
	end component;

	begin

	-- fake PLL
	clk16 <= not clk16 after (SYSCLK_PERIOD / 2.0 );

	process
		variable vhdl_initial : BOOLEAN := TRUE;
	begin
		if ( vhdl_initial ) then
			-- Assert Reset
			nRESET <= '0';
			wait for ( SYSCLK_PERIOD * 10 );
            
			nRESET <= '1';
			wait;
		end if;
	end process;



	-- bootstrap code
	bootrom_0 : bench_cpc_bootrom port map( addr=>bootrom_addr, data=>bootrom_data );

	cpc_0: cpc port map (
		nRESET => nRESET,
		clk16 => clk16,
		pushsw => pushsw,
		dipsw => dipsw,
		rxd => rxd,
		txd => txd,
		dummy => dummy,
		leds => leds,
		sram_address => sram_address,
		sram_data => sram_data,
		sram_we => sram_we,
		sram_ce => sram_ce,
		sram_oe => sram_oe,
		bootrom_addr => bootrom_addr,
		bootrom_data => bootrom_data,
		spi_clk => spi_clk,
		spi_di => spi_di,
		spi_do => spi_do,
		spi_flash_cs => spi_flash_cs,
		video_sync2 => video_sync2,
		video_r2 => video_r2,
		video_g2 => video_g2,
		video_b2 => video_b2,
		video_sound => video_sound
	);

	-- some fake SRAM
	process(nRESET,sram_oe,sram_we,sram_address,sram_data)
		variable fake_sram	:	memory;
		variable init_seed	:	std_logic_vector(7 downto 0);
	begin
		if nRESET='0' then
			init_seed	:= (others=>'0');

			for i in 255 downto 0 loop
				fake_sram(i) := init_seed;
				init_seed    := init_seed + i;		-- squares mod 256 should be randomish
			end loop;
		end if;

		if rising_edge(sram_we) then
			fake_sram(to_integer(ieee.numeric_std.unsigned(sram_address(7 downto 0)))) := sram_data;
		end if;

		if sram_oe='1' then
			sram_data <= (others=>'Z');
		else
			sram_data <= fake_sram(to_integer(ieee.numeric_std.unsigned(sram_address(7 downto 0))));
		end if;
	end process;

	-- inputs from board
	rxd			<= '1';
	dipsw			<= (others=>'0');	
	pushsw			<= (others=>'0');

	-- test bed
	process(clk16,nRESET)
	begin
		if nRESET = '0' then
		elsif rising_edge(clk16) then
		end if;
	end process;
	
end impl;
