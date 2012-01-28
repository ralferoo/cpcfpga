#!/usr/bin/perl

while (<>) {
	s/MA20-2/ACTEL_HDR/g;

# <pad name="40" x="24.13" y="1.27" drill="1.016" shape="octagon"/>

	if (/(<pad\s+name=")(\d+)("\s+x="-?\d+(\.\d+)?"\s+y=")\d+\.\d+?(".*)$/) {
		printf ("%s%d%s%f%s\n", $1,40+($2/2),$3,0.0,$5)
	}

# <rectangle x1="-24.384" y1="1.016" x2="-23.876" y2="1.524" layer="51"/>
# <rectangle x1="-19.304" y1="1.016" x2="-18.796" y2="1.524" layer="51"/>

	$y1=1.016-1.27; #2.286-2.54;
	$y2=1.524-1.27; #2.794-2.54;
	if (/(<rectangle\s+x1="-?\d+(\.\d+)?"\s+y1=")\d+\.\d+?("\s+x2="-?\d+(\.\d+)?"\s+y2=")\d+\.\d+?(".*)$/) {
		printf("%s%f%s%f%s\n", $1,$y1,$3,$y2,$5 );
	}

# shift the y in every other measurement

	if (/<rectangle.*layer="51"/ || /<wire.*layer="21/ || /<pad/ ) {

		while (s/^(.*?)(y[12]?)="(-?)(\d+(\.\d+))"//) {
			($pre,$y,$sign,$val)=($1,$2,$3,$4);
			print $pre;
			printf ("%s=\"%s%f\"",$y,$sign,1.27+$val);
#			print "___${y}___=\"___${sign}_${val}___\"";
		}
	}

	print;
}
