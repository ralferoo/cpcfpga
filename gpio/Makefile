TARGETS=scan prom_dump prom_erase prom_program prom_reload bsr
LIBOBJS=jtag.o hex.o jtag.o prom.o

all: $(TARGETS)

clean:
	rm -f *.o $(TARGETS)

edit:
	gvim -p *.[ch]&

run: scan prom_dump
	./scan
	./prom_dump

$(LIBOBJS): $(wildcard *.h)

bsr: bsr.o $(LIBOBJS)
	gcc -o $@ $^

scan: scan.o $(LIBOBJS)
	gcc -o $@ $^

prom_dump: prom_dump.o $(LIBOBJS)
	gcc -o $@ $^

prom_erase: prom_erase.o $(LIBOBJS)
	gcc -o $@ $^

prom_program: prom_program.o $(LIBOBJS)
	gcc -o $@ $^

prom_reload: prom_reload.o $(LIBOBJS)
	gcc -o $@ $^
