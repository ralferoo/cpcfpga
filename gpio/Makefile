TARGETS=scan prom_dump
LIBOBJS=jtag.o hex.o jtag.o prom.o

all: $(TARGETS)

clean:
	rm -f *.o $(TARGETS)

edit:
	gvim -p *.[ch]&

run: scan prom_dump
	./scan
	./prom_dump

scan: scan.o $(LIBOBJS)
	gcc -o $@ $^

prom_dump: prom_dump.o $(LIBOBJS)
	gcc -o $@ $^
