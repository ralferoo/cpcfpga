-- gate_array.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity gate_array is
	port(
		nRESET				: in  std_logic;
		clk16				: in  std_logic;				-- master clock input @ 16 MHz

		-- z80 basic functionality
		z80_clk				: out std_logic;				-- generated Z80 clock @ 4 MHz (16MHz behind)
		z80_din				: out std_logic_vector(7 downto 0);		-- data bus input to z80
		z80_dout			: in  std_logic_vector(7 downto 0);		-- data bus output from z80
		z80_a				: in  std_logic_vector(15 downto 0);		-- address bus output from z80
		z80_wr_n			: in  std_logic;				-- used for gate array out

		-- generation of wait states
		z80_rd_n			: in  std_logic;				-- used in determining wait flag
		z80_m1_n			: in  std_logic;				-- used in determining wait flag
		z80_iorq_n			: in  std_logic;				-- used in determining wait flag
		z80_mreq_n			: in  std_logic;				-- used in determining wait flag
		z80_wait_n			: out std_logic;				-- determines in the CPU should be paused

		-- interrupt generation
		z80_int_n			: out std_logic;				-- interrupt acknowledge

		-- psg interface
		psg_clk				: out std_logic;				-- generated psg clock @ 1MHz

		-- crtc interface (for screen reading)
		crtc_clk			: out std_logic;				-- generated crtc clock @ 1MHz
		crtc_ma				: in  std_logic_vector(13 downto 0);		-- address generated by crtc
		crtc_ra				: in  std_logic_vector(3 downto 0);		-- address generated by crtc		
		crtc_hsync, crtc_vsync		: in  std_logic;				-- sync pulses from crtc
		crtc_de				: in  std_logic;				-- display enable from crtc
		
		-- video output
		video_sync			: out std_logic;				-- 1 when sync pulse needed
		video_red,video_green,video_blue: out std_logic_vector(1 downto 0);		-- 2 bits per colour output

		-- bootrom interface
        	bootrom_addr        		: out std_logic_vector(13 downto 0);		-- address set here
        	bootrom_data        		: in  std_logic_vector(7 downto 0);		-- data becomes available here

		-- sram interface
		sram_address			: out std_logic_vector(18 downto 0);
		sram_data			: inout std_logic_vector(7 downto 0);
		sram_we				: out std_logic;
		sram_ce				: out std_logic;				-- i might tie this low
		sram_oe				: out std_logic					-- could even tie this low
	);
end gate_array;

architecture impl of gate_array is

	-- we work on a 16 MHz input clock, but the CPC works on a 4MHz clock with 4 cycles per "period"
	-- so, we have 16 cycles per period.

	signal d_tstate				: std_logic_vector(1 downto 0);
	signal d_idle				: std_logic;
	signal d_us_count			: std_logic_vector(7 downto 0);

	type t_palette is array(0 to 16) of std_logic_vector(4 downto 0);
	
	signal	local_z80_clk			: std_logic;
	signal	video_mode			: std_logic_vector(1 downto 0);
	signal	vm_shift_add			: std_logic_vector(2 downto 0);
	signal	vm_pixel_mask			: std_logic_vector(3 downto 0);
	signal	palette				: t_palette;
	signal	upper_rom_paging_disable	: std_logic;
	signal	lower_rom_paging_disable	: std_logic;
	signal	memory_page_64k			: std_logic_vector(2 downto 0);
	signal	bank_select			: std_logic_vector(2 downto 0);
	signal	upper_rom_base			: std_logic_vector(4 downto 0);

	signal	force_interrupt_ack		: std_logic;
	signal	use_boot_rom			: std_logic;
	signal	lower_rom_writeable		: std_logic;
	signal	upper_rom_writeable		: std_logic;

	signal	rom_enabled			: std_logic_vector(7 downto 0);
