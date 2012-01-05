quietly set ACTELLIBNAME igloo
quietly set PROJECT_DIR "C:/fpga/cpcfpga"

if {[file exists presynth/_info]} {
   echo "INFO: Simulation library presynth already exists"
} else {
   vlib presynth
}
vmap presynth presynth
vmap igloo "C:/Actel/Libero_v9.1/Designer/lib/modelsim/precompiled/vhdl/igloo"

vcom -93 -explicit -work presynth "${PROJECT_DIR}/smartgen/PLL16mhz/PLL16mhz.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/T80_MCode.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/T80_ALU.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/T80_Reg.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/T80_Pack.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/T80.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/T80s.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/crtc.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/testrom.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/memory_mux.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/my_uart_tx.vhd"
vcom -93 -explicit -work presynth "${PROJECT_DIR}/hdl/cpc.vhd"

vsim -L igloo -L presynth  -t 1ps presynth.cpc
# The following lines are commented because no testbench is associated with the project
# add wave /testbench/*
# run 1000ns
