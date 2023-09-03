vcom -93 -work work {C:/Users/tyler/dev/Quartus2/Quartus2LA2P1/SourceCode/testbench.vhd}

vsim work.testbench

add wave -position insertpoint \
sim:/testbench/in1_tb \
sim:/testbench/in2_tb \
sim:/testbench/out1_tb \
sim:/testbench/out1_expected

run 50 ns