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

	signal	key_enter	: std_logic := '1';
	signal	key_control	: std_logic := '1';
	signal	key_ctrl_l	: std_logic := '1';
	signal	key_ctrl_r	: std_logic := '1';
	signal	key_space	: std_logic := '1';

	signal	d_scancode	: std_logic_vector(9 downto 0);
begin
	-- special key combos
	key_control		<= key_ctrl_l and key_ctrl_r;

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
				when "0000" =>
						n_dout(6)	:= key_enter;

				when "0010" =>
						n_dout(7)	:= key_control;


				when "0101" =>
						n_dout(7)	:= key_space;

				when "1001" =>
						n_dout(5 downto 0):= joystick_1;

				-- expose the raw scancode for debugging purposes
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
					-- n_shift_reg(10) = '1' and t_parity ='0'	-- odd parity + stop bit 
					-- should check parity, but i don't want to do the host requesting retransmit

					t_scancode	:= "000" & n_extended & n_shift_reg(8 downto 1);	

					n_keystate	:= '0';			-- default next keystate to pressed for next key
					n_extended	:= '0';

					d_scancode	<= r_keystate & t_scancode(8 downto 0);

					case t_scancode is
						when x"029" =>		key_space	<= r_keystate;		-- space bar
						when x"014" =>		key_ctrl_l	<= r_keystate;		-- left control
						when x"114" =>		key_ctrl_r	<= r_keystate;		-- right control
						when x"15a" =>		key_enter	<= r_keystate;		-- numeric enter

						-- handle extended scancode prefix
						when x"0e0" =>		n_extended	:= '1';			-- set extended state

						-- handle break prefix
						when x"0f0" =>		n_keystate	:= '1';			-- next key is release
						when x"1f0" =>		n_keystate	:= '1';			-- next key is release
									n_extended	:= '1';			-- maintain extended
						when others => null;
					end case;

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

