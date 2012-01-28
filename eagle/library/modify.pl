#!/usr/bin/perl

while (<>) {
	s/MA20-2/ACTEL_HDR/g;

# <pad name="40" x="24.13" y="1.27" drill="1.016" shape="octagon"/>

	if (m|</package>|) {
		for( $i=41;$i<=60;$i++) {
			$x=-1.27+($i-50)*2.54;
			print "<pad name=\"$i\" x=\"$x\" y=\"0.00\" drill=\"1.016\" shape=\"octagon\"/>\n";
			if ($i>41) {
				$x=-1.27+($i-50)*2.54;
				$xx=-1.27+($i-51)*2.54;
				print "<wire x1=\"$x\" y1=\"0.00\" x2=\"$xx\" y2=\"0.00\" width=\"0.1524\" layer=\"16\"/>\n";
			}
		}
	}

#	if (/(<pad\s+name=")(\d+)("\s+x="-?\d+(\.\d+)?"\s+y=")\d+\.\d+?(".*)$/) {
#		printf ("%s%d%s%f%s\n", $1,40+($2/2),$3,0.0,$5)
#	}

# <rectangle x1="-24.384" y1="1.016" x2="-23.876" y2="1.524" layer="51"/>
# <rectangle x1="-19.304" y1="1.016" x2="-18.796" y2="1.524" layer="51"/>

	$y1=1.016-1.27; #2.286-2.54;
	$y2=1.524-1.27; #2.794-2.54;
	if (/(<rectangle\s+x1="-?\d+(\.\d+)?"\s+y1=")\d+\.\d+?("\s+x2="-?\d+(\.\d+)?"\s+y2=")\d+\.\d+?(".*)$/) {
		printf("%s%f%s%f%s\n", $1,$y1,$3,$y2,$5 );
	}

# add extra ground pin

	$ygnd=-25.4-2.54;
	if (m|</symbol>|) {
		print "<wire x1=\"1.27\" y1=\"${ygnd}\" x2=\"2.54\" y2=\"${ygnd}\" width=\"0.6096\" layer=\"94\"/>\n";
		print "<pin name=\"41\" x=\"7.62\" y=\"${ygnd}\" visible=\"pad\" length=\"middle\" direction=\"pas\" swaplevel=\"1\" rot=\"R180\"/>\n";
	}

	if (m|</connects>|) {
		for( $i=41;$i<=41;$i++) {
			print "<connect gate=\"G\$1\" pin=\"41\" pad=\"41\"/>\n";
		}
	}

# shift the y in every other measurement

	if (/<rectangle.*layer="51"/ || /<wire.*layer="21/ || /<pad/ || /<text/ || /<wire.*width="0.4064"/ ) {

		while (s/^(.*?)(y[12]?)="(-?)(\d+(\.\d+))"//) {
			($pre,$y,$sign,$val)=($1,$2,$3,$4);
			print $pre;
			printf ("%s=\"%s%f\"",$y,$sign,1.27+$val);
#			print "___${y}___=\"___${sign}_${val}___\"";
		}
	}

	print;
}
