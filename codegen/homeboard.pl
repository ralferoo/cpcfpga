#!/usr/bin/perl

$pfx = "";

sub translate {
	my $a = $_[0];
	$a=~s/spi_clk/fl_sclk/;
	$a=~s/spi_di/fl_di/;
	$a=~s/spi_do/fl_do/;
	$a=~s/spi_flash_cs/fl_sel/;
	$a=~s/video_r2/scart_r/;
	$a=~s/video_g2/scart_g/;
	$a=~s/video_b2/scart_b/;
	$a=~s/video_sync_out/scart_csync/;
	$a=~s/video_sound_left/scart_audio_left/;
	$a=~s/video_sound_right/scart_audio_right/;
	return $a;
}

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
		fl_hold			: out  std_logic;
		fl_wp			: out  std_logic;
HEADER
	
	foreach (@defn) {
		next if /bootrom/;
		next if /clklock/;
		next if /sram_ce/;
		next if /nRESET/;
		next if /pushsw/;
		next if /dipsw/;
		next if /rxd/;
		next if /txd/;
		next if /tape_out/;
		next if /tape_motor/;
		next if /dummy/;

		my $a=$_;
#		$a=~s/clk16/clock/;
		print &translate($a);
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

	signal dummy			: std_logic;
	signal clklock			: std_logic;

	signal nRESET			: std_logic;
	signal pushsw			: std_logic_vector(3 downto 0);
	signal dipsw			: std_logic_vector(7 downto 0);

	signal rxd			: std_logic;
	signal txd			: std_logic;

	signal tape_out			: std_logic;
	signal tape_motor		: std_logic;

	signal sram_ce			: std_logic;

	-- evil hacky code for bootstrapping
	component bootrom_homeboard is port(
		clk			: in std_logic;
		addr			: in std_logic_vector(13 downto 0);
		data			: out std_logic_vector(7 downto 0)
        );
	end component;
	signal bootrom_data		: std_logic_vector(7 downto 0);
	signal bootrom_addr		: std_logic_vector(13 downto 0);
	signal bootrom_clk		: std_logic;

	begin

	-- bootstrap code
	bootrom_0 : bootrom_homeboard port map( clk=>bootrom_clk, addr=>bootrom_addr, data=>bootrom_data );

	-- PLL fake
	nRESET <= '1';
	clklock <= '1';
	pushsw <= "1111";
	dipsw <= "11111111";
	rxd <= '1';

	fl_hold <= '1';
	fl_wp <= '1';

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

		$a=$_;
		while ($a=~s/^([^,]+)(,?)//) {
			($f,$c)=($1,$2);
			my $t=&translate($f);
			print "\t\t$f => $t$c\n";
		}
	}

print <<FOOTER;
	);
end impl;
FOOTER

}

