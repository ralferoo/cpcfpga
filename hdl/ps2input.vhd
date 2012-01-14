-- cpc emulator
--
-- ps/2 keyboard decoder

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity ps2input is port(
	nRESET			: in	std_logic;
	clk			: in	std_logic;					-- 1mhz clock

	-- ps/2 keyboard interface
	ps2_clock		: inout std_logic;
	ps2_data		: inout std_logic;

	-- receive matrix
	keyboard_row		: in	std_logic_vector(3 downto 0);
	keyboard_column		: out	std_logic_vector(7 downto 0);	

	-- joystick special
	joystick_1		: in	std_logic_vector(5 downto 0);
	joystick_2		: in	std_logic_vector(5 downto 0) );
end ps2input;

architecture impl of ps2input is

	signal	d_scancode	: std_logic_vector(9 downto 0);

	-- special keys

	signal	key_shift_l	: std_logic := '1';
	signal	key_shift_r	: std_logic := '1';
	signal	key_ctrl_l	: std_logic := '1';
	signal	key_ctrl_r	: std_logic := '1';
	signal	key_bslash_real	: std_logic := '1';
	signal	key_bslash_ralt	: std_logic := '1';

--  grep n_dout hdl/ps2input.vhd |perl -ne '$a=$_;{while ($a=~s/(key_[^\s;\)]+)//) {print "\tsignal\t$1\t\t : std_logic := '1';\n";}}'

	signal	key_fdot	 : std_logic := '1';
	signal	key_enter	 : std_logic := '1';
	signal	key_f3		 : std_logic := '1';
	signal	key_f6		 : std_logic := '1';
	signal	key_f9		 : std_logic := '1';
	signal	key_curdown	 : std_logic := '1';
	signal	key_curright	 : std_logic := '1';
	signal	key_curup	 : std_logic := '1';
	signal	key_f0		 : std_logic := '1';
	signal	key_f2		 : std_logic := '1';
	signal	key_f1		 : std_logic := '1';
	signal	key_f5		 : std_logic := '1';
	signal	key_f8		 : std_logic := '1';
	signal	key_f7		 : std_logic := '1';
	signal	key_copy	 : std_logic := '1';
	signal	key_curleft	 : std_logic := '1';
	signal	key_control	 : std_logic := '1';
	signal	key_bslash	 : std_logic := '1';
	signal	key_shift	 : std_logic := '1';
	signal	key_f4		 : std_logic := '1';
	signal	key_rsquare	 : std_logic := '1';
	signal	key_return	 : std_logic := '1';
	signal	key_lsquare	 : std_logic := '1';
	signal	key_clr		 : std_logic := '1';
	signal	key_dot		 : std_logic := '1';
	signal	key_fslash	 : std_logic := '1';
	signal	key_colon	 : std_logic := '1';
	signal	key_semi	 : std_logic := '1';
	signal	key_p		 : std_logic := '1';
	signal	key_at		 : std_logic := '1';
	signal	key_dash	 : std_logic := '1';
	signal	key_hat		 : std_logic := '1';
	signal	key_comma	 : std_logic := '1';
	signal	key_m		 : std_logic := '1';
	signal	key_k		 : std_logic := '1';
	signal	key_l		 : std_logic := '1';
	signal	key_i		 : std_logic := '1';
	signal	key_o		 : std_logic := '1';
	signal	key_9		 : std_logic := '1';
	signal	key_0		 : std_logic := '1';
	signal	key_space	 : std_logic := '1';
	signal	key_n		 : std_logic := '1';
	signal	key_j		 : std_logic := '1';
	signal	key_h		 : std_logic := '1';
	signal	key_y		 : std_logic := '1';
	signal	key_u		 : std_logic := '1';
	signal	key_7		 : std_logic := '1';
	signal	key_8		 : std_logic := '1';
	signal	key_v		 : std_logic := '1';
	signal	key_b		 : std_logic := '1';
	signal	key_f		 : std_logic := '1';
	signal	key_g		 : std_logic := '1';
	signal	key_t		 : std_logic := '1';
	signal	key_r		 : std_logic := '1';
	signal	key_5		 : std_logic := '1';
	signal	key_6		 : std_logic := '1';
	signal	key_x		 : std_logic := '1';
	signal	key_c		 : std_logic := '1';
	signal	key_d		 : std_logic := '1';
	signal	key_s		 : std_logic := '1';
	signal	key_w		 : std_logic := '1';
	signal	key_e		 : std_logic := '1';
	signal	key_3		 : std_logic := '1';
	signal	key_4		 : std_logic := '1';
	signal	key_z		 : std_logic := '1';
	signal	key_caps	 : std_logic := '1';
	signal	key_a		 : std_logic := '1';
	signal	key_tab		 : std_logic := '1';
	signal	key_q		 : std_logic := '1';
	signal	key_esc		 : std_logic := '1';
	signal	key_2		 : std_logic := '1';
	signal	key_1		 : std_logic := '1';
	signal	key_del		 : std_logic := '1';
