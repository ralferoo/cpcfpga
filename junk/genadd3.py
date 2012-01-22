#!/usr/bin/python

def bin(x,len):
	out = []
	while len > 0:
		out.append('01'[x & 1])
		len = len -1
		x = x >> 1
	return ''.join(reversed(out))

for carry in xrange(0,4):
	for a in xrange(0,2):
		for b in xrange(0,2):
			for c in xrange(0,2):
				r = carry + a + b + c
				inp=bin(carry,2)+bin(a,1)+bin(b,1)+bin(c,1)
				out=bin(r,3)

				print '%40swhen "%s" => t_carry:="%s"; n_output(i):=\'%s\';'%("",inp,out[0:2],out[2])
	

