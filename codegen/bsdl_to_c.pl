#!/usr/bin/perl

$m=0;
while(<>) {
	s/--.*$//;
	if (s/^.*attribute\s+BOUNDARY_REGISTER\s+of\s+([^\s]+)\s*:\s*entity\s+is//) {
		$name=$1;
		$m=1;
		printf("struct BoundaryScan %s_BSCAN[] = {\n", $name);
	}

	if ($m==1) {
		if (/"\s*(\d+)\s*\(([^,\s]+)\s*,\s*([^,\s]+)\s*,\s*([^,\s]+)\s*,\s*([^,\s]+)\s*(,\s*([^,\s]+)\s*,\s*([^,\s]+)\s*,\s*([^,\s]+)\s*)?(.*)\)(,)?"/) { #\s*(,.*\s*)?"/) {
			($pos,$type,$pin,$ctype,$safe,$ctrl,$disctrl,$disval,$comma)=($1,$2,$3,$4,$5,$7,$8,$9,$11);

			$pin=~s/^(.*)$/"$1"/;
			$pin=~s/^"\*"$/0/;

			$ctype=~tr/[a-z]/[A-Z]/;
			$safe=~s/X/1/;

			$ctrl=~s/^$/-1/;
			$disctrl=~s/^$/-1/;
			$disval=~s/^$/-1/;
			$disval=~s/Z/-1/;

			printf("\t{%3d, %-4s, %-15s, %-8s, %2d, %3d, %2d, %2d },\n", $pos, $type, $pin, $ctype, $safe, $ctrl, $disctrl, $disval );

			unless ($comma=~/,/) {
				printf("\t{%3d, %-4s, %-15s, %-8s, %2d, %3d, %2d, %2d }\n};\n", -1, -1, 0, -1, 1, -1, -1, -1 );
	
				$m=2;
				s/^.*;//;
			}
		}
	}
}
