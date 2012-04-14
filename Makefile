TOP_NAME = cpc

ACTEL_TOP_NAME		= evalboard
XILINX_TOP_NAME		= homeboard

###########################################################################
#
# source files

VHD_FILES = $(filter-out hdl/bench%.vhd,$(wildcard hdl/*.vhd))

#all:
#	@echo $(VHD_FILES)

ACTEL_VHD_FILES = $(sort hdl/$(ACTEL_TOP_NAME).vhd $(VHD_FILES) $(wildcard smartgen/*/*.vhd))
XILINX_VHD_FILES = $(sort hdl/$(XILINX_TOP_NAME).vhd $(VHD_FILES))

PDC_FILES =constraint/$(ACTEL_TOP_NAME)_pins.pdc
SDC_FILES =$(wildcard constraint/$(ACTEL_TOP_NAME)_sdc.sdc)
#UCF_FILE  = constraint/$(XILINX_TOP_NAME).ucf

###########################################################################
#
# generic rules

all: pdb

clean:
	$(RM) -rf build/ $(PDB_NAME) stdout.log $(PDB_NAME).depends image/

.PRECIOUS:
.SECONDARY:

###########################################################################
#
# actel board config
#
# this is used to codegen a new top with a clk16 generated by the PLL
# from the eval board 20MHz clock
ACTEL_FAMILY		= IGLOO
ACTEL_PART		= AGLN250V2
ACTEL_PACKAGE		= VQFP100
ACTEL_SPEED		= STD
ACTEL_VOLTAGE		= 1.2
ACTEL_IOSTD		= LVTTL

###########################################################################
#
# xilinx board config
#
XILINX_PART		= xc3s400-5-tq144
XILINX_SPEED		= STD
XILINX_VOLTAGE		= 1.2
XILINX_IOSTD		= LVTTL

XILINX_INSTALL_DIR	= /home/xilinx/ISE_DS
XILINX_SETTINGS_FILE	= settings64.sh

###########################################################################
#
# actel rules

UFC_NAME=smartgen/bootrom_internal/bootrom_internal

EDN_NAME = $(TOP_NAME).edn
PDB_NAME = $(TOP_NAME).pdb

