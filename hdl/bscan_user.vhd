library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bscan_user is
	port (
		inst		: out std_logic_vector(7 downto 0);		-- outputs the instruction code
		inst_strobe	: out std_logic;				-- asserted when instruction updated
		inst_width	: in  std_logic_vector(1 downto 0);		-- application decodes to data width

		data_out	: out std_logic_vector(31 downto 0);		-- outputs the data code
		data_strobe	: out std_logic;				-- asserted when data updated
		data_in		: in  std_logic_vector(31 downto 0)		-- data in
	);
end bscan_user;

architecture impl of bscan_user is
	component BSCAN_SPARTAN3 port (
		CAPTURE : out std_ulogic;
		DRCK1   : out std_ulogic;
		DRCK2   : out std_ulogic;
		RESET   : out std_ulogic;
		SEL1    : out std_ulogic;
		SEL2    : out std_ulogic;
		SHIFT   : out std_ulogic;
		TDI     : out std_ulogic;
		UPDATE  : out std_ulogic;
		TDO1    : in  std_ulogic;
		TDO2    : in  std_ulogic);
	end component;

	signal jt_shift, jt_tck, jt_update, jt_tdi, jt_tdo1, jt_tdo2, jt_drck1, jt_drck2,
		jt_capture, jt_tck2, jt_sel1, jt_sel2, jt_reset, jt1, jt2, jt3 : std_ulogic := '0';

	signal r_inst_strobe	: std_logic;
	signal r_data_strobe	: std_logic;

	signal r_inst 		: std_logic_vector(7 downto 0);
	signal r_inst_width	: std_logic_vector(1 downto 0);

	signal r_data_in 	: std_logic_vector(31 downto 0);
	signal r_data_out	: std_logic_vector(31 downto 0);

	signal bsr_inst 	: std_logic_vector(7 downto 0);
	signal bsr_data 	: std_logic_vector(31 downto 0);

begin
	-- copy the instructions signals
	inst		<= r_inst;
	inst_strobe	<= r_inst_strobe;
	r_inst_width	<= inst_width;

	-- copy the data signals
	data_out	<= r_data_out;
	data_strobe	<= r_data_strobe;
	r_data_in	<= data_in;

	-- the jtag component
	BSCAN_SPARTAN3_1 : BSCAN_SPARTAN3 port map (
		CAPTURE => jt_CAPTURE,
		DRCK1   => jt_DRCK1,
		DRCK2   => jt_DRCK2,
		RESET   => jt_RESET,
		SEL1    => jt_SEL1,
		SEL2    => jt_SEL2,
		SHIFT   => jt_SHIFT,
		TDI     => jt_TDI,
		UPDATE  => jt_UPDATE,
		TDO1    => jt_TDO1,
		TDO2    => jt_TDO2);

	-- process data shifted out through USER1
	process_inst : process (jt_drck1, jt_reset)
	begin
		if jt_reset = '1' then
			bsr_inst <= (others=>'0'); 
		elsif jt_drck1'event and jt_drck1='1' then
			if jt_shift='0' then
				bsr_inst <= r_inst;
			else
				bsr_inst <= jt_tdi & bsr_inst(7 downto 1);
			end if;
		end if;
	end process;
	jt_tdo1 <= bsr_inst(0);

	-- process data received through USER1 or USER2
	process_update : process (jt_reset, jt_update)
	begin
		if jt_reset = '1' then
			r_inst <= (others=>'0'); 
			r_data_out <= (others=>'0'); 
		elsif jt_update'event and jt_update='1' then
			if jt_sel1='1' then
				r_inst <= bsr_inst;
			elsif jt_sel2='1' then
				r_data_out <= bsr_data;
			end if;
		end if;
	end process;
	r_inst_strobe <= jt_update and jt_sel1;
	r_data_strobe <= jt_update and jt_sel2;

	-- process data shifted out through USER2
	process_data : process (jt_drck2, jt_reset)
	begin
		if jt_reset = '1' then
			bsr_data <= (others=>'0'); 
		elsif jt_drck2'event and jt_drck2='1' then
			if jt_shift='0' then
				if inst_width="00" then
					bsr_data <= (others=>'0');
				else
					bsr_data <= data_in;
				end if;
			else
				bsr_data <= jt_tdi & bsr_data(31 downto 1);

				-- truncate the shift register
				if inst_width="00" then			-- 00 = 0 bit (bypass register)
					bsr_data(0) <= jt_tdi;
				elsif inst_width="01" then		-- 01 = 8 bit (byte)
					bsr_data(7) <= jt_tdi;
				elsif inst_width="10" then		-- 10 = 16 bit (word)
					bsr_data(15) <= jt_tdi;
				end if;					-- 11 = 32 bit (dword)
				
			end if;
		end if;
	end process;
	jt_tdo2 <= bsr_data(0);

end impl;


