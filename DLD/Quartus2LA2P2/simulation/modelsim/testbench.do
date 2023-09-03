vcom -93 -work work {C:/Users/tyler/dev/Quartus2/Quartus2LA2P2/SourceCode/testbench.vhd}

vsim work.testbench

add wave -position insertpoint \
sim:/testbench/inA_tb \
sim:/testbench/inB_tb \
sim:/testbench/inC_tb \
sim:/testbench/Z_tb \
sim:/testbench/Z_expected

run 90 ns