begin
	process(nRESET,clk16) is

		------------------------------------------------------------------------------------------------------------
		--
		-- calculate the wait signal
		procedure calculate_wait(			iorq_n,mreq_n,m1_n	: in std_logic;
						variable	tstate			: in std_logic_vector(1 downto 0); 
						variable	idle			: inout std_logic;
						variable	wait_n			: inout std_logic) is
		begin
			wait_n	:= '1';

			if tstate="11" then							-- if we've reached T1, all signals should be normal
				idle	:= '1';							-- and we can transition back to the idle state
			end if;

			if (iorq_n='0' and m1_n='0') then					-- we're acknowledging an interrupt, T4->T2(instr)
				if tstate="00" then
					wait_n	:= '1';						-- we can proceed out Tw that's a T2
				else
					wait_n	:= '0';						-- wait until T2
				end if;
				idle	:= '0';							-- and go into busy state just in case
			elsif idle='1' and (iorq_n='0' or mreq_n='0') then			-- we're in the idle state and IO/mem requested
				if tstate="00" then
					idle	:= '0';						-- from T2 we can transition into busy state
					wait_n	:= iorq_n; --not m1_n;				-- but add a wait state unless it's instruction fetch
				else
					wait_n	:= '0';						-- not in T2, force them to wait until the next block
				end if;

			end if;
		end procedure calculate_wait;

		------------------------------------------------------------------------------------------------------------
		--
		-- calculate the sram address for a z80 address
		procedure calculate_address(			address			: in std_logic_vector(15 downto 0);
						variable	real_address		: out std_logic_vector(18 downto 0);
								rd_n			: in std_logic) is
			variable	t_disable		: std_logic;	
			variable	t_writeable		: std_logic;	
			variable	t_base			: std_logic_vector(4 downto 0);	
		begin
			-- the bootrom is a special case - if it is enabled, reads from the lower 16K will always read from there
			-- writes will always happen to the write address. so we don't really even need to worry about it here

			case address(15 downto 14) is
				when "00" =>	t_disable		:= lower_rom_paging_disable;
						t_writeable		:= lower_rom_writeable;
						t_base			:= "00111";			-- lower rom from #1c000

				when "11" =>	t_disable		:= upper_rom_paging_disable;
						t_writeable		:= upper_rom_writeable;
						t_base			:= upper_rom_base;		-- upper rom from #20000

				when others =>	t_disable		:= '1';
						t_writeable		:= '0';

			end case;

			-- default address is just plain RAM address - add RAM banking in later
			real_address := "000" & address;

			-- do upper/lower RAM mapping
			if t_disable='0' then						-- ROM is enabled
				if rd_n='0' or t_writeable='1' then			-- reading or writing to write-enabled ROM
					real_address := t_base & address(13 downto 0);
				end if;
			end if;

		end procedure calculate_address;

		------------------------------------------------------------------------------------------------------------
		--
		-- current cycle
		variable		current_cycle		: std_logic_vector(3 downto 0);	
		variable		z80_bus_is_idle		: std_logic;	

		variable		out_z80_clock		: std_logic;

		variable		out_z80_wait_n		: std_logic;
		variable		out_z80_din		: std_logic_vector(7 downto 0);

		variable		out_boot_address	: std_logic_vector(13 downto 0);
		variable		out_sram_address	: std_logic_vector(18 downto 0);
		variable		out_sram_data		: std_logic_vector(7 downto 0);
		variable		out_sram_we		: std_logic;
		variable		out_sram_ce		: std_logic;				-- i might tie this low
		variable		out_sram_oe		: std_logic;

		variable		out_video_byte_data	: std_logic_vector(7 downto 0);
		variable		out_video_shift_count	: std_logic_vector(1 downto 0);
		variable		out_video_byte_clock	: std_logic;
		variable		out_crtc_clock		: std_logic;
		variable		out_de			: std_logic;
		variable		out_hsync		: std_logic;
		variable		out_hsync_delayed	: std_logic;
		variable		out_vsync		: std_logic;

		variable		out_video_sync		: std_logic;
		variable		out_video_red		: std_logic_vector(1 downto 0);
		variable		out_video_green		: std_logic_vector(1 downto 0);
		variable		out_video_blue		: std_logic_vector(1 downto 0);

		variable		out_latch_cpu_data	: std_logic;
		variable		out_latch_boot_data	: std_logic;
		variable		out_latch_video_data	: std_logic;
		variable		out_latch_write_data	: std_logic;

		variable		out_d_us_count		: std_logic_vector(7 downto 0);

		procedure init_current_cycle is
		begin

			-- init variables
			current_cycle		:= "0100";	-- we want to make sure it's not "00", this gives us a few cycles to settle down
			z80_bus_is_idle		:= '1';
			out_z80_clock		:= '0';
			out_crtc_clock		:= '0';
			out_z80_wait_n		:= '1';
			out_z80_din		:= (others=>'0');

			out_boot_address	:= (others=>'0');
			out_sram_address	:= (others=>'0');
			out_sram_data		:= (others=>'0');
			out_sram_we		:= '1';
			out_sram_ce		:= '1';
			out_sram_oe		:= '1';

			out_video_byte_data	:= (others=>'0');
			out_video_byte_clock	:= '0';
			out_video_shift_count	:= (others=>'0');

			out_video_sync		:= '0';
			out_video_red		:= (others=>'0');
			out_video_green		:= (others=>'0');
			out_video_blue		:= (others=>'0');

			out_latch_cpu_data	:= '0';
			out_latch_boot_data	:= '0';
			out_latch_video_data	:= '0';
			out_latch_write_data	:= '0';
			out_de			:= '0';
			out_hsync		:= '0';
			out_vsync		:= '0';
			out_hsync_delayed	:= '0';

			out_d_us_count		:= (others=>'1');

		end procedure init_current_cycle;

		procedure update_video_pixel(	variable	n_out_video_byte_data	: inout std_logic_vector(7 downto 0); 
						variable	n_out_video_shift_count	: inout std_logic_vector(1 downto 0);
						variable	n_out_de		: in	std_logic;
						variable	n_out_hsync		: in	std_logic;
						variable	n_out_hsync_delayed	: in	std_logic;
						variable	n_out_vsync		: in	std_logic;
						variable	n_out_video_red		: out   std_logic_vector(1 downto 0);
						variable	n_out_video_green	: out   std_logic_vector(1 downto 0);
						variable	n_out_video_blue	: out   std_logic_vector(1 downto 0);
						variable	n_out_video_sync	: out   std_logic ) is
			variable	t_colour_index	: std_logic_vector(3 downto 0);			
			variable	t_colour_data	: std_logic_vector(4 downto 0);	
			variable	t_rgb		: std_logic_vector(5 downto 0);	
			variable	t_shift_count	: std_logic_vector(2 downto 0);	
			variable	t_shift		: std_logic;	
		begin
			-- colour index selection
			t_colour_index	:= n_out_video_byte_data(1) & n_out_video_byte_data(5) &
					   n_out_video_byte_data(3) & n_out_video_byte_data(7);

			t_colour_index	:= t_colour_index and vm_pixel_mask;

			-- move to next pixel at appropriate time
			t_shift_count			:= ('0' & n_out_video_shift_count) + vm_shift_add;
			t_shift				:= t_shift_count(2);

			if t_shift='1' then
				n_out_video_byte_data	:= n_out_video_byte_data(6 downto 0) & '0';
				n_out_video_shift_count	:= (others=>'0');
			else
				n_out_video_shift_count	:= t_shift_count(1 downto 0);
			end if;

			-- lookup colour
			if n_out_de='0' then
				t_colour_data		:= palette(16);
			else
				t_colour_data		:= palette( to_integer(ieee.numeric_std.unsigned(t_colour_index)) );
			end if;

			-- and map from that into real colours
			case t_colour_data is
				when "00000" | "00001"	=> t_rgb := "010101";	-- white
				when "00010" | "10001"	=> t_rgb := "001101";	-- sea green
				when "00011" | "01001"	=> t_rgb := "111101";	-- pastel yellow
				when "00100" | "10000"	=> t_rgb := "000001";	-- blue
				when "00101" | "01000"	=> t_rgb := "110001";	-- purple
				when "00110"		=> t_rgb := "000101";	-- cyan
				when "00111"		=> t_rgb := "110101";	-- pink
				when "01010"		=> t_rgb := "111100";	-- bright yellow
				when "01011"		=> t_rgb := "111111";	-- bright white
				when "01100"		=> t_rgb := "110000";	-- bright red
				when "01101"		=> t_rgb := "110011";	-- bright magenta
				when "01110"		=> t_rgb := "110100";	-- orange
				when "01111"		=> t_rgb := "110111";	-- pastel magenta
				when "10010"		=> t_rgb := "001100";	-- bright green
				when "10011"		=> t_rgb := "001111";	-- bright cyan
				when "10100"		=> t_rgb := "000000";	-- black
				when "10101"		=> t_rgb := "000011";	-- bright blue
				when "10110"		=> t_rgb := "000100";	-- green
				when "10111"		=> t_rgb := "000111";	-- sky blue
				when "11000"		=> t_rgb := "010001";	-- magenta
				when "11001"		=> t_rgb := "011101";	-- pastel green
				when "11010"		=> t_rgb := "011100";	-- lime
				when "11011"		=> t_rgb := "011111";	-- pastel cyan
				when "11100"		=> t_rgb := "010000";	-- red
				when "11101"		=> t_rgb := "010011";	-- mauve
				when "11110"		=> t_rgb := "010100";	-- yellow
				when others		=> t_rgb := "010111";	-- pastel blue
			end case;


			-- and from there render the pixel
			if (n_out_HSYNC or n_out_HSYNC_delayed or n_out_VSYNC)='1' then		-- ensure black level if in front/back porch
				n_out_video_red		:= "00";
				n_out_video_green	:= "00";
				n_out_video_blue	:= "00";
			else
				n_out_video_red		:= t_rgb(5 downto 4);
				n_out_video_green	:= t_rgb(3 downto 2);
				n_out_video_blue	:= t_rgb(1 downto 0);
			end if;
			n_out_video_sync		:= n_out_HSYNC_delayed or n_out_VSYNC;
		end procedure update_video_pixel;

		procedure update_current_cycle is
			variable	n_current_cycle		: std_logic_vector(3 downto 0);

			variable	n_out_z80_clock		: std_logic;
			variable	tstate			: std_logic_vector(1 downto 0);
			variable	tstate_for_video	: std_logic;
			variable	lsb_of_video_address	: std_logic;

			variable	n_z80_bus_is_idle	: std_logic;	
			variable	n_out_z80_wait_n	: std_logic;
			variable	n_out_z80_din		: std_logic_vector(7 downto 0);

			variable	n_out_boot_address	: std_logic_vector(13 downto 0);
			variable	n_out_sram_address	: std_logic_vector(18 downto 0);
			variable	n_out_sram_data		: std_logic_vector(7 downto 0);
			variable	n_out_sram_we		: std_logic;
			variable	n_out_sram_ce		: std_logic;				-- i might tie this low
			variable	n_out_sram_oe		: std_logic;

			variable	n_out_video_byte_data	: std_logic_vector(7 downto 0);
			variable	n_out_video_shift_count	: std_logic_vector(1 downto 0);
			variable	n_out_video_byte_clock	: std_logic;
			variable	n_out_crtc_clock	: std_logic;
			variable	n_out_de		: std_logic;
			variable	n_out_hsync		: std_logic;
			variable	n_out_hsync_delayed	: std_logic;
			variable	n_out_vsync		: std_logic;

			variable	n_out_video_sync	: std_logic;
			variable	n_out_video_red		: std_logic_vector(1 downto 0);
			variable	n_out_video_green	: std_logic_vector(1 downto 0);
			variable	n_out_video_blue	: std_logic_vector(1 downto 0);

			variable	n_out_read_next_cycle	: std_logic;

			variable	n_out_latch_cpu_data	: std_logic;
			variable	n_out_latch_boot_data	: std_logic;
			variable	n_out_latch_video_data	: std_logic;
			variable	n_out_latch_write_data	: std_logic;

			variable	n_out_d_us_count	: std_logic_vector(7 downto 0);
		begin

			-- update variables
			n_current_cycle		:= current_cycle + 1;
			n_z80_bus_is_idle	:= z80_bus_is_idle;
			n_out_z80_din		:= out_z80_din;
			n_out_z80_wait_n	:= out_z80_wait_n;

			n_out_boot_address	:= out_boot_address;
			n_out_sram_address	:= out_sram_address;
			n_out_sram_data		:= out_sram_data;
			n_out_sram_we		:= out_sram_we;
			n_out_sram_ce		:= out_sram_ce;
			n_out_sram_oe		:= out_sram_oe;

			n_out_video_byte_clock	:= out_video_byte_clock;
			n_out_video_byte_data	:= out_video_byte_data;
			n_out_crtc_clock	:= out_crtc_clock;
			n_out_video_shift_count	:= out_video_shift_count;
			n_out_de		:= out_de;
			n_out_hsync		:= out_hsync;
			n_out_vsync		:= out_vsync;
			n_out_hsync_delayed	:= out_hsync_delayed;

