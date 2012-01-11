#!/usr/bin/perl

$pfx = "";

@defn=();
$mode=-1;
while (<>) {
	s/\s*--.*$//;
	#s/^\s+//;

	next if /^$/;

	#print "$mode$_";
	if ($mode==-1 && s/entity\s+cpc\s+is//) {
		$mode=0;
	}
	#print "$mode$_";
	if ($mode==0 && s/(.*)port\s*\(\s*//) {
		$mode=1;
	}
	#print "$mode$_";
	if ($mode==1) {
		if (s/end\s+cpc\s*;.*//) {
			$mode=2;
		}

		$txt=$_;
		$txt=~s/\([^)]*\)//;

		if ($txt=~/\)/) {
			$mode=3;
			next;
		}

		push @defn,$_ unless /^\s*$/;
		#print "[$_]";
	}
}
if ($mode==3) {
	print <<HEADER;
-- cpc.vhd
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use IEEE.numeric_std.all;

entity bench_cpc is
-- empty
end bench_cpc;

architecture impl of bench_cpc is

	-- PLL
	constant SYSCLK_PERIOD : time := 62.5 ns;

	-- fake memory
	type memory is array(0 to 255) of std_logic_vector(7 downto 0);
	
	component cpc is port (
HEADER

	foreach (@defn) {
		print;
	}

print <<MIDDLE;
	);
	end component;

MIDDLE
	foreach (@defn) {
		my $a=$_;
		$a=~s/:\s*([a-zA-Z]+)\s+/: /;
		$a=~s/;//;
		$a=~s/$/ := '0'/ if /clk16/;
		$a=~s/$/;/;
		print "\tsignal $a";
	}

	print <<MIDDLE;

	-- evil hacky code for bootstrapping
	component bench_cpc_bootrom is port(
		addr				: in std_logic_vector(13 downto 0);
		data				: out std_logic_vector(7 downto 0)
        );
	end component;

	begin

	-- fake PLL
	clk16 <= not clk16 after (SYSCLK_PERIOD / 2.0 );

	process
		variable vhdl_initial : BOOLEAN := TRUE;
	begin
		if ( vhdl_initial ) then
			-- Assert Reset
			nRESET <= '0';
			wait for ( SYSCLK_PERIOD * 10 );
            
			nRESET <= '1';
			wait;
		end if;
	end process;



	-- bootstrap code
	bootrom_0 : bench_cpc_bootrom port map( addr=>bootrom_addr, data=>bootrom_data );

	cpc_0: cpc port map (
MIDDLE

	foreach (@defn) {
		#print "--$_";

		s/\([^)]*\)//;
		break if /\)/;

		s/\s+:[^;]+//;
		s/;/,/;
		s/^\s*//;
		s/\s*$//;

		while (s/^([^,]+)(,?)//) {
			print "\t\t$1 => $1$2\n";
		}
	}

print <<FOOTER;
	);

	-- some fake SRAM
	process(nRESET,sram_oe,sram_we,sram_address,sram_data)
		variable fake_sram	:	memory;
		variable init_seed	:	std_logic_vector(7 downto 0);
	begin
		if nRESET='0' then
			init_seed	:= (others=>'0');

			for i in 255 downto 0 loop
				fake_sram(i) := init_seed;
				init_seed    := init_seed + i;		-- squares mod 256 should be randomish
			end loop;
		end if;

		if rising_edge(sram_we) then
			fake_sram(to_integer(ieee.numeric_std.unsigned(sram_address(7 downto 0)))) := sram_data;
		end if;

		if sram_oe='1' then
			sram_data <= (others=>'Z');
		else
			sram_data <= fake_sram(to_integer(ieee.numeric_std.unsigned(sram_address(7 downto 0))));
		end if;
	end process;

	-- inputs from board
	rxd			<= '1';
	dipsw			<= (others=>'0');	
	pushsw			<= (others=>'0');

	-- test bed
	process(clk16,nRESET)
	begin
		if nRESET = '0' then
		elsif rising_edge(clk16) then
		end if;
	end process;
	
end impl;
FOOTER

}

