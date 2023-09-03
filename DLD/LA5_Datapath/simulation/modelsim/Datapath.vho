-- Copyright (C) 2020  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and any partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details, at
-- https://fpgasoftware.intel.com/eula.

-- VENDOR "Altera"
-- PROGRAM "Quartus Prime"
-- VERSION "Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"

-- DATE "10/24/2022 18:30:52"

-- 
-- Device: Altera 10M08DAF484C8G Package FBGA484
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	hard_block IS
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic
	);
END hard_block;

-- Design Ports Information
-- ~ALTERA_TMS~	=>  Location: PIN_H2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TCK~	=>  Location: PIN_G2,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDI~	=>  Location: PIN_L4,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_TDO~	=>  Location: PIN_M5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_CONFIG_SEL~	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ~ALTERA_nCONFIG~	=>  Location: PIN_H9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_nSTATUS~	=>  Location: PIN_G9,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default
-- ~ALTERA_CONF_DONE~	=>  Location: PIN_F8,	 I/O Standard: 2.5 V Schmitt Trigger,	 Current Strength: Default


ARCHITECTURE structure OF hard_block IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL \~ALTERA_TMS~~padout\ : std_logic;
SIGNAL \~ALTERA_TCK~~padout\ : std_logic;
SIGNAL \~ALTERA_TDI~~padout\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~padout\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~padout\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~padout\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~padout\ : std_logic;
SIGNAL \~ALTERA_TMS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TCK~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_TDI~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONFIG_SEL~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nCONFIG~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_nSTATUS~~ibuf_o\ : std_logic;
SIGNAL \~ALTERA_CONF_DONE~~ibuf_o\ : std_logic;

BEGIN

ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
END structure;


LIBRARY ALTERA;
LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	Datapath IS
    PORT (
	reset : IN std_logic;
	clock : IN std_logic;
	cmar : IN std_logic;
	embr : IN std_logic;
	cmbr : IN std_logic;
	eir : IN std_logic;
	ed0 : IN std_logic;
	cd0 : IN std_logic;
	ealu : IN std_logic;
	calu : IN std_logic;
	f0 : IN std_logic;
	f1 : IN std_logic;
	cir : IN std_logic;
	epc : IN std_logic;
	cpc : IN std_logic;
	data_bus : BUFFER std_logic_vector(7 DOWNTO 0);
	Z : BUFFER std_logic;
	address_bus : BUFFER std_logic_vector(4 DOWNTO 0);
	opcode : BUFFER std_logic_vector(2 DOWNTO 0)
	);
END Datapath;

-- Design Ports Information
-- Z	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address_bus[0]	=>  Location: PIN_L2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address_bus[1]	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address_bus[2]	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address_bus[3]	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- address_bus[4]	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[0]	=>  Location: PIN_J9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[1]	=>  Location: PIN_K6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[2]	=>  Location: PIN_D1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[0]	=>  Location: PIN_J10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[1]	=>  Location: PIN_H11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[2]	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[3]	=>  Location: PIN_H4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[4]	=>  Location: PIN_C8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[5]	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[6]	=>  Location: PIN_H3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- data_bus[7]	=>  Location: PIN_G3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- f0	=>  Location: PIN_D9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- f1	=>  Location: PIN_K5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cd0	=>  Location: PIN_B7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cmar	=>  Location: PIN_J3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cir	=>  Location: PIN_K4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- embr	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- eir	=>  Location: PIN_J8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ealu	=>  Location: PIN_A9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ed0	=>  Location: PIN_F3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- epc	=>  Location: PIN_J4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cmbr	=>  Location: PIN_B8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- calu	=>  Location: PIN_G4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cpc	=>  Location: PIN_C7,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF Datapath IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_reset : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_cmar : std_logic;
SIGNAL ww_embr : std_logic;
SIGNAL ww_cmbr : std_logic;
SIGNAL ww_eir : std_logic;
SIGNAL ww_ed0 : std_logic;
SIGNAL ww_cd0 : std_logic;
SIGNAL ww_ealu : std_logic;
SIGNAL ww_calu : std_logic;
SIGNAL ww_f0 : std_logic;
SIGNAL ww_f1 : std_logic;
SIGNAL ww_cir : std_logic;
SIGNAL ww_epc : std_logic;
SIGNAL ww_cpc : std_logic;
SIGNAL ww_data_bus : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_Z : std_logic;
SIGNAL ww_address_bus : std_logic_vector(4 DOWNTO 0);
SIGNAL ww_opcode : std_logic_vector(2 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \data_bus[0]~output_o\ : std_logic;
SIGNAL \data_bus[1]~output_o\ : std_logic;
SIGNAL \data_bus[2]~output_o\ : std_logic;
SIGNAL \data_bus[3]~output_o\ : std_logic;
SIGNAL \data_bus[4]~output_o\ : std_logic;
SIGNAL \data_bus[5]~output_o\ : std_logic;
SIGNAL \data_bus[6]~output_o\ : std_logic;
SIGNAL \data_bus[7]~output_o\ : std_logic;
SIGNAL \Z~output_o\ : std_logic;
SIGNAL \address_bus[0]~output_o\ : std_logic;
SIGNAL \address_bus[1]~output_o\ : std_logic;
SIGNAL \address_bus[2]~output_o\ : std_logic;
SIGNAL \address_bus[3]~output_o\ : std_logic;
SIGNAL \address_bus[4]~output_o\ : std_logic;
SIGNAL \opcode[0]~output_o\ : std_logic;
SIGNAL \opcode[1]~output_o\ : std_logic;
SIGNAL \opcode[2]~output_o\ : std_logic;
SIGNAL \epc~input_o\ : std_logic;
SIGNAL \embr~input_o\ : std_logic;
SIGNAL \eir~input_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \data_bus[0]~input_o\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \cmbr~input_o\ : std_logic;
SIGNAL \b2v_IR|q_internal[0]~feeder_combout\ : std_logic;
SIGNAL \cir~input_o\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[0]~8_combout\ : std_logic;
SIGNAL \cpc~input_o\ : std_logic;
SIGNAL \cd0~input_o\ : std_logic;
SIGNAL \f1~input_o\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder0|s~combout\ : std_logic;
SIGNAL \calu~input_o\ : std_logic;
SIGNAL \ed0~input_o\ : std_logic;
SIGNAL \ealu~input_o\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[0]~9_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[0]~10_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[0]~11_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[0]~12_combout\ : std_logic;
SIGNAL \data_bus[1]~input_o\ : std_logic;
SIGNAL \b2v_IR|q_internal[1]~feeder_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[1]~13_combout\ : std_logic;
SIGNAL \f0~input_o\ : std_logic;
SIGNAL \b2v_alu|a_value[1]~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder1|s~combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[1]~14_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[1]~15_combout\ : std_logic;
SIGNAL \data_bus[2]~input_o\ : std_logic;
SIGNAL \b2v_alu|a_value[2]~1_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder2|s~combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[2]~17_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[2]~16_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[2]~18_combout\ : std_logic;
SIGNAL \data_bus[3]~input_o\ : std_logic;
SIGNAL \b2v_alu|a_value[3]~2_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder3|s~combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[3]~20_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[3]~19_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[3]~21_combout\ : std_logic;
SIGNAL \data_bus[4]~input_o\ : std_logic;
SIGNAL \b2v_alu|a_value[4]~3_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder4|s~combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[4]~23_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[4]~22_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[4]~24_combout\ : std_logic;
SIGNAL \data_bus[5]~input_o\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[5]~25_combout\ : std_logic;
SIGNAL \b2v_alu|a_value[5]~4_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder5|s~combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[5]~26_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[5]~27_combout\ : std_logic;
SIGNAL \data_bus[6]~input_o\ : std_logic;
SIGNAL \b2v_alu|a_value[6]~5_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder6|s~combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[6]~29_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[6]~28_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[6]~30_combout\ : std_logic;
SIGNAL \data_bus[7]~input_o\ : std_logic;
SIGNAL \b2v_D0|q_internal[7]~feeder_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder7|s~0_combout\ : std_logic;
SIGNAL \b2v_alu|adder_subtractor0|full_adder7|s~1_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[7]~32_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[7]~31_combout\ : std_logic;
SIGNAL \b2v_pc_buffer|data_out[7]~33_combout\ : std_logic;
SIGNAL \b2v_alu|Z~1_combout\ : std_logic;
SIGNAL \b2v_alu|Z~0_combout\ : std_logic;
SIGNAL \b2v_alu|Z~2_combout\ : std_logic;
SIGNAL \cmar~input_o\ : std_logic;
SIGNAL \b2v_MAR|q_internal[1]~feeder_combout\ : std_logic;
SIGNAL \b2v_MBR|q_internal\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b2v_D0|q_internal\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b2v_alu|b_value\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b2v_MAR|q_internal\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b2v_alu_register|q_internal\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b2v_IR|q_internal\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \b2v_PC|q_internal\ : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \b2v_alu|ALT_INV_Z~2_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_reset <= reset;
ww_clock <= clock;
ww_cmar <= cmar;
ww_embr <= embr;
ww_cmbr <= cmbr;
ww_eir <= eir;
ww_ed0 <= ed0;
ww_cd0 <= cd0;
ww_ealu <= ealu;
ww_calu <= calu;
ww_f0 <= f0;
ww_f1 <= f1;
ww_cir <= cir;
ww_epc <= epc;
ww_cpc <= cpc;
data_bus <= ww_data_bus;
Z <= ww_Z;
address_bus <= ww_address_bus;
opcode <= ww_opcode;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \reset~input_o\);

\clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock~input_o\);
\ALT_INV_reset~inputclkctrl_outclk\ <= NOT \reset~inputclkctrl_outclk\;
\b2v_alu|ALT_INV_Z~2_combout\ <= NOT \b2v_alu|Z~2_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X11_Y14_N24
\~QUARTUS_CREATED_GND~I\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \~QUARTUS_CREATED_GND~I_combout\ = GND

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	combout => \~QUARTUS_CREATED_GND~I_combout\);

-- Location: IOOBUF_X17_Y25_N23
\data_bus[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[0]~10_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[0]~output_o\);

-- Location: IOOBUF_X17_Y25_N30
\data_bus[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[1]~15_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[1]~output_o\);

-- Location: IOOBUF_X15_Y25_N9
\data_bus[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[2]~18_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[2]~output_o\);

-- Location: IOOBUF_X10_Y20_N2
\data_bus[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[3]~21_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[3]~output_o\);

-- Location: IOOBUF_X17_Y25_N9
\data_bus[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[4]~24_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[4]~output_o\);

-- Location: IOOBUF_X15_Y25_N30
\data_bus[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[5]~27_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[5]~output_o\);

-- Location: IOOBUF_X10_Y20_N23
\data_bus[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[6]~30_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[6]~output_o\);

-- Location: IOOBUF_X10_Y20_N9
\data_bus[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_pc_buffer|data_out[7]~33_combout\,
	oe => \b2v_pc_buffer|data_out[0]~12_combout\,
	devoe => ww_devoe,
	o => \data_bus[7]~output_o\);

-- Location: IOOBUF_X13_Y25_N16
\Z~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_alu|ALT_INV_Z~2_combout\,
	devoe => ww_devoe,
	o => \Z~output_o\);

-- Location: IOOBUF_X10_Y16_N9
\address_bus[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_MAR|q_internal\(0),
	devoe => ww_devoe,
	o => \address_bus[0]~output_o\);

-- Location: IOOBUF_X10_Y18_N16
\address_bus[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_MAR|q_internal\(1),
	devoe => ww_devoe,
	o => \address_bus[1]~output_o\);

-- Location: IOOBUF_X10_Y17_N2
\address_bus[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_MAR|q_internal\(2),
	devoe => ww_devoe,
	o => \address_bus[2]~output_o\);

-- Location: IOOBUF_X13_Y25_N9
\address_bus[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_MAR|q_internal\(3),
	devoe => ww_devoe,
	o => \address_bus[3]~output_o\);

-- Location: IOOBUF_X15_Y25_N16
\address_bus[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_MAR|q_internal\(4),
	devoe => ww_devoe,
	o => \address_bus[4]~output_o\);

-- Location: IOOBUF_X10_Y21_N23
\opcode[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_IR|q_internal\(5),
	devoe => ww_devoe,
	o => \opcode[0]~output_o\);

-- Location: IOOBUF_X10_Y19_N23
\opcode[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_IR|q_internal\(6),
	devoe => ww_devoe,
	o => \opcode[1]~output_o\);

-- Location: IOOBUF_X10_Y17_N9
\opcode[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \b2v_IR|q_internal\(7),
	devoe => ww_devoe,
	o => \opcode[2]~output_o\);

-- Location: IOIBUF_X10_Y20_N15
\epc~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_epc,
	o => \epc~input_o\);

-- Location: IOIBUF_X17_Y25_N1
\embr~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_embr,
	o => \embr~input_o\);

-- Location: IOIBUF_X10_Y21_N15
\eir~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_eir,
	o => \eir~input_o\);

-- Location: IOIBUF_X0_Y6_N15
\clock~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clock,
	o => \clock~input_o\);

-- Location: CLKCTRL_G3
\clock~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clock~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clock~inputclkctrl_outclk\);

-- Location: IOIBUF_X17_Y25_N22
\data_bus[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(0),
	o => \data_bus[0]~input_o\);

-- Location: IOIBUF_X0_Y6_N22
\reset~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_reset,
	o => \reset~input_o\);

-- Location: CLKCTRL_G4
\reset~inputclkctrl\ : fiftyfivenm_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \reset~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \reset~inputclkctrl_outclk\);

