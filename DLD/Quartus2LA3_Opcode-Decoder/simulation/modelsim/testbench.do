vcom -93 -work work {C:/Users/tyler/dev/Quartus2/Quartus2LA3_Opcode-Decoder/SourceCode/testbench.vhd}

vsim work.testbench

add wave -position insertpoint \
sim:/testbench/execute_tb \
sim:/testbench/opcode_tb \
sim:/testbench/load_tb \
sim:/testbench/store_tb \
sim:/testbench/add_tb \
sim:/testbench/sub_tb \
sim:/testbench/inc_tb \
sim:/testbench/dec_tb \
sim:/testbench/bra_tb \
sim:/testbench/beq_tb \
sim:/testbench/load_expected \
sim:/testbench/store_expected \
sim:/testbench/add_expected \
sim:/testbench/sub_expected \
sim:/testbench/inc_expected \
sim:/testbench/dec_expected \
sim:/testbench/bra_expected \
sim:/testbench/beq_expected \

run 200 ns