--			n_out_video_sync	:= out_video_sync;
--			n_out_video_red		:= out_video_red;
--			n_out_video_green	:= out_video_green;
--			n_out_video_blue	:= out_video_blue;

			n_out_z80_clock		:= n_current_cycle(1);
			tstate			:= n_current_cycle(3 downto 2);
			tstate_for_video	:= n_current_cycle(2);
			lsb_of_video_address	:= n_current_cycle(3);

			n_out_d_us_count	:= out_d_us_count;

			-- check the condition where we need to latch data from the sram bus for the CPU
			if out_latch_cpu_data='1' then
				n_out_z80_din		:= sram_data;
				n_out_sram_ce		:= '1';
				n_out_sram_oe		:= '1';
			end if;
			n_out_latch_cpu_data		:= '0';

			if out_latch_boot_data='1' then
				n_out_z80_din		:= bootrom_data;
			end if;
			n_out_latch_boot_data		:= '0';

			-- check the condition where we need to latch data from the sram bus for the video
			if out_latch_video_data='1' then
				n_out_video_byte_clock	:= '1';
				n_out_video_byte_data	:= sram_data;
				n_out_sram_ce		:= '1';
				n_out_sram_oe		:= '1';
				n_out_video_shift_count	:= (others=>'0');
				n_out_de		:= crtc_de;
				n_out_hsync_delayed	:= n_out_hsync;
				n_out_hsync		:= crtc_hsync;
				n_out_vsync		:= crtc_vsync;
			end if;
			n_out_latch_video_data		:= '0';

			-- check the condition where we were writing and need ot stop it
			if out_latch_write_data='1' then
				n_out_sram_ce		:= '1';
				n_out_sram_we		:= '1';
			end if;
			out_latch_write_data		:= '0';

			-- update video output
			update_video_pixel( n_out_video_byte_data, n_out_video_shift_count,
						n_out_de, n_out_hsync, n_out_vsync, n_out_hsync_delayed,
						n_out_video_red, n_out_video_green, n_out_video_blue, n_out_video_sync);

			-- handle z80 memory accesses
			if out_z80_clock='1' and n_out_z80_clock='0' then		-- falling edge means change of tstate
				-- first off, calculate the wait_n for the new tstate
				calculate_wait( iorq_n	=> z80_iorq_n, 
						mreq_n	=> z80_mreq_n,
						m1_n	=> z80_m1_n,
						tstate	=> tstate,
						idle	=> n_z80_bus_is_idle,
						wait_n 	=> n_out_z80_wait_n );

				-- handle video data transfer
				if tstate_for_video='1' then				-- start video byte transfer in T1 or T3
					n_out_sram_address	:= "000" & crtc_ma(13 downto 12) & crtc_ra(2 downto 0) & crtc_ma(9 downto 0) & lsb_of_video_address;
					n_out_sram_data		:= (others=>'Z');
					n_out_sram_we		:= '1';
					n_out_sram_ce		:= '0';
					n_out_sram_oe		:= '0';
					n_out_video_byte_clock	:= '0';
					n_out_latch_video_data	:= '1';

