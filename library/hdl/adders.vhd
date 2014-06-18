-- adders.vhd

--------------------------------------------------------------------------------------------------------------------------------

-- inc2bits and dec2bits take a 2 bit input and a 1 bit carry/borrow and return a 2 bit output and 1 bit carry/borrow
-- because they are implemented as a LUT, they should take 3 LUTs per 2 bits, compared to 2 LUTs per bit for a 1 bit adder

--------------------------------------------------------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity inc2bits is
	port (
		num_in	   : in  std_logic_vector(1 downto 0);
		num_out	   : out std_logic_vector(1 downto 0);
		carry_in   : in  std_logic;
		carry_out  : out std_logic);
end entity;

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity dec2bits is
	port (
		num_in	   : in  std_logic_vector(1 downto 0);
		num_out	   : out std_logic_vector(1 downto 0);
		carry_in   : in  std_logic;
		carry_out  : out std_logic);
end entity;

--------------------------------------------------------------------------------------------------------------------------------

architecture impl of inc2bits is
begin
	process (num_in,carry_in)
		variable	t_input  : std_logic_vector(2 downto 0);
		variable	t_output : std_logic_vector(2 downto 0);
	begin
		t_input		:= carry_in & num_in;
		case t_input is
--			when "000" =>	t_output := "000";
			when "001" =>	t_output := "001";
			when "010" =>	t_output := "010";
			when "011" =>	t_output := "011";
			when "100" =>	t_output := "001";
			when "101" =>	t_output := "010";
			when "110" =>	t_output := "011";
			when "111" =>	t_output := "100";
			when others =>	t_output := "000";
		end case;
		carry_out	<= t_output(2);
		num_out		<= t_output(1 downto 0);
	end process;
end impl;

--------------------------------------------------------------------------------------------------------------------------------

architecture impl of dec2bits is
begin
	process (num_in,carry_in)
		variable	t_input  : std_logic_vector(2 downto 0);
		variable	t_output : std_logic_vector(2 downto 0);
	begin
		t_input		:= carry_in & num_in;
		case t_input is
--			when "000" =>	t_output := "000";
			when "001" =>	t_output := "001";
			when "010" =>	t_output := "010";
			when "011" =>	t_output := "011";
			when "100" =>	t_output := "111";
			when "101" =>	t_output := "000";
			when "110" =>	t_output := "001";
			when "111" =>	t_output := "010";
			when others =>	t_output := "000";
		end case;
		carry_out	<= t_output(2);
		num_out		<= t_output(1 downto 0);
	end process;
end impl;

--------------------------------------------------------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity clock_divider is
	port	(
		clk		: in  std_logic;
		load		: in  std_logic := '0';
		reset		: in  std_logic := '1';
		divisor		: in  std_logic_vector;						-- note that divider is actually by 2*divisor
		osc		: out std_logic;
		output		: out std_logic);
end entity;

