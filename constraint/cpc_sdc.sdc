define_clock -name n:clock -freq 20
define_clock -name n:clk16 -freq 16

# anything below 1mhz is treated as 1, so all the low frequency things are specified as 1mhz

define_clock -name {n:gate_array_0.current_cycle[0]} -freq 8
define_clock -name {n:gate_array_0.current_cycle[1]} -freq 4
define_clock -name {n:gate_array_0.current_cycle[2]} -freq 2
define_clock -name {n:gate_array_0.current_cycle[3]} -freq 1

# this isn't a clock at all, but the driver from the cpu
# can't be driven faster than the cpu clock, so 16MHz/4
define_clock -name {n:cpc_0.crtc_e} -freq 4
# this is the real clock to the crtc
define_clock -name {n:cpc_0.gate_array_0.out_crtc_clock} -freq 1

# and this is the z80 clock, really it's at 4MHz but we want everything to finish as if it's 16MHz
define_clock -name {n:cpc_0.gate_array_0.out_z80_clock_delayed} -freq 16

# these are divisors of 16MHz
define_clock -name {n:cpc_0.gate_array_0.current_cycle[0]} -freq 8
define_clock -name {n:cpc_0.gate_array_0.current_cycle[1]} -freq 4

# the real clock. not sure this actually works..
create_clock  -name { external_clock_source } -period 50.000 -waveform { 0.000 25.000  }  { n:clock  }

define_clock -name {n:cpc_0.un2_z80_iorq_n} -freq 4
define_clock -name {n:cpc_0.gate_array_0.current_cycle[3]} -freq 4
define_clock -name {n:cpc_0.psg_0.env_div.counter[16]} -freq 1
define_clock -name {n:cpc_0.psg_0.env_div_clock_gen.counter[4]} -freq 1
define_clock -name {n:cpc_0.psg_0.tone_div_clock_gen.counter[4]} -freq 1