--					report "Starting video byte transfer at address " & integer'image(to_integer(ieee.numeric_std.unsigned(n_out_sram_address)));
				end if;

				n_out_crtc_clock		:= lsb_of_video_address;

				if tstate="00" then
					n_out_d_us_count := n_out_d_us_count + 1;			-- debug cycle counter
				end if;

				-- handle regular ram transfer only during T state 00
				if tstate="00" and z80_mreq_n='0' and n_z80_bus_is_idle='0' then	-- start a memory read/write
					calculate_address( z80_a, n_out_sram_address, z80_rd_n );

					if z80_rd_n='0' then						-- memory read
						if z80_a(15 downto 14)="00" and use_boot_rom='1' then
							n_out_latch_boot_data	:= '1';
							n_out_boot_address	:= n_out_sram_address(13 downto 0);
						else
							n_out_sram_data		:= (others=>'Z');
							n_out_sram_we		:= '1';
							n_out_sram_oe		:= '0';
							n_out_sram_ce		:= '0';
							n_out_latch_cpu_data	:= '1';
						end if;
						
--						report "Starting memory read at address " & integer'image(to_integer(ieee.numeric_std.unsigned(n_out_sram_address)));
					elsif z80_wr_n='0' then					-- memory write
						n_out_sram_data			:= z80_dout;
						n_out_sram_we			:= '0';
						n_out_sram_oe			:= '1';
						n_out_sram_ce			:= '0';
						out_latch_write_data		:= '1';

