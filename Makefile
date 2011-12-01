FAMILY		= IGLOO
PART		= AGLN250V2
PACKAGE		= VQFP100
SPEED		= STD
VOLTAGE		= 1.5
IOSTD		= LVTTL

TOP_NAME = top
VHD_FILES = $(wildcard hdl/*.vhd)
PDC_FILES = $(wildcard constraint/*.pdc)

EDN_NAME = $(TOP_NAME).edn
PDB_NAME = $(TOP_NAME).pdb

all: $(PDB_NAME)

clean:
	c:\\cygwin\\bin\\rm -rf build/

program: $(PDB_NAME) $(TOP_NAME).pro
	flashpro $(TOP_NAME).pro

syn: build/$(EDN_NAME)

pdb: $(PDB_NAME)

build/$(TOP_NAME).prj: Makefile $(VHD_FILES)
	@echo Rebuilding $@
	-@mkdir -p $(dir $@)
	@echo add_file -vhdl $(patsubst %,../%,$(VHD_FILES)) >$@
	@echo set_option -top_module work.top >>$@
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

build/$(EDN_NAME): build/$(TOP_NAME).prj
	-@mkdir -p $(dir $@)
	-C:\\Actel\\Libero_v9.1\\Synopsys\\synplify_E201009A-1\\bin\\mbin\\synplify.exe -product synplify_pro build/$(TOP_NAME).prj

$(PDB_NAME): build/$(TOP_NAME)_build.tcl build/$(EDN_NAME) $(PDC_FILES)
	designer SCRIPT:$(notdir $<) SCRIPT_DIR:$(dir $<) LOGFILE:$(notdir $<).log

build/$(TOP_NAME)_build.tcl: Makefile
	@echo Rebuilding $@
	-@mkdir -p $(dir $@)
	@echo # autogen >$@
	@echo new_design \
    		-name $(TOP_NAME) \
    		-family $(FAMILY) \
    		-path . >>$@
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
