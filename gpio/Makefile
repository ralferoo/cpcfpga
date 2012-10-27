#VERSION=rpi_pins
VERSION=libusb

LIBS=-lusb

TARGETS=scan prom_dump prom_erase prom_program prom_reload bsr pintest sramtest flashtest
LIBOBJS=jtag.o hex.o jtag.o prom.o pinhelpers.o $(VERSION).o
EXOBJS=$(patsubst %,%.o,$(TARGETS))

all: $(TARGETS)

clean:
	rm -f *.o $(TARGETS)

edit:
	gvim -p *.[ch]&

run: scan prom_dump
	./scan
	./prom_dump

$(LIBOBJS): $(wildcard *.h)

$(EXOBJS): $(wildcard *.h)

pinhelpers.o: xc3s400_tq144_1532.h xcf02s_vo20.h

%.h: ../docs/%.bsd ../codegen/bsdl_to_c.pl
	../codegen/bsdl_to_c.pl <$< >$@

bsr: bsr.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

flashtest: flashtest.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

sramtest: sramtest.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

pintest: pintest.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

scan: scan.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

prom_dump: prom_dump.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

prom_erase: prom_erase.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

prom_program: prom_program.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

prom_reload: prom_reload.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)

prom_direct_load: prom_direct_load.o $(LIBOBJS)
	gcc -o $@ $^ $(LIBS)
