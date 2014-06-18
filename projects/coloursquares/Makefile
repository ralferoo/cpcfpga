TOP_NAME = coloursquares

XILINX_TOP_NAME		= coloursquares
XILINX_USER_ID		= FFFFFFFF

###########################################################################
#
# source files

VHD_FILES = $(filter-out hdl/bench%.vhd,$(wildcard hdl/*.vhd) $(wildcard ../../library/hdl/*.vhd))

#all:
#	@echo $(VHD_FILES)

XILINX_VHD_FILES = $(sort build/$(XILINX_TOP_NAME)_auto.vhd $(VHD_FILES))

UCF_FILE  = constraint/$(XILINX_TOP_NAME).ucf
BMM_FILE  = $(XILINX_TOP_NAME).bmm

###########################################################################
#
# generic rules

all: $(TOP_NAME).mcs
#all: xilinx

clean:
	$(RM) -rf build/ $(PDB_NAME) stdout.log $(PDB_NAME).depends image/ $(TOP_NAME).mcs

$(TOP_NAME).mcs: build/$(XILINX_TOP_NAME)_rom.mcs
	cp $< $@

.PRECIOUS:
.SECONDARY:

###########################################################################
#
# xilinx board config
#
XILINX_PART		= xc3s400-5-tq144
XILINX_SPEED		= STD
XILINX_VOLTAGE		= 1.2
XILINX_IOSTD		= LVTTL

#XILINX_INSTALL_DIR	= /home/xilinx/ISE_DS
#XILINX_SETTINGS_FILE	= settings32.sh
XILINX_INSTALL_DIR	= /opt/Xilinx/14.1/ISE_DS
XILINX_SETTINGS_FILE	= settings64.sh

#############################################################################

constraint/homeboard48.%: constraint/homeboard.%
	perl -pe '{s/CLK16/CLK48/gi;s/62.5ns/20.833ns/}' <$< >$@

#############################################################################

# alternative to using touch so it works with mingw make and cygwin make
build/.dummy:
	-@mkdir build
	@echo dummy >$@

###########################################################################
#
# codegen rules

codegen: hdl/bootrom.vhd hdl/bench_cpc.vhd $(CODEGEN_SREC_FILES)
# hdl/evalboard.vhd

build/%_auto.vhd: codegen/%.asm codegen/makerom.py build/.dummy
	pasmo $< build/$*.bin build/$*.sym
	codegen/makerom.py $* build/$*.bin >$@

build/evalboard_auto.vhd: codegen/evalboard.pl hdl/cpc.vhd hdl/bootrom.vhd build/.dummy
	codegen/evalboard.pl <hdl/cpc.vhd >$@

# hdl/bootrom_homeboard.vhd replaced by bootrom_bram.vhd
build/homeboard_auto.vhd: codegen/homeboard.pl hdl/cpc.vhd build/.dummy
	codegen/homeboard.pl <hdl/cpc.vhd >$@

build/homeboard48_auto.vhd: codegen/homeboard48.pl hdl/cpc.vhd build/.dummy
	codegen/homeboard48.pl <hdl/cpc.vhd >$@

build/%_auto.vhd: hdl/%.vhd build/.dummy
	cp $< $@

hdl/bench_cpc.vhd: codegen/bench_cpc.pl hdl/cpc.vhd hdl/bench_cpc_bootrom.vhd
	codegen/bench_cpc.pl <hdl/cpc.vhd >$@

build/%.bin: rom/%.asm build/.dummy
	pasmo $< build/$*.bin build/$*.sym

build/%.bin: codegen/%.asm build/.dummy
	pasmo $< build/$*.bin build/$*.sym

build/%.bin: codegen/obsolete/%.asm build/.dummy
	pasmo $< build/$*.bin build/$*.sym

build/%.bin: build/%.compat build/.dummy
	pasmo $< build/$*.bin build/$*.sym

build/%.compat: test/%.asm
	@echo Making $@
	@perl -pe '{s/read\s\"([^"]*)\.inc\"/include "build\/$$1.inc"/;s/read\s\"([^"]*)\.asm\"/include "$$1.compat"/;s/([xy][lh])/i$$1/g;s/(add\s+)(i)?([xy][lh])/$$1a,i$$3/g;}' <$< >$@

###########################################################################
#
# xilinx rules

BUILD_BMM_FILE	= $(if $(BMM_FILE),build/$(BMM_FILE),)
BUILD_BMM_BD_FILE = $(patsubst %.bmm,%_bd.bmm,$(BUILD_BMM_FILE))
XILINX_MCS_FILE	= $(XILINX_TOP_NAME)$(if $(BMM_FILE),_rom,).mcs

XILINX_WRAPPER		= build/xilinx-wrapper
INTSTYLE		= 
#INTSTYLE		= -intstyle silent 
MTFLAGS			= -mt on
XST_FLAGS		= $(INTSTYLE)
NGDBUILD_FLAGS   ?= $(INTSTYLE) -dd _ngo -nt timestamp  # ngdbuild flags
NGDBUILD_FLAGS   += $(if $(UCF_FILE),-uc ../$(UCF_FILE),-i)         # append the UCF file option if it is specified
NGDBUILD_FLAGS   += $(if $(BMM_FILE),-bm $(BMM_FILE),)           # append the BMM file option if it is specified

EFFORT		 = std
#EFFORT		 = high

MAP_FLAGS        ?= $(INTSTYLE) -cm area -ir off -pr off -c 100 # $(MTFLAGS)
#MAP_FLAGS        ?= $(INTSTYLE) -cm area -pr b -k 4 -c 100 -tx off
PAR_FLAGS        ?= $(INTSTYLE) -w -ol $(EFFORT) -pl $(EFFORT) -t 1 $(MTFLAGS)
TRCE_FLAGS       ?= $(INTSTYLE) -e 3 -l 3 $(MTFLAGS)
BITGEN_FLAGS     ?= $(INTSTYLE)           # most bitgen flags are specified in the .ut file
PROMGEN_FLAGS    ?= -w -u 0               # flags that control the MCS/EXO file generation

xilinx: build/$(XILINX_MCS_FILE) build/$(XILINX_TOP_NAME).bit

build/$(XILINX_TOP_NAME).ngc: $(XILINX_VHD_FILES) build/$(XILINX_TOP_NAME).xst $(XILINX_WRAPPER) build/$(XILINX_TOP_NAME).prj
	$(XILINX_WRAPPER) xst $(XST_FLAGS) -ifn $(XILINX_TOP_NAME).xst -ofn $(XILINX_TOP_NAME).syr
# | tee build/$(XILINX_TOP_NAME).xst.log # this is the .syr file

build/%.ngd: build/%.ngc $(UCF_FILE) $(BUILD_BMM_FILE)
	$(XILINX_WRAPPER) ngdbuild $(NGDBUILD_FLAGS) -p $(XILINX_PART) $*.ngc $*.ngd | tee build/$(XILINX_TOP_NAME).ngdbuild.log

build/%_map.ncd build/%.pcf: build/%.ngd
	$(XILINX_WRAPPER) map $(MAP_FLAGS) -p $(XILINX_PART) -o $*_map.ncd $*.ngd $*.pcf
# | tee build/$(XILINX_TOP_NAME).map.log # this is _map.map

build/%.ncd: build/%_map.ncd build/%.pcf
	$(XILINX_WRAPPER) par $(PAR_FLAGS) $*_map.ncd $*.ncd $*.pcf
# | tee build/$(XILINX_TOP_NAME).par.log # this is .par

build/%.bit build/%_bd.bmm: build/%.ncd build/%.ut
#$(XILINX_TOP_NAME).ut
	$(XILINX_WRAPPER) bitgen $(BITGEN_FLAGS) -f $(XILINX_TOP_NAME).ut $*.ncd

build/%_rom.bit: build/%.bit build/bootrom_%.mem build/%_bd.bmm
	$(XILINX_WRAPPER) data2mem -bm $*_bd.bmm -bd bootrom_$*.mem -bt $*.bit -o b $*_rom.bit

build/extracted_%.mem/.do: build/%.bit build/bootrom_%.mem build/%_bd.bmm
	@mkdir -p build/extracted_$*.mem
	$(XILINX_WRAPPER) data2mem -bm $*_bd.bmm -bd bootrom_$*.mem -bt $*.bit -bx extracted_$*.mem

build/%.mcs: build/%.bit
	$(XILINX_WRAPPER) promgen $(PROMGEN_FLAGS) $*.bit -p mcs
	
build/%.bmm: constraint/%.bmm
	@cp $< $@

build/$(XILINX_TOP_NAME).rev.vhd: $(XILINX_VHD_FILES) build/$(XILINX_TOP_NAME).xst $(XILINX_WRAPPER) build/$(XILINX_TOP_NAME).prj
	$(XILINX_WRAPPER) netgen -sim -aka -dir . -ofmt vhdl -w -pcf $(XILINX_TOP_NAME).pcf  $(XILINX_TOP_NAME).ngc $(XILINX_TOP_NAME).rev.vhd

$(XILINX_WRAPPER): build/.dummy
	@echo '#!/bin/bash' >$@
	@echo source $(XILINX_INSTALL_DIR)/$(XILINX_SETTINGS_FILE) $(XILINX_INSTALL_DIR) '>/dev/null' >>$@
	@echo cd build >>$@
	@echo 'exec "$$@"' >>$@
	@chmod +x $@

build/make_xilinx_prj: build/.dummy
	@echo '#!/bin/bash' >$@
	@echo 'for i in "$$@"' >>$@
	@echo do >>$@
	@echo 'echo vhdl work \"../$$i\"' >>$@
	@echo done >>$@ 
	@chmod +x $@

build/$(XILINX_TOP_NAME).prj: $(XILINX_VHD_FILES) build/make_xilinx_prj
	@echo Rebuilding $@
	@build/make_xilinx_prj $(XILINX_VHD_FILES) >build/$(XILINX_TOP_NAME).prj

build/$(XILINX_TOP_NAME).xst: build/.dummy build/$(XILINX_TOP_NAME).prj
	@mkdir -p build/projnav.tmp
	@echo Rebuilding $@
	@echo set -tmpdir '"projnav.tmp"' >$@
	@echo set -xsthdpdir '"xst"' >>$@
	@echo run >>$@
	@echo -ifn $(XILINX_TOP_NAME).prj >>$@
	@echo -ifmt mixed >>$@
	@echo -ofn $(XILINX_TOP_NAME) >>$@
	@echo -ofmt NGC >>$@
	@echo -p $(XILINX_PART) >>$@
	@echo -top $(XILINX_TOP_NAME) >>$@
	@echo -opt_mode Speed >>$@
	@echo -opt_level 1 >>$@
	@echo -iuc NO >>$@
	@echo -keep_hierarchy No >>$@
	@echo -netlist_hierarchy As_Optimized >>$@
	@echo -rtlview Yes >>$@
	@echo -glob_opt AllClockNets >>$@
	@echo -read_cores YES >>$@
	@echo -write_timing_constraints NO >>$@
	@echo -cross_clock_analysis NO >>$@
	@echo -hierarchy_separator / >>$@
	@echo '-bus_delimiter <>' >>$@
	@echo -case Maintain >>$@
	@echo -slice_utilization_ratio 100 >>$@
	@echo -bram_utilization_ratio 100 >>$@
	@echo -verilog2001 YES >>$@
	@echo -fsm_extract YES -fsm_encoding Auto >>$@
	@echo -safe_implementation No >>$@
	@echo -fsm_style LUT >>$@
	@echo -ram_extract Yes >>$@
	@echo -ram_style Auto >>$@
	@echo -rom_extract Yes >>$@
	@echo -mux_style Auto >>$@
	@echo -decoder_extract YES >>$@
	@echo -priority_extract Yes >>$@
	@echo -shreg_extract YES >>$@
	@echo -shift_extract YES >>$@
	@echo -xor_collapse YES >>$@
	@echo -rom_style Auto >>$@
	@echo -auto_bram_packing NO >>$@
	@echo -mux_extract Yes >>$@
	@echo -resource_sharing YES >>$@
	@echo -async_to_sync NO >>$@
	@echo -mult_style Auto >>$@
	@echo -iobuf YES >>$@
	@echo -max_fanout 100000 >>$@
	@echo -bufg 8 >>$@
	@echo -register_duplication YES >>$@
	@echo -register_balancing No >>$@
	@echo -slice_packing YES >>$@
	@echo -optimize_primitives NO >>$@
	@echo -use_clock_enable Yes >>$@
	@echo -use_sync_set Yes >>$@
	@echo -use_sync_reset Yes >>$@
	@echo -iob Auto >>$@
	@echo -equivalent_register_removal YES >>$@
	@echo -slice_utilization_ratio_maxmargin 5 >>$@

build/$(XILINX_TOP_NAME).ut: build/.dummy Makefile
	@echo Rebuilding $@
	@echo -w >$@
	@echo -g DebugBitstream:No >>$@
	@echo -g Binary:no >>$@
	@echo -g CRC:Enable >>$@
	@echo -g ConfigRate:6 >>$@
	@echo -g CclkPin:PullUp >>$@
	@echo -g M0Pin:PullUp >>$@
	@echo -g M1Pin:PullUp >>$@
	@echo -g M2Pin:PullUp >>$@
	@echo -g ProgPin:PullUp >>$@
	@echo -g DonePin:PullUp >>$@
	@echo -g HswapenPin:PullUp >>$@
	@echo -g TckPin:PullNone >>$@
	@echo -g TdiPin:PullNone >>$@
	@echo -g TdoPin:PullUp >>$@
	@echo -g TmsPin:PullNone >>$@
	@echo -g UnusedPin:PullDown >>$@
	@echo -g UserID:0x$(XILINX_USER_ID) >>$@
	@echo -g DCMShutdown:Disable >>$@
	@echo -g DCIUpdateMode:AsRequired >>$@
	@echo -g StartUpClk:CClk >>$@
	@echo -g DONE_cycle:4 >>$@
	@echo -g GTS_cycle:5 >>$@
	@echo -g GWE_cycle:6 >>$@
	@echo -g LCK_cycle:NoWait >>$@
	@echo -g Match_cycle:Auto >>$@
	@echo -g Security:None >>$@
	@echo -g DonePipe:No >>$@
	@echo -g DriveDone:Yes >>$@

# useful source: http://home.mnet-online.de/al/BRAM_Bitstreams.html
#
# this requires srecord package, see http://srecord.sourceforge.net/
build/%.mem: build/%.pad
	srec_cat $< -binary -o $@ -vmem 8

build/%.rom: build/%.bin
	dd if=$< of=$@ bs=16384 conv=sync

build/%.pad: build/%.bin
	dd if=$< of=$@ bs=2048 conv=sync

##############################################################################
#
# don't need the stupid rom files...

build/sdtest_rom.bit: build/sdtest.bit
	cp $< $@

build/fasttest_rom.bit: build/fasttest.bit
	cp $< $@

build/videotest_rom.bit: build/videotest.bit
	cp $< $@

build/fract_rom.bit: build/fract.bit
	cp $< $@

build/coloursquares_rom.bit: build/coloursquares.bit
	cp $< $@

build/hsynctest_rom.bit: build/hsynctest.bit
	cp $< $@
