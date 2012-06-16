all: direct.hex load.hex

clean:
	rm -f *.hex *.bin load.mcs load.svf load.svf-content
	
load.bin: load.mcs
	objcopy -I ihex $< -O binary $@

directmain.bin: direct.bin
	dd if=$< of=$@ bs=20 skip=1

direct.bin: load.svf-content
	./convert.pl <$< >$@

%.hex: %.bin
	hexdump -C $< >$@

load.mcs load.svf load.svf-content: load.tgz
	tar mxfz load.tgz