begin
	-- special key combos
	key_control		<= key_ctrl_l      and key_ctrl_r;
	key_shift		<= key_shift_l     and key_shift_r;
	key_bslash		<= key_bslash_real and key_bslash_ralt;

	-- this process updates the column result based on the selected row
	process(nRESET, clk, keyboard_row,
		key_enter,
		key_control,
		key_space)
		variable	n_dout				: std_logic_vector(7 downto 0);
	begin
		if nRESET='0' then
			keyboard_column				<= (others=>'1');
		
		elsif rising_edge(clk) then
			n_dout					:= (others=>'1');
			case keyboard_row is
				when "0000" =>	n_dout		:= key_fdot	& key_enter	& key_f3	& key_f6	& key_f9	& key_curdown	& key_curright	& key_curup;
				when "0001" =>	n_dout		:= key_f0	& key_f2	& key_f1	& key_f5	& key_f8	& key_f7	& key_copy	& key_curleft;
				when "0010" =>	n_dout		:= key_control	& key_bslash	& key_shift	& key_f4	& key_rsquare	& key_return	& key_lsquare	& key_clr;
				when "0011" =>	n_dout		:= key_dot	& key_fslash	& key_colon	& key_semi	& key_p		& key_at	& key_dash	& key_hat;
				when "0100" =>	n_dout		:= key_comma	& key_m		& key_k		& key_l		& key_i		& key_o		& key_9		& key_0;
				when "0101" =>	n_dout		:= key_space	& key_n		& key_j		& key_h		& key_y		& key_u		& key_7		& key_8;
				when "0110" =>	n_dout		:= key_v	& key_b	     & (( key_f		& key_g		& key_t		& key_r		& key_5		& key_6)	and joystick_2); 
				when "0111" =>	n_dout		:= key_x	& key_c		& key_d		& key_s		& key_w		& key_e		& key_3		& key_4;
				when "1000" =>	n_dout		:= key_z	& key_caps	& key_a		& key_tab	& key_q		& key_esc	& key_2		& key_1;
				when "1001" =>	n_dout		:= key_del	& '1'		& joystick_1;

				-- expose the raw scancode for debugging purposes on some "unused" rows
				when "1110" => n_dout		:= d_scancode(7 downto 0);
				when "1111" => n_dout(1 downto 0):= d_scancode(9 downto 8);

				when others => null;
			end case;

			keyboard_column		<= n_dout;
		end if;

	end process;

	-- this process reads from the ps2 interface
	process(nRESET, clk)
		variable	r_timeout	: std_logic_vector(12 downto 0);
		variable	r_clock		: std_logic;
		variable	r_filter_count	: std_logic_vector(3 downto 0);
		variable	r_do_sample	: std_logic;
		variable	r_shift_reg	: std_logic_vector(10 downto 0);
		variable	r_parity	: std_logic;
		variable	r_keystate	: std_logic;
		variable	r_extended	: std_logic;

		variable	n_timeout	: std_logic_vector(13 downto 0);
		variable	n_clock		: std_logic;
		variable	n_filter_count	: std_logic_vector(3 downto 0);
		variable	n_do_sample	: std_logic;
		variable	n_shift_reg	: std_logic_vector(10 downto 0);
		variable	n_parity	: std_logic;
		variable	n_keystate	: std_logic;
		variable	n_extended	: std_logic;

		variable	t_scancode	: std_logic_vector(11 downto 0);
	begin
		if nRESET='0' then
			n_timeout	:= (others=>'0');
			n_clock		:= '0';
			n_filter_count	:= "1111";
			n_do_sample	:= '1';
			n_shift_reg	:= (others=>'1');
			n_parity	:= '0';
			n_keystate	:= '0';
			n_extended	:= '0';

			-- set the buses to high-Z
			ps2_clock	<= 'Z';
			ps2_data	<= 'Z';

			d_scancode	<= (others=>'0');

