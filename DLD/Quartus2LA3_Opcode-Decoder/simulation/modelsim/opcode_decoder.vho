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

-- DATE "09/26/2022 19:23:25"

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


LIBRARY FIFTYFIVENM;
LIBRARY IEEE;
USE FIFTYFIVENM.FIFTYFIVENM_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	opcode_decoder IS
    PORT (
	execute : IN std_logic;
	opcode : IN std_logic_vector(2 DOWNTO 0);
	load : BUFFER std_logic;
	store : BUFFER std_logic;
	add : BUFFER std_logic;
	sub : BUFFER std_logic;
	inc : BUFFER std_logic;
	dec : BUFFER std_logic;
	bra : BUFFER std_logic;
	beq : BUFFER std_logic
	);
END opcode_decoder;

-- Design Ports Information
-- load	=>  Location: PIN_R2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- store	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- add	=>  Location: PIN_T5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sub	=>  Location: PIN_T1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inc	=>  Location: PIN_R1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dec	=>  Location: PIN_R3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- bra	=>  Location: PIN_N9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- beq	=>  Location: PIN_T6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- execute	=>  Location: PIN_W6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[0]	=>  Location: PIN_Y1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[1]	=>  Location: PIN_W5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- opcode[2]	=>  Location: PIN_B2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF opcode_decoder IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_execute : std_logic;
SIGNAL ww_opcode : std_logic_vector(2 DOWNTO 0);
SIGNAL ww_load : std_logic;
SIGNAL ww_store : std_logic;
SIGNAL ww_add : std_logic;
SIGNAL ww_sub : std_logic;
SIGNAL ww_inc : std_logic;
SIGNAL ww_dec : std_logic;
SIGNAL ww_bra : std_logic;
SIGNAL ww_beq : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \load~output_o\ : std_logic;
SIGNAL \store~output_o\ : std_logic;
SIGNAL \add~output_o\ : std_logic;
SIGNAL \sub~output_o\ : std_logic;
SIGNAL \inc~output_o\ : std_logic;
SIGNAL \dec~output_o\ : std_logic;
SIGNAL \bra~output_o\ : std_logic;
SIGNAL \beq~output_o\ : std_logic;
SIGNAL \opcode[1]~input_o\ : std_logic;
SIGNAL \execute~input_o\ : std_logic;
SIGNAL \opcode[0]~input_o\ : std_logic;
SIGNAL \opcode[2]~input_o\ : std_logic;
SIGNAL \load~0_combout\ : std_logic;
SIGNAL \store~0_combout\ : std_logic;
SIGNAL \add~0_combout\ : std_logic;
SIGNAL \sub~0_combout\ : std_logic;
SIGNAL \inc~0_combout\ : std_logic;
SIGNAL \dec~0_combout\ : std_logic;
SIGNAL \bra~0_combout\ : std_logic;
SIGNAL \beq~0_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_execute <= execute;
ww_opcode <= opcode;
load <= ww_load;
store <= ww_store;
add <= ww_add;
sub <= ww_sub;
inc <= ww_inc;
dec <= ww_dec;
bra <= ww_bra;
beq <= ww_beq;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X11_Y21_N16
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

-- Location: IOOBUF_X0_Y2_N9
\load~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \load~0_combout\,
	devoe => ww_devoe,
	o => \load~output_o\);

-- Location: IOOBUF_X6_Y10_N30
\store~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \store~0_combout\,
	devoe => ww_devoe,
	o => \store~output_o\);

-- Location: IOOBUF_X0_Y2_N16
\add~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \add~0_combout\,
	devoe => ww_devoe,
	o => \add~output_o\);

-- Location: IOOBUF_X0_Y4_N2
\sub~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \sub~0_combout\,
	devoe => ww_devoe,
	o => \sub~output_o\);

-- Location: IOOBUF_X0_Y2_N2
\inc~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \inc~0_combout\,
	devoe => ww_devoe,
	o => \inc~output_o\);

-- Location: IOOBUF_X0_Y5_N23
\dec~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \dec~0_combout\,
	devoe => ww_devoe,
	o => \dec~output_o\);

-- Location: IOOBUF_X0_Y3_N23
\bra~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \bra~0_combout\,
	devoe => ww_devoe,
	o => \bra~output_o\);

-- Location: IOOBUF_X0_Y2_N23
\beq~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \beq~0_combout\,
	devoe => ww_devoe,
	o => \beq~output_o\);

-- Location: IOIBUF_X3_Y0_N15
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

-- Location: IOIBUF_X3_Y0_N8
\execute~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_execute,
	o => \execute~input_o\);

-- Location: IOIBUF_X3_Y0_N1
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

-- Location: IOIBUF_X3_Y10_N29
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

-- Location: LCCOMB_X2_Y2_N24
\load~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \load~0_combout\ = (!\opcode[1]~input_o\ & (\execute~input_o\ & (!\opcode[0]~input_o\ & !\opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \load~0_combout\);

-- Location: LCCOMB_X2_Y2_N10
\store~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \store~0_combout\ = (!\opcode[1]~input_o\ & (\execute~input_o\ & (\opcode[0]~input_o\ & !\opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000001000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \store~0_combout\);

-- Location: LCCOMB_X2_Y2_N4
\add~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \add~0_combout\ = (\opcode[1]~input_o\ & (\execute~input_o\ & (!\opcode[0]~input_o\ & !\opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \add~0_combout\);

-- Location: LCCOMB_X2_Y2_N22
\sub~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \sub~0_combout\ = (\opcode[1]~input_o\ & (\execute~input_o\ & (\opcode[0]~input_o\ & !\opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \sub~0_combout\);

-- Location: LCCOMB_X2_Y2_N0
\inc~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \inc~0_combout\ = (!\opcode[1]~input_o\ & (\execute~input_o\ & (!\opcode[0]~input_o\ & \opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \inc~0_combout\);

-- Location: LCCOMB_X2_Y2_N2
\dec~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \dec~0_combout\ = (!\opcode[1]~input_o\ & (\execute~input_o\ & (\opcode[0]~input_o\ & \opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \dec~0_combout\);

-- Location: LCCOMB_X2_Y2_N12
\bra~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \bra~0_combout\ = (\opcode[1]~input_o\ & (\execute~input_o\ & (!\opcode[0]~input_o\ & \opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \bra~0_combout\);

-- Location: LCCOMB_X2_Y2_N6
\beq~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \beq~0_combout\ = (\opcode[1]~input_o\ & (\execute~input_o\ & (\opcode[0]~input_o\ & \opcode[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \opcode[1]~input_o\,
	datab => \execute~input_o\,
	datac => \opcode[0]~input_o\,
	datad => \opcode[2]~input_o\,
	combout => \beq~0_combout\);

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

ww_load <= \load~output_o\;

ww_store <= \store~output_o\;

ww_add <= \add~output_o\;

ww_sub <= \sub~output_o\;

ww_inc <= \inc~output_o\;

ww_dec <= \dec~output_o\;

ww_bra <= \bra~output_o\;

ww_beq <= \beq~output_o\;
END structure;


