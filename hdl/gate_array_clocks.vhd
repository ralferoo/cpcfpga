-- gate_array.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

-- calculate the wait signal
entity gate_array_clocks is
port(
	clk_32mhz		: in  std_logic;
	iorq_n,mreq_n,m1_n	: in  std_logic;
	tstate			: in  std_logic_vector(1 downto 0); 
	clocks_out		: out std_logic_vector(15 downto 0);
	wait_n_out		: out std_logic;
	z80_clk_out		: out std_logic);
end gate_array_clocks;

-- 	description	SRAM		FLASH			BOOT
-- 0	tstate="00"	access cycle	(-1) A23-A20		A12-A0
-- 1			WE=1		( 0) A19-A16
-- 2	video_read			( 1) A15-A12
-- 3					( 2) A11-A8
-- 5					( 3) A7 -A4
-- 5					( 4) A3 -A0
-- 6					( 5) M7 -M4
-- 7					( 6) M3 -M0
-- 8					( 7) 	
-- 9					( 8) set hi-Z
-- 10	video_read			( 9)
-- 11					(10) D7-D4		D7-D0
-- 12					(11) D3-D0
-- 13	tstate="01"			(12)
-- 14	tstate="10"			(13) CS high
-- 15	tstate="11"	OE=1		(14) CS low	


architecture impl of gate_array_clocks is
begin
	process(clk_32mhz, iorq_n, mreq_n, m1_n, tstate)
		variable	clock_16mhz	: std_logic			:= '0';
		variable	clock_sr	: std_logic_vector(15 downto 0)	:= "1000000000000000";
		variable	idle		: std_logic			:= '1';
		variable	m1_n_on_t2	: std_logic			:= '0';

		variable	idle_n		: std_logic;
		variable	wait_n		: std_logic;
	begin
		if rising_edge(clk_32mhz) then
			clock_16mhz	:= not clock_16mhz;
			if clock_16mhz = '0' then
				clock_sr	:= clock_sr(14 downto 0) & clock_sr(15); -- shift clock pulse along

				wait_n		:= '1';					-- never wait unless iorq/mreq 

				if iorq_n='0' or mreq_n='0' then			-- if iorq or mreq, 
					wait_n		:= '0';				-- assume we need to wait
	
					if clock_sr(0)='1' and mreq_n='0' then
						wait_n	:= '1';				-- memory request, it's fine
						idle	:= '0';				-- move out of idle mode
	
					elsif clock_sr(0)='1' and iorq_n='0' and idle='0' then
						wait_n	:= '1';				-- iorq, already started
	
					elsif clock_sr(15)='1' and iorq_n='0' then
						wait_n	:= '0'; 			-- iorq, need extra cycle here
						idle	:= not m1_n;
	
					elsif clock_sr(13)='1' and idle='0' then
						wait_n	:= '1';				-- already started, it's fine
	
					elsif clock_sr(14)='1' and idle='0' and mreq_n='0' and m1_n_on_t2='0' then
						wait_n	:= '1';				-- legitimate refresh cycle
											-- after IF/INTACK
	
					elsif clock_sr(0)='1' and iorq_n='0' and m1_n='0' then
						wait_n	:= '1';				-- correct ioreq ack
	
					end if;
				end if;
	
				if clock_sr(0)='1' then
					m1_n_on_t2	:= m1_n;
				end if;
	
				if clock_sr(14)='1' then				-- for IF/INTACK, extend into
					idle		:= m1_n_on_t2;			-- 3rd cycle
				
				elsif clock_sr(15)='1' then				-- set idle, unless we have 
					idle		:= iorq_n or not m1_n;		-- an io request
	
				end if;
			end if;

			-- set the outputs
			clocks_out	<= clock_sr;
			z80_clk_out	<= clock_16mhz and (clock_sr( 0) or clock_sr(13) or
							    clock_sr(14) or clock_sr(15));
			wait_n_out	<= wait_n;

		end if;
	end process;
end impl;
