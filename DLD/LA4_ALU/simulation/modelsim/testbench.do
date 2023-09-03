vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA4_ALU/SourceCode/testbench.vhd}

vsim work.testbench

add wave -position insertpoint  \
sim:/testbench/p_tb \
sim:/testbench/q_tb \
sim:/testbench/f0_tb \
sim:/testbench/f1_tb \
sim:/testbench/alu_out_tb \
sim:/testbench/Z_tb \
sim:/testbench/alu_out_expected \
sim:/testbench/Z_expected

run 50 ns
