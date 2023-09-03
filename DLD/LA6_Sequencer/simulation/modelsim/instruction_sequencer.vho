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

-- DATE "11/05/2022 18:12:30"

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

ENTITY 	instruction_sequencer IS
    PORT (
	opcode : IN std_logic_vector(2 DOWNTO 0);
	reset : IN std_logic;
	clock : IN std_logic;
	t0 : OUT std_logic;
	t1 : OUT std_logic;
	t2 : OUT std_logic;
	t3 : OUT std_logic;
	t4 : OUT std_logic;
	t5 : OUT std_logic;
	t6 : OUT std_logic;
	t7 : OUT std_logic;
	execute : OUT std_logic
	);
END instruction_sequencer;

-- Design Ports Information
-- opcode[0]	=>  Location: PIN_W17,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t0	=>  Location: PIN_AB4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t1	=>  Location: PIN_W3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t2	=>  Location: PIN_AA2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t3	=>  Location: PIN_W7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t4	=>  Location: PIN_Y3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t5	=>  Location: PIN_W4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t6	=>  Location: PIN_W8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t7	=>  Location: PIN_Y4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- execute	=>  Location: PIN_AA3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[2]	=>  Location: PIN_R10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[1]	=>  Location: PIN_P10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- reset	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF instruction_sequencer IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_opcode : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_reset : std_logic;
SIGNAL ww_clock : std_logic;
SIGNAL ww_t0 : std_logic;
SIGNAL ww_t1 : std_logic;
SIGNAL ww_t2 : std_logic;
SIGNAL ww_t3 : std_logic;
SIGNAL ww_t4 : std_logic;
SIGNAL ww_t5 : std_logic;
SIGNAL ww_t6 : std_logic;
SIGNAL ww_t7 : std_logic;
SIGNAL ww_execute : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \reset~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \clock~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \opcode[0]~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \t0~output_o\ : std_logic;
SIGNAL \t1~output_o\ : std_logic;
SIGNAL \t2~output_o\ : std_logic;
SIGNAL \t3~output_o\ : std_logic;
SIGNAL \t4~output_o\ : std_logic;
SIGNAL \t5~output_o\ : std_logic;
SIGNAL \t6~output_o\ : std_logic;
SIGNAL \t7~output_o\ : std_logic;
SIGNAL \execute~output_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \clock~inputclkctrl_outclk\ : std_logic;
SIGNAL \opcode[2]~input_o\ : std_logic;
SIGNAL \opcode[1]~input_o\ : std_logic;
SIGNAL \q0_next~0_combout\ : std_logic;
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \q0_ff|q~q\ : std_logic;
SIGNAL \q1_next~0_combout\ : std_logic;
SIGNAL \q1_next~1_combout\ : std_logic;
SIGNAL \q1_ff|q~q\ : std_logic;
SIGNAL \q2_next~0_combout\ : std_logic;
SIGNAL \q2_next~1_combout\ : std_logic;
SIGNAL \q2_ff|q~q\ : std_logic;
SIGNAL \t0~0_combout\ : std_logic;
SIGNAL \t1~0_combout\ : std_logic;
SIGNAL \t2~0_combout\ : std_logic;
SIGNAL \t3~0_combout\ : std_logic;
SIGNAL \t4~0_combout\ : std_logic;
SIGNAL \t5~0_combout\ : std_logic;
SIGNAL \t6~0_combout\ : std_logic;
SIGNAL \t7~0_combout\ : std_logic;
SIGNAL \ALT_INV_reset~inputclkctrl_outclk\ : std_logic;
SIGNAL \ALT_INV_t0~0_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_opcode <= opcode;
ww_reset <= reset;
ww_clock <= clock;
t0 <= ww_t0;
t1 <= ww_t1;
t2 <= ww_t2;
t3 <= ww_t3;
t4 <= ww_t4;
t5 <= ww_t5;
t6 <= ww_t6;
t7 <= ww_t7;
execute <= ww_execute;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);

\reset~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \reset~input_o\);

\clock~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clock~input_o\);
\ALT_INV_reset~inputclkctrl_outclk\ <= NOT \reset~inputclkctrl_outclk\;
\ALT_INV_t0~0_combout\ <= NOT \t0~0_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X11_Y13_N16
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

-- Location: IOOBUF_X11_Y0_N16
\t0~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_t0~0_combout\,
	devoe => ww_devoe,
	o => \t0~output_o\);

-- Location: IOOBUF_X9_Y0_N23
\t1~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t1~0_combout\,
	devoe => ww_devoe,
	o => \t1~output_o\);

-- Location: IOOBUF_X6_Y0_N2
\t2~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t2~0_combout\,
	devoe => ww_devoe,
	o => \t2~output_o\);

-- Location: IOOBUF_X9_Y0_N2
\t3~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t3~0_combout\,
	devoe => ww_devoe,
	o => \t3~output_o\);

-- Location: IOOBUF_X9_Y0_N16
\t4~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t4~0_combout\,
	devoe => ww_devoe,
	o => \t4~output_o\);

-- Location: IOOBUF_X9_Y0_N30
\t5~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t5~0_combout\,
	devoe => ww_devoe,
	o => \t5~output_o\);

-- Location: IOOBUF_X11_Y0_N30
\t6~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t6~0_combout\,
	devoe => ww_devoe,
	o => \t6~output_o\);

-- Location: IOOBUF_X9_Y0_N9
\t7~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t7~0_combout\,
	devoe => ww_devoe,
	o => \t7~output_o\);

