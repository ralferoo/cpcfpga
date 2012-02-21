#!/usr/bin/perl

$base=0;

while (<>) {
	s/#.*$//;
	if (m/^\s*([^:\s]+)\s+(\d+)\s*$/) {
		($n,$l)=($1,$2);
		printf("%-64s equ %5d\n", $n, $base);
		$base += $l;
	}
}

