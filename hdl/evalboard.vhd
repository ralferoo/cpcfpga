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
		uart_rx			: in  std_logic;
		uart_tx			: out std_logic;
		dummy			: out std_logic;
		leds			: out std_logic_vector(7 downto 0);
		sram_address		: out std_logic_vector(18 downto 0);
		sram_data		: inout std_logic_vector(7 downto 0);
		sram_we			: out std_logic;
		sram_ce			: out std_logic;
		sram_oe			: out std_logic;
		video_sync2,video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sound                                 : out  std_logic
	);
end evalboard;

architecture impl of evalboard is
	-- PLL
	component PLL16mhz is port(POWERDOWN, CLKA : in std_logic; LOCK, GLA : out std_logic);
	end component;

	component cpc is port (
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
		sram_ce			: out std_logic;
		sram_oe			: out std_logic;
		video_sync2,video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sound                                 : out  std_logic
	);
end component;

	signal clklock : std_logic;
	signal clk16   : std_logic;

	begin
	-- generate the master clock
	PLL_clock_clk16 : PLL16mhz port map ( CLKA => clock, POWERDOWN => '1', GLA => clk16, LOCK => clklock );

	cpc_0: cpc port map (
		nRESET => nRESET,
		clk16 => clk16,
		pushsw => pushsw,
		dipsw => dipsw,
		uart_rx => uart_rx,
		uart_tx => uart_tx,
		dummy => dummy,
		leds => leds,
		sram_address => sram_address,
		sram_data => sram_data,
		sram_we => sram_we,
		sram_ce => sram_ce,
		sram_oe => sram_oe,
		video_sync2 => video_sync2,
		video_r2 => video_r2,
		video_g2 => video_g2,
		video_b2 => video_b2,
		video_sound => video_sound
	);
end impl;
