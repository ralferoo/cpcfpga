#!/usr/bin/perl

@b=();

while (<>) {
	$a="";
	while (s/^([0-9a-fA-F]{2})//) {
		$a=$1.$a;
	}
	push @b,$a;
	}

while ($a=pop @b) {
	printf "%s\n", $a;
}