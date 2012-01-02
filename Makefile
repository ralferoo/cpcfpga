TOP_NAME = cpc
#TOP_NAME = uart_expt

# this is used to codegen a new top with a clk16 generated by the PLL from the eval board 20MHz clock
GEN_TOP_NAME	= evalboard

FAMILY		= IGLOO
PART		= AGLN250V2
PACKAGE		= VQFP100
SPEED		= STD
VOLTAGE		= 1.2
IOSTD		= LVTTL

VHD_FILES = $(sort  hdl/$(GEN_TOP_NAME).vhd $(wildcard hdl/*.vhd)) $(wildcard smartgen/*/*.vhd)

PDC_FILES =constraint/$(TOP_NAME)_pins.pdc
SDC_FILES =$(wildcard constraint/$(TOP_NAME)_sdc.sdc)
#PDC_FILES = $(wildcard constraint/*.pdc)

EDN_NAME = $(TOP_NAME).edn
PDB_NAME = $(TOP_NAME).pdb

FLASHPRO	= flashpro
SYNPLIFY	= C:\\Actel\\Libero_v9.1\\Synopsys\\synplify_E201009A-1\\bin\\mbin\\synplify.exe
DESIGNER	= designer
RM		= c:\\cygwin\\bin\\rm

all: $(PDB_NAME)

pdb: $(PDB_NAME)

clean:
	$(RM) -rf build/ $(PDB_NAME) stdout.log $(PDB_NAME).depends

edn: build/$(EDN_NAME)

log:
	less build/$(TOP_NAME).srr

error:
	grep 'E:' build/$(TOP_NAME).srr

program: build/$(TOP_NAME)_fp.tcl $(PDB_NAME)
	@echo Flashing device...
	-@rm -rf build/$(TOP_NAME)_fpro
	$(FLASHPRO) script:$<

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

build/$(TOP_NAME)_fp.tcl: build/.dummy Makefile
	@echo Rebuilding $@
	@echo new_project \
         -name {$(TOP_NAME)_fpro} \
         -location {$(TOP_NAME)_fpro} \
         -mode {single} >$@
	@echo set_programming_file -file {../$(TOP_NAME).pdb} >>$@
	@echo run_selected_actions >>$@

build/$(TOP_NAME).prj: Makefile $(VHD_FILES) $(SDC_FILES) build/.dummy
	@echo Rebuilding $@
	@echo add_file -vhdl $(patsubst %,../%,$(VHD_FILES)) >$@
	@echo add_file -constraint $(patsubst %,../%,$(SDC_FILES)) >>$@
	@echo set_option -top_module work.$(GEN_TOP_NAME) >>$@
#device options
	@echo set_option -technology $(FAMILY) >>$@
	@echo set_option -part $(PART) >>$@
#compilation/mapping options
	@echo set_option -symbolic_fsm_compiler true >>$@
#compilation/mapping options
	@echo set_option -frequency 20.000 >>$@
#simulation options
	@echo impl -active synthesis >>$@
	@echo project -result_file $(EDN_NAME) >>$@
	@echo project -run -fg synthesis >>$@
	@echo project -close >>$@

build/$(TOP_NAME)_build.tcl: Makefile build/.dummy
	@echo Rebuilding $@
	@echo new_design \
    		-name $(TOP_NAME) \
    		-family $(FAMILY) \
    		-path . >$@
	@echo set_device \
    		-die $(PART) \
    		-package $(PACKAGE) \
    		-speed $(SPEED) \
    		-voltage $(VOLTAGE) \
		-iostd $(IOSTD) \
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

##########################################################################

codegen: hdl/testrom.vhd hdl/evalboard.vhd

hdl/jingle.vhd: codegen/jingle.py
	codegen/jingle.py >$@

hdl/notelookup.vhd: codegen/notes.py
	codegen/notes.py >$@

hdl/%.vhd: codegen/%.asm codegen/makerom.py build/.dummy
	pasmo $< build/$*.bin build/$*.sym
	codegen/makerom.py $* build/$*.bin >$@

hdl/evalboard.vhd: codegen/evalboard.pl hdl/$(TOP_NAME).vhd
	codegen/evalboard.pl <hdl/$(TOP_NAME).vhd >$@

