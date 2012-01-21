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
--	generic ( width : integer := 12 );
	port	(
		clk		: in  std_logic;
		load		: in  std_logic;
--		divisor		: in  std_logic_vector( width-1 downto 0 );
		divisor		: in  std_logic_vector;
		output		: out std_logic);
end entity;

architecture impl of clock_divider is
begin
	process(clk)
		variable	counter		: std_logic_vector(divisor'high+1 downto 0);	-- note 1 bit longer than width
		variable	t_bit0		: std_logic;				-- new bit 0 after subtract
		variable	t_carry0	: std_logic;				-- carry to subtract from bit 1
		variable	t_divisor	: std_logic_vector(divisor'high downto 0);	-- remainder of subtractand
		variable	t_rest		: std_logic_vector(divisor'high downto 0);	-- remainder of subtractand
		variable	t_restsub	: std_logic_vector(divisor'high downto 0);	-- result of subtraction

	begin
		if rising_edge(clk) then
			if load='1' then						-- reset to divisor - 2 on load
				t_divisor	:= divisor;
				t_bit0		:= t_divisor(0);			-- bit 0 untouched
				t_carry0	:= '1';					-- always carry into bit 1
				report std.standard.natural'image(t_divisor'high);
				t_rest		:= "0" & t_divisor(t_divisor'high downto 1);

			elsif counter(counter'high)='1' then				-- also on rollover (same code, wary about uninitialised)
				t_divisor	:= divisor;
				t_bit0		:= t_divisor(0);			-- bit 0 untouched
				t_carry0	:= '1';
				report std.standard.natural'image(t_divisor'high);
				t_rest		:= "0" & t_divisor(t_divisor'high downto 1);

			else								-- manually do the bit 0 carry
				t_bit0		:= not counter(0);
				t_carry0	:= not counter(0);
				t_rest		:= "0" & counter(counter'high-1 downto 1);
			end if;

			t_restsub		:= t_rest - (t_carry0);			-- do the rest of the subtraction
			counter			:= t_restsub & t_bit0;
			output			<= counter(counter'high);		-- will pulse on last clock per divisor
		end if;
	end process;
end impl;
