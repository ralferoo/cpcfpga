-- cpc emulator
--
-- ay8912

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
entity ay8912 is port(
	nRESET			: in	std_logic;
	clk			: in	std_logic;
	pwm_clk			: in	std_logic;
	
	-- z80 databus interface
	bdir_bc1		: in	std_logic_vector(1 downto 0);			-- bc2, a8 are pulled high, so won't bother
	din			: in	std_logic_vector(7 downto 0);
	dout			: out	std_logic_vector(7 downto 0);

	-- io port a (keyboard)
	io_a			: in	std_logic_vector(7 downto 0);			-- really this should be inout, but cpc is input

	-- sound
	tape_noise		: in	std_logic;
	is_mono			: in	std_logic;
	pwm_left, pwm_right	: out	std_logic);
end ay8912;

architecture impl of ay8912 is
	-- these are the internal state of the PSG
	signal	tone_a, tone_b, tone_c			: std_logic_vector(11 downto 0);
	signal	noise					: std_logic_vector( 4 downto 0);
	signal	ioadir, iobdir				: std_logic;
	signal	en_noise_a, en_noise_b, en_noise_c	: std_logic;
	signal	en_tone_a,  en_tone_b,  en_tone_c	: std_logic;
	signal	amp_a, amp_b, amp_c			: std_logic_vector( 4 downto 0);
	signal	env_period				: std_logic_vector(15 downto 0);
	signal	env_shape				: std_logic_vector( 3 downto 0);
	signal	env_restart				: std_logic;

	signal	pwm_add_left, pwm_add_right		: std_logic_vector(7 downto 0);	-- contribution to pwm output per physical channel

	component clock_divider is
		port	(
			clk		: in  std_logic;
			reset		: in  std_logic;
			load		: in  std_logic;
			divisor		: in  std_logic_vector;
			osc		: out std_logic;
			output		: out std_logic);
	end component;
	signal tone_out_a : std_logic;
	signal tone_out_b : std_logic;
	signal tone_out_c : std_logic;
	signal noise_clock : std_logic;
	signal tone_divider_clock : std_logic;
	signal env_divider_clock : std_logic;
--	signal env_divider_load : std_logic;
	signal env_clock : std_logic;

	signal	env_volume				: std_logic_vector( 3 downto 0);			-- represents the amplitude of the global envelope
	signal noise_bit				: std_logic;
begin

	tone_div_clock_gen: clock_divider port map( clk=>clk, output=>tone_divider_clock, reset=>nRESET, divisor=>"1000", load=>'0');
	env_div_clock_gen: clock_divider port map( clk=>tone_divider_clock, output=>env_divider_clock, reset=>nRESET, load=>env_restart, divisor=>"1000");

	tone_div_a: clock_divider port map( clk=>tone_divider_clock, reset=>nRESET, divisor=>tone_a, osc=>tone_out_a, load=>'0');
	tone_div_b: clock_divider port map( clk=>tone_divider_clock, reset=>nRESET, divisor=>tone_b, osc=>tone_out_b, load=>'0');
	tone_div_c: clock_divider port map( clk=>tone_divider_clock, reset=>nRESET, divisor=>tone_c, osc=>tone_out_c, load=>'0');
	noise_div: clock_divider port map( clk=>tone_divider_clock, reset=>nRESET, divisor=>noise, output=>noise_clock, load=>'0');

