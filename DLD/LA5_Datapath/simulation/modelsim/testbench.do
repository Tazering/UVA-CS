vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA5_Datapath/SourceCode/testbench.vhd}

vsim work.testbench

add wave -position insertpoint  \
sim:/testbench/reset_signal \
sim:/testbench/clock_signal \
sim:/testbench/cmar_signal \
sim:/testbench/cmbr_signal \
sim:/testbench/embr_signal \
sim:/testbench/cir_signal \
sim:/testbench/eir_signal \
sim:/testbench/cpc_signal \
sim:/testbench/epc_signal \
sim:/testbench/cd0_signal \
sim:/testbench/ed0_signal \
sim:/testbench/calu_signal \
sim:/testbench/ealu_signal \
sim:/testbench/f0_signal \
sim:/testbench/f1_signal \
sim:/testbench/data_bus \
sim:/testbench/address_bus \
sim:/testbench/opcode \
sim:/testbench/Z 


run 1100 ns;