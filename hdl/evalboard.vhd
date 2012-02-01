-- cpc.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity evalboard is
	port(
		nRESET			: in  std_logic;
		clock			: in  std_logic;
		pushsw			: in  std_logic_vector(3 downto 0);
		dipsw			: in  std_logic_vector(7 downto 0);
		rxd			: in  std_logic;
		txd			: out std_logic;
		dummy			: out std_logic;
		leds			: out std_logic_vector(3 downto 0);
		tape_out		: out std_logic;
		tape_motor		: out std_logic;
		ps2_clock		: inout std_logic;
		ps2_data		: inout std_logic;
		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_ce			: out std_logic;
		sram_oe			: out std_logic;
		spi_clk			: out  std_logic;
		spi_di			: out  std_logic;
		spi_do			: in   std_logic;
		spi_flash_cs		: out  std_logic;
		video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sync_out			: out  std_logic;
		video_sound_left		: out  std_logic;
		video_sound_right		: out  std_logic
	);
end evalboard;

architecture impl of evalboard is
	-- PLL
	component PLL16mhz is port(POWERDOWN, CLKA : in std_logic; LOCK, GLA : out std_logic);
	end component;

	component cpc is port (
		nRESET			: in  std_logic;
		clk16			: in  std_logic;
		clklock			: in  std_logic;
		pushsw			: in  std_logic_vector(3 downto 0);
		dipsw			: in  std_logic_vector(7 downto 0);
		rxd			: in  std_logic;
		txd			: out std_logic;
		dummy			: out std_logic;
		leds			: out std_logic_vector(3 downto 0);
		tape_out		: out std_logic;
		tape_motor		: out std_logic;
		ps2_clock		: inout std_logic;
		ps2_data		: inout std_logic;
		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_ce			: out std_logic;
		sram_oe			: out std_logic;
		bootrom_addr        	: out std_logic_vector(13 downto 0);
		bootrom_data        	: in  std_logic_vector(7 downto 0);
		bootrom_clk        	: out std_logic;
		spi_clk			: out  std_logic;
		spi_di			: out  std_logic;
		spi_do			: in   std_logic;
		spi_flash_cs		: out  std_logic;
		video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sync_out			: out  std_logic;
		video_sound_left		: out  std_logic;
		video_sound_right		: out  std_logic
	);
end component;

	signal clklock : std_logic;
	signal clk16   : std_logic;

	-- evil hacky code for bootstrapping
	component bootrom is port(
		clk				: in std_logic;
		addr				: in std_logic_vector(13 downto 0);
		data				: out std_logic_vector(7 downto 0)
        );
	end component;
	signal bootrom_data : std_logic_vector(7 downto 0);
	signal bootrom_addr : std_logic_vector(13 downto 0);
	signal bootrom_clk  : std_logic;

	begin
	-- generate the master clock
	PLL_clock_clk16 : PLL16mhz port map ( CLKA => clock, POWERDOWN => '1', GLA => clk16, LOCK => clklock );

	-- bootstrap code
	bootrom_0 : bootrom port map( clk=>bootrom_clk, addr=>bootrom_addr, data=>bootrom_data );

	cpc_0: cpc port map (
		nRESET => nRESET,
		clk16 => clk16,
		clklock => clklock,
		pushsw => pushsw,
		dipsw => dipsw,
		rxd => rxd,
		txd => txd,
		dummy => dummy,
		leds => leds,
		tape_out => tape_out,
		tape_motor => tape_motor,
		ps2_clock => ps2_clock,
		ps2_data => ps2_data,
		sram_address => sram_address,
		sram_data => sram_data,
		sram_we => sram_we,
		sram_ce => sram_ce,
		sram_oe => sram_oe,
		bootrom_addr => bootrom_addr,
		bootrom_data => bootrom_data,
		bootrom_clk => bootrom_clk,
		spi_clk => spi_clk,
		spi_di => spi_di,
		spi_do => spi_do,
		spi_flash_cs => spi_flash_cs,
		video_r2 => video_r2,
		video_g2 => video_g2,
		video_b2 => video_b2,
		video_sync_out => video_sync_out,
		video_sound_left => video_sound_left,
		video_sound_right => video_sound_right
	);
end impl;