architecture impl of clock_divider is
begin
	process(clk)
		variable	counter		: std_logic_vector(divisor'high+1 downto 0);	-- note 1 bit longer than width
		variable	osc_val		: std_logic;					-- oscillating output
		variable	t_osc_val	: std_logic;					-- oscillating output
		variable	t_bit0		: std_logic;					-- new bit 0 after subtract
		variable	t_carry0	: std_logic;					-- carry to subtract from bit 1
		variable	t_divisor	: std_logic_vector(divisor'high downto 0);	-- remainder of subtractand
		variable	t_rest		: std_logic_vector(divisor'high downto 0);	-- remainder of subtractand
		variable	t_restsub	: std_logic_vector(divisor'high downto 0);	-- result of subtraction

	begin
		if rising_edge(clk) then
			if (reset='0' or load='1') then					-- reset to divisor - 2 on load
				t_divisor	:= divisor;				-- reorder bits in case constant passed in
				t_bit0		:= t_divisor(0);			-- bit 0 untouched
				t_carry0	:= '1';					-- always carry into bit 1
				t_rest		:= "0" & t_divisor(t_divisor'high downto 1);
				t_osc_val	:= '0';

			elsif counter(counter'high)='1' then				-- also on rollover (same code, wary about uninitialised)
				t_divisor	:= divisor;				-- reorder bits in case constant passed in
				t_bit0		:= t_divisor(0);			-- bit 0 untouched
				t_carry0	:= '1';
				t_rest		:= "0" & t_divisor(t_divisor'high downto 1);
				t_osc_val	:= not osc_val;

			else								-- manually do the bit 0 carry
				t_bit0		:= not counter(0);
				t_carry0	:= not counter(0);
				t_rest		:= "0" & counter(counter'high-1 downto 1);
				t_osc_val	:= osc_val;
			end if;

			t_restsub		:= t_rest - (t_carry0);			-- do the rest of the subtraction
			counter			:= t_restsub & t_bit0;
			osc_val			:= t_osc_val;

			osc			<= osc_val;
			output			<= counter(counter'high);		-- will pulse on last clock per divisor
		end if;
	end process;
end impl;




--------------------------------------------------------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity add3 is
	port	(
		clk		: in  std_logic;
		a,b,c		: in  std_logic_vector;
		output		: out std_logic_vector;
		carry		: out std_logic_vector(1 downto 0));
end entity;

architecture impl of add3 is
begin
	process(clk)
		variable	n_output	: std_logic_vector(a'high downto 0);
		variable	t_carry		: std_logic_vector(1 downto 0);
		variable	t_bits		: std_logic_vector(4 downto 0);
	begin
		if rising_edge(clk) then
			t_carry		:= "00";
	
			for i in 0 to a'high loop
				t_bits	:= t_carry & a(i) & b(i) & c(i);
				case t_bits is
                                        when "00000" => t_carry:="00"; n_output(i):='0';
                                        when "00001" => t_carry:="00"; n_output(i):='1';
                                        when "00010" => t_carry:="00"; n_output(i):='1';
                                        when "00011" => t_carry:="01"; n_output(i):='0';
                                        when "00100" => t_carry:="00"; n_output(i):='1';
                                        when "00101" => t_carry:="01"; n_output(i):='0';
                                        when "00110" => t_carry:="01"; n_output(i):='0';
                                        when "00111" => t_carry:="01"; n_output(i):='1';
                                        when "01000" => t_carry:="00"; n_output(i):='1';
                                        when "01001" => t_carry:="01"; n_output(i):='0';
                                        when "01010" => t_carry:="01"; n_output(i):='0';
                                        when "01011" => t_carry:="01"; n_output(i):='1';
                                        when "01100" => t_carry:="01"; n_output(i):='0';
                                        when "01101" => t_carry:="01"; n_output(i):='1';
                                        when "01110" => t_carry:="01"; n_output(i):='1';
                                        when "01111" => t_carry:="10"; n_output(i):='0';
                                        when "10000" => t_carry:="01"; n_output(i):='0';
                                        when "10001" => t_carry:="01"; n_output(i):='1';
                                        when "10010" => t_carry:="01"; n_output(i):='1';
                                        when "10011" => t_carry:="10"; n_output(i):='0';
                                        when "10100" => t_carry:="01"; n_output(i):='1';
                                        when "10101" => t_carry:="10"; n_output(i):='0';
                                        when "10110" => t_carry:="10"; n_output(i):='0';
                                        when "10111" => t_carry:="10"; n_output(i):='1';
                                        when "11000" => t_carry:="01"; n_output(i):='1';
                                        when "11001" => t_carry:="10"; n_output(i):='0';
                                        when "11010" => t_carry:="10"; n_output(i):='0';
                                        when "11011" => t_carry:="10"; n_output(i):='1';
                                        when "11100" => t_carry:="10"; n_output(i):='0';
                                        when "11101" => t_carry:="10"; n_output(i):='1';
                                        when "11110" => t_carry:="10"; n_output(i):='1';
                                        when "11111" => t_carry:="11"; n_output(i):='0';
					when others =>
                                        		t_carry:="00"; n_output(i):='0';
				end case;
			end loop;

			output		<= n_output;
			carry		<= t_carry;
		end if;
	end process;
end impl;

