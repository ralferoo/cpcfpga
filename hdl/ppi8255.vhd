-- ppi8255.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity ppi8255 is
	port(
		nRESET				: in  std_logic;
		clk				: in  std_logic;

		-- z80 interface
		rd_n				: in  std_logic;
		wr_n				: in  std_logic;
		cs_n				: in  std_logic;
		a				: in  std_logic_vector(1 downto 0);
		din				: in  std_logic_vector(7 downto 0);
		dout				: out std_logic_vector(7 downto 0);

		-- cpc specific ports out
		psg_databus_out			: in  std_logic_vector(7 downto 0);
		psg_databus_in			: out std_logic_vector(7 downto 0);
		psg_bdir_bc1			: out std_logic_vector(1 downto 0);
		keyboard_row			: out std_logic_vector(3 downto 0);

		cas_in				: in  std_logic;
		cas_out, cas_motor		: out std_logic;
		vsync				: in std_logic
	);
end ppi8255;

architecture impl of ppi8255 is
begin
	process(clk,nreset) -- rd_n, wr_n, nreset, cs_n, a, din)
		variable	v_psg_inout		: std_logic;
		variable	v_psg_databus_in	: std_logic_vector(7 downto 0);
		variable	v_psg_bdir_bc1		: std_logic_vector(1 downto 0);
		variable	v_keyboard_row		: std_logic_vector(3 downto 0);
		variable	v_cas_out, v_cas_motor	: std_logic;
		variable	v_dout			: std_logic_vector(7 downto 0);
	begin
		if nreset='0' then			-- note reset is different on real ppi
			v_psg_inout		:= '1';
			v_psg_databus_in	:= (others=>'0');
			v_psg_bdir_bc1		:= "00";
			v_keyboard_row		:= (others=>'0');
			v_cas_out		:= '0';
			v_cas_motor		:= '0';
			v_dout			:= (others=>'1');

		elsif rising_edge(clk) then
			-- check for port write
			if cs_n='0' and wr_n='0' then
--				v_dout			:= (others=>'1');
				case a is
					when "00"	=>	v_psg_databus_in	:= din;
	
					when "10"	=>	v_psg_bdir_bc1		:= din(7 downto 6);
								v_cas_out		:= din(5);
								v_cas_motor		:= din(4);
								v_keyboard_row		:= din(3 downto 0);
	
					when "11" 	=>
							if din(7)='1' then
								v_psg_inout		:= din(4);	-- 0=output, 1=input

								-- auto reset of ports a, b and c
								v_psg_databus_in	:= (others=>'0');
								v_psg_bdir_bc1		:= "00";
								v_keyboard_row		:= (others=>'0');
								v_cas_out		:= '0';
								v_cas_motor		:= '0';
							else
								case din(3 downto 1) is
									when "000" =>	v_keyboard_row(0) := din(0);
									when "001" =>	v_keyboard_row(1) := din(0);
									when "010" =>	v_keyboard_row(2) := din(0);
									when "011" =>	v_keyboard_row(3) := din(0);
									when "100" =>	v_cas_motor := din(0);
									when "101" =>	v_cas_out := din(0);
									when "110" =>	v_psg_bdir_bc1(0) := din(0);
									when "111" =>	v_psg_bdir_bc1(1) := din(0);
									when others =>	null;
								end case;
							end if;
	
					when others	=> null;
				end case;
			end if;

			-- check for port read
--			elsif cs_n='0' and rd_n='0' then
				v_dout			:= (others=>'1');
				case a is
					when "00"	=>	if v_psg_inout='0' then
									v_dout		:= v_psg_databus_in;	-- output mode, read our copy
								else
									v_dout		:= psg_databus_out;	-- input mode, read live
								end if;
					when "01"	=>	v_dout(7)		:= cas_in;
	--							v_dout(6)		:= '1';			-- printer not ready
	--							v_dout(5)		:= '1';			-- exp_n
	--							v_dout(4)		:= '1';			-- 1=50hz, 0=60hz
								v_dout(3 downto 1)	:= (others=>'1');	-- distributor = amstrad
								v_dout(0)		:= vsync;
					when "10"	=>	v_dout(7 downto 6)	:= v_psg_bdir_bc1;
								v_dout(5)		:= v_cas_out;
								v_dout(4)		:= v_cas_motor;
								v_dout(3 downto 0)	:= v_keyboard_row;
	
					when others	=> null;
	
				end case;
--			end if;
		end if;

		-- output ports
		psg_databus_in			<= v_psg_databus_in;	-- output mode, so send our data
		psg_bdir_bc1			<= v_psg_bdir_bc1;
		keyboard_row			<= v_keyboard_row;
		cas_out				<= v_cas_out;
		cas_motor			<= v_cas_motor;
		dout				<= v_dout;
	end process;
end impl;

