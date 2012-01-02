#!/usr/bin/perl

$pfx = "";

@pins=();
while (<>) {
#	s/\r(\n)$/$1/;
	s/#.*$//;
	s/^\s+//;

	$_=$pfx.$_;
	$pfx="";
	if( s/\\\s*(\n)$// ) {
		$pfx=$_;
		next;
	}
	next if /^$/;

	if (m/^SET_IO\s+([\{]?)([^\}\s]+)([\}]?)(\s+.*)$/i) {
		($name, $_)=($2,$4);

		$dir="UNKNOWN";
		if (s/\s-DIRECTION\s+input//i) {
			$dir="in";
		} elsif (s/\s-DIRECTION\s+output//i) {
			$dir="out";
		} elsif (s/\s-DIRECTION\s+([^\s]+)//i) {
			$dir=$1;
		} else {
			print "ERROR IO: $name dir: $dir rest: $_\n";
			next;
		}

		$pin="UNKNOWN";
		if (s/\s-PINNAME\s+([^\s]+)//i) {
			$pin=$1;
		} else {
			print "ERROR IO: $name dir: $dir pin: $pin rest: $_\n";
			next;
		}

		my @row=($name,$dir,$pin,$_);
		push @pins,\@row;
	} else {
		print "ERROR: $_";
	}
}

print <<EOF;
library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity cpc is
	port(
EOF

foreach (@pins) {
	($name,$dir,$pin,$rest) = @{$_};
	print "io: $name dir: $dir pin: $pin rest: $rest\n";
#		"clock			: in  std_logic;"
}

print <<EOF;
	);
end cpc;
EOF


%logic={};
%vector={};
%vectormax={};
foreach (@pins) {
	($name,$dir,$pin,$rest) = @{$_};
	print "io: $name dir: $dir pin: $pin rest: $rest\n";
	if ($name=~m/^([^[]+)\[(\d+)\]$/) {
		$vector{$name}=$1;
		$vectormax{$name}=$2;
	} else {
		$logic{$name}=$dir;
	}
}

for (keys %logic) {
	($name,$dir)=($_,$logic{$_});
	print "logic: $name,$dir\n";
}
