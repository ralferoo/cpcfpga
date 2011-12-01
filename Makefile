FAMILY		= IGLOO
PART		= AGLN250V2
PACKAGE		= VQFP100
SPEED		= STD
VOLTAGE		= 1.5
IOSTD		= LVTTL

TOP_NAME = top
EDN_NAME = build/$(TOP_NAME).edn
PDC_NAME = constraint/top_pins.pdc
PDB_NAME = $(TOP_NAME).pdb

all: $(PDB_NAME)

program: $(PDB_NAME) $(TOP_NAME).pro
	flashpro $(TOP_NAME).pro

clean:
	c:\\cygwin\\bin\\rm -f synthesis/top.edn

$(EDN_NAME): hdl/top.vhd
	@mkdir -p $(dir $@)
	-C:\\Actel\\Libero_v9.1\\Synopsys\\synplify_E201009A-1\\bin\\mbin\\synplify.exe -product synplify_pro manual_syn.prj

syn: $(EDN_NAME)

pdb: $(PDB_NAME)

$(PDB_NAME): build/$(TOP_NAME)_build.tcl
	designer SCRIPT:$(notdir $<) SCRIPT_DIR:$(dir $<) LOGFILE:$(notdir $<).log

build/$(TOP_NAME)_build.tcl: $(EDN_NAME) $(PDC_NAME)
	@echo Rebuilding $@
	@mkdir -p $(dir $@)
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
    		-edif_flavor GENERIC ../$(EDN_NAME) \
    		-format pdc \
    		-abort_on_error yes ../$(PDC_NAME) \
    		-merge_physical no \
    		-merge_timing yes >>$@
	@echo save_design $(TOP_NAME)_build.adb >>$@
	@echo puts "about to compile..." >>$@
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
	@echo puts "about to layout..." >>$@
	@echo layout \
    		-timing_driven \
    		-run_placer on \
    		-place_incremental off \
    		-run_router on \
    		-route_incremental OFF \
    		-placer_high_effort off >>$@
	@echo save_design $(TOP_NAME)_build.adb >>$@
	@echo puts "about to export..." >>$@
	@echo export \
    		-format pdb \
    		-feature prog_fpga \
    		../$(PDB_NAME) >>$@
	@echo save_design $(TOP_NAME)_build.adb >>$@
