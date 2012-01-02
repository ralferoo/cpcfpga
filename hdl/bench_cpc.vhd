-- bench_crtc.vhd

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;


entity bench_cpc is
end bench_cpc;

architecture behavioral of bench_cpc is

    constant SYSCLK_PERIOD : time := 62.5 ns;

    signal SYSCLK : std_logic := '0';
    signal NSYSRESET : std_logic := '0';

    component cpc is
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
    end component;

	signal	pushsw			: 	std_logic_vector(3 downto 0);
	signal	dipsw			: 	std_logic_vector(7 downto 0);
	signal	uart_rx			: 	std_logic;
	signal	uart_tx			: 	std_logic;
	signal	dummy			: 	std_logic;
	signal	leds			: 	std_logic_vector(7 downto 0);
	signal	sram_address		: 	std_logic_vector(18 downto 0);
	signal	sram_data		: 	std_logic_vector(7 downto 0);
	signal	sram_we			: 	std_logic;
	signal	sram_ce			: 	std_logic;
	signal	sram_oe			: 	std_logic;

	signal	video_sync2,video_r2,video_g2,video_b2      : std_logic_vector(1 downto 0);
	signal	video_sound                                 : std_logic;

	type memory is array(0 to 255) of std_logic_vector(7 downto 0);
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


    cpc_0 : cpc port map ( nRESET=>NSYSRESET, clk16=>SYSCLK,
		pushsw			=> pushsw,
		dipsw			=> dipsw,

		uart_rx			=> uart_rx,
		uart_tx			=> uart_tx,

		dummy			=> dummy,
		leds			=> leds,

		sram_address		=> sram_address,
		sram_data		=> sram_data,
		sram_we			=> sram_we,
		sram_ce			=> sram_ce,
		sram_oe			=> sram_oe,

		video_sync2=>video_sync2,video_r2=>video_r2,video_g2=>video_g2,video_b2=>video_b2,
		video_sound                                 => video_sound);

	process(NSYSRESET,sram_oe,sram_we,sram_address,sram_data)
		variable fake_sram	:	memory;
		variable init_seed	:	std_logic_vector(7 downto 0);
	begin
		if NSYSRESET='0' then
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

	uart_rx			<= '1';
	dipsw			<= (others=>'0');	
	pushsw			<= (others=>'0');

    process(SYSCLK,NSYSRESET)
    begin
        if NSYSRESET = '0' then

        elsif rising_edge(SYSCLK) then


        end if;
    end process;

end behavioral;

