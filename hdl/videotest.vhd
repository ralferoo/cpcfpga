-- cpc.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity videotest is
	port(
		nRESET			: in  std_logic;
		clock			: in  std_logic;

        video_sync_outpin, video_blank_outpin, video_r_outpin, video_g_outpin, video_b_outpin: out std_logic;

		video_sync2,video_r2,video_g2,video_b2      : out std_logic_vector(1 downto 0);
		video_sound                                 : out  std_logic
	);
end videotest;

architecture impl of videotest is

	signal	out_video_sync2,out_video_r2,out_video_g2,out_video_b2      : std_logic_vector(1 downto 0);

	component clock_divider is
		port	(
			clk		: in  std_logic;
			load		: in  std_logic;
			divisor		: in  std_logic_vector;
			osc		: out std_logic;
			output		: out std_logic);
	end component;

	signal clk_load : std_logic;
	signal clk1mhz : std_logic;
begin

	clk_load <= not nRESET;
	clkgen_1mhz: clock_divider port map( clk=>clock, load=>clk_load, divisor=>"1010", osc=>clk1mhz);	-- divide by 2 then by 10, 20mhz->1mhz

	video_sound <= '0';
	video_sync2 <= out_video_sync2;
	video_r2 <= out_video_r2;
	video_g2 <= out_video_g2;
	video_b2 <= out_video_b2;

	process(clock, nRESET)
		variable	which			: std_logic;
	begin
		if nRESET='0' then
			which				:= '0';

		elsif rising_edge(clock) then
			which				:= not which;

			if which='1' then
				video_r_outpin		<= out_video_r2(0);
				video_g_outpin		<= out_video_g2(0);
				video_b_outpin		<= out_video_b2(0);
				video_sync_outpin	<= out_video_sync2(0);
			else
				video_r_outpin		<= out_video_r2(1);
				video_g_outpin		<= out_video_g2(1);
				video_b_outpin		<= out_video_b2(1);
				video_sync_outpin	<= out_video_sync2(1);
			end if;
			video_blank_outpin		<= '1';

		end if;
	end process;


	process(clk1mhz,nRESET)
		variable	  counter		: std_logic_vector(14 downto 0);

		variable	n_counter		: std_logic_vector(15 downto 0);
		variable	t_horiz			: std_logic_vector(5 downto 0);
		variable	t_vert			: std_logic_vector(8 downto 0);

		variable	t_vsync			: std_logic;
		variable	t_hsync			: std_logic;
		variable	t_de			: std_logic;
	begin
		if rising_edge(clk1mhz) then
			if nRESET='0' then
				-- reset
				counter			:= (others=>'0');

				out_video_sync2		<= "00";
				out_video_r2		<= "00";
				out_video_g2		<= "00";
				out_video_b2		<= "00";
			else
				-- normal operations

				n_counter		:= ("0"&counter) - 1;
				if n_counter(n_counter'high)='1' then
					n_counter	:= "0100110111111111";				-- (312*64)-1 = 19967
				end if;

				t_horiz			:= n_counter(5 downto 0);
				t_vert			:= n_counter(14 downto 6);

				t_de			:= '1';
				if t_horiz >= 50 then
					t_hsync		:= '1';
					t_de		:= '0';
				elsif t_horiz >= 56 then
					t_de		:= '0';
				elsif t_horiz <= 4 then
					t_de		:= '0';
				else
					t_hsync		:= '0';
				end if;

				if t_vert >= 300 then
					t_vsync		:= '1';
					t_de		:= '0';
				elsif t_vert >= 294 then
					t_de		:= '0';
				elsif t_vert <= 6 then 
					t_de		:= '0';
				else
					t_vsync		:= '0';
				end if;

				if (t_vsync or t_hsync)='1' then
					out_video_sync2	<= "00";
					out_video_r2	<= "10";
					out_video_g2	<= "10";
					out_video_b2	<= "10";
				elsif t_de='0' then
					out_video_sync2	<= "11";
					out_video_r2	<= "00";
					out_video_g2	<= "00";
					out_video_b2	<= "00";
				else
					out_video_sync2	<= "11";
					out_video_r2	<= t_horiz(3 downto 2);
					out_video_g2	<= t_horiz(1 downto 0);
					out_video_b2	<= t_vert(4 downto 3);
				end if;

				counter			:= n_counter(n_counter'high-1 downto 0);
			end if;
		end if;
	end process;
end impl;
