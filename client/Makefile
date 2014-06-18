LIBS=-lusb-1.0
INCS=-I/usr/include/libusb-1.0

TARGETS=$(patsubst %.c,%,$(wildcard *.c))
LIBOBJS=$(patsubst %.c,%.o,$(wildcard lib/*.c))
LIBA=sidecar.a

all: $(TARGETS)

clean:
	rm -f *.o $(TARGETS) $(LIBOBJS)

%.go: %
	./$<

$(LIBOBJS): $(wildcard lib/*.h)

$(LIBA): $(LIBOBJS)
	ar r $(LIBA) $(LIBOBJS)

lib/pinhelpers.o: lib/xc3s400_tq144_1532.h lib/xcf02s_vo20.h

lib/%.h: ../docs/%.bsd ../codegen/bsdl_to_c.pl
	../codegen/bsdl_to_c.pl <$< >$@

# stop implicit rule
%: %.c

%: %.o $(LIBA)
	gcc -o $@ $^ $(LIBS)

%.o: %.c
	gcc -c $(INCS) -ggdb -o $@ $<

l:
	@echo $(LIBOBJS)
	@echo $(TARGETS)
	@echo $(LIBA)