--	env_divider_load <= (not nRESET) or env_restart;
	env_div: clock_divider port map( clk=>env_divider_clock, reset=>nRESET, load=>env_restart, divisor=>env_period, output=>env_clock);

	-- this process deals with the CPU (well, PPI) interface to the registers
	process(nRESET, clk, bdir_bc1, din)
		variable	r_sel_register	: std_logic_vector(3 downto 0);
		variable	r_dout		: std_logic_vector(7 downto 0);
		variable	r_env_restart	: std_logic;
		variable	r_tone_a	: std_logic_vector(11 downto 0);
		variable	r_tone_b	: std_logic_vector(11 downto 0);
		variable	r_tone_c	: std_logic_vector(11 downto 0);

		variable	n_sel_register	: std_logic_vector(3 downto 0);
		variable	n_dout		: std_logic_vector(7 downto 0);
		variable	n_env_restart	: std_logic;
		variable	n_tone_a	: std_logic_vector(11 downto 0);
		variable	n_tone_b	: std_logic_vector(11 downto 0);
		variable	n_tone_c	: std_logic_vector(11 downto 0);
	begin
		if nRESET='0' then
			r_sel_register	:= (others=>'0');
			r_dout		:= (others=>'0');
			r_env_restart	:= '0';

			r_tone_a	:= (others=>'0');
			r_tone_b	:= (others=>'0');
			r_tone_c	:= (others=>'0');

		elsif rising_edge(clk) then	
			n_sel_register	:= r_sel_register;
			n_dout		:= r_dout;
			n_env_restart	:= '0';

			n_tone_a	:= r_tone_a;
			n_tone_b	:= r_tone_b;
			n_tone_c	:= r_tone_c;
			
			-- bc2 is pulled high, so on CPC:
			-- bdir bc1
			--   0   0   IAB - inactive
			--   0   1   DTB - read from psg
			--   1   0   DWS - write to psg
			--   1   1 INTAK - latch address

			case bdir_bc1 is
				when "11" =>			if din(7 downto 4)="0000" then
									n_sel_register	:= din(3 downto 0);
								end if;

				when "01" =>	case r_sel_register is
							when "0000" =>		n_dout	:=          tone_a( 7 downto 0);			-- R0
							when "0001" =>		n_dout	:= "0000" & tone_a(11 downto 8);			-- R1
	
							when "0010" =>		n_dout	:=          tone_b( 7 downto 0);			-- R2
							when "0011" =>		n_dout	:= "0000" & tone_b(11 downto 8);			-- R3
	
							when "0100" =>		n_dout	:=          tone_c( 7 downto 0);			-- R4
							when "0101" =>		n_dout	:= "0000" & tone_c(11 downto 8);			-- R5

							when "0110" =>		n_dout	:= "000"  &  noise;					-- R6
							when "0111" =>		n_dout	:= iobdir & ioadir &					-- R7
												en_noise_c & en_noise_b & en_noise_a &
												en_tone_c  & en_tone_b  & en_tone_a;

							when "1000" =>		n_dout	:= "000"  &  amp_a;					-- R10 (octal)
							when "1001" =>		n_dout	:= "000"  &  amp_b;					-- R11 (octal);
							when "1010" =>		n_dout	:= "000"  &  amp_c;					-- R12 (octal);

							when "1011" =>		n_dout	:= env_period( 7 downto 0);				-- R13 (octal);
							when "1100" =>		n_dout	:= env_period(15 downto 8);				-- R14 (octal);
							when "1101" =>		n_dout	:= "0000" & env_shape;					-- R15 (octal)
	
							when "1110" =>		n_dout	:= io_a;						-- R16 (octal);
							when "1111" =>		n_dout	:= (others=>'0');					-- R17 (octal);

							when others => null;
						end case;

				when "10" =>	case r_sel_register is
							when "0000" =>	n_tone_a( 7 downto 0)	:= din;
							when "0001" =>	n_tone_a(11 downto 8)	:= din(3 downto 0);

							when "0010" =>	n_tone_b( 7 downto 0)	:= din;
							when "0011" =>	n_tone_b(11 downto 8)	:= din(3 downto 0);

							when "0100" =>	n_tone_c( 7 downto 0)	:= din;
							when "0101" =>	n_tone_c(11 downto 8)	:= din(3 downto 0);

							when "0110" =>	noise			<= din(4 downto 0);
							when "0111" =>	iobdir			<= din(7);
									ioadir			<= din(6);
									en_noise_c		<= din(5);
									en_noise_b		<= din(4);
									en_noise_a		<= din(3);
									en_tone_c		<= din(2);
									en_tone_b		<= din(1);
									en_tone_a		<= din(0);

							when "1000" =>	amp_a			<= din(4 downto 0);
							when "1001" =>	amp_b			<= din(4 downto 0);
							when "1010" =>	amp_c			<= din(4 downto 0);

							when "1011" => env_period( 7 downto 0)	<= din;
							when "1100" => env_period(15 downto 8)	<= din;
							when "1101" => env_shape		<= din(3 downto 0);
									n_env_restart		:= '1';
							when others => null;
						end case;

				when others => null;
			end case;
			r_sel_register	:= n_sel_register;
			r_dout		:= n_dout;
			r_env_restart	:= n_env_restart;

			r_tone_a	:= n_tone_a;
			r_tone_b	:= n_tone_b;
			r_tone_c	:= n_tone_c;
		end if;

		env_restart		<= r_env_restart;
		dout			<= r_dout;

		tone_a			<= r_tone_a;
		tone_b			<= r_tone_b;
		tone_c			<= r_tone_c;
	end process;

	
	noise_calc: process(noise_clock, nRESET)
		variable	n_lfsr						: std_logic_vector(14 downto 0);	-- current random seed for noise
	begin
		if nRESET='0' then
			n_lfsr			:= (others=>'0');
			noise_bit		<= '0';

		else
			noise_bit		<= n_lfsr(14);
			n_lfsr			:= (n_lfsr(14) xnor n_lfsr(13)) & n_lfsr(12 downto 5) & (n_lfsr(14) xnor n_lfsr(4)) &
								n_lfsr(3 downto 2) & (n_lfsr(14) xnor n_lfsr(1)) & n_lfsr(0) & n_lfsr(14);
		end if;
	end process;

	global_envelope: process(env_clock, nRESET)
		variable	r_env_step					: std_logic_vector(4 downto 0);		-- amplitude to use for envelope

		variable	n_env_step					: std_logic_vector(4 downto 0);		-- amplitude to use for envelope
		variable	n_env_actual					: std_logic_vector(3 downto 0);		-- amplitude to use for envelope

		variable	t_attack, t_alternate, t_hold			: std_logic;				-- temp vars for envelope
		variable	t_stop, t_doalt, t_xor_bit			: std_logic;				-- temp vars for envelope
	begin
		if nRESET='0' or env_restart='1' then
			n_env_step			:= (others=>'0');			-- restart envelope whenever port is written to
			env_volume			<= (others=>'0');

		elsif rising_edge(env_clock) then
			n_env_step			:= r_env_step;

			-- rules from figure 7, condensed
			if env_shape(3) = '1' then
				t_attack		:= env_shape(2);
				t_alternate		:= env_shape(1);
				t_hold			:= env_shape(0);
			else
				t_attack		:= env_shape(2);
				t_alternate		:= env_shape(2);
				t_hold			:= '1';
			end if;							
			t_stop				:= t_hold and n_env_step(4);
			t_doalt				:= t_alternate and n_env_step(4);

			-- this next bit is complicated...
			--
			-- env_shape(0) = hold		'1' = limit to one cycle, holding at 0000 or 1111 depending on count-up or -down
			-- env_shape(1)	= alternate	'1' = reverse direction after each cycle
			-- env_shape(2) = attack	'1' = count up 0000->1111, '0' = count down 1111->0000
			-- env_shape(3)	= continue	'1' = defined by hold, '0' reset to 0000 after each cycle and hold it there

			-- however, this description is clearly wrong when looking at figure 7...
			-- 1011 should hold at 0, but shows it at 1. therefore hold also counts to "10000" and holds it depending on alternate
			-- best to work it out from a table based on figure 7 (reordered)

			-- CTLH							
			-- 1000		\\\\
			-- 1010		\/\/
			
			-- 1100		////
			-- 1110		/\/\
			
			-- 1011		\111
			-- 1101		/111
			
			-- 1001		\000
			-- 1111		/000							
			
			-- 00xx		\000	synonym: 1001
			-- 01xx		/000	synonym: 1111

			-- calculate envelope value
			if t_stop='1' then
				t_xor_bit		:= t_attack xor t_alternate;
				n_env_actual		:= t_xor_bit & t_xor_bit & t_xor_bit & t_xor_bit;

			else
				t_xor_bit		:= t_attack xor t_doalt;
				n_env_actual		:= n_env_step(3 downto 0) xnor (t_xor_bit & t_xor_bit & t_xor_bit & t_xor_bit);
			end if;

			-- and do the count
			n_env_step			:= n_env_step + ("0000"&(not t_stop));

			env_volume			<= n_env_actual;
		end if;
	end process;



	do_pwm: process(pwm_clk, nRESET)
		variable	r_left_sum, r_right_sum				: std_logic_vector(6 downto 0);
		variable	r_selector					: std_logic_vector(1 downto 0);

		variable	n_left_sum, n_right_sum				: std_logic_vector(7 downto 0);
		variable	t_left_v, t_right_v				: std_logic_vector(7 downto 0);		-- thing to add to sum this time
		variable	t_left_a, t_right_a				: std_logic_vector(4 downto 0);		-- amplitude to use for envelope
		variable	t_bit_a,  t_bit_b,  t_bit_c			: std_logic;
		variable	t_left,   t_right				: std_logic;

		variable	t_root2_bit					: std_logic;
		variable	r_root2_sum					: std_logic_vector(6 downto 0);
		variable	n_root2_sum					: std_logic_vector(6 downto 0);
	begin
		if nRESET='0' or env_restart='1' then
			r_selector			:= (others=>'0');
			r_left_sum			:= (others=>'0');
			r_right_sum			:= (others=>'0');
			r_root2_sum			:= (others=>'0');

			pwm_left			<= '0';
			pwm_right			<= '0';

		elsif rising_edge(pwm_clk) then
			n_left_sum			:= "0"&r_left_sum;
			n_right_sum			:= "0"&r_right_sum;
			n_root2_sum			:= r_root2_sum;

			t_root2_bit			:= r_root2_sum(6);

			-- 

			-- http://www.cpcwiki.eu/index.php/PSG says:
			-- If both Tone and Noise are disabled on a channel, then a constant HIGH level is output (useful for digitized speech).
		        -- If both Tone and Noise are enabled on the same channel, then the signals are ANDed (the signals aren't ADDed)
			-- (ie. HIGH is output only if both are HIGH). 
			t_bit_a					:= (en_noise_a or noise_bit) and (en_tone_a or tone_out_a); 
			t_bit_b					:= (en_noise_b or noise_bit) and (en_tone_b or tone_out_b); 
			t_bit_c					:= (en_noise_c or noise_bit) and (en_tone_c or tone_out_c); 

			if r_selector(1)='0' then
				--		normal		mono
				--	L	L1,L3		L1,R3
				--	R	R1,R3		L1,R3

				if (r_selector(0) and is_mono)='0' then
					t_left		:= t_bit_a;
					t_left_a	:= amp_a;
				else
					t_left		:= t_bit_c;
					t_left_a	:= amp_c;		-- play C in left only on 01 & mono
				end if;

				if ((not r_selector(0)) and is_mono)='0' then
					t_right		:= t_bit_c;
					t_right_a	:= amp_c;
				else
					t_right		:= t_bit_a;
					t_right_a	:= amp_a;		-- play A in right only on 00 & mono
				end if;

			elsif r_selector(0)='0' then
					t_left		:= t_bit_b;
					t_left_a	:= amp_b;
					t_right		:= t_bit_b;
					t_right_a	:= amp_b;
			else
					t_left		:= tape_noise;							t_left_a:= "01100";
					t_right		:= tape_noise;							t_right_a:= "01100";

					-- also, update the root 2 malarky every 4th cycle
					n_root2_sum	:= ("0"+n_root2_sum(5 downto 0)) + "0101101";		-- 45/64 is 0.703, sqrt(2)=0.707
			end if;

			-- use envelope amplitude instead of channel if bit 4 set
			if t_left_a(4)='1' then
				t_left_a(3 downto 0)	:= env_volume;
			end if;
			if t_right_a(4)='1' then
				t_right_a(3 downto 0)	:= env_volume;
			end if;

			-- calculate the contribution to the pwm bit
			case t_left_a(3 downto 1) is
				when "111" => t_left_v	:= "10000000";
				when "110" => t_left_v	:= "01000000";
				when "101" => t_left_v	:= "00100000";
				when "100" => t_left_v	:= "00010000";
				when "011" => t_left_v	:= "00001000";
				when "010" => t_left_v	:= "00000100";
				when "001" => t_left_v	:= "00000010";
				when others=> t_left_v	:= "0000000" & t_left_a(0);		-- special case "0000" is complete silence, not based on t_root2_bit
			end case;
			case t_right_a(3 downto 1) is
				when "111" => t_right_v	:= "10000000";
				when "110" => t_right_v	:= "01000000";
				when "101" => t_right_v	:= "00100000";
				when "100" => t_right_v	:= "00010000";
				when "011" => t_right_v	:= "00001000";
				when "010" => t_right_v	:= "00000100";
				when "001" => t_right_v	:= "00000010";
				when others=> t_right_v	:= "0000000" & t_right_a(0);		-- special case "0000" is complete silence, not based on t_root2_bit
			end case;

			-- add this contribution every cycle or every 0.707 cycles depending on lower bit
			if (t_left and (t_left_a(0) or t_root2_bit))='1' then
				n_left_sum		:= n_left_sum + t_left_v;
			end if;
			if (t_right and (t_right_a(0) or t_root2_bit))='1' then
				n_right_sum		:= n_right_sum + t_right_v;
			end if;

			r_left_sum			:= n_left_sum(6 downto 0);
			r_right_sum			:= n_right_sum(6 downto 0);
			r_selector			:= r_selector + 1;
			r_root2_sum			:= n_root2_sum;

			pwm_left			<= n_left_sum(7);
			pwm_right			<= n_right_sum(7);
		end if;
	end process;

end impl;

-- sound 7,100,100,15	:' note how it actually uses volume 14 not 15!
-- 64 00 64 00 64 00 00 38 0e 0e 0e 00 00 00 00 00