-- grep signal hdl/ps2input.vhd |perl -ne 'if (s/signal\s+(key_[^\s;\)]+)\s+:\s+std_logic//) {print "\t\t\t$1\t\t\t\t<= '\''1'\'';\n";}'			

			key_shift_l				<= '1';
			key_shift_r				<= '1';
			key_ctrl_l				<= '1';
			key_ctrl_r				<= '1';
			key_bslash_real				<= '1';
			key_bslash_ralt				<= '1';
			key_fdot				<= '1';
			key_enter				<= '1';
			key_f3					<= '1';
			key_f6					<= '1';
			key_f9					<= '1';
			key_curdown				<= '1';
			key_curright				<= '1';
			key_curup				<= '1';
			key_f0					<= '1';
			key_f2					<= '1';
			key_f1					<= '1';
			key_f5					<= '1';
			key_f8					<= '1';
			key_f7					<= '1';
			key_copy				<= '1';
			key_curleft				<= '1';
			key_f4					<= '1';
			key_rsquare				<= '1';
			key_return				<= '1';
			key_lsquare				<= '1';
			key_clr					<= '1';
			key_dot					<= '1';
			key_fslash				<= '1';
			key_colon				<= '1';
			key_semi				<= '1';
			key_p					<= '1';
			key_at					<= '1';
			key_dash				<= '1';
			key_hat					<= '1';
			key_comma				<= '1';
			key_m					<= '1';
			key_k					<= '1';
			key_l					<= '1';
			key_i					<= '1';
			key_o					<= '1';
			key_9					<= '1';
			key_0					<= '1';
			key_space				<= '1';
			key_n					<= '1';
			key_j					<= '1';
			key_h					<= '1';
			key_y					<= '1';
			key_u					<= '1';
			key_7					<= '1';
			key_8					<= '1';
			key_v					<= '1';
			key_b					<= '1';
			key_f					<= '1';
			key_g					<= '1';
			key_t					<= '1';
			key_r					<= '1';
			key_5					<= '1';
			key_6					<= '1';
			key_x					<= '1';
			key_c					<= '1';
			key_d					<= '1';
			key_s					<= '1';
			key_w					<= '1';
			key_e					<= '1';
			key_3					<= '1';
			key_4					<= '1';
			key_z					<= '1';
			key_caps				<= '1';
			key_a					<= '1';
			key_tab					<= '1';
			key_q					<= '1';
			key_esc					<= '1';
			key_2					<= '1';
			key_1					<= '1';
			key_del					<= '1';
			

		elsif rising_edge(clk) then	
			-- initialise vars
			n_timeout	:= '0' & r_timeout;
			n_clock		:= r_clock;
			n_filter_count	:= r_filter_count;
			n_do_sample	:= r_do_sample;
			n_shift_reg	:= r_shift_reg;
			n_parity	:= r_parity;
			n_keystate	:= r_keystate;
			n_extended	:= r_extended;

			-- manage the timeout, if we go over 8192us without a clock pulse then empty out the shift register
			n_timeout		:= n_timeout + 1;
			if n_timeout(13)='1' then
				n_shift_reg	:= (others=>'1');
			end if;

			-- filter out the clock signal
			if r_clock /= ps2_clock then			-- ps2 clock is 10-16.7MHz, so 30-50us between edges
				n_filter_count		:= "1111";	-- so, wait for 15us for a stable clock signal
				n_clock			:= ps2_clock;	-- so we can sample it approximately 1/2 way
				n_do_sample		:= ps2_clock;	-- sample on the falling edge

			elsif n_filter_count /= "0000" then
				n_filter_count		:= n_filter_count - 1;	-- reduce filter count

			elsif n_do_sample = '0'	then			-- count reduced and we're on the falling edge
				n_do_sample		:= '1';		-- only care about the edge not the whole signal

				-- process the incoming bit, shifting right => 1(stop) x(par) xxxxxxxx(data) 0(start)
				n_shift_reg		:= ps2_data & n_shift_reg(10 downto 1); -- shift right, LSB first
				n_parity		:= n_parity xor ps2_data;		-- calculate parity bit
				n_timeout		:= (others=>'0');			-- clear timeout

				-- check if we received an entire byte and if so, process scancode
				if n_shift_reg(0) = '0' then	-- byte received
					if n_shift_reg(10) = '1' and n_parity ='0' then	-- odd parity + stop bit 
					-- should check parity, but i don't want to do the host requesting retransmit

					    t_scancode	:= "000" & n_extended & n_shift_reg(8 downto 1);	

					    n_keystate	:= '0';			-- default next keystate to pressed for next key
					    n_extended	:= '0';

					    d_scancode	<= r_keystate & t_scancode(8 downto 0);

					    case t_scancode is
						when x"014" =>		key_ctrl_l	<= r_keystate;		-- left control
						when x"114" =>		key_ctrl_r	<= r_keystate;		-- right control

						-- handle extended scancode prefix
						when x"0e0" =>		n_extended	:= '1';			-- set extended state

						-- handle break prefix
						when x"0f0" =>		n_keystate	:= '1';			-- next key is release
						when x"1f0" =>		n_keystate	:= '1';			-- next key is release
									n_extended	:= '1';			-- maintain extended

