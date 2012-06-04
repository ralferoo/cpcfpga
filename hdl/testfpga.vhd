library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity testfpga is
    Port ( 
	joy0: in std_logic_vector( 5 downto 0 );	
	joy1: in std_logic_vector( 5 downto 0 );	
	gpio: out std_logic_vector( 7 downto 0 );
	exp: out std_logic_vector( 2 downto 0 );
	hdr_mosi: out std_logic;
	hdr_miso: out std_logic;
	hdr_sel : out std_logic;
	hdr_sclk: out std_logic;
	hdr_spare: out std_logic;

	scart_csync: out std_logic;
	scart_r: out std_logic_vector(1 downto 0);
	scart_g: out std_logic_vector(1 downto 0);
	scart_b: out std_logic_vector(1 downto 0);
	
	clk16: in std_logic
);
end testfpga;

architecture impl of testfpga is

	signal accum : std_logic_vector(28 downto 0);

begin
	gpio(5 downto 0) <= joy0;
	gpio(7 downto 6) <= joy1(5 downto 4);
	hdr_mosi <= joy1(3) xor joy1(1);
	hdr_miso <= joy1(2) xor joy1(0);
	hdr_sel  <= accum(22);
	hdr_sclk <= accum(23);

	hdr_spare <= accum(21);

	process(clk16)
	begin
		if rising_edge(clk16) then
			accum <= accum + 1;
		end if;
	end process;

--	scart_csync <= accum(24);
--	scart_r <= accum(26 downto 25);
--	scart_g <= accum(27 downto 26);
--	scart_b <= accum(28 downto 27);

	-- test video
    process (clk16)
        variable hpos : std_logic_vector (9 downto 0) := "0000000000";
        variable vpos : std_logic_vector (9 downto 0) := "0000000000";
        variable local_vvalid, local_hvalid, local_hsync, local_vsync : std_logic := '0';
        variable dot : std_logic := '0';

        variable c_pixelclock, c_hsync, c_vsync, c_valid              : std_logic := '0';   -- rising edge indicates data is valid 
        variable c_red, c_green, c_blue                               : std_logic_vector(1 downto 0) := "00";    -- output data

    begin
        if rising_edge(clk16) then

		if c_valid = '1' then
			scart_r	<= c_red;
			scart_g	<= c_green;
			scart_b	<= c_blue;
		else
			scart_r	<= "00";
			scart_g	<= "00";
			scart_b	<= "00";
		end if;

		scart_csync <= (c_hsync and c_vsync);

--            valid <= c_valid;
--            hsync <= c_hsync;
--            vsync <= c_vsync;

            if (hpos = 1023) then
                hpos := "0000000000";

                if (vpos = 311) then
                    vpos := "0000000000";
                else
                    vpos := vpos + 1;
                end if;
            else
                hpos := hpos + 1;
            end if;

            if (hpos >= 736 and hpos < 800) then
                local_hsync := '0';
            else
                local_hsync := '1';
            end if;

            if (vpos >= 240 and vpos < 252) then
                local_vsync := '0';
            else
                local_vsync := '1';
            end if;

            if (hpos < 639) then
                local_hvalid := '1';
            else
                local_hvalid := '0';
            end if;

            if (vpos < 200) then
                local_vvalid := '1';
            else
                local_vvalid := '0';
            end if;

            if ( hpos(9 downto 1) < vpos(8 downto 0) ) then
                dot := '1';
            else
                dot := '0';
            end if;


            c_pixelclock := hpos(0);

            if (hpos(0) = '0') then
                c_red   := hpos(6) & (hpos(6) and hpos(5));
                c_green := dot & (dot and vpos(6));
                c_blue  := vpos(5) & (vpos(5) and vpos(4));

                c_valid := local_hvalid and local_vvalid;
                c_hsync := local_hsync;
                c_vsync := local_vsync;

--                pixelclock <= '0';
--            else
--                pixelclock <= '1';
            end if;

        end if;
    end process;

end impl;

