-- cpc.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity homeboard is
	port(
		fl_hold			: out  std_logic;
		fl_wp			: out  std_logic;
		clk16			: in  std_logic;
		rxd			: in  std_logic;
		txd			: out std_logic;
		leds			: out std_logic_vector(3 downto 0);
		ps2_clock		: inout std_logic;
		ps2_data		: inout std_logic;
		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_oe			: out std_logic;
		fl_sclk			: out  std_logic;
		fl_di			: out  std_logic;
		fl_do			: in   std_logic;
		fl_sel		: out  std_logic;
		scart_r,scart_g,scart_b      : out std_logic_vector(1 downto 0);
		scart_csync			: out  std_logic;
		scart_audio_left		: out  std_logic;
		scart_audio_right		: out  std_logic
	);
end homeboard;

architecture impl of homeboard is
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

	signal dummy			: std_logic;
	signal clklock			: std_logic;

	signal nRESET			: std_logic;
	signal pushsw			: std_logic_vector(3 downto 0);
	signal dipsw			: std_logic_vector(7 downto 0);

	signal tape_out			: std_logic;
	signal tape_motor		: std_logic;

	signal sram_ce			: std_logic;

	-- evil hacky code for bootstrapping
	component bootrom_bram is port(
		clk			: in std_logic;
		addr			: in std_logic_vector(13 downto 0);
		data			: out std_logic_vector(7 downto 0)
        );
	end component;
	signal bootrom_data		: std_logic_vector(7 downto 0);
	signal bootrom_addr		: std_logic_vector(13 downto 0);
	signal bootrom_clk		: std_logic;
	signal clk16_180		: std_logic;

	begin

	-- bootstrap code
	bootrom_0 : bootrom_bram port map( clk=>clk16_180, addr=>bootrom_addr, data=>bootrom_data );
	clk16_180 <= not clk16;

	-- PLL fake
	nRESET <= '1';
	clklock <= '1';
	pushsw <= "1111";
	dipsw <= "11111111";

	fl_hold <= '1';
	fl_wp <= '1';

	-- CPC core
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
		spi_clk => fl_sclk,
		spi_di => fl_di,
		spi_do => fl_do,
		spi_flash_cs => fl_sel,
		video_r2 => scart_r,
		video_g2 => scart_g,
		video_b2 => scart_b,
		video_sync_out => scart_csync,
		video_sound_left => scart_audio_left,
		video_sound_right => scart_audio_right
	);
end impl;
