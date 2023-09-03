vcom -93 -work work {C:/Users/tyler/dev/Quartus2/Exercise3/SourceCode/testbench.vhd}

vsim work.testbench

add wave -position insertpoint \
sim:/testbench/sel_tb \
sim:/testbench/in_n_tb \
sim:/testbench/z_tb \
sim:/testbench/z_expected 

run 100 ns