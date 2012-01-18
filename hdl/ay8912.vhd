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
	pcm_clk			: in	std_logic;
	
	-- z80 databus interface
	bdir_bc1		: in	std_logic_vector(1 downto 0);			-- bc2, a8 are pulled high, so won't bother
	din			: in	std_logic_vector(7 downto 0);
	dout			: out	std_logic_vector(7 downto 0);

	-- io port a (keyboard)
	io_a			: in	std_logic_vector(7 downto 0);			-- really this should be inout, but cpc is input

	-- sound
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

	signal	pwm_add_left, pwm_add_right		: std_logic_vector(11 downto 0);	-- contribution to pwm output per physical channel
begin
	-- this process deals with the CPU (well, PPI) interface to the registers
	process(nRESET, clk, bdir_bc1, din)
		variable	r_sel_register	: std_logic_vector(3 downto 0);
		variable	r_dout		: std_logic_vector(7 downto 0);
		variable	r_env_restart	: std_logic;

		variable	n_sel_register	: std_logic_vector(3 downto 0);
		variable	n_dout		: std_logic_vector(7 downto 0);
		variable	n_env_restart	: std_logic;
	begin
		if nRESET='0' then
			r_sel_register	:= (others=>'0');
			r_dout		:= (others=>'0');
			r_env_restart	:= '0';

		elsif rising_edge(clk) then	
			n_sel_register	:= r_sel_register;
			n_dout		:= r_dout;
			n_env_restart	:= '0';
			
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
							when "0000" =>	tone_a( 7 downto 0)	<= din;
							when "0001" =>	tone_a(11 downto 8)	<= din(3 downto 0);

							when "0010" =>	tone_b( 7 downto 0)	<= din;
							when "0011" =>	tone_b(11 downto 8)	<= din(3 downto 0);

							when "0100" =>	tone_c( 7 downto 0)	<= din;
							when "0101" =>	tone_c(11 downto 8)	<= din(3 downto 0);

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
		end if;

		env_restart		<= r_env_restart;
		dout			<= r_dout;
	end process;

	-- this process deals with playback
	process(nRESET, clk, tone_a, tone_b, tone_c)
		variable	r_tone_divisor					: std_logic_vector(2 downto 0);		-- freq divide by 16, toggle every 8
		variable	r_tone_a_ctr, r_tone_b_ctr, r_tone_c_ctr	: std_logic_vector(11 downto 0);	-- current count for each tone unit
		variable	r_tone_a_out, r_tone_b_out, r_tone_c_out	: std_logic; 				-- output tones
		variable	r_noise_ctr					: std_logic_vector(4 downto 0);		-- current count for noise
		variable	r_lfsr						: std_logic_vector(14 downto 0);	-- current random seed for noise
		variable	r_pwm_add_left, r_pwm_add_right			: std_logic_vector(11 downto 0);	-- contribution to pwm output per physical channel
		variable	r_env_divisor					: std_logic_vector(3 downto 0);		-- divide r_tone_divisor by 16
		variable	r_env_period_ctr				: std_logic_vector(15 downto 0);	-- counts up to env_period
		variable	r_env_vol					: std_logic_vector(4 downto 0);		-- amplitude to use for envelope
		variable	r_env_actual					: std_logic_vector(3 downto 0);		-- amplitude to use for envelope

		variable	n_tone_divisor					: std_logic_vector(3 downto 0);		-- freq divide by 16, toggle every 8
		variable	n_tone_a_ctr, n_tone_b_ctr, n_tone_c_ctr	: std_logic_vector(11 downto 0);	-- current count for each tone unit
		variable	n_tone_a_out, n_tone_b_out, n_tone_c_out	: std_logic; 				-- output tones
		variable	n_noise_ctr					: std_logic_vector(4 downto 0);		-- current count for noise
		variable	n_lfsr						: std_logic_vector(14 downto 0);	-- current random seed for noise
		variable	n_pwm_add_left, n_pwm_add_right			: std_logic_vector(11 downto 0);	-- contribution to pwm output per physical channel
		variable	n_env_vol					: std_logic_vector(4 downto 0);		-- amplitude to use for envelope
		variable	n_env_period_ctr				: std_logic_vector(15 downto 0);	-- counts up to env_period
		variable	n_env_divisor					: std_logic_vector(4 downto 0);		-- divide r_tone_divisor by 16
		variable	n_env_actual					: std_logic_vector(3 downto 0);		-- amplitude to use for envelope

		variable	t_amp_a, t_amp_b, t_amp_c			: std_logic_vector(4 downto 0);		-- amplitude to use
		variable	t_pwm_cont_a, t_pwm_cont_b, t_pwm_cont_c	: std_logic_vector(11 downto 0);	-- contribution to pwm output per AY channel
		variable	t_noise_a, t_noise_b, t_noise_c			: std_logic;				-- noise per channel
		variable	t_sound_a, t_sound_b, t_sound_c			: std_logic;				-- sound per channel

		variable	t_attack, t_alternate, t_hold			: std_logic;				-- temp vars for envelope
		variable	t_stop, t_doalt, t_xor_bit			: std_logic;				-- temp vars for envelope


	procedure calculate_pwm_contribution(	variable	enable	: in  std_logic;
						variable	vol	: in  std_logic_vector(4 downto 0);
						variable	env	: in  std_logic_vector(3 downto 0);
						variable	pwmval	: out std_logic_vector(11 downto 0)) is
		variable	t_vol	: std_logic_vector(3 downto 0);
		begin
			if enable='1' then
				if vol(4)='0' then
					t_vol		:= vol(3 downto 0);
				else
					t_vol		:= env(3 downto 0);
				end if;

				--- hmm, this log scale doesn't actually seem to match the 464 volume at all... :(
	
				case t_vol is						-- translate figure 9 into PWM contribution
					when "1111" =>	pwmval	:= x"AAA";		-- 1.000*AAA FFF / 1.5 (as we're mixing A+B/2 and C+B/2)
					when "1110" =>	pwmval	:= x"78A";		-- 0.707*AAA (0.5*sqrt(2))
					when "1101" =>	pwmval	:= x"555";		-- 0.500*AAA
					when "1100" =>	pwmval	:= x"33B";		-- 0.303*AAA (this is starts the non-logarithmic section)
					when "1011" =>	pwmval	:= x"2AA";		-- 0.250*AAA
					when "1010" =>	pwmval	:= x"19D";		-- 0.1515*AAA
					when "1001" =>	pwmval	:= x"155";		-- 0.125*AAA
					when "1000" =>	pwmval	:= x"0CE";		-- all subsequent ones are half the penultimate value
					when "0111" =>	pwmval	:= x"0AA";	
					when "0110" =>	pwmval	:= x"067";	
					when "0101" =>	pwmval	:= x"055";	
					when "0100" =>	pwmval	:= x"033";	
					when "0011" =>	pwmval	:= x"02A";	
					when "0010" =>	pwmval	:= x"019";	
					when "0001" =>	pwmval	:= x"015";	
					when others =>	pwmval	:= (others=>'0');
				end case;
			else
				pwmval				:= (others=>'0');
			end if;
		end procedure calculate_pwm_contribution;

	begin
		if nRESET='0' then
			-- initialise variables
			r_tone_divisor			:= (others=>'0');
			r_env_divisor			:= (others=>'0');
			r_tone_a_ctr			:= (others=>'0');
			r_tone_b_ctr			:= (others=>'0');
			r_tone_c_ctr			:= (others=>'0');
			r_tone_a_out			:= '0';
			r_tone_b_out			:= '0';
			r_tone_c_out			:= '0';
			r_noise_ctr			:= (others=>'0');
			r_lfsr				:= (others=>'0');
			r_pwm_add_left			:= (others=>'0');
			r_pwm_add_right			:= (others=>'0');
			r_env_vol			:= (others=>'0');
			r_env_period_ctr		:= (others=>'0');
			r_env_actual			:= (others=>'0');

			pwm_add_left			<= (others=>'0');
			pwm_add_right			<= (others=>'0');

		elsif rising_edge(clk) then	
			-- initialise variables
			n_tone_divisor			:= "0" & r_tone_divisor;	
			n_env_divisor			:= "0" & r_env_divisor;
			n_tone_a_ctr			:= r_tone_a_ctr;
			n_tone_b_ctr			:= r_tone_b_ctr;
			n_tone_c_ctr			:= r_tone_c_ctr;
			n_tone_a_out			:= r_tone_a_out;
			n_tone_b_out			:= r_tone_b_out;
			n_tone_c_out			:= r_tone_c_out;
			n_noise_ctr			:= r_noise_ctr;
			n_lfsr				:= r_lfsr;
			n_pwm_add_left			:= r_pwm_add_left;
			n_pwm_add_right			:= r_pwm_add_right;
			n_env_vol			:= r_env_vol;
			n_env_period_ctr		:= r_env_period_ctr;
			n_env_actual			:= r_env_actual;

			-- do the tone divisor and counters
			n_tone_divisor			:= n_tone_divisor + 1;
			if n_tone_divisor(3)='1' then				-- overflow, i.e. == 8 clock cycles
				-- tone a
				if n_tone_a_ctr = x"001" then
					n_tone_a_ctr	:= tone_a;
					n_tone_a_out	:= not n_tone_a_out;
				else
					n_tone_a_ctr	:= n_tone_a_ctr - 1;
				end if;

				-- tone b
				if n_tone_b_ctr = x"001" then
					n_tone_b_ctr	:= tone_b;
					n_tone_b_out	:= not n_tone_b_out;
				else
					n_tone_b_ctr	:= n_tone_b_ctr - 1;
				end if;

				-- tone c
				if n_tone_c_ctr = x"001" then
					n_tone_c_ctr	:= tone_c;
					n_tone_c_out	:= not n_tone_c_out;
				else
					n_tone_c_ctr	:= n_tone_c_ctr - 1;
				end if;

				-- noise
				if n_noise_ctr = "00001" then
					n_noise_ctr	:= noise;
					n_lfsr		:= (n_lfsr(14) xor n_lfsr(13)) & n_lfsr(12 downto 5) & (n_lfsr(14) xor n_lfsr(4)) &
								n_lfsr(3 downto 2) & (n_lfsr(14) xor n_lfsr(1)) & n_lfsr(0) & n_lfsr(14);
				else
					n_noise_ctr	:= n_noise_ctr - 1;
				end if;

				-- update envelope
				n_env_divisor		:= n_env_divisor + 1;
				if n_env_divisor(4)='1' then				-- divide r_tone_divisor by 16 
					if n_env_period_ctr = x"0001" or env_restart='1' then
						n_env_period_ctr	:= env_period;

						if env_restart='1' then
							n_env_vol	:= (others=>'0');		-- restart envelope whenever port is written to
						end if;

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
						t_stop				:= t_hold and n_env_vol(4);
						t_doalt				:= t_alternate and n_env_vol(4);

						-- calculate envelope value
						if t_stop='1' then
							t_xor_bit		:= t_attack xor t_alternate;
							n_env_actual		:= t_xor_bit & t_xor_bit & t_xor_bit & t_xor_bit;

						else
							t_xor_bit		:= t_attack xor t_doalt;
							n_env_actual		:= n_env_vol(3 downto 0) xnor (t_xor_bit & t_xor_bit & t_xor_bit & t_xor_bit);
						end if;

						-- and do the count
						n_env_vol			:= n_env_vol + ("0000"&(not t_stop));

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
					else
						n_env_period_ctr	:= n_env_period_ctr - 1;
					end if; -- env period ctr
				end if; -- env divisor

				-- calculate the tone bits
				t_noise_a		:= r_lfsr( 7) and en_noise_a;			-- generate noise using a different bit
				t_noise_b		:= r_lfsr(13) and en_noise_b;			-- of the feedback register for each
				t_noise_c		:= r_lfsr(11) and en_noise_c;			-- channel
	
				-- calculate the sound enable
				t_sound_a		:= t_noise_a xor r_tone_a_out;			-- effectively add and divide by 2
				t_sound_b		:= t_noise_b xor r_tone_b_out;
				t_sound_c		:= t_noise_c xor r_tone_c_out;
	
				-- calculate the accumulation values for the PWM
				t_amp_a			:= amp_a;
				t_amp_b			:= amp_b;
				t_amp_c			:= amp_c;
				calculate_pwm_contribution( t_sound_a, t_amp_a, r_env_actual, t_pwm_cont_a );
				calculate_pwm_contribution( t_sound_b, t_amp_b, r_env_actual, t_pwm_cont_b );
				calculate_pwm_contribution( t_sound_c, t_amp_c, r_env_actual, t_pwm_cont_c );

				n_pwm_add_left		:= t_pwm_cont_a + ("0" & t_pwm_cont_b(11 downto 1) );
				n_pwm_add_right		:= t_pwm_cont_c + ("0" & t_pwm_cont_b(11 downto 1) );

			end if; -- tone divisor

			-- store registers
			r_tone_divisor			:= n_tone_divisor(2 downto 0);
			r_env_divisor			:= n_env_divisor(3 downto 0);
			r_tone_a_ctr			:= n_tone_a_ctr;
			r_tone_b_ctr			:= n_tone_b_ctr;
			r_tone_c_ctr			:= n_tone_c_ctr;
			r_tone_a_out			:= n_tone_a_out;
			r_tone_b_out			:= n_tone_b_out;
			r_tone_c_out			:= n_tone_c_out;
			r_noise_ctr			:= n_noise_ctr;
			r_lfsr				:= n_lfsr;
			r_pwm_add_left			:= n_pwm_add_left;
			r_pwm_add_right			:= n_pwm_add_right;
			r_env_vol			:= n_env_vol;
			r_env_period_ctr		:= n_env_period_ctr;
			r_env_actual			:= n_env_actual;

			pwm_add_left			<= r_pwm_add_left;
			pwm_add_right			<= r_pwm_add_right;

		end if; -- rising clock
	end process;

	-- this process deals with PWM output
	process(nRESET, pcm_clk, pwm_add_left, pwm_add_right)
		variable	r_pwm_sum_left, r_pwm_sum_right		: std_logic_vector(11 downto 0);
		variable	n_pwm_sum_left, n_pwm_sum_right		: std_logic_vector(12 downto 0);
	begin
		if nRESET='0' then
			r_pwm_sum_left			:= (others=>'0');
			r_pwm_sum_right			:= (others=>'0');
			pwm_left			<= '0';
			pwm_right			<= '0';

		elsif rising_edge(pcm_clk) then	
			n_pwm_sum_left 			:= ("0"&r_pwm_sum_left ) + ("0"&pwm_add_left );
			n_pwm_sum_right			:= ("0"&r_pwm_sum_right) + ("0"&pwm_add_right);

			r_pwm_sum_left			:= n_pwm_sum_left(11 downto 0);
			r_pwm_sum_right			:= n_pwm_sum_right(11 downto 0);

			pwm_left			<= n_pwm_sum_left(12);
			pwm_right			<= n_pwm_sum_right(12);
		end if;
	end process;
end impl;

