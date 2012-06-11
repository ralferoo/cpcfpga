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

while len(data)<2048:
	data.append(0)

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
library UNISIM;
use UNISIM.VComponents.all;

entity '''+name+''' is
    port(
	clk		: in  std_logic;
        addr		: in  std_logic_vector(13 downto 0);
        data		: out std_logic_vector(7 downto 0)
    );
end '''+name+''';

architecture impl of '''+name+''' is


	component RAMB16_S9 
-- pragma translate_off
--  generic (
-- "Read during Write" attribute for functional simulation
--	WRITE_MODE : string := "READ_FIRST" ; -- WRITE_FIRST(default)/ READ_FIRST/ NO_CHANGE
-- RAM initialization ("0" by default) for functional simulation: see example
--	);
-- pragma translate_on
		generic (
'''

for i in xrange(0,2048):
	if (i & 31) == 0:
		if i <> 0:	str='\t\t;'
		else:		str='\t\t '
		bval = hex(i/32)[2:].upper()
		if len(bval)<2: bval="0"+bval
		str = str + 'INIT_'+bval+' : bit_vector(255 downto 0) := X"'
		str2 = ""
	bval = hex(data[i])[2:].upper()
	if len(bval)<2: bval="0"+bval
	str2 = bval + str2
	if (i & 31) == 31:
		str = str + str2 + '"'
		print str
print '''
		);
		port (
			DI     : in std_logic_vector (7 downto 0);
			DIP    : in std_logic_vector (0 downto 0);
			ADDR   : in std_logic_vector (10 downto 0);
			EN     : in std_logic;
			WE     : in std_logic;
			SSR    : in std_logic;
			CLK    : in std_logic;
			DO     : out std_logic_vector (7 downto 0);
			DOP    : out std_logic_vector (0 downto 0)
		); 
	end component;

	signal dout	: std_logic_vector(7 downto 0);
	signal doutp	: std_logic_vector(0 downto 0);

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

	bootrom_u0 : RAMB16_S9 
		generic map (
'''

for i in xrange(0,2048):
	if (i & 31) == 0:
		if i <> 0:	str='\t\t,'
		else:		str='\t\t '
		bval = hex(i/32)[2:].upper()
		if len(bval)<2: bval="0"+bval
		str = str + 'INIT_'+bval+' => X"'
		str2 = ""
	bval = hex(data[i])[2:].upper()
	if len(bval)<2: bval="0"+bval
	str2 = bval + str2
	if (i & 31) == 31:
		str = str + str2 + '"'
		print str
print '''
		)
		port map (
		DI => (others=>'0'), DIP => "0",
		ADDR => addr(10 downto 0), EN => '1', WE => '0', SSR => '1',
		CLK => clk, DO => dout, DOP => doutp);

	data <= dout when addr(13)='1' else (others=>doutp(0));
'''

if internal <> None: print '''
	internal_0 : bootrom_internal port map (clk=>clk, addr=>addr(6 downto 0), dout=>intout);
'''

#print '''
#process (addr)
#    begin
#'''
#
#if internal <> None: print '''
#	if addr('''+str(size-1)+''' downto 7) = 0 then
#		data <= intout;
#	else '''
#
#print '''	        case addr('''+str(size-1)+''' downto 0) is '''
#
#for n in xrange(start,len(data)):
#	bn = bin(n,size)
#	bval = hex(data[n])[2:]
#	if len(bval)<2: bval="0"+bval #bin(data[n], 8)
#        print '%20swhen "%s" => data <= X"%s";'%('',bn,bval)
#
#print '''
#	            when others => data <= X"00";
#        	  end case;
#'''
#
#if internal <> None: print '''
#	end if;
#'''
#
#print '''
#    end process;
#'''

print '''
end impl;'''

#if internal <> None:
#	while len(data)<128:
#		data.append('\000')
#	for n in xrange(0, start):
#		try: v=data[n]
#		except: v=0
#		bn = bin(v,8)
#		f2.write(bn+"\n")
#	f2.close()
