FAMILY		= IGLOO
PART		= AGLN250V2
PACKAGE		= VQFP100
SPEED		= STD
VOLTAGE		= 1.5
IOSTD		= LVTTL

all:
	@echo Hello

clean:
	c:\cygwin\bin\rm -f synthesis/top.edn

TOP_NAME = top
EDN_NAME = synthesis/$(TOP_NAME).edn
PDC_NAME = constraint/top_pins.pdc
PDB_NAME = $(TOP_NAME).pdb

syn: $(EDN_NAME)

$(EDN_NAME): hdl/top.vhd
	-C:\Actel\Libero_v9.1\Synopsys\synplify_E201009A-1\bin\mbin\synplify.exe -product synplify_pro manual_syn.prj

adb: manual/postlayout.adb

manual/precompile.adb: manual/precompile.tcl $(EDN_NAME)
	designer SCRIPT:$(notdir $<) SCRIPT_DIR:$(dir $<) LOGFILE:$(notdir $<).log

manual/postcompile.adb: manual/postcompile.tcl manual/precompile.adb
	designer SCRIPT:$(notdir $<) SCRIPT_DIR:$(dir $<) LOGFILE:$(notdir $<).log

manual/postlayout.adb: manual/postlayout.tcl manual/postcompile.adb
	designer SCRIPT:$(notdir $<) SCRIPT_DIR:$(dir $<) LOGFILE:$(notdir $<).log

manual/postexport.adb: manual/postexport.tcl manual/postlayout.adb
	designer SCRIPT:$(notdir $<) SCRIPT_DIR:$(dir $<) LOGFILE:$(notdir $<).log

$(PDB_NAME): manual/postexport.adb

pdb: $(PDB_NAME)

manual/precompile.tcl:
	@echo Rebuilding $@
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
	@echo save_design precompile.adb >>$@


manual/postcompile.tcl:
	@echo Rebuilding $@
	@echo # autogen >$@
	@echo open_design precompile.adb >>$@
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
	@echo save_design postcompile.adb >>$@

manual/postlayout.tcl:
	@echo Rebuilding $@
	@echo # autogen >$@
	@echo open_design postcompile.adb >>$@
	@echo layout \
    		-timing_driven \
    		-run_placer on \
    		-place_incremental off \
    		-run_router on \
    		-route_incremental OFF \
    		-placer_high_effort off >>$@
	@echo save_design postlayout.adb >>$@

manual/postexport.tcl:
	@echo Rebuilding $@
	@echo # autogen >$@
	@echo open_design postlayout.adb >>$@
	@echo export \
    		-format pdb \
    		-feature prog_fpga \
    		../$(PDB_NAME) >>$@
	@echo save_design postexport.adb >>$@
