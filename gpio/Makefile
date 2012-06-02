TARGETS=scan prom_dump

all: prom_dump scan

clean:
	rm -f *.o $(TARGETS)

run: prom_dump
	./prom_dump

scan: scan.o gpio.o
	gcc -o $@ $^

prom_dump: prom_dump.o gpio.o
	gcc -o $@ $^
