##############################################################################
#
# CPC FPGA
#
##############################################################################

PROJECTS = $(wildcard projects/*)
DIRS = sidecar2 client $(PROJECTS)
BUILDDIRS = $(DIRS:%=build-%)
CLEANDIRS = $(DIRS:%=clean-%)

all: build-client build-bitstreams

build: $(BUILDDIRS) build-bitstreams
$(BUILDDIRS):
	$(MAKE) -C $(@:build-%=%)

clean: $(CLEANDIRS)
$(CLEANDIRS):
	$(MAKE) -C $(@:clean-%=%) clean

.PHONY: $(DIRS)
sidecar2: build-sidecar2
client: build-client
bitstreams: build-bitstreams

#PROJSTREAMS = $(patsubst projects/%,bitstreams/%.fpg,$(PROJECTS))
#bitstreams: $(PROJSTREAMS)
build-bitstreams: $(patsubst projects/%,bitstreams/%.fpg,$(PROJECTS))
bitstreams/%.fpg: build-projects/% build-client
	client/prepare_direct_load <$(<:build-projects/%=projects/%)/$(<:build-projects/%=%.mcs) $@

##############################################################################
#
# Specific common operations

scan: build-client
	client/scan

log: build-client
	client/log

dump: build-client
	client/prom_dump

dfu: build-sidecar2 build-client
	client/bootloader || true
	make -C sidecar2 dfu

reload: build-client
	client/prom_reload

reset: build-client
	client/avr_reset || dfu-programmer atmega32u2 start

#%.load: bitstreams/%.fpg build-client
#	client/fpga_direct_load <$<

%.load: build-projects/% build-client
	client/fpga_direct_load <$(<:build-projects/%=projects/%)/$(<:build-projects/%=%.mcs)

%.program: build-projects/% build-client
	client/prom_erase_program <$(<:build-projects/%=projects/%)/$(<:build-projects/%=%.mcs)
