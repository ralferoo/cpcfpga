-- cpc emulator
--
-- sram support

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity memory_mux is port(
	nrst			: in  std_logic;

    MREQ_n		: in std_logic;
	IORQ_n		: in std_logic;
	RD_n		: in std_logic;
	WR_n		: in std_logic;
	A			: in std_logic_vector(15 downto 0);
	DI			: out std_logic_vector(7 downto 0);                     -- these are named as per CPU view
	DO			: in std_logic_vector(7 downto 0);                      -- these are named as per CPU view

	sram_address: out std_logic_vector(18 downto 0);
	sram_data	: inout std_logic_vector(7 downto 0);
	sram_we		: out std_logic;
	sram_ce		: out std_logic;	                                    -- i might tie this low
	sram_oe		: out std_logic;                                        -- could even tie this low

	clk			: in std_logic);
end memory_mux;


architecture impl of memory_mux is

    signal upper_rom_dis, lower_rom_dis     : std_logic;
    signal ram_00, ram_01, ram_10, ram_11   : std_logic_vector(2 downto 0);

    component testrom is
        port(
    	    addr        : std_logic_vector(13 downto 0);
            data        : out std_logic_vector(7 downto 0)
        );
    end component;
    signal testrom_data : std_logic_vector(7 downto 0);

begin
    -- ce always enabled in this implementation
    sram_ce <= '0';

    -- fake ROM space
    memory_testrom : testrom port map( addr=>A(13 downto 0), data=>testrom_data );

    -- rom selection
    process(nrst,IORQ_n,WR_n,A,DO)
    begin
        -- state on reset
        if nrst='0' then
            upper_rom_dis       <= '0';
            lower_rom_dis       <= '0';
            ram_00              <= "000";
            ram_01              <= "001";
            ram_10              <= "010";
            ram_11              <= "011";

        -- gate array rom enable bits
        elsif IORQ_n = '0' and WR_n = '0' and A(15 downto 14)="01" and DO(7 downto 6)="10" then
            upper_rom_dis       <= DO(3);
            lower_rom_dis       <= DO(2);

        -- gate array ram bank switch bits
        elsif IORQ_n = '0' and WR_n = '0' and A(15 downto 14)="01" and DO(7 downto 6)="11" then
            case DO(2 downto 0) is
                when "010"               => ram_00 <= "100"; 
                                            ram_10 <= "110"; 

                when others              => ram_00 <= "000"; 
                                            ram_10 <= "100"; 
            end case;

            if DO(2)='0' and DO(0)='0' then
                                            ram_01 <= DO(1)&"01";
            else
                                            ram_01 <= DO(2 downto 0);
            end if;
--            case DO(2 downto 0) is
--                when "000"               => ram_01 <= "001"; 
--                when "010"               => ram_01 <= "101"; 
--                when others              => ram_01 <= DO(2 downto 0);
--            end case;
            if DO(2)='0' and (DO(1)='1' or DO(0)='1') then
                                            ram_11 <= "111";
            else
                                            ram_11 <= "111";
            end if;                                          
--            case DO(2 downto 0) is
--                when "001", "010", "011" => ram_11 <= "111";
--                when others              => ram_11 <= "011";
--            end case;

        end if;
    end process;

    -- normal ram access
    process(nrst,clk,MREQ_n,RD_n,WR_n,ram_00,ram_01,ram_10,ram_11)
    begin
        if nrst = '0' then
        	sram_we <= '1';
        	sram_oe <= '1';
		DI <= (others=>'0');
		sram_address <= (others=>'0');
        	sram_data <= (others=>'Z');

        elsif rising_edge(clk) then
	   DI <= (others=>'0');
           if MREQ_n='0' then
		    DI <= (others=>'0');
	            case A(15 downto 14) is
        	        when "00"               => sram_address(16 downto 14) <= ram_00;
	                when "01"               => sram_address(16 downto 14) <= ram_01;
        	        when "10"               => sram_address(16 downto 14) <= ram_10;
                	when "11"               => sram_address(16 downto 14) <= ram_11;
	            end case;
        	    sram_address(13 downto 0) <= A(13 downto 0);
	            sram_address(18 downto 16) <= (others=>'0');

        	    if RD_n='0' then
            		sram_we <= '1';
	            	sram_oe <= '0';
        	        sram_data <= (others=>'Z');

	                if A(15 downto 14)="00" then
        	           DI <= testrom_data;
                	else
	                    DI <= sram_data;
        	        end if;

	            elsif WR_n='0' then
        	    	sram_we <= '0';
            		sram_oe <= '1';
	                sram_data <= DO;

        	    else
            		sram_we <= '1';
	            	sram_oe <= '1';
        	        sram_data <= (others=>'Z');

	            end if;
        	else
		    DI <= (others=>'0');
        		sram_we <= '1';
        		sram_oe <= '1';
	            sram_data <= (others=>'Z');
        	end if;
       end if;
    end process;

end impl;