-- Location: IOOBUF_X11_Y0_N23
\execute~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \q2_ff|q~q\,
	devoe => ww_devoe,
	o => \execute~output_o\);

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

-- Location: IOIBUF_X11_Y0_N8
\opcode[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_opcode(2),
	o => \opcode[2]~input_o\);

-- Location: IOIBUF_X11_Y0_N1
\opcode[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_opcode(1),
	o => \opcode[1]~input_o\);

-- Location: LCCOMB_X10_Y1_N22
\q0_next~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \q0_next~0_combout\ = (!\q0_ff|q~q\ & (((!\q2_ff|q~q\) # (!\opcode[1]~input_o\)) # (!\opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000011100001111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[2]~input_o\,
	datab => \opcode[1]~input_o\,
	datac => \q0_ff|q~q\,
	datad => \q2_ff|q~q\,
	combout => \q0_next~0_combout\);

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

-- Location: FF_X10_Y1_N23
\q0_ff|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \q0_next~0_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \q0_ff|q~q\);

-- Location: LCCOMB_X10_Y1_N28
\q1_next~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \q1_next~0_combout\ = (\opcode[2]~input_o\) # ((\opcode[1]~input_o\) # (!\q2_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110111011111111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[2]~input_o\,
	datab => \opcode[1]~input_o\,
	datad => \q2_ff|q~q\,
	combout => \q1_next~0_combout\);

-- Location: LCCOMB_X10_Y1_N24
\q1_next~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \q1_next~1_combout\ = (\q0_ff|q~q\ & (!\q1_ff|q~q\ & \q1_next~0_combout\)) # (!\q0_ff|q~q\ & (\q1_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q0_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q1_next~0_combout\,
	combout => \q1_next~1_combout\);

-- Location: FF_X10_Y1_N25
\q1_ff|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \q1_next~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \q1_ff|q~q\);

-- Location: LCCOMB_X10_Y1_N2
\q2_next~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \q2_next~0_combout\ = (\q1_ff|q~q\ & (((!\q0_ff|q~q\)))) # (!\q1_ff|q~q\ & ((\opcode[2]~input_o\ & (!\opcode[1]~input_o\)) # (!\opcode[2]~input_o\ & ((\opcode[1]~input_o\) # (!\q0_ff|q~q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111101100111",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[2]~input_o\,
	datab => \opcode[1]~input_o\,
	datac => \q0_ff|q~q\,
	datad => \q1_ff|q~q\,
	combout => \q2_next~0_combout\);

-- Location: LCCOMB_X10_Y1_N20
\q2_next~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \q2_next~1_combout\ = (\q2_ff|q~q\ & (((\q2_next~0_combout\)))) # (!\q2_ff|q~q\ & (\q1_ff|q~q\ & (\q0_ff|q~q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q1_ff|q~q\,
	datab => \q0_ff|q~q\,
	datac => \q2_ff|q~q\,
	datad => \q2_next~0_combout\,
	combout => \q2_next~1_combout\);

-- Location: FF_X10_Y1_N21
\q2_ff|q\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clock~inputclkctrl_outclk\,
	d => \q2_next~1_combout\,
	clrn => \ALT_INV_reset~inputclkctrl_outclk\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \q2_ff|q~q\);

-- Location: LCCOMB_X10_Y1_N18
\t0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t0~0_combout\ = (\q2_ff|q~q\) # ((\q1_ff|q~q\) # (\q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t0~0_combout\);

-- Location: LCCOMB_X10_Y1_N0
\t1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t1~0_combout\ = (!\q2_ff|q~q\ & (!\q1_ff|q~q\ & \q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t1~0_combout\);

-- Location: LCCOMB_X10_Y1_N26
\t2~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t2~0_combout\ = (!\q2_ff|q~q\ & (\q1_ff|q~q\ & !\q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t2~0_combout\);

-- Location: LCCOMB_X10_Y1_N12
\t3~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t3~0_combout\ = (!\q2_ff|q~q\ & (\q1_ff|q~q\ & \q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t3~0_combout\);

-- Location: LCCOMB_X10_Y1_N30
\t4~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t4~0_combout\ = (\q2_ff|q~q\ & (!\q1_ff|q~q\ & !\q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t4~0_combout\);

-- Location: LCCOMB_X10_Y1_N8
\t5~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t5~0_combout\ = (\q2_ff|q~q\ & (!\q1_ff|q~q\ & \q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000101000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t5~0_combout\);

-- Location: LCCOMB_X10_Y1_N6
\t6~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t6~0_combout\ = (\q2_ff|q~q\ & (\q1_ff|q~q\ & !\q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t6~0_combout\);

-- Location: LCCOMB_X10_Y1_N16
\t7~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \t7~0_combout\ = (\q2_ff|q~q\ & (\q1_ff|q~q\ & \q0_ff|q~q\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \q2_ff|q~q\,
	datac => \q1_ff|q~q\,
	datad => \q0_ff|q~q\,
	combout => \t7~0_combout\);

-- Location: IOIBUF_X29_Y0_N8
\opcode[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_opcode(0),
	o => \opcode[0]~input_o\);

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

ww_t0 <= \t0~output_o\;

ww_t1 <= \t1~output_o\;

ww_t2 <= \t2~output_o\;

ww_t3 <= \t3~output_o\;

ww_t4 <= \t4~output_o\;

ww_t5 <= \t5~output_o\;

ww_t6 <= \t6~output_o\;

ww_t7 <= \t7~output_o\;

ww_execute <= \execute~output_o\;
END structure;