-- Location: IOIBUF_X19_Y25_N22
\cmbr~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cmbr,
	o => \cmbr~input_o\);

-- Location: FF_X18_Y20_N27
\b2v_MBR|q_internal[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[0]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(0));

-- Location: LCCOMB_X18_Y20_N24
\b2v_IR|q_internal[0]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_IR|q_internal[0]~feeder_combout\ = \data_bus[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \data_bus[0]~input_o\,
	combout => \b2v_IR|q_internal[0]~feeder_combout\);

-- Location: IOIBUF_X10_Y19_N1
\cir~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cir,
	o => \cir~input_o\);

-- Location: FF_X18_Y20_N25
\b2v_IR|q_internal[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_IR|q_internal[0]~feeder_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(0));

-- Location: LCCOMB_X18_Y20_N26
\b2v_pc_buffer|data_out[0]~8\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[0]~8_combout\ = (\embr~input_o\ & (\b2v_MBR|q_internal\(0) & ((\b2v_IR|q_internal\(0)) # (!\eir~input_o\)))) # (!\embr~input_o\ & (((\b2v_IR|q_internal\(0))) # (!\eir~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \eir~input_o\,
	datac => \b2v_MBR|q_internal\(0),
	datad => \b2v_IR|q_internal\(0),
	combout => \b2v_pc_buffer|data_out[0]~8_combout\);

-- Location: IOIBUF_X17_Y25_N15
\cpc~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cpc,
	o => \cpc~input_o\);

-- Location: FF_X17_Y20_N1
\b2v_PC|q_internal[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[0]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cpc~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_PC|q_internal\(0));

-- Location: IOIBUF_X15_Y25_N1
\cd0~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cd0,
	o => \cd0~input_o\);

-- Location: FF_X16_Y20_N5
\b2v_D0|q_internal[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[0]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(0));

-- Location: IOIBUF_X10_Y19_N15
\f1~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_f1,
	o => \f1~input_o\);

-- Location: LCCOMB_X14_Y20_N14
\b2v_alu|adder_subtractor0|full_adder0|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder0|s~combout\ = \data_bus[0]~input_o\ $ (((\b2v_D0|q_internal\(0)) # (\f1~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000001111111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \b2v_D0|q_internal\(0),
	datac => \f1~input_o\,
	datad => \data_bus[0]~input_o\,
	combout => \b2v_alu|adder_subtractor0|full_adder0|s~combout\);

-- Location: IOIBUF_X10_Y21_N1
\calu~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_calu,
	o => \calu~input_o\);

-- Location: FF_X14_Y20_N15
\b2v_alu_register|q_internal[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder0|s~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(0));

-- Location: IOIBUF_X10_Y21_N8
\ed0~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ed0,
	o => \ed0~input_o\);

-- Location: IOIBUF_X19_Y25_N15
\ealu~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_ealu,
	o => \ealu~input_o\);

-- Location: LCCOMB_X17_Y20_N2
\b2v_pc_buffer|data_out[0]~9\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[0]~9_combout\ = (\b2v_alu_register|q_internal\(0) & ((\b2v_D0|q_internal\(0)) # ((!\ed0~input_o\)))) # (!\b2v_alu_register|q_internal\(0) & (!\ealu~input_o\ & ((\b2v_D0|q_internal\(0)) # (!\ed0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101011001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu_register|q_internal\(0),
	datab => \b2v_D0|q_internal\(0),
	datac => \ed0~input_o\,
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[0]~9_combout\);

-- Location: LCCOMB_X17_Y20_N0
\b2v_pc_buffer|data_out[0]~10\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[0]~10_combout\ = (\b2v_pc_buffer|data_out[0]~8_combout\ & (\b2v_pc_buffer|data_out[0]~9_combout\ & ((\b2v_PC|q_internal\(0)) # (!\epc~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \epc~input_o\,
	datab => \b2v_pc_buffer|data_out[0]~8_combout\,
	datac => \b2v_PC|q_internal\(0),
	datad => \b2v_pc_buffer|data_out[0]~9_combout\,
	combout => \b2v_pc_buffer|data_out[0]~10_combout\);

-- Location: LCCOMB_X18_Y20_N20
\b2v_pc_buffer|data_out[0]~11\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[0]~11_combout\ = (\embr~input_o\) # ((\eir~input_o\) # ((\ed0~input_o\) # (\ealu~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \eir~input_o\,
	datac => \ed0~input_o\,
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[0]~11_combout\);

-- Location: LCCOMB_X17_Y20_N10
\b2v_pc_buffer|data_out[0]~12\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[0]~12_combout\ = (\b2v_pc_buffer|data_out[0]~11_combout\) # (\epc~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_pc_buffer|data_out[0]~11_combout\,
	datac => \epc~input_o\,
	combout => \b2v_pc_buffer|data_out[0]~12_combout\);

-- Location: IOIBUF_X17_Y25_N29
\data_bus[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(1),
	o => \data_bus[1]~input_o\);

-- Location: FF_X18_Y20_N9
\b2v_MBR|q_internal[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[1]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(1));

-- Location: LCCOMB_X18_Y20_N18
\b2v_IR|q_internal[1]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_IR|q_internal[1]~feeder_combout\ = \data_bus[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \data_bus[1]~input_o\,
	combout => \b2v_IR|q_internal[1]~feeder_combout\);

-- Location: FF_X18_Y20_N19
\b2v_IR|q_internal[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_IR|q_internal[1]~feeder_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(1));

-- Location: LCCOMB_X18_Y20_N8
\b2v_pc_buffer|data_out[1]~13\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[1]~13_combout\ = (\embr~input_o\ & (\b2v_MBR|q_internal\(1) & ((\b2v_IR|q_internal\(1)) # (!\eir~input_o\)))) # (!\embr~input_o\ & (((\b2v_IR|q_internal\(1))) # (!\eir~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \eir~input_o\,
	datac => \b2v_MBR|q_internal\(1),
	datad => \b2v_IR|q_internal\(1),
	combout => \b2v_pc_buffer|data_out[1]~13_combout\);

-- Location: FF_X17_Y20_N15
\b2v_PC|q_internal[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[1]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cpc~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_PC|q_internal\(1));

-- Location: FF_X16_Y20_N11
\b2v_D0|q_internal[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[1]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(1));

-- Location: IOIBUF_X15_Y25_N22
\f0~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_f0,
	o => \f0~input_o\);

-- Location: LCCOMB_X16_Y20_N8
\b2v_alu|a_value[1]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|a_value[1]~0_combout\ = (\f1~input_o\ & (\data_bus[1]~input_o\)) # (!\f1~input_o\ & ((\b2v_D0|q_internal\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \data_bus[1]~input_o\,
	datad => \b2v_D0|q_internal\(1),
	combout => \b2v_alu|a_value[1]~0_combout\);

-- Location: LCCOMB_X16_Y20_N4
\b2v_alu|adder_subtractor0|full_adder0|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\ = (\f1~input_o\ & (\data_bus[0]~input_o\)) # (!\f1~input_o\ & ((\data_bus[0]~input_o\ & (\b2v_D0|q_internal\(0))) # (!\data_bus[0]~input_o\ & ((\f0~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \data_bus[0]~input_o\,
	datac => \b2v_D0|q_internal\(0),
	datad => \f0~input_o\,
	combout => \b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\);

-- Location: LCCOMB_X17_Y20_N24
\b2v_alu|b_value[1]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|b_value\(1) = (\data_bus[1]~input_o\ & !\f1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \data_bus[1]~input_o\,
	datac => \f1~input_o\,
	combout => \b2v_alu|b_value\(1));

-- Location: LCCOMB_X16_Y20_N30
\b2v_alu|adder_subtractor0|full_adder1|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder1|s~combout\ = \f0~input_o\ $ (\b2v_alu|a_value[1]~0_combout\ $ (\b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\ $ (\b2v_alu|b_value\(1))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f0~input_o\,
	datab => \b2v_alu|a_value[1]~0_combout\,
	datac => \b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\,
	datad => \b2v_alu|b_value\(1),
	combout => \b2v_alu|adder_subtractor0|full_adder1|s~combout\);

-- Location: FF_X16_Y20_N31
\b2v_alu_register|q_internal[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder1|s~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(1));

-- Location: LCCOMB_X17_Y20_N20
\b2v_pc_buffer|data_out[1]~14\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[1]~14_combout\ = (\b2v_D0|q_internal\(1) & ((\b2v_alu_register|q_internal\(1)) # ((!\ealu~input_o\)))) # (!\b2v_D0|q_internal\(1) & (!\ed0~input_o\ & ((\b2v_alu_register|q_internal\(1)) # (!\ealu~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000110010101111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_D0|q_internal\(1),
	datab => \b2v_alu_register|q_internal\(1),
	datac => \ed0~input_o\,
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[1]~14_combout\);

-- Location: LCCOMB_X17_Y20_N14
\b2v_pc_buffer|data_out[1]~15\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[1]~15_combout\ = (\b2v_pc_buffer|data_out[1]~13_combout\ & (\b2v_pc_buffer|data_out[1]~14_combout\ & ((\b2v_PC|q_internal\(1)) # (!\epc~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \epc~input_o\,
	datab => \b2v_pc_buffer|data_out[1]~13_combout\,
	datac => \b2v_PC|q_internal\(1),
	datad => \b2v_pc_buffer|data_out[1]~14_combout\,
	combout => \b2v_pc_buffer|data_out[1]~15_combout\);

-- Location: IOIBUF_X15_Y25_N8
\data_bus[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(2),
	o => \data_bus[2]~input_o\);

-- Location: FF_X16_Y20_N9
\b2v_D0|q_internal[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[2]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(2));

-- Location: LCCOMB_X16_Y20_N10
\b2v_alu|a_value[2]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|a_value[2]~1_combout\ = (\f1~input_o\ & (\data_bus[2]~input_o\)) # (!\f1~input_o\ & ((\b2v_D0|q_internal\(2))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \data_bus[2]~input_o\,
	datad => \b2v_D0|q_internal\(2),
	combout => \b2v_alu|a_value[2]~1_combout\);

-- Location: LCCOMB_X17_Y20_N30
\b2v_alu|b_value[2]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|b_value\(2) = (!\f1~input_o\ & \data_bus[2]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \f1~input_o\,
	datad => \data_bus[2]~input_o\,
	combout => \b2v_alu|b_value\(2));

-- Location: LCCOMB_X16_Y20_N12
\b2v_alu|adder_subtractor0|full_adder1|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\ = (\b2v_alu|a_value[1]~0_combout\ & ((\b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\) # (\f0~input_o\ $ (\b2v_alu|b_value\(1))))) # (!\b2v_alu|a_value[1]~0_combout\ & 
-- (\b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\ & (\f0~input_o\ $ (\b2v_alu|b_value\(1)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f0~input_o\,
	datab => \b2v_alu|b_value\(1),
	datac => \b2v_alu|a_value[1]~0_combout\,
	datad => \b2v_alu|adder_subtractor0|full_adder0|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\);

-- Location: LCCOMB_X16_Y20_N26
\b2v_alu|adder_subtractor0|full_adder2|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder2|s~combout\ = \f0~input_o\ $ (\b2v_alu|a_value[2]~1_combout\ $ (\b2v_alu|b_value\(2) $ (\b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f0~input_o\,
	datab => \b2v_alu|a_value[2]~1_combout\,
	datac => \b2v_alu|b_value\(2),
	datad => \b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder2|s~combout\);

-- Location: FF_X16_Y20_N27
\b2v_alu_register|q_internal[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder2|s~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(2));

-- Location: LCCOMB_X17_Y20_N16
\b2v_pc_buffer|data_out[2]~17\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[2]~17_combout\ = (\b2v_D0|q_internal\(2) & (((\b2v_alu_register|q_internal\(2)) # (!\ealu~input_o\)))) # (!\b2v_D0|q_internal\(2) & (!\ed0~input_o\ & ((\b2v_alu_register|q_internal\(2)) # (!\ealu~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000010111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_D0|q_internal\(2),
	datab => \ed0~input_o\,
	datac => \b2v_alu_register|q_internal\(2),
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[2]~17_combout\);

-- Location: FF_X17_Y20_N19
\b2v_PC|q_internal[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[2]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cpc~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_PC|q_internal\(2));

-- Location: FF_X18_Y20_N23
\b2v_IR|q_internal[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[2]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(2));

-- Location: FF_X18_Y20_N17
\b2v_MBR|q_internal[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[2]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(2));

-- Location: LCCOMB_X18_Y20_N16
\b2v_pc_buffer|data_out[2]~16\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[2]~16_combout\ = (\b2v_IR|q_internal\(2) & (((\b2v_MBR|q_internal\(2)) # (!\embr~input_o\)))) # (!\b2v_IR|q_internal\(2) & (!\eir~input_o\ & ((\b2v_MBR|q_internal\(2)) # (!\embr~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011000010111011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_IR|q_internal\(2),
	datab => \eir~input_o\,
	datac => \b2v_MBR|q_internal\(2),
	datad => \embr~input_o\,
	combout => \b2v_pc_buffer|data_out[2]~16_combout\);

-- Location: LCCOMB_X17_Y20_N18
\b2v_pc_buffer|data_out[2]~18\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[2]~18_combout\ = (\b2v_pc_buffer|data_out[2]~17_combout\ & (\b2v_pc_buffer|data_out[2]~16_combout\ & ((\b2v_PC|q_internal\(2)) # (!\epc~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \epc~input_o\,
	datab => \b2v_pc_buffer|data_out[2]~17_combout\,
	datac => \b2v_PC|q_internal\(2),
	datad => \b2v_pc_buffer|data_out[2]~16_combout\,
	combout => \b2v_pc_buffer|data_out[2]~18_combout\);

-- Location: IOIBUF_X10_Y20_N1
\data_bus[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(3),
	o => \data_bus[3]~input_o\);

-- Location: FF_X15_Y20_N5
\b2v_D0|q_internal[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[3]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(3));

-- Location: LCCOMB_X15_Y20_N10
\b2v_alu|a_value[3]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|a_value[3]~2_combout\ = (\f1~input_o\ & (\data_bus[3]~input_o\)) # (!\f1~input_o\ & ((\b2v_D0|q_internal\(3))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \data_bus[3]~input_o\,
	datac => \b2v_D0|q_internal\(3),
	combout => \b2v_alu|a_value[3]~2_combout\);

-- Location: LCCOMB_X17_Y20_N12
\b2v_alu|b_value[3]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|b_value\(3) = (\data_bus[3]~input_o\ & !\f1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \data_bus[3]~input_o\,
	datac => \f1~input_o\,
	combout => \b2v_alu|b_value\(3));

-- Location: LCCOMB_X16_Y20_N0
\b2v_alu|adder_subtractor0|full_adder2|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\ = (\b2v_alu|a_value[2]~1_combout\ & ((\b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\) # (\b2v_alu|b_value\(2) $ (\f0~input_o\)))) # (!\b2v_alu|a_value[2]~1_combout\ & 
-- (\b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\ & (\b2v_alu|b_value\(2) $ (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|b_value\(2),
	datab => \f0~input_o\,
	datac => \b2v_alu|a_value[2]~1_combout\,
	datad => \b2v_alu|adder_subtractor0|full_adder1|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\);

-- Location: LCCOMB_X16_Y20_N22
\b2v_alu|adder_subtractor0|full_adder3|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder3|s~combout\ = \b2v_alu|a_value[3]~2_combout\ $ (\f0~input_o\ $ (\b2v_alu|b_value\(3) $ (\b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|a_value[3]~2_combout\,
	datab => \f0~input_o\,
	datac => \b2v_alu|b_value\(3),
	datad => \b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder3|s~combout\);

-- Location: FF_X16_Y20_N23
\b2v_alu_register|q_internal[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder3|s~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(3));

-- Location: LCCOMB_X17_Y20_N28
\b2v_pc_buffer|data_out[3]~20\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[3]~20_combout\ = (\ealu~input_o\ & (\b2v_alu_register|q_internal\(3) & ((\b2v_D0|q_internal\(3)) # (!\ed0~input_o\)))) # (!\ealu~input_o\ & (((\b2v_D0|q_internal\(3)) # (!\ed0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110100001101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ealu~input_o\,
	datab => \b2v_alu_register|q_internal\(3),
	datac => \ed0~input_o\,
	datad => \b2v_D0|q_internal\(3),
	combout => \b2v_pc_buffer|data_out[3]~20_combout\);

-- Location: FF_X17_Y20_N23
\b2v_PC|q_internal[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[3]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cpc~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_PC|q_internal\(3));

-- Location: FF_X18_Y20_N5
\b2v_MBR|q_internal[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[3]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(3));

-- Location: FF_X18_Y20_N11
\b2v_IR|q_internal[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[3]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(3));

-- Location: LCCOMB_X18_Y20_N4
\b2v_pc_buffer|data_out[3]~19\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[3]~19_combout\ = (\embr~input_o\ & (\b2v_MBR|q_internal\(3) & ((\b2v_IR|q_internal\(3)) # (!\eir~input_o\)))) # (!\embr~input_o\ & (((\b2v_IR|q_internal\(3))) # (!\eir~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \eir~input_o\,
	datac => \b2v_MBR|q_internal\(3),
	datad => \b2v_IR|q_internal\(3),
	combout => \b2v_pc_buffer|data_out[3]~19_combout\);

-- Location: LCCOMB_X17_Y20_N22
\b2v_pc_buffer|data_out[3]~21\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[3]~21_combout\ = (\b2v_pc_buffer|data_out[3]~20_combout\ & (\b2v_pc_buffer|data_out[3]~19_combout\ & ((\b2v_PC|q_internal\(3)) # (!\epc~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \epc~input_o\,
	datab => \b2v_pc_buffer|data_out[3]~20_combout\,
	datac => \b2v_PC|q_internal\(3),
	datad => \b2v_pc_buffer|data_out[3]~19_combout\,
	combout => \b2v_pc_buffer|data_out[3]~21_combout\);

-- Location: IOIBUF_X17_Y25_N8
\data_bus[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(4),
	o => \data_bus[4]~input_o\);

-- Location: LCCOMB_X15_Y20_N8
\b2v_alu|b_value[4]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|b_value\(4) = (\data_bus[4]~input_o\ & !\f1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \data_bus[4]~input_o\,
	datad => \f1~input_o\,
	combout => \b2v_alu|b_value\(4));

-- Location: FF_X15_Y20_N13
\b2v_D0|q_internal[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[4]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(4));

-- Location: LCCOMB_X15_Y20_N18
\b2v_alu|a_value[4]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|a_value[4]~3_combout\ = (\f1~input_o\ & (\data_bus[4]~input_o\)) # (!\f1~input_o\ & ((\b2v_D0|q_internal\(4))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010110100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datac => \data_bus[4]~input_o\,
	datad => \b2v_D0|q_internal\(4),
	combout => \b2v_alu|a_value[4]~3_combout\);

-- Location: LCCOMB_X16_Y20_N16
\b2v_alu|adder_subtractor0|full_adder3|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\ = (\b2v_alu|a_value[3]~2_combout\ & ((\b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\) # (\f0~input_o\ $ (\b2v_alu|b_value\(3))))) # (!\b2v_alu|a_value[3]~2_combout\ & 
-- (\b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\ & (\f0~input_o\ $ (\b2v_alu|b_value\(3)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|a_value[3]~2_combout\,
	datab => \f0~input_o\,
	datac => \b2v_alu|b_value\(3),
	datad => \b2v_alu|adder_subtractor0|full_adder2|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\);

-- Location: LCCOMB_X16_Y20_N2
\b2v_alu|adder_subtractor0|full_adder4|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder4|s~combout\ = \b2v_alu|b_value\(4) $ (\b2v_alu|a_value[4]~3_combout\ $ (\b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\ $ (\f0~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|b_value\(4),
	datab => \b2v_alu|a_value[4]~3_combout\,
	datac => \b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\,
	datad => \f0~input_o\,
	combout => \b2v_alu|adder_subtractor0|full_adder4|s~combout\);

-- Location: FF_X16_Y20_N3
\b2v_alu_register|q_internal[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder4|s~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(4));

-- Location: LCCOMB_X17_Y20_N4
\b2v_pc_buffer|data_out[4]~23\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[4]~23_combout\ = (\b2v_alu_register|q_internal\(4) & (((\b2v_D0|q_internal\(4))) # (!\ed0~input_o\))) # (!\b2v_alu_register|q_internal\(4) & (!\ealu~input_o\ & ((\b2v_D0|q_internal\(4)) # (!\ed0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010001011110011",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu_register|q_internal\(4),
	datab => \ed0~input_o\,
	datac => \b2v_D0|q_internal\(4),
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[4]~23_combout\);

-- Location: FF_X17_Y20_N27
\b2v_PC|q_internal[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[4]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cpc~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_PC|q_internal\(4));

-- Location: FF_X18_Y20_N29
\b2v_MBR|q_internal[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[4]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(4));

-- Location: FF_X18_Y20_N7
\b2v_IR|q_internal[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[4]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(4));

-- Location: LCCOMB_X18_Y20_N28
\b2v_pc_buffer|data_out[4]~22\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[4]~22_combout\ = (\embr~input_o\ & (\b2v_MBR|q_internal\(4) & ((\b2v_IR|q_internal\(4)) # (!\eir~input_o\)))) # (!\embr~input_o\ & (((\b2v_IR|q_internal\(4))) # (!\eir~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111010100110001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \eir~input_o\,
	datac => \b2v_MBR|q_internal\(4),
	datad => \b2v_IR|q_internal\(4),
	combout => \b2v_pc_buffer|data_out[4]~22_combout\);

-- Location: LCCOMB_X17_Y20_N26
\b2v_pc_buffer|data_out[4]~24\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[4]~24_combout\ = (\b2v_pc_buffer|data_out[4]~23_combout\ & (\b2v_pc_buffer|data_out[4]~22_combout\ & ((\b2v_PC|q_internal\(4)) # (!\epc~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \epc~input_o\,
	datab => \b2v_pc_buffer|data_out[4]~23_combout\,
	datac => \b2v_PC|q_internal\(4),
	datad => \b2v_pc_buffer|data_out[4]~22_combout\,
	combout => \b2v_pc_buffer|data_out[4]~24_combout\);

-- Location: IOIBUF_X15_Y25_N29
\data_bus[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(5),
	o => \data_bus[5]~input_o\);

-- Location: FF_X14_Y20_N31
\b2v_IR|q_internal[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[5]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(5));

-- Location: FF_X15_Y20_N25
\b2v_D0|q_internal[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[5]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(5));

-- Location: LCCOMB_X14_Y20_N30
\b2v_pc_buffer|data_out[5]~25\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[5]~25_combout\ = (\ed0~input_o\ & (\b2v_D0|q_internal\(5) & ((\b2v_IR|q_internal\(5)) # (!\eir~input_o\)))) # (!\ed0~input_o\ & (((\b2v_IR|q_internal\(5))) # (!\eir~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001101010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ed0~input_o\,
	datab => \eir~input_o\,
	datac => \b2v_IR|q_internal\(5),
	datad => \b2v_D0|q_internal\(5),
	combout => \b2v_pc_buffer|data_out[5]~25_combout\);

-- Location: LCCOMB_X15_Y20_N24
\b2v_alu|b_value[5]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|b_value\(5) = (\data_bus[5]~input_o\ & !\f1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \data_bus[5]~input_o\,
	datad => \f1~input_o\,
	combout => \b2v_alu|b_value\(5));

-- Location: LCCOMB_X15_Y20_N6
\b2v_alu|a_value[5]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|a_value[5]~4_combout\ = (\f1~input_o\ & (\data_bus[5]~input_o\)) # (!\f1~input_o\ & ((\b2v_D0|q_internal\(5))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \data_bus[5]~input_o\,
	datad => \b2v_D0|q_internal\(5),
	combout => \b2v_alu|a_value[5]~4_combout\);

-- Location: LCCOMB_X16_Y20_N20
\b2v_alu|adder_subtractor0|full_adder4|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\ = (\b2v_alu|a_value[4]~3_combout\ & ((\b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\) # (\b2v_alu|b_value\(4) $ (\f0~input_o\)))) # (!\b2v_alu|a_value[4]~3_combout\ & 
-- (\b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\ & (\b2v_alu|b_value\(4) $ (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|b_value\(4),
	datab => \b2v_alu|a_value[4]~3_combout\,
	datac => \f0~input_o\,
	datad => \b2v_alu|adder_subtractor0|full_adder3|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\);

-- Location: LCCOMB_X16_Y20_N18
\b2v_alu|adder_subtractor0|full_adder5|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder5|s~combout\ = \f0~input_o\ $ (\b2v_alu|b_value\(5) $ (\b2v_alu|a_value[5]~4_combout\ $ (\b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f0~input_o\,
	datab => \b2v_alu|b_value\(5),
	datac => \b2v_alu|a_value[5]~4_combout\,
	datad => \b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder5|s~combout\);

-- Location: FF_X16_Y20_N19
\b2v_alu_register|q_internal[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder5|s~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(5));

-- Location: FF_X18_Y20_N3
\b2v_MBR|q_internal[5]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[5]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(5));

-- Location: LCCOMB_X18_Y20_N2
\b2v_pc_buffer|data_out[5]~26\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[5]~26_combout\ = (\embr~input_o\ & (\b2v_MBR|q_internal\(5) & ((\b2v_alu_register|q_internal\(5)) # (!\ealu~input_o\)))) # (!\embr~input_o\ & ((\b2v_alu_register|q_internal\(5)) # ((!\ealu~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \b2v_alu_register|q_internal\(5),
	datac => \b2v_MBR|q_internal\(5),
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[5]~26_combout\);

-- Location: LCCOMB_X14_Y20_N16
\b2v_pc_buffer|data_out[5]~27\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[5]~27_combout\ = (!\epc~input_o\ & (\b2v_pc_buffer|data_out[5]~25_combout\ & \b2v_pc_buffer|data_out[5]~26_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \epc~input_o\,
	datac => \b2v_pc_buffer|data_out[5]~25_combout\,
	datad => \b2v_pc_buffer|data_out[5]~26_combout\,
	combout => \b2v_pc_buffer|data_out[5]~27_combout\);

-- Location: IOIBUF_X10_Y20_N22
\data_bus[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(6),
	o => \data_bus[6]~input_o\);

-- Location: FF_X15_Y20_N7
\b2v_D0|q_internal[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[6]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(6));

-- Location: LCCOMB_X15_Y20_N12
\b2v_alu|a_value[6]~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|a_value[6]~5_combout\ = (\f1~input_o\ & (\data_bus[6]~input_o\)) # (!\f1~input_o\ & ((\b2v_D0|q_internal\(6))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101110001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \data_bus[6]~input_o\,
	datab => \f1~input_o\,
	datad => \b2v_D0|q_internal\(6),
	combout => \b2v_alu|a_value[6]~5_combout\);

-- Location: LCCOMB_X15_Y20_N20
\b2v_alu|b_value[6]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|b_value\(6) = (!\f1~input_o\ & \data_bus[6]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datac => \data_bus[6]~input_o\,
	combout => \b2v_alu|b_value\(6));

-- Location: LCCOMB_X16_Y20_N28
\b2v_alu|adder_subtractor0|full_adder5|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\ = (\b2v_alu|a_value[5]~4_combout\ & ((\b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\) # (\f0~input_o\ $ (\b2v_alu|b_value\(5))))) # (!\b2v_alu|a_value[5]~4_combout\ & 
-- (\b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\ & (\f0~input_o\ $ (\b2v_alu|b_value\(5)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111011001100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f0~input_o\,
	datab => \b2v_alu|b_value\(5),
	datac => \b2v_alu|a_value[5]~4_combout\,
	datad => \b2v_alu|adder_subtractor0|full_adder4|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\);

-- Location: LCCOMB_X16_Y20_N14
\b2v_alu|adder_subtractor0|full_adder6|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder6|s~combout\ = \b2v_alu|a_value[6]~5_combout\ $ (\f0~input_o\ $ (\b2v_alu|b_value\(6) $ (\b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|a_value[6]~5_combout\,
	datab => \f0~input_o\,
	datac => \b2v_alu|b_value\(6),
	datad => \b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder6|s~combout\);

-- Location: FF_X16_Y20_N15
\b2v_alu_register|q_internal[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder6|s~combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(6));

-- Location: FF_X18_Y20_N13
\b2v_MBR|q_internal[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[6]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(6));

-- Location: LCCOMB_X18_Y20_N12
\b2v_pc_buffer|data_out[6]~29\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[6]~29_combout\ = (\embr~input_o\ & (\b2v_MBR|q_internal\(6) & ((\b2v_alu_register|q_internal\(6)) # (!\ealu~input_o\)))) # (!\embr~input_o\ & ((\b2v_alu_register|q_internal\(6)) # ((!\ealu~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \b2v_alu_register|q_internal\(6),
	datac => \b2v_MBR|q_internal\(6),
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[6]~29_combout\);

-- Location: FF_X14_Y20_N29
\b2v_IR|q_internal[6]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[6]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(6));

-- Location: LCCOMB_X14_Y20_N28
\b2v_pc_buffer|data_out[6]~28\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[6]~28_combout\ = (\ed0~input_o\ & (\b2v_D0|q_internal\(6) & ((\b2v_IR|q_internal\(6)) # (!\eir~input_o\)))) # (!\ed0~input_o\ & (((\b2v_IR|q_internal\(6))) # (!\eir~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001101010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ed0~input_o\,
	datab => \eir~input_o\,
	datac => \b2v_IR|q_internal\(6),
	datad => \b2v_D0|q_internal\(6),
	combout => \b2v_pc_buffer|data_out[6]~28_combout\);

-- Location: LCCOMB_X14_Y20_N22
\b2v_pc_buffer|data_out[6]~30\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[6]~30_combout\ = (!\epc~input_o\ & (\b2v_pc_buffer|data_out[6]~29_combout\ & \b2v_pc_buffer|data_out[6]~28_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \epc~input_o\,
	datac => \b2v_pc_buffer|data_out[6]~29_combout\,
	datad => \b2v_pc_buffer|data_out[6]~28_combout\,
	combout => \b2v_pc_buffer|data_out[6]~30_combout\);

-- Location: IOIBUF_X10_Y20_N8
\data_bus[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => data_bus(7),
	o => \data_bus[7]~input_o\);

-- Location: LCCOMB_X15_Y20_N26
\b2v_D0|q_internal[7]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_D0|q_internal[7]~feeder_combout\ = \data_bus[7]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \data_bus[7]~input_o\,
	combout => \b2v_D0|q_internal[7]~feeder_combout\);

-- Location: FF_X15_Y20_N27
\b2v_D0|q_internal[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_D0|q_internal[7]~feeder_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \cd0~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_D0|q_internal\(7));

-- Location: LCCOMB_X16_Y20_N24
\b2v_alu|adder_subtractor0|full_adder7|s~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder7|s~0_combout\ = (\b2v_alu|a_value[6]~5_combout\ & ((\b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\ & (!\f0~input_o\)) # (!\b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\ & ((\b2v_alu|b_value\(6)))))) # 
-- (!\b2v_alu|a_value[6]~5_combout\ & ((\b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\ & ((\b2v_alu|b_value\(6)))) # (!\b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\ & (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0111001011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|a_value[6]~5_combout\,
	datab => \f0~input_o\,
	datac => \b2v_alu|b_value\(6),
	datad => \b2v_alu|adder_subtractor0|full_adder5|cout~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder7|s~0_combout\);

-- Location: LCCOMB_X16_Y20_N6
\b2v_alu|adder_subtractor0|full_adder7|s~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|adder_subtractor0|full_adder7|s~1_combout\ = \data_bus[7]~input_o\ $ (\b2v_alu|adder_subtractor0|full_adder7|s~0_combout\ $ (((!\f1~input_o\ & \b2v_D0|q_internal\(7)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110001110011100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \data_bus[7]~input_o\,
	datac => \b2v_D0|q_internal\(7),
	datad => \b2v_alu|adder_subtractor0|full_adder7|s~0_combout\,
	combout => \b2v_alu|adder_subtractor0|full_adder7|s~1_combout\);

-- Location: FF_X16_Y20_N7
\b2v_alu_register|q_internal[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_alu|adder_subtractor0|full_adder7|s~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \calu~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_alu_register|q_internal\(7));

-- Location: FF_X18_Y20_N15
\b2v_MBR|q_internal[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[7]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmbr~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MBR|q_internal\(7));

-- Location: LCCOMB_X18_Y20_N14
\b2v_pc_buffer|data_out[7]~32\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[7]~32_combout\ = (\embr~input_o\ & (\b2v_MBR|q_internal\(7) & ((\b2v_alu_register|q_internal\(7)) # (!\ealu~input_o\)))) # (!\embr~input_o\ & ((\b2v_alu_register|q_internal\(7)) # ((!\ealu~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100010011110101",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \embr~input_o\,
	datab => \b2v_alu_register|q_internal\(7),
	datac => \b2v_MBR|q_internal\(7),
	datad => \ealu~input_o\,
	combout => \b2v_pc_buffer|data_out[7]~32_combout\);

-- Location: FF_X14_Y20_N19
\b2v_IR|q_internal[7]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[7]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cir~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_IR|q_internal\(7));

-- Location: LCCOMB_X14_Y20_N18
\b2v_pc_buffer|data_out[7]~31\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[7]~31_combout\ = (\ed0~input_o\ & (\b2v_D0|q_internal\(7) & ((\b2v_IR|q_internal\(7)) # (!\eir~input_o\)))) # (!\ed0~input_o\ & (((\b2v_IR|q_internal\(7))) # (!\eir~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111001101010001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \ed0~input_o\,
	datab => \eir~input_o\,
	datac => \b2v_IR|q_internal\(7),
	datad => \b2v_D0|q_internal\(7),
	combout => \b2v_pc_buffer|data_out[7]~31_combout\);

-- Location: LCCOMB_X14_Y20_N24
\b2v_pc_buffer|data_out[7]~33\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_pc_buffer|data_out[7]~33_combout\ = (!\epc~input_o\ & (\b2v_pc_buffer|data_out[7]~32_combout\ & \b2v_pc_buffer|data_out[7]~31_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \epc~input_o\,
	datac => \b2v_pc_buffer|data_out[7]~32_combout\,
	datad => \b2v_pc_buffer|data_out[7]~31_combout\,
	combout => \b2v_pc_buffer|data_out[7]~33_combout\);

-- Location: LCCOMB_X14_Y20_N20
\b2v_alu|Z~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|Z~1_combout\ = (\b2v_alu|adder_subtractor0|full_adder5|s~combout\) # (\b2v_alu|adder_subtractor0|full_adder6|s~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111110000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \b2v_alu|adder_subtractor0|full_adder5|s~combout\,
	datad => \b2v_alu|adder_subtractor0|full_adder6|s~combout\,
	combout => \b2v_alu|Z~1_combout\);

-- Location: LCCOMB_X15_Y20_N2
\b2v_alu|Z~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|Z~0_combout\ = (\b2v_alu|adder_subtractor0|full_adder4|s~combout\) # ((\b2v_alu|adder_subtractor0|full_adder3|s~combout\) # ((\b2v_alu|adder_subtractor0|full_adder1|s~combout\) # (\b2v_alu|adder_subtractor0|full_adder2|s~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|adder_subtractor0|full_adder4|s~combout\,
	datab => \b2v_alu|adder_subtractor0|full_adder3|s~combout\,
	datac => \b2v_alu|adder_subtractor0|full_adder1|s~combout\,
	datad => \b2v_alu|adder_subtractor0|full_adder2|s~combout\,
	combout => \b2v_alu|Z~0_combout\);

-- Location: LCCOMB_X14_Y20_N12
\b2v_alu|Z~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_alu|Z~2_combout\ = (\b2v_alu|adder_subtractor0|full_adder7|s~1_combout\) # ((\b2v_alu|Z~1_combout\) # ((\b2v_alu|adder_subtractor0|full_adder0|s~combout\) # (\b2v_alu|Z~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \b2v_alu|adder_subtractor0|full_adder7|s~1_combout\,
	datab => \b2v_alu|Z~1_combout\,
	datac => \b2v_alu|adder_subtractor0|full_adder0|s~combout\,
	datad => \b2v_alu|Z~0_combout\,
	combout => \b2v_alu|Z~2_combout\);

-- Location: IOIBUF_X10_Y19_N8
\cmar~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_cmar,
	o => \cmar~input_o\);

-- Location: FF_X15_Y20_N1
\b2v_MAR|q_internal[0]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[0]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmar~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MAR|q_internal\(0));

-- Location: LCCOMB_X15_Y20_N30
\b2v_MAR|q_internal[1]~feeder\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \b2v_MAR|q_internal[1]~feeder_combout\ = \data_bus[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \data_bus[1]~input_o\,
	combout => \b2v_MAR|q_internal[1]~feeder_combout\);

-- Location: FF_X15_Y20_N31
\b2v_MAR|q_internal[1]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \b2v_MAR|q_internal[1]~feeder_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	ena => \cmar~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MAR|q_internal\(1));

-- Location: FF_X15_Y20_N17
\b2v_MAR|q_internal[2]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[2]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmar~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MAR|q_internal\(2));

-- Location: FF_X15_Y20_N23
\b2v_MAR|q_internal[3]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[3]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmar~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MAR|q_internal\(3));

-- Location: FF_X15_Y20_N29
\b2v_MAR|q_internal[4]\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	asdata => \data_bus[4]~input_o\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	sload => VCC,
	ena => \cmar~input_o\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \b2v_MAR|q_internal\(4));

-- Location: UNVM_X0_Y11_N40
\~QUARTUS_CREATED_UNVM~\ : fiftyfivenm_unvm
-- pragma translate_off
GENERIC MAP (
	addr_range1_end_addr => -1,
	addr_range1_offset => -1,
	addr_range2_end_addr => -1,
	addr_range2_offset => -1,
	addr_range3_offset => -1,
	is_compressed_image => "false",
	is_dual_boot => "false",
	is_eram_skip => "false",
	max_ufm_valid_addr => -1,
	max_valid_addr => -1,
	min_ufm_valid_addr => -1,
	min_valid_addr => -1,
	part_name => "quartus_created_unvm",
	reserve_block => "true")
-- pragma translate_on
PORT MAP (
	nosc_ena => \~QUARTUS_CREATED_GND~I_combout\,
	xe_ye => \~QUARTUS_CREATED_GND~I_combout\,
	se => \~QUARTUS_CREATED_GND~I_combout\,
	busy => \~QUARTUS_CREATED_UNVM~~busy\);

-- Location: ADCBLOCK_X10_Y24_N0
\~QUARTUS_CREATED_ADC1~\ : fiftyfivenm_adcblock
-- pragma translate_off
GENERIC MAP (
	analog_input_pin_mask => 0,
	clkdiv => 1,
	device_partname_fivechar_prefix => "none",
	is_this_first_or_second_adc => 1,
	prescalar => 0,
	pwd => 1,
	refsel => 0,
	reserve_block => "true",
	testbits => 66,
	tsclkdiv => 1,
	tsclksel => 0)
-- pragma translate_on
PORT MAP (
	soc => \~QUARTUS_CREATED_GND~I_combout\,
	usr_pwd => VCC,
	tsen => \~QUARTUS_CREATED_GND~I_combout\,
	chsel => \~QUARTUS_CREATED_ADC1~_CHSEL_bus\,
	eoc => \~QUARTUS_CREATED_ADC1~~eoc\);

ww_Z <= \Z~output_o\;

ww_address_bus(0) <= \address_bus[0]~output_o\;

ww_address_bus(1) <= \address_bus[1]~output_o\;

ww_address_bus(2) <= \address_bus[2]~output_o\;

ww_address_bus(3) <= \address_bus[3]~output_o\;

ww_address_bus(4) <= \address_bus[4]~output_o\;

ww_opcode(0) <= \opcode[0]~output_o\;

ww_opcode(1) <= \opcode[1]~output_o\;

ww_opcode(2) <= \opcode[2]~output_o\;

data_bus(0) <= \data_bus[0]~output_o\;

data_bus(1) <= \data_bus[1]~output_o\;

data_bus(2) <= \data_bus[2]~output_o\;

data_bus(3) <= \data_bus[3]~output_o\;

data_bus(4) <= \data_bus[4]~output_o\;

data_bus(5) <= \data_bus[5]~output_o\;

data_bus(6) <= \data_bus[6]~output_o\;

data_bus(7) <= \data_bus[7]~output_o\;
END structure;


