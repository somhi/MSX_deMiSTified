set vid_clk   "clk_out1_clk_wiz_0"
set sdram_clk "clk_out2_clk_wiz_0"

# Clock groups
set_clock_groups -asynchronous -group [get_clocks spiclk] -group [get_clocks {clk_out1_clk_wiz_0 clk_out2_clk_wiz_0} ]

# Some relaxed constrain to the VGA pins. The signals should arrive together, the delay is not really important.
set_output_delay -clock [get_clocks $vid_clk] -max 0 [get_ports {VGA_*}]
set_output_delay -clock [get_clocks $vid_clk] -min -5 [get_ports {VGA_*}]

set_multicycle_path -to {VGA_*[*]} -setup 2
set_multicycle_path -to {VGA_*[*]} -hold 1

# SDRAM delays
set_input_delay -clock [get_clocks $sdram_clk] -reference_pin [get_ports ${RAM_CLK}] -max 6.4 [get_ports ${RAM_IN}]
set_input_delay -clock [get_clocks $sdram_clk] -reference_pin [get_ports ${RAM_CLK}] -min 3.2 [get_ports ${RAM_IN}]

set_output_delay -clock [get_clocks $sdram_clk] -reference_pin [get_ports ${RAM_CLK}] -max 1.5  [get_ports ${RAM_OUT}]
set_output_delay -clock [get_clocks $sdram_clk] -reference_pin [get_ports ${RAM_CLK}] -min -0.8 [get_ports ${RAM_OUT}]

set_multicycle_path -from [get_clocks $sdram_clk] -to [get_clocks $vid_clk] -setup 2
set_multicycle_path -from [get_clocks $sdram_clk] -to [get_clocks $vid_clk] -hold 1

set_false_path -to [get_ports ${FALSE_OUT}]
set_false_path -from [get_ports ${FALSE_IN}]
