vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA7_SimpleCPU/SourceCode/eeprom_memory.vhd}
vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA7_SimpleCPU/SourceCode/clock_reset_generation.vhd}
vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA7_SimpleCPU/SourceCode/simple_cpu.vhd}
vcom -93 -work work {C:/Users/tyler/dev/Quartus2/LA7_SimpleCPU/SourceCode/SimpleCPUTestbench.vhd}

vsim simplecputestbench
add wave -position insertpoint sim:/simplecputestbench/address_bus
add wave -position insertpoint sim:/simplecputestbench/data_bus
add wave -position insertpoint sim:/simplecputestbench/system_clock
add wave -position insertpoint sim:/simplecputestbench/r
add wave -position insertpoint sim:/simplecputestbench/w
add wave -position insertpoint sim:/simplecputestbench/b2v_CPU/b2v_Datapath/b2v_PC/q
add wave -position insertpoint sim:/simplecputestbench/b2v_CPU/b2v_Datapath/b2v_MAR/q
add wave -position insertpoint sim:/simplecputestbench/b2v_CPU/b2v_Datapath/b2v_MBR/q
add wave -position insertpoint sim:/simplecputestbench/b2v_CPU/b2v_Datapath/b2v_IR/q
add wave -position insertpoint sim:/simplecputestbench/b2v_CPU/b2v_Datapath/b2v_D0/q
add wave -position insertpoint sim:/simplecputestbench/b2v_memory/memory_contents

run 100000 ns

