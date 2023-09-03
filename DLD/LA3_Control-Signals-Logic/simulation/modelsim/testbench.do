vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA3_Control-Signals-Logic/SourceCode/testbench.vhd}

vsim work.testbench

add wave -position insertpoint  \
sim:/testbench/reset_signal \
sim:/testbench/clock_signal \
sim:/testbench/load_signal \
sim:/testbench/store_signal \
sim:/testbench/add_signal \
sim:/testbench/sub_signal \
sim:/testbench/inc_signal \
sim:/testbench/dec_signal \
sim:/testbench/bra_signal \
sim:/testbench/beq_signal \
sim:/testbench/t0_signal \
sim:/testbench/t1_signal \
sim:/testbench/t2_signal \
sim:/testbench/t3_signal \
sim:/testbench/t4_signal \
sim:/testbench/t5_signal \
sim:/testbench/t6_signal \
sim:/testbench/t7_signal \
sim:/testbench/Z_signal \
sim:/testbench/r_signal \
sim:/testbench/w_signal \
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
sim:/testbench/r_expected \
sim:/testbench/w_expected \
sim:/testbench/cmar_expected \
sim:/testbench/cmbr_expected \
sim:/testbench/embr_expected \
sim:/testbench/cir_expected \
sim:/testbench/eir_expected \
sim:/testbench/cpc_expected \
sim:/testbench/epc_expected \
sim:/testbench/cd0_expected \
sim:/testbench/ed0_expected \
sim:/testbench/calu_expected \
sim:/testbench/ealu_expected \
sim:/testbench/f0_expected \
sim:/testbench/f1_expected

run 1200 ns