--						report "Starting memory write at address " & integer'image(to_integer(ieee.numeric_std.unsigned(n_out_sram_address))) & " value " & integer'image(to_integer(ieee.numeric_std.unsigned(z80_dout)));
--					else								-- memory write
--						report "Memory acces, neither read nor write at address " & integer'image(to_integer(ieee.numeric_std.unsigned(n_out_sram_address))) & " value " & integer'image(to_integer(ieee.numeric_std.unsigned(z80_dout)));
					end if;
					n_out_sram_ce		:= '0';
				end if;

			end if;

			-- do all the assignments together
			current_cycle		:= n_current_cycle;
			z80_bus_is_idle		:= n_z80_bus_is_idle;
			out_z80_wait_n		:= n_out_z80_wait_n;
			out_z80_din		:= n_out_z80_din;
			out_z80_clock		:= n_out_z80_clock;

			out_boot_address	:= n_out_boot_address;
			out_sram_address	:= n_out_sram_address;
			out_sram_data		:= n_out_sram_data;
			out_sram_we		:= n_out_sram_we;
			out_sram_ce		:= n_out_sram_ce;
			out_sram_oe		:= n_out_sram_oe;

			out_video_byte_clock	:= n_out_video_byte_clock;
			out_video_byte_data	:= n_out_video_byte_data;
			out_crtc_clock		:= n_out_crtc_clock;
			out_video_shift_count	:= n_out_video_shift_count;
			out_de			:= n_out_de;
			out_hsync		:= n_out_hsync;
			out_vsync		:= n_out_vsync;
			out_hsync_delayed	:= n_out_hsync_delayed;

			out_video_sync		:= n_out_video_sync;
			out_video_red		:= n_out_video_red;
			out_video_green		:= n_out_video_green;
			out_video_blue		:= n_out_video_blue;

			out_latch_cpu_data	:= n_out_latch_cpu_data;
			out_latch_boot_data	:= n_out_latch_boot_data;
			out_latch_video_data	:= n_out_latch_video_data;

			out_d_us_count		:= n_out_d_us_count;
		end procedure update_current_cycle;

		procedure update_ports_current_cycle is
		begin
			z80_wait_n		<= out_z80_wait_n;
			z80_clk			<= out_z80_clock;
			local_z80_clk		<= out_z80_clock;
			crtc_clk		<= out_crtc_clock;
			z80_din			<= out_z80_din;

			sram_address		<= out_sram_address;
			sram_data		<= out_sram_data;
			sram_we			<= out_sram_we;
			sram_ce			<= out_sram_ce;
			sram_oe			<= out_sram_oe;

			--video_data		<= out_video_byte_data;
			video_sync		<= out_video_sync;
			video_red		<= out_video_red;
			video_green		<= out_video_green;
			video_blue		<= out_video_blue;

			bootrom_addr		<= out_boot_address;

			d_tstate		<= current_cycle(3 downto 2);
			d_idle			<= z80_bus_is_idle;
			d_us_count		<= out_d_us_count;

			psg_clk			<= current_cycle(3);
		end procedure update_ports_current_cycle;

		------------------------------------------------------------------------------------------------------------
		--
		-- this just calls each of the "submodule's" code
		
		-- initialisation for registers
		procedure init_regs is
		begin
			init_current_cycle;

		end procedure init_regs;

		-- updating for registers, once per clock
		procedure update_regs is
		begin
			update_current_cycle;
		end procedure update_regs;

		-- updating for ports, once per clock or after initialisation
		procedure update_ports is
		begin
			update_ports_current_cycle;
		end procedure update_ports;

		------------------------------------------------------------------------------------------------------------
		
	-- now we've defined our procedures, the main process is fairly simple
	begin
		if nRESET='0' then
			init_regs;
		elsif rising_edge(clk16) then
			update_regs;
		end if;
		update_ports;
	end process;

	-- update mode at the end of hsync
	mode_on_hsync: process(crtc_hsync, video_mode) is
	begin
		if rising_edge(crtc_hsync) then
			case video_mode is
				when "10" =>	vm_shift_add <= "100";
				when "01" =>	vm_shift_add <= "010";
				when others =>	vm_shift_add <= "001";
			end case;

			case video_mode is
				when "10" =>	vm_pixel_mask <= "0001";
				when "00" =>	vm_pixel_mask <= "1111";
				when others =>	vm_pixel_mask <= "0011";
			end case;
		end if;
	end process;


	-- watch the gate array ports
	watch_ports: process(nRESET, local_z80_clk,z80_a,z80_wr_n,z80_iorq_n,z80_dout) is
		variable	t_force_int_ack	: std_logic;
		variable	t_upper_rom_base: std_logic_vector(4 downto 0);
	begin
		if nRESET='0' then
			video_mode			<= "01";

			upper_rom_paging_disable	<= '0';
			lower_rom_paging_disable	<= '0';
			memory_page_64k			<= "000";
			bank_select			<= "000";
			force_interrupt_ack		<= '0';
			use_boot_rom			<= '1';
			lower_rom_writeable		<= '1';
			upper_rom_writeable		<= '1';
			upper_rom_base			<= "01000";
			rom_enabled			<= (others=>'0');		-- note BASIC is always available

		elsif rising_edge(local_z80_clk) then
			t_force_int_ack			:= '0';
	
			if z80_wr_n='0' and z80_iorq_n='0' and z80_a(15 downto 14)="01" then
				case z80_dout(7 downto 6) is
					when "11"	=>	memory_page_64k			<= z80_dout(5 downto 3);
								bank_select			<= z80_dout(2 downto 0);
	
					when "10"	=>	
								if z80_dout(4)='1' then
									t_force_int_ack		:= '1';
								end if;
								upper_rom_paging_disable	<= z80_dout(3);
								lower_rom_paging_disable	<= z80_dout(2);
								video_mode			<= z80_dout(1 downto 0);
	
					when others	=>	null;
				end case;
	
				force_interrupt_ack	<= t_force_int_ack;
	
			elsif z80_wr_n='0' and z80_iorq_n='0' and z80_a(13)='0' then		-- DFxx
				t_upper_rom_base	:= "01000";					-- default to BASIC rom
	
				case z80_dout is
					when "00000001" =>	if rom_enabled(1)='1' then
									t_upper_rom_base := "01" & z80_dout(2 downto 0);
								end if;
					when "00000010" =>	if rom_enabled(2)='1' then
									t_upper_rom_base := "01" & z80_dout(2 downto 0);
								end if;
					when "00000011" =>	if rom_enabled(3)='1' then
									t_upper_rom_base := "01" & z80_dout(2 downto 0);
								end if;
					when "00000100" =>	if rom_enabled(4)='1' then
									t_upper_rom_base := "01" & z80_dout(2 downto 0);
								end if;
					when "00000101" =>	if rom_enabled(5)='1' then
									t_upper_rom_base := "01" & z80_dout(2 downto 0);
								end if;
					when "00000110" =>	if rom_enabled(6)='1' then
									t_upper_rom_base := "01" & z80_dout(2 downto 0);
								end if;
					when "00000111" =>	if rom_enabled(7)='1' then
									t_upper_rom_base := "01" & z80_dout(2 downto 0);
								end if;
					when others => null;
				end case;
				upper_rom_base		<= t_upper_rom_base;
	
			elsif z80_wr_n='0' and z80_iorq_n='0' and z80_a(15 downto 0)=x"FEFE" then
				upper_rom_writeable	<= z80_dout(7);
				lower_rom_writeable	<= z80_dout(6);
				use_boot_rom		<= z80_dout(5);
	
			elsif z80_wr_n='0' and z80_iorq_n='0' and z80_a(15 downto 0)=x"FEFD" then
				rom_enabled		<= z80_dout;

			end if;
	
		end if;
	end process;

	-- watch the gate array port for palette things
	palette_updater: process(nRESET, local_z80_clk,z80_a,z80_wr_n,z80_iorq_n,z80_dout) is
		variable	r_pal_index	: std_logic_vector(4 downto 0);