-- grep n_dout hdl/ps2input.vhd |perl -ne '$a=$_;{while ($a=~s/(key_[^\s;\)]+)//) {print "\t\t\t\t\t\twhen \"x000\" =>\t$1\t\t<= r_keystate;\n";}}' 

						when x"071" =>		key_fdot	<= r_keystate;
						when x"15a" =>		key_enter	<= r_keystate;		-- numeric enter
						when x"07a" =>		key_f3		<= r_keystate;
						when x"074" =>		key_f6		<= r_keystate;
						when x"07d" =>		key_f9		<= r_keystate;
						when x"172" =>		key_curdown	<= r_keystate;
						when x"174" =>		key_curright	<= r_keystate;
						when x"175" =>		key_curup	<= r_keystate;
						when x"070" =>		key_f0		<= r_keystate;
						when x"072" =>		key_f2		<= r_keystate;
						when x"069" =>		key_f1		<= r_keystate;
						when x"073" =>		key_f5		<= r_keystate;
						when x"075" =>		key_f8		<= r_keystate;
						when x"06c" =>		key_f7		<= r_keystate;
						when x"011" =>		key_copy	<= r_keystate;		-- left alt = copy on pc
						when x"16b" =>		key_curleft	<= r_keystate;
						---when x"000" =>		key_control	<= r_keystate;
						--when x"05d" =>		key_bslash_real	<= r_keystate;		-- backslash, but on wrong side of pc keyboard	(oooooh!)
						when x"127" =>		key_bslash_ralt	<= r_keystate;		-- backslash, right alt is close
						when x"012" =>		key_shift_l	<= r_keystate;
						when x"059" =>		key_shift_r	<= r_keystate;
						when x"06b" =>		key_f4		<= r_keystate;
						when x"05d" =>		key_rsquare	<= r_keystate;		-- rsqaure on cpc		-> hash (bslash) on pc	(oooooh!)
						when x"05a" =>		key_return	<= r_keystate;		-- "enter" on PC/464, "return" on 6128
						when x"05b" =>		key_lsquare	<= r_keystate;		-- lsquare on cpc		-> rsquare on pc
						when x"171" =>		key_clr		<= r_keystate;		-- clr on cpc			-> delete on pc
						when x"049" =>		key_dot		<= r_keystate;
						when x"04a" =>		key_fslash	<= r_keystate;
						when x"04c" =>		key_colon	<= r_keystate;		-- colon / star on cpc		-> semi / colon on pc
						when x"052" =>		key_semi	<= r_keystate;		-- semi / plus on cpc		-> quote / at on pc
						when x"04d" =>		key_p		<= r_keystate;
						when x"054" =>		key_at		<= r_keystate;		-- at / bar on cpc		-> left square on pc
						when x"04e" =>		key_dash	<= r_keystate;		-- minus / equals on cpc	-> minus on pc
						when x"055" =>		key_hat		<= r_keystate;		-- hat / pound on cpc		-> equals on pc
						when x"041" =>		key_comma	<= r_keystate;
						when x"03a" =>		key_m		<= r_keystate;
						when x"042" =>		key_k		<= r_keystate;
						when x"04b" =>		key_l		<= r_keystate;
						when x"043" =>		key_i		<= r_keystate;
						when x"044" =>		key_o		<= r_keystate;
						when x"046" =>		key_9		<= r_keystate;
						when x"045" =>		key_0		<= r_keystate;
						when x"029" =>		key_space	<= r_keystate;		-- space bar
						when x"031" =>		key_n		<= r_keystate;
						when x"03b" =>		key_j		<= r_keystate;
						when x"033" =>		key_h		<= r_keystate;
						when x"035" =>		key_y		<= r_keystate;
						when x"03c" =>		key_u		<= r_keystate;
						when x"03d" =>		key_7		<= r_keystate;
						when x"03e" =>		key_8		<= r_keystate;
						when x"02a" =>		key_v		<= r_keystate;
						when x"032" =>		key_b		<= r_keystate;
						when x"02b" =>		key_f		<= r_keystate;
						when x"034" =>		key_g		<= r_keystate;
						when x"02c" =>		key_t		<= r_keystate;
						when x"02d" =>		key_r		<= r_keystate;
						when x"02e" =>		key_5		<= r_keystate;
						when x"036" =>		key_6		<= r_keystate;
						when x"022" =>		key_x		<= r_keystate;
						when x"021" =>		key_c		<= r_keystate;
						when x"023" =>		key_d		<= r_keystate;
						when x"01b" =>		key_s		<= r_keystate;
						when x"01d" =>		key_w		<= r_keystate;
						when x"024" =>		key_e		<= r_keystate;
						when x"026" =>		key_3		<= r_keystate;
						when x"025" =>		key_4		<= r_keystate;
						when x"01a" =>		key_z		<= r_keystate;
						when x"058" =>		key_caps	<= r_keystate;
						when x"01c" =>		key_a		<= r_keystate;
						when x"00d" =>		key_tab		<= r_keystate;
						when x"015" =>		key_q		<= r_keystate;
						when x"076" =>		key_esc		<= r_keystate;
						when x"01e" =>		key_2		<= r_keystate;
						when x"016" =>		key_1		<= r_keystate;
						when x"066" =>		key_del		<= r_keystate;		-- backsp on pc

						when others => null;
					    end case;
					end if;

					-- clear out the shift register so we can detect the start bit falling through to the end again
					n_shift_reg	:= (others=>'1');
					n_parity	:= '0';
				end if; -- byte recvd
			end if; -- do sample
		end if; -- rising edge

		-- save vars
		r_timeout	:= n_timeout(12 downto 0);
		r_clock		:= n_clock;
		r_filter_count	:= n_filter_count;
		r_do_sample	:= n_do_sample;
		r_shift_reg	:= n_shift_reg;
		r_parity	:= n_parity;
		r_keystate	:= n_keystate;
		r_extended	:= n_extended;
	end process;
end impl;

