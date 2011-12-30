#!/usr/bin/python

import sys,os

def bin(x,len):
	out = []
	while len > 0:
		out.append('01'[x & 1])
		len = len -1
		x = x >> 1
	return ''.join(reversed(out))

f=open(sys.argv[1], "rb")
xdata=f.read(100000);
f.close()

data = [ord(c) for c in xdata]

xdata = [
	0x01,0xdc,0xfa,
	0x21,0x0f,0x80,
	0x7e,
	0xb7,
	0x28,0xf9,
	0x23,
	0xed,0x79,
	0x18,0xf7,
	]
for x in "This is a test message\r\n\000":
	xdata.append(ord(x))

#print data
#sys.exit(0)

datalen = len(data)
(size,x) = (0,datalen-1)
while x > 0:
	size = size + 1
	x = x >> 1

print '''-- testrom.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity testrom is
    port(
        addr        : std_logic_vector(13 downto 0);
        data        : out std_logic_vector(7 downto 0)
    );
end testrom;

architecture impl of testrom is

begin
process (addr)
    begin
        case addr('''+str(size-1)+''' downto 0) is '''

for n in xrange(0,len(data)):
	bn = bin(n,size)
	bval = hex(data[n])[2:]
	if len(bval)<2: bval="0"+bval #bin(data[n], 8)
        print '%12swhen "%s" => data <= X"%s";'%('',bn,bval)

print '''
            when others => data <= X"00";
          end case;
    end process;

end impl;'''