--		variable	r_palette	: t_palette;

		variable	n_pal_index	: std_logic_vector(4 downto 0);
--		variable	n_palette	: t_palette;
	begin
		if rising_edge(local_z80_clk) then
			if nRESET='0' then
				n_pal_index				:= (others=>'0');

--				for i in 0 to 16 loop
--					palette(i)            		<= "10100";
--				end loop;
				
			else
				n_pal_index				:= r_pal_index;

				if z80_wr_n='0' and z80_iorq_n='0' and z80_a(15 downto 14)="01" and z80_dout(7)='0' then
					if z80_dout(6)='1' then
						if r_pal_index(4)='1' then
							palette(16)	<= z80_dout(4 downto 0);
						else
							palette( to_integer(ieee.numeric_std.unsigned(r_pal_index)) )
									<= z80_dout(4 downto 0);
						end if;
					else
						n_pal_index		:= z80_dout(4 downto 0);
					end if;
				end if;
			end if;

			r_pal_index			:= n_pal_index;
		end if;
	end process;

	-- interrupt generation
	process(nRESET, local_z80_clk, crtc_hsync, crtc_vsync, z80_iorq_n, z80_m1_n ) is
		variable	last_hsync			: std_logic;
		variable	line_counter			: std_logic_vector(5 downto 0);
		variable	vsync_sense			: std_logic_vector(1 downto 0);
		variable	generate_interrupt		: std_logic;

		variable	n_last_hsync			: std_logic;
		variable	n_line_counter			: std_logic_vector(5 downto 0);
		variable	n_vsync_sense			: std_logic_vector(2 downto 0);
		variable	n_generate_interrupt		: std_logic;
	begin
		if nRESET='0' then
			last_hsync				:= '0';
			line_counter				:= (others=>'0');
			vsync_sense				:= (others=>'0');
			generate_interrupt			:= '0';
			z80_int_n				<= '1';
			
		elsif falling_edge(local_z80_clk) then
			-- get local copy of variables
			n_line_counter				:= line_counter;
			n_vsync_sense				:= "0" & vsync_sense;
			n_generate_interrupt			:= generate_interrupt;
			n_last_hsync				:= crtc_hsync;

			-- process hsync pulses (and reset on 2nd after vysnc)
			if n_last_hsync='1' and last_hsync='0' then					-- rising edge of hsync
				-- process hsync counter
				n_line_counter			:= n_line_counter + 1;
				if n_line_counter = "110100" then
					n_generate_interrupt	:= '1';
					n_line_counter		:= (others=>'0');
				end if;
	
				-- process vsync reset on 2nd hsync after vsync
				if crtc_vsync = '1' then
					report "vysnc";
				end if;
				n_vsync_sense			:= vsync_sense & crtc_vsync;
				if n_vsync_sense = "011" then
					if n_line_counter(5)='0' then
						n_generate_interrupt	:= '1';
					end if;
					n_line_counter		:= (others=>'0');
				end if;
			end if;

			-- process acknowledge from code
			if force_interrupt_ack='1' then
--				force_interrupt_ack		<= '0';
				n_line_counter			:= (others=>'0');

			-- process acknowledge from z80
			elsif z80_iorq_n='0' and z80_m1_n='0' then
				n_line_counter(5)		:= '0';
				n_generate_interrupt		:= '0';
--				force_interrupt_ack		<= '0';

			-- reset the int line at start of next instruction
--			elsif z80_m1_n='0' then
--				n_generate_interrupt		:= '0';
			end if;

			-- update variables
			line_counter				:= n_line_counter;
			vsync_sense				:= n_vsync_sense(1 downto 0);
			last_hsync				:= n_last_hsync;
			generate_interrupt			:= n_generate_interrupt;

			-- update the z80 interrupt signal
			z80_int_n				<= not generate_interrupt;
		end if;

	end process;

end impl;
