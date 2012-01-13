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

begin
	-- this process deals with the CPU (well, PPI) interface to the registers
	process(nRESET, clk, bdir_bc1, din)
		variable	r_sel_register	: std_logic_vector(3 downto 0);
		variable	r_dout		: std_logic_vector(7 downto 0);

		variable	n_sel_register	: std_logic_vector(3 downto 0);
		variable	n_dout		: std_logic_vector(7 downto 0);
	begin
		if nRESET='0' then
			r_sel_register	:= (others=>'0');
			r_dout		:= (others=>'0');

		elsif rising_edge(clk) then	
			n_sel_register	:= r_sel_register;
			n_dout		:= r_dout;
			
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
							when others => null;
						end case;

				when others => null;
			end case;
			r_sel_register	:= n_sel_register;
			r_dout		:= n_dout;
		end if;

		dout			<= r_dout;
	end process;

	-- dummy for now
	pwm_left	<= '0';
	pwm_right	<= '0';
end impl;
