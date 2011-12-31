define_clock -name n:clock -freq 20
define_clock -name n:clk16 -freq 16
define_clock -name n:clk4  -freq 4

define_clock -name {n:clk_divider[0]} -freq 8
define_clock -name {n:clk_divider[1]} -freq 4
define_clock -name {n:clk_divider[2]} -freq 2
define_clock -name {n:clk_divider[3]} -freq 1
define_clock -name {n:clk_divider[4]} -freq 1	# anything below 1 is used as 1
define_clock -name {n:clk_divider[5]} -freq 1
define_clock -name {n:clk_divider[6]} -freq 1
define_clock -name {n:clk_divider[7]} -freq 1
define_clock -name {n:clk_divider[8]} -freq 1
define_clock -name {n:clk_divider[9]} -freq 1
define_clock -name {n:clk_divider[10]} -freq 1
define_clock -name {n:clk_divider[11]} -freq 1
define_clock -name {n:clk_divider[18]} -freq 1

create_clock  -name { external_clock_source } -period 50.000 -waveform { 0.000 25.000  }  { n:clock  }


# main clock