CODEGEN_ASM_FILES = $(sort $(wildcard codegen/*.asm)) $(sort $(wildcard test/*.asm)) $(sort $(wildcard rom/installer*.asm))
CODEGEN_SCR_FILES = $(sort $(wildcard codegen/*.scr))
CODEGEN_SREC_FILES = $(patsubst codegen/%.asm,image/%.srec,$(patsubst rom/%.asm,image/%.srec,$(patsubst test/%.asm,image/%.srec,$(CODEGEN_ASM_FILES)))) $(patsubst codegen/%.scr,image/%.srec,$(CODEGEN_SCR_FILES))

FLASHPRO	= flashpro
SYNPLIFY	= C:\\Actel\\Libero_v9.1\\Synopsys\\synplify_E201009A-1\\bin\\mbin\\synplify.exe
DESIGNER	= designer
RM		= rm
#RM		= c:\\cygwin\\bin\\rm

pdb: $(PDB_NAME)

log:
	less build/$(TOP_NAME).srr

error:
	grep 'E:' build/$(TOP_NAME).srr

program: build/$(TOP_NAME)_fp.tcl $(PDB_NAME)
	@echo Flashing device...
	-@rm -rf build/$(TOP_NAME)_fpro
	$(FLASHPRO) script:$<

edn: build/$(EDN_NAME)

progui: $(PDB_NAME) $(TOP_NAME).pro
	$(FLASHPRO) $(TOP_NAME).pro

build/$(EDN_NAME): build/$(TOP_NAME).prj
	-@rm -f build/$(EDN_NAME)
	-@rm -f build/$(TOP_NAME).s*
	-$(SYNPLIFY) -product synplify_pro build/$(TOP_NAME).prj
	@cp build/$(EDN_NAME) build/$(EDN_NAME).tmp
#	@mv build/_$(EDN_NAME) build/$(EDN_NAME)

$(PDB_NAME): build/$(TOP_NAME)_build.tcl build/$(EDN_NAME) $(PDC_FILES)
	$(DESIGNER) SCRIPT:$(notdir $<) SCRIPT_DIR:$(dir $<) LOGFILE:$(notdir $<).log

syn: build/$(EDN_NAME)

#############################################################################

# alternative to using touch so it works with mingw make and cygwin make
build/.dummy:
	-@mkdir build
	@echo dummy >$@
image/.dummy:
	-@mkdir image
	@echo dummy >$@

build/$(TOP_NAME)_fp.tcl: build/.dummy Makefile $(UFC_NAME).mem
	@echo Rebuilding $@
	@echo new_project \
         -name {$(TOP_NAME)_fpro} \
         -location {$(TOP_NAME)_fpro} \
         -mode {single} >$@
	@echo set_programming_file -file {../$(TOP_NAME).pdb} >>$@
#	@echo update_programming_file \
#         -feature {prog_from} \
#         -from_content {ufc} \
#         -from_config_file {../$(UFC_NAME).ufc} \
#         -number_of_devices {1} \
#         -from_program_pages {0 1 2 3 4 5 6 7 } \
#         -pdb_file {../$(TOP_NAME).pdb} >>$@
	@echo run_selected_actions >>$@

build/$(TOP_NAME).prj: Makefile $(ACTEL_VHD_FILES) $(SDC_FILES) build/.dummy
	@echo Rebuilding $@
	@echo add_file -vhdl $(patsubst %,../%,$(ACTEL_VHD_FILES)) >$@
	@echo add_file -constraint $(patsubst %,../%,$(SDC_FILES)) >>$@
	@echo set_option -top_module work.$(ACTEL_TOP_NAME) >>$@
#device options
	@echo set_option -technology $(ACTEL_FAMILY) >>$@
	@echo set_option -part $(ACTEL_PART) >>$@
#compilation/mapping options
	@echo set_option -symbolic_fsm_compiler true >>$@
#compilation/mapping options
	@echo set_option -frequency 16.000 >>$@
#simulation options
	@echo impl -active synthesis >>$@
	@echo project -result_file $(EDN_NAME) >>$@
	@echo project -run -fg synthesis >>$@
	@echo project -close >>$@

build/$(TOP_NAME)_build.tcl: Makefile build/.dummy
	@echo Rebuilding $@
	@echo new_design \
    		-name $(TOP_NAME) \
    		-family $(ACTEL_FAMILY) \
    		-path . >$@
	@echo set_device \
    		-die $(ACTEL_PART) \
    		-package $(ACTEL_PACKAGE) \
    		-speed $(ACTEL_SPEED) \
    		-voltage $(ACTEL_VOLTAGE) \
		-iostd $(ACTEL_IOSTD) \
    		-jtag yes \
    		-probe yes \
    		-trst yes \
    		-temprange COM \
    		-voltrange COM >>$@
	@echo import_source \
    		-format edif \
    		-edif_flavor GENERIC $(EDN_NAME) \
    		-format pdc \
    		-abort_on_error yes $(patsubst %,../%,$(PDC_FILES)) \
    		-merge_physical no \
    		-merge_timing yes >>$@
	@echo save_design $(TOP_NAME)_build.adb >>$@
	@echo compile \
    		-pdc_abort_on_error on \
    		-pdc_eco_display_unmatched_objects off \
    		-pdc_eco_max_warnings 10000 \
    		-demote_globals off \
    		-demote_globals_max_fanout 12 \
    		-promote_globals off \
    		-promote_globals_min_fanout 200 \
    		-promote_globals_max_limit 0 \
    		-localclock_max_shared_instances 12 \
    		-localclock_buffer_tree_max_fanout 12 \
    		-combine_register off \
    		-delete_buffer_tree off \
    		-delete_buffer_tree_max_fanout 12 \
    		-report_high_fanout_nets_limit 10 >>$@
	@echo save_design $(TOP_NAME)_build.adb >>$@
	@echo layout \
    		-timing_driven \
    		-run_placer on \
    		-place_incremental off \
    		-run_router on \
    		-route_incremental OFF \
    		-placer_high_effort off >>$@
	@echo save_design $(TOP_NAME)_build.adb >>$@
	@echo export \
    		-format pdb \
    		-feature prog_fpga \
    		../$(PDB_NAME) >>$@
	@echo save_design $(TOP_NAME)_build.adb >>$@

###########################################################################
#
# codegen rules

codegen: hdl/bootrom.vhd hdl/bench_cpc.vhd hdl/evalboard.vhd $(CODEGEN_SREC_FILES)

hdl/jingle.vhd: codegen/jingle.py
	codegen/jingle.py >$@

hdl/notelookup.vhd: codegen/notes.py
	codegen/notes.py >$@

#hdl/bootrom.vhd smartgen/bootrom_internal/bootrom_internal.mem: codegen/bootrom.asm codegen/makerom.py build/.dummy
#	pasmo $< build/bootrom.bin build/bootrom.sym
#	codegen/makerom.py bootrom -$(UFC_NAME).mem build/bootrom.bin >$@
	
hdl/%.vhd: codegen/%.asm codegen/makerom.py build/.dummy
	pasmo $< build/$*.bin build/$*.sym
	codegen/makerom.py $* build/$*.bin >$@

hdl/evalboard.vhd: codegen/evalboard.pl hdl/cpc.vhd hdl/bootrom.vhd
	codegen/evalboard.pl <hdl/cpc.vhd >$@

hdl/homeboard.vhd: codegen/homeboard.pl hdl/cpc.vhd hdl/bootrom.vhd
	codegen/homeboard.pl <hdl/cpc.vhd >$@

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
	@perl -pe '{s/read\s\"([^"]*)\.asm\"/include "$$1.compat"/;s/([xy][lh])/i$$1/g;s/(add\s+)(i)?([xy][lh])/$$1a,i$$3/g;}' <$< >$@

build/linear.bin: build/sinquad.compat build/bresenham.compat

image/rom_c000.srec: rom/rom_c000.asm build/.dummy image/.dummy
	pasmo $< build/rom_c000.bin build/rom_c000.sym
	objcopy --change-addresses=49152 -I binary build/rom_c000.bin -O srec $@

image/%.srec: build/%.bin image/.dummy
	objcopy --change-addresses=16384 -I binary build/$*.bin -O srec $@

image/%.srec: build/%-0800.bin image/.dummy
	objcopy --change-addresses=2048 -I binary build/$*-0800.bin -O srec $@

#image/%.srec: codegen/%.asm build/.dummy image/.dummy
#	pasmo $< build/$*.bin build/$*.sym
#	objcopy --change-addresses=16384 -I binary build/$*.bin -O srec $@

#image/%.srec: rom/%.asm build/.dummy image/.dummy
#	pasmo $< build/$*.bin build/$*.sym
#	objcopy --change-addresses=16384 -I binary build/$*.bin -O srec $@

#image/%.srec: test/%.asm build/.dummy image/.dummy
#	pasmo $< build/$*.bin build/$*.sym
#	objcopy --change-addresses=16384 -I binary build/$*.bin -O srec $@

image/%.srec: codegen/%.scr build/.dummy image/.dummy
	objcopy --change-addresses=16384 -I binary $< -O srec build/$*.srec
	perl -ne '{print unless m/^S9/;}' <build/$*.srec >$@

image/hyperorig.srec: roms/hyper-headerless.bin build/.dummy image/.dummy
	objcopy --change-addresses=4096 --set-start=0 -I binary $< -O srec $@

image/bb4cpc.srec: bb4cpc/BB4CPC.BAS build/.dummy image/.dummy
	objcopy --change-addresses=240 --set-start=160 -I binary $< -O srec $@

#image/bb4cpc.srec: bb4cpc/bb4cpc.raw build/.dummy image/.dummy
#	objcopy --change-addresses=368 --set-start=32 -I binary $< -O srec $@

image/installer_bubble_bobble.srec: build/installer_bubble_bobble.bin image/.dummy
	objcopy --change-addresses=2048 -I binary $< -O srec $@

image/verify_bubble_bobble.srec: build/verify_bubble_bobble.bin image/.dummy
	objcopy --change-addresses=2048 -I binary $< -O srec $@

image/linear.srec: build/linear.bin image/.dummy
	objcopy --change-addresses=2048 -I binary $< -O srec $@

build/installer_recovery.bin: build/rom_c000.bin
build/installer_boot_into_basic.bin: build/boot_into_basic.bin
build/installer_myrom.bin: build/mytestrom.bin
build/installer_spidos.bin: build/spidos.bin

%.inc: %.struct
	codegen/structinc.pl <$< >$@

build/spidos.bin: rom/spidos.asm rom/spidos_iy_regs.inc

build/hyper-0800.bin: build/hyper-1000.bin build/hyper-4000.bin build/hyper-7000.bin 

build/hyper-1000.bin: roms/hyper-headerless.bin
	dd if=roms/hyper-headerless.bin of=build/hyper-1000.bin bs=1 count=50

build/hyper-4000.bin: roms/hyper-headerless.bin
	dd if=roms/hyper-headerless.bin of=build/hyper-4000.bin bs=1 skip=12288 count=11104

build/hyper-7000.bin: roms/hyper-headerless.bin
	dd if=roms/hyper-headerless.bin of=build/hyper-7000.bin bs=1 skip=24576
	
%.run: image/%.srec
#	stty 19200 cs8 -parenb -icrnl onlcr </dev/ttyUSB0
#	stty 19200 cs8 -parenb </dev/ttyUSB0
	stty 19200 cs8 -parenb onlcr </dev/ttyUSB0
#	bin/splat <$< >/dev/ttyUSB0
	echo | perl -ne '{s/\n/\n\n\n\n\n/g;print;}' >/dev/ttyUSB0
#	perl -ne '{s/\n/\n\n\n\n\n\n\n\n\n\n\n\n\n/g;print;}' <$< >/dev/ttyUSB0
	perl -ne '{s/\n/\n\n\n/g;print;}' <$< |bin/splat >/dev/ttyUSB0
	echo | perl -ne '{s/\n/\n\n\n\n\n/g;print;}' >/dev/ttyUSB0

serial:
#	stty 19200 cs8 -parenb -icrnl onlcr </dev/ttyUSB0
#	stty 19200 cs8 -parenb </dev/ttyUSB0
	stty 19200 cs8 -parenb -icrnl </dev/ttyUSB0
	cat /dev/ttyUSB0

###########################################################################
#
# xilinx rules

XILINX_WRAPPER		= build/xilinx-wrapper
INTSTYLE		= -intstyle silent 
XST_FLAGS		= $(INTSTYLE)
NGDBUILD_FLAGS   ?= $(INTSTYLE) -dd _ngo -nt timestamp  # ngdbuild flags
NGDBUILD_FLAGS   += $(if $(UCF_FILE),-uc ../$(UCF_FILE),-i)         # append the UCF file option if it is specified

MAP_FLAGS        ?= $(INTSTYLE) -cm area -ir off -pr off -c 100
#MAP_FLAGS        ?= $(INTSTYLE) -cm area -pr b -k 4 -c 100 -tx off
PAR_FLAGS        ?= $(INTSTYLE) -w -ol high -t 1
TRCE_FLAGS       ?= $(INTSTYLE) -e 3 -l 3
BITGEN_FLAGS     ?= $(INTSTYLE)           # most bitgen flags are specified in the .ut file
PROMGEN_FLAGS    ?= -u 0                  # flags that control the MCS/EXO file generation

xilinx: build/$(XILINX_TOP_NAME).mcs

build/$(XILINX_TOP_NAME).ngc: $(XILINX_VHD_FILES) build/$(XILINX_TOP_NAME).xst $(XILINX_WRAPPER)
	$(XILINX_WRAPPER) xst $(XST_FLAGS) -ifn $(XILINX_TOP_NAME).xst -ofn $(XILINX_TOP_NAME).syr
	
build/%.ngd: build/%.ngc $(UCF_FILE)
	$(XILINX_WRAPPER) ngdbuild $(NGDBUILD_FLAGS) -p $(XILINX_PART) $*.ngc $*.ngd

build/%_map.ncd build/%.pcf: build/%.ngd
	$(XILINX_WRAPPER) map $(MAP_FLAGS) -p $(XILINX_PART) -o $*_map.ncd $*.ngd $*.pcf

build/%.ncd: build/%_map.ncd build/%.pcf
	$(XILINX_WRAPPER) par $(PAR_FLAGS) $*_map.ncd $*.ncd $*.pcf

build/%.bit: build/%.ncd build/$(XILINX_TOP_NAME).ut
	$(XILINX_WRAPPER) bitgen $(BITGEN_FLAGS) -f $(XILINX_TOP_NAME).ut $*.ncd

build/%.mcs: build/%.bit
	$(XILINX_WRAPPER) promgen $(PROMGEN_FLAGS) $*.bit -p mcs
	
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

build/$(XILINX_TOP_NAME).ut: build/.dummy
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
	@echo -g TckPin:PullUp >>$@
	@echo -g TdiPin:PullUp >>$@
	@echo -g TdoPin:PullUp >>$@
	@echo -g TmsPin:PullUp >>$@
	@echo -g UnusedPin:PullDown >>$@
	@echo -g UserID:0xFFFFFFFF >>$@
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
	@echo -g DriveDone:No >>$@
