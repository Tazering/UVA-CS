vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA6_Sequencer/SourceCode/testbench.vhd}

vsim work.testbench
add wave -position insertpoint  \
sim:/testbench/reset_signal \
sim:/testbench/clock_signal \
sim:/testbench/opcode_signal \
sim:/testbench/t0_signal \
sim:/testbench/t1_signal \
sim:/testbench/t2_signal \
sim:/testbench/t3_signal \
sim:/testbench/t4_signal \
sim:/testbench/t5_signal \
sim:/testbench/t6_signal \
sim:/testbench/t7_signal \
sim:/testbench/execute_signal \

run 6200 ns;