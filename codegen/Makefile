all: ../hdl/testrom.vhd

../hdl/jingle.vhd: jingle.py
	./jingle.py >$@

../hdl/notelookup.vhd: notes.py
	./notes.py >$@

../hdl/testrom.vhd: testrom.py testrom.bin
	./testrom.py testrom.bin >$@

%.bin: %.asm
	pasmo $< $@ $*.sym
