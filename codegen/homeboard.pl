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

entity homeboard is
	port(
HEADER
	
	foreach (@defn) {
		next if /bootrom/;
		next if /clklock/;
		my $a=$_;
#		$a=~s/clk16/clock/;
		print $a;
	}

	print <<HEADER;
	);
end homeboard;

architecture impl of homeboard is
	component cpc is port (
HEADER

	foreach (@defn) {
		print;
	}

print <<MIDDLE;
	);
end component;

	signal clklock : std_logic;
--	signal clk16   : std_logic;

	-- evil hacky code for bootstrapping
	component bootrom is port(
		clk				: in std_logic;
		addr				: in std_logic_vector(13 downto 0);
		data				: out std_logic_vector(7 downto 0)
        );
	end component;
	signal bootrom_data : std_logic_vector(7 downto 0);
	signal bootrom_addr : std_logic_vector(13 downto 0);
	signal bootrom_clk  : std_logic;

	begin

	-- bootstrap code
	bootrom_0 : bootrom port map( clk=>bootrom_clk, addr=>bootrom_addr, data=>bootrom_data );

	-- PLL fake
	clklock <= '1';

	-- CPC core
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
end impl;
FOOTER

}

