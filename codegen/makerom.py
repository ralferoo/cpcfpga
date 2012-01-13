#!/usr/bin/python

import sys,os

def bin(x,len):
	out = []
	while len > 0:
		out.append('01'[x & 1])
		len = len -1
		x = x >> 1
	return ''.join(reversed(out))

name=sys.argv[1]
if sys.argv[2][0] == '-':
	internal=sys.argv[2][1:]
	start=128
	f=open(sys.argv[3], "rb")

	f2=open(internal, "wb")
else:
	internal=None
	start=0
	f=open(sys.argv[2], "rb")
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

print '''-- '''+name+'''.vhd
library IEEE;
use ieee.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.std_logic_arith.all;

entity '''+name+''' is
    port(
	clk		: in  std_logic;
        addr		: in  std_logic_vector(13 downto 0);
        data		: out std_logic_vector(7 downto 0)
    );
end '''+name+''';

architecture impl of '''+name+''' is
'''

if internal <> None: print '''
	component bootrom_internal is
	    port(CLK : in std_logic;
	    	ADDR : in std_logic_vector(6 downto 0);
		DOUT : out std_logic_vector(7 downto 0)) ;
	end component;

	signal intout : std_logic_vector(7 downto 0);
'''

print '''
begin
'''

if internal <> None: print '''
	internal_0 : bootrom_internal port map (clk=>clk, addr=>addr(6 downto 0), dout=>intout);
'''

print '''
process (addr)
    begin
'''

if internal <> None: print '''
	if addr('''+str(size-1)+''' downto 7) = 0 then
		data <= intout;
	else '''

print '''	        case addr('''+str(size-1)+''' downto 0) is '''

for n in xrange(start,len(data)):
	bn = bin(n,size)
	bval = hex(data[n])[2:]
	if len(bval)<2: bval="0"+bval #bin(data[n], 8)
        print '%20swhen "%s" => data <= X"%s";'%('',bn,bval)

print '''
	            when others => data <= X"00";
        	  end case;
'''

if internal <> None: print '''
	end if;
'''

print '''
    end process;

end impl;'''

if internal <> None:
	while len(data)<128:
		data.append('\000')
	for n in xrange(0, start):
		try: v=data[n]
		except: v=0
		bn = bin(v,8)
		f2.write(bn+"\n")
	f2.close()
