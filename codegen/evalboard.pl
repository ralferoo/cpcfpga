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

entity evalboard is
	port(
HEADER
	
	foreach (@defn) {
		my $a=$_;
		$a=~s/clk16/clock/;
		print $a;
	}

	print <<HEADER;
	);
end evalboard;

architecture impl of evalboard is
	-- PLL
	component PLL16mhz is port(POWERDOWN, CLKA : in std_logic; LOCK, GLA : out std_logic);
	end component;

	component cpc is port (
HEADER

	foreach (@defn) {
		print;
	}

print <<MIDDLE;
	);
end component;

	signal clklock : std_logic;
	signal clk16   : std_logic;

	begin
	-- generate the master clock
	PLL_clock_clk16 : PLL16mhz port map ( CLKA => clock, POWERDOWN => '1', GLA => clk16, LOCK => clklock );

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
