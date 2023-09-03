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

-- DATE "10/15/2022 17:27:24"

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

ENTITY 	alu IS
    PORT (
	p : IN std_logic_vector(7 DOWNTO 0);
	q : IN std_logic_vector(7 DOWNTO 0);
	f0 : IN std_logic;
	f1 : IN std_logic;
	alu_out : BUFFER std_logic_vector(7 DOWNTO 0);
	Z : BUFFER std_logic
	);
END alu;

-- Design Ports Information
-- alu_out[0]	=>  Location: PIN_F2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_out[1]	=>  Location: PIN_K2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_out[2]	=>  Location: PIN_B4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_out[3]	=>  Location: PIN_L8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_out[4]	=>  Location: PIN_J1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_out[5]	=>  Location: PIN_B1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_out[6]	=>  Location: PIN_C4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- alu_out[7]	=>  Location: PIN_P5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Z	=>  Location: PIN_M2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- f1	=>  Location: PIN_AB4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[0]	=>  Location: PIN_C3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[0]	=>  Location: PIN_E1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- f0	=>  Location: PIN_C2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[1]	=>  Location: PIN_L9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[1]	=>  Location: PIN_E8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[2]	=>  Location: PIN_K6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[2]	=>  Location: PIN_AA3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[3]	=>  Location: PIN_V5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[3]	=>  Location: PIN_D5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[4]	=>  Location: PIN_F7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[4]	=>  Location: PIN_W8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[5]	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[5]	=>  Location: PIN_B5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[6]	=>  Location: PIN_M8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[6]	=>  Location: PIN_P4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- p[7]	=>  Location: PIN_N3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- q[7]	=>  Location: PIN_N2,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF alu IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_p : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_q : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_f0 : std_logic;
SIGNAL ww_f1 : std_logic;
SIGNAL ww_alu_out : std_logic_vector(7 DOWNTO 0);
SIGNAL ww_Z : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \alu_out[0]~output_o\ : std_logic;
SIGNAL \alu_out[1]~output_o\ : std_logic;
SIGNAL \alu_out[2]~output_o\ : std_logic;
SIGNAL \alu_out[3]~output_o\ : std_logic;
SIGNAL \alu_out[4]~output_o\ : std_logic;
SIGNAL \alu_out[5]~output_o\ : std_logic;
SIGNAL \alu_out[6]~output_o\ : std_logic;
SIGNAL \alu_out[7]~output_o\ : std_logic;
SIGNAL \Z~output_o\ : std_logic;
SIGNAL \f1~input_o\ : std_logic;
SIGNAL \p[0]~input_o\ : std_logic;
SIGNAL \q[0]~input_o\ : std_logic;
SIGNAL \adder_subtractor0|full_adder0|s~combout\ : std_logic;
SIGNAL \q[1]~input_o\ : std_logic;
SIGNAL \p[1]~input_o\ : std_logic;
SIGNAL \a_value[1]~0_combout\ : std_logic;
SIGNAL \f0~input_o\ : std_logic;
SIGNAL \adder_subtractor0|full_adder0|cout~0_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder1|s~combout\ : std_logic;
SIGNAL \q[2]~input_o\ : std_logic;
SIGNAL \adder_subtractor0|full_adder1|cout~0_combout\ : std_logic;
SIGNAL \p[2]~input_o\ : std_logic;
SIGNAL \a_value[2]~1_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder2|s~combout\ : std_logic;
SIGNAL \q[3]~input_o\ : std_logic;
SIGNAL \p[3]~input_o\ : std_logic;
SIGNAL \a_value[3]~2_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder2|cout~0_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder3|s~combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder3|cout~0_combout\ : std_logic;
SIGNAL \q[4]~input_o\ : std_logic;
SIGNAL \p[4]~input_o\ : std_logic;
SIGNAL \a_value[4]~3_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder4|s~combout\ : std_logic;
SIGNAL \q[5]~input_o\ : std_logic;
SIGNAL \p[5]~input_o\ : std_logic;
SIGNAL \a_value[5]~4_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder4|cout~0_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder5|s~combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder5|cout~0_combout\ : std_logic;
SIGNAL \q[6]~input_o\ : std_logic;
SIGNAL \p[6]~input_o\ : std_logic;
SIGNAL \a_value[6]~5_combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder6|s~combout\ : std_logic;
SIGNAL \adder_subtractor0|full_adder7|s~0_combout\ : std_logic;
SIGNAL \p[7]~input_o\ : std_logic;
SIGNAL \q[7]~input_o\ : std_logic;
SIGNAL \adder_subtractor0|full_adder7|s~1_combout\ : std_logic;
SIGNAL \Z~1_combout\ : std_logic;
SIGNAL \Z~0_combout\ : std_logic;
SIGNAL \Z~2_combout\ : std_logic;
SIGNAL b_value : std_logic_vector(7 DOWNTO 0);
SIGNAL \ALT_INV_Z~2_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_p <= p;
ww_q <= q;
ww_f0 <= f0;
ww_f1 <= f1;
alu_out <= ww_alu_out;
Z <= ww_Z;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
\ALT_INV_Z~2_combout\ <= NOT \Z~2_combout\;
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X11_Y14_N16
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

-- Location: IOOBUF_X10_Y15_N9
\alu_out[0]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder0|s~combout\,
	devoe => ww_devoe,
	o => \alu_out[0]~output_o\);

-- Location: IOOBUF_X10_Y16_N2
\alu_out[1]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder1|s~combout\,
	devoe => ww_devoe,
	o => \alu_out[1]~output_o\);

-- Location: IOOBUF_X6_Y10_N2
\alu_out[2]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder2|s~combout\,
	devoe => ww_devoe,
	o => \alu_out[2]~output_o\);

-- Location: IOOBUF_X10_Y15_N16
\alu_out[3]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder3|s~combout\,
	devoe => ww_devoe,
	o => \alu_out[3]~output_o\);

-- Location: IOOBUF_X0_Y8_N23
\alu_out[4]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder4|s~combout\,
	devoe => ww_devoe,
	o => \alu_out[4]~output_o\);

-- Location: IOOBUF_X1_Y10_N2
\alu_out[5]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder5|s~combout\,
	devoe => ww_devoe,
	o => \alu_out[5]~output_o\);

-- Location: IOOBUF_X6_Y10_N16
\alu_out[6]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder6|s~combout\,
	devoe => ww_devoe,
	o => \alu_out[6]~output_o\);

-- Location: IOOBUF_X0_Y7_N9
\alu_out[7]~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \adder_subtractor0|full_adder7|s~1_combout\,
	devoe => ww_devoe,
	o => \alu_out[7]~output_o\);

-- Location: IOOBUF_X0_Y5_N2
\Z~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_Z~2_combout\,
	devoe => ww_devoe,
	o => \Z~output_o\);

-- Location: IOIBUF_X11_Y0_N15
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

-- Location: IOIBUF_X1_Y10_N22
\p[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(0),
	o => \p[0]~input_o\);

-- Location: IOIBUF_X10_Y15_N1
\q[0]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(0),
	o => \q[0]~input_o\);

-- Location: LCCOMB_X10_Y9_N8
\adder_subtractor0|full_adder0|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder0|s~combout\ = \q[0]~input_o\ $ (((\f1~input_o\) # (\p[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111000011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \p[0]~input_o\,
	datac => \q[0]~input_o\,
	combout => \adder_subtractor0|full_adder0|s~combout\);

-- Location: IOIBUF_X10_Y15_N22
\q[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(1),
	o => \q[1]~input_o\);

-- Location: LCCOMB_X10_Y9_N22
\b_value[1]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- b_value(1) = (\q[1]~input_o\ & !\f1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \q[1]~input_o\,
	datac => \f1~input_o\,
	combout => b_value(1));

-- Location: IOIBUF_X6_Y10_N22
\p[1]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(1),
	o => \p[1]~input_o\);

-- Location: LCCOMB_X10_Y9_N4
\a_value[1]~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \a_value[1]~0_combout\ = (\f1~input_o\ & ((\q[1]~input_o\))) # (!\f1~input_o\ & (\p[1]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101011001010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \p[1]~input_o\,
	datab => \q[1]~input_o\,
	datac => \f1~input_o\,
	combout => \a_value[1]~0_combout\);

-- Location: IOIBUF_X1_Y10_N29
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

-- Location: LCCOMB_X10_Y9_N26
\adder_subtractor0|full_adder0|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder0|cout~0_combout\ = (\f1~input_o\ & (\q[0]~input_o\)) # (!\f1~input_o\ & ((\q[0]~input_o\ & ((\p[0]~input_o\))) # (!\q[0]~input_o\ & (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101110010011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \q[0]~input_o\,
	datac => \f0~input_o\,
	datad => \p[0]~input_o\,
	combout => \adder_subtractor0|full_adder0|cout~0_combout\);

-- Location: LCCOMB_X10_Y9_N24
\adder_subtractor0|full_adder1|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder1|s~combout\ = b_value(1) $ (\a_value[1]~0_combout\ $ (\f0~input_o\ $ (\adder_subtractor0|full_adder0|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(1),
	datab => \a_value[1]~0_combout\,
	datac => \f0~input_o\,
	datad => \adder_subtractor0|full_adder0|cout~0_combout\,
	combout => \adder_subtractor0|full_adder1|s~combout\);

-- Location: IOIBUF_X10_Y19_N22
\q[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(2),
	o => \q[2]~input_o\);

-- Location: LCCOMB_X10_Y9_N30
\b_value[2]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- b_value(2) = (\q[2]~input_o\ & !\f1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \q[2]~input_o\,
	datac => \f1~input_o\,
	combout => b_value(2));

-- Location: LCCOMB_X10_Y9_N2
\adder_subtractor0|full_adder1|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder1|cout~0_combout\ = (\a_value[1]~0_combout\ & ((\adder_subtractor0|full_adder0|cout~0_combout\) # (b_value(1) $ (\f0~input_o\)))) # (!\a_value[1]~0_combout\ & (\adder_subtractor0|full_adder0|cout~0_combout\ & (b_value(1) $ 
-- (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(1),
	datab => \a_value[1]~0_combout\,
	datac => \f0~input_o\,
	datad => \adder_subtractor0|full_adder0|cout~0_combout\,
	combout => \adder_subtractor0|full_adder1|cout~0_combout\);

-- Location: IOIBUF_X11_Y0_N22
\p[2]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(2),
	o => \p[2]~input_o\);

-- Location: LCCOMB_X10_Y9_N20
\a_value[2]~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \a_value[2]~1_combout\ = (\f1~input_o\ & (\q[2]~input_o\)) # (!\f1~input_o\ & ((\p[2]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \q[2]~input_o\,
	datac => \f1~input_o\,
	datad => \p[2]~input_o\,
	combout => \a_value[2]~1_combout\);

-- Location: LCCOMB_X10_Y9_N0
\adder_subtractor0|full_adder2|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder2|s~combout\ = b_value(2) $ (\adder_subtractor0|full_adder1|cout~0_combout\ $ (\f0~input_o\ $ (\a_value[2]~1_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(2),
	datab => \adder_subtractor0|full_adder1|cout~0_combout\,
	datac => \f0~input_o\,
	datad => \a_value[2]~1_combout\,
	combout => \adder_subtractor0|full_adder2|s~combout\);

-- Location: IOIBUF_X3_Y0_N22
\q[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(3),
	o => \q[3]~input_o\);

-- Location: LCCOMB_X10_Y9_N6
\b_value[3]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- b_value(3) = (!\f1~input_o\ & \q[3]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101000001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datac => \q[3]~input_o\,
	combout => b_value(3));

-- Location: IOIBUF_X3_Y10_N8
\p[3]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(3),
	o => \p[3]~input_o\);

-- Location: LCCOMB_X10_Y9_N28
\a_value[3]~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \a_value[3]~2_combout\ = (\f1~input_o\ & ((\q[3]~input_o\))) # (!\f1~input_o\ & (\p[3]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datab => \p[3]~input_o\,
	datac => \q[3]~input_o\,
	combout => \a_value[3]~2_combout\);

-- Location: LCCOMB_X10_Y9_N10
\adder_subtractor0|full_adder2|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder2|cout~0_combout\ = (\adder_subtractor0|full_adder1|cout~0_combout\ & ((\a_value[2]~1_combout\) # (b_value(2) $ (\f0~input_o\)))) # (!\adder_subtractor0|full_adder1|cout~0_combout\ & (\a_value[2]~1_combout\ & (b_value(2) $ 
-- (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(2),
	datab => \adder_subtractor0|full_adder1|cout~0_combout\,
	datac => \f0~input_o\,
	datad => \a_value[2]~1_combout\,
	combout => \adder_subtractor0|full_adder2|cout~0_combout\);

-- Location: LCCOMB_X10_Y9_N16
\adder_subtractor0|full_adder3|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder3|s~combout\ = b_value(3) $ (\a_value[3]~2_combout\ $ (\f0~input_o\ $ (\adder_subtractor0|full_adder2|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(3),
	datab => \a_value[3]~2_combout\,
	datac => \f0~input_o\,
	datad => \adder_subtractor0|full_adder2|cout~0_combout\,
	combout => \adder_subtractor0|full_adder3|s~combout\);

-- Location: LCCOMB_X10_Y9_N18
\adder_subtractor0|full_adder3|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder3|cout~0_combout\ = (\a_value[3]~2_combout\ & ((\adder_subtractor0|full_adder2|cout~0_combout\) # (b_value(3) $ (\f0~input_o\)))) # (!\a_value[3]~2_combout\ & (\adder_subtractor0|full_adder2|cout~0_combout\ & (b_value(3) $ 
-- (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(3),
	datab => \a_value[3]~2_combout\,
	datac => \f0~input_o\,
	datad => \adder_subtractor0|full_adder2|cout~0_combout\,
	combout => \adder_subtractor0|full_adder3|cout~0_combout\);

-- Location: IOIBUF_X6_Y10_N29
\q[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(4),
	o => \q[4]~input_o\);

-- Location: LCCOMB_X10_Y6_N2
\b_value[4]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- b_value(4) = (!\f1~input_o\ & \q[4]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \f1~input_o\,
	datad => \q[4]~input_o\,
	combout => b_value(4));

-- Location: IOIBUF_X11_Y0_N29
\p[4]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(4),
	o => \p[4]~input_o\);

-- Location: LCCOMB_X10_Y6_N24
\a_value[4]~3\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \a_value[4]~3_combout\ = (\f1~input_o\ & ((\q[4]~input_o\))) # (!\f1~input_o\ & (\p[4]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \f1~input_o\,
	datac => \p[4]~input_o\,
	datad => \q[4]~input_o\,
	combout => \a_value[4]~3_combout\);

-- Location: LCCOMB_X10_Y6_N12
\adder_subtractor0|full_adder4|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder4|s~combout\ = \adder_subtractor0|full_adder3|cout~0_combout\ $ (b_value(4) $ (\f0~input_o\ $ (\a_value[4]~3_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \adder_subtractor0|full_adder3|cout~0_combout\,
	datab => b_value(4),
	datac => \f0~input_o\,
	datad => \a_value[4]~3_combout\,
	combout => \adder_subtractor0|full_adder4|s~combout\);

-- Location: IOIBUF_X0_Y6_N22
\q[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(5),
	o => \q[5]~input_o\);

-- Location: LCCOMB_X10_Y6_N26
\b_value[5]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- b_value(5) = (!\f1~input_o\ & \q[5]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \f1~input_o\,
	datad => \q[5]~input_o\,
	combout => b_value(5));

-- Location: IOIBUF_X6_Y10_N8
\p[5]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(5),
	o => \p[5]~input_o\);

-- Location: LCCOMB_X10_Y6_N8
\a_value[5]~4\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \a_value[5]~4_combout\ = (\f1~input_o\ & (\q[5]~input_o\)) # (!\f1~input_o\ & ((\p[5]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \q[5]~input_o\,
	datac => \f1~input_o\,
	datad => \p[5]~input_o\,
	combout => \a_value[5]~4_combout\);

-- Location: LCCOMB_X10_Y6_N6
\adder_subtractor0|full_adder4|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder4|cout~0_combout\ = (\adder_subtractor0|full_adder3|cout~0_combout\ & ((\a_value[4]~3_combout\) # (b_value(4) $ (\f0~input_o\)))) # (!\adder_subtractor0|full_adder3|cout~0_combout\ & (\a_value[4]~3_combout\ & (b_value(4) $ 
-- (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011111000101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \adder_subtractor0|full_adder3|cout~0_combout\,
	datab => b_value(4),
	datac => \f0~input_o\,
	datad => \a_value[4]~3_combout\,
	combout => \adder_subtractor0|full_adder4|cout~0_combout\);

-- Location: LCCOMB_X10_Y6_N20
\adder_subtractor0|full_adder5|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder5|s~combout\ = b_value(5) $ (\a_value[5]~4_combout\ $ (\f0~input_o\ $ (\adder_subtractor0|full_adder4|cout~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(5),
	datab => \a_value[5]~4_combout\,
	datac => \f0~input_o\,
	datad => \adder_subtractor0|full_adder4|cout~0_combout\,
	combout => \adder_subtractor0|full_adder5|s~combout\);

-- Location: LCCOMB_X10_Y6_N22
\adder_subtractor0|full_adder5|cout~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder5|cout~0_combout\ = (\a_value[5]~4_combout\ & ((\adder_subtractor0|full_adder4|cout~0_combout\) # (b_value(5) $ (\f0~input_o\)))) # (!\a_value[5]~4_combout\ & (\adder_subtractor0|full_adder4|cout~0_combout\ & (b_value(5) $ 
-- (\f0~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101111001001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => b_value(5),
	datab => \a_value[5]~4_combout\,
	datac => \f0~input_o\,
	datad => \adder_subtractor0|full_adder4|cout~0_combout\,
	combout => \adder_subtractor0|full_adder5|cout~0_combout\);

-- Location: IOIBUF_X0_Y6_N15
\q[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(6),
	o => \q[6]~input_o\);

-- Location: LCCOMB_X10_Y6_N18
\b_value[6]\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- b_value(6) = (\q[6]~input_o\ & !\f1~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000110000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \q[6]~input_o\,
	datac => \f1~input_o\,
	combout => b_value(6));

-- Location: IOIBUF_X0_Y7_N1
\p[6]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(6),
	o => \p[6]~input_o\);

-- Location: LCCOMB_X10_Y6_N16
\a_value[6]~5\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \a_value[6]~5_combout\ = (\f1~input_o\ & (\q[6]~input_o\)) # (!\f1~input_o\ & ((\p[6]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100111111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \q[6]~input_o\,
	datac => \f1~input_o\,
	datad => \p[6]~input_o\,
	combout => \a_value[6]~5_combout\);

-- Location: LCCOMB_X10_Y6_N28
\adder_subtractor0|full_adder6|s\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder6|s~combout\ = \adder_subtractor0|full_adder5|cout~0_combout\ $ (b_value(6) $ (\f0~input_o\ $ (\a_value[6]~5_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110010110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \adder_subtractor0|full_adder5|cout~0_combout\,
	datab => b_value(6),
	datac => \f0~input_o\,
	datad => \a_value[6]~5_combout\,
	combout => \adder_subtractor0|full_adder6|s~combout\);

-- Location: LCCOMB_X10_Y6_N30
\adder_subtractor0|full_adder7|s~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder7|s~0_combout\ = (\adder_subtractor0|full_adder5|cout~0_combout\ & ((\a_value[6]~5_combout\ & ((!\f0~input_o\))) # (!\a_value[6]~5_combout\ & (b_value(6))))) # (!\adder_subtractor0|full_adder5|cout~0_combout\ & 
-- ((\a_value[6]~5_combout\ & (b_value(6))) # (!\a_value[6]~5_combout\ & ((\f0~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100111011011000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \adder_subtractor0|full_adder5|cout~0_combout\,
	datab => b_value(6),
	datac => \f0~input_o\,
	datad => \a_value[6]~5_combout\,
	combout => \adder_subtractor0|full_adder7|s~0_combout\);

-- Location: IOIBUF_X0_Y6_N1
\p[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_p(7),
	o => \p[7]~input_o\);

-- Location: IOIBUF_X0_Y6_N8
\q[7]~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_q(7),
	o => \q[7]~input_o\);

-- Location: LCCOMB_X10_Y6_N0
\adder_subtractor0|full_adder7|s~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \adder_subtractor0|full_adder7|s~1_combout\ = \adder_subtractor0|full_adder7|s~0_combout\ $ (\q[7]~input_o\ $ (((\p[7]~input_o\ & !\f1~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0101100110100110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \adder_subtractor0|full_adder7|s~0_combout\,
	datab => \p[7]~input_o\,
	datac => \f1~input_o\,
	datad => \q[7]~input_o\,
	combout => \adder_subtractor0|full_adder7|s~1_combout\);

-- Location: LCCOMB_X10_Y6_N10
\Z~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Z~1_combout\ = (\adder_subtractor0|full_adder6|s~combout\) # (\adder_subtractor0|full_adder5|s~combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \adder_subtractor0|full_adder6|s~combout\,
	datad => \adder_subtractor0|full_adder5|s~combout\,
	combout => \Z~1_combout\);

-- Location: LCCOMB_X10_Y9_N12
\Z~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Z~0_combout\ = (\adder_subtractor0|full_adder4|s~combout\) # ((\adder_subtractor0|full_adder3|s~combout\) # ((\adder_subtractor0|full_adder1|s~combout\) # (\adder_subtractor0|full_adder2|s~combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \adder_subtractor0|full_adder4|s~combout\,
	datab => \adder_subtractor0|full_adder3|s~combout\,
	datac => \adder_subtractor0|full_adder1|s~combout\,
	datad => \adder_subtractor0|full_adder2|s~combout\,
	combout => \Z~0_combout\);

-- Location: LCCOMB_X10_Y6_N4
\Z~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \Z~2_combout\ = (\Z~1_combout\) # ((\adder_subtractor0|full_adder7|s~1_combout\) # ((\adder_subtractor0|full_adder0|s~combout\) # (\Z~0_combout\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \Z~1_combout\,
	datab => \adder_subtractor0|full_adder7|s~1_combout\,
	datac => \adder_subtractor0|full_adder0|s~combout\,
	datad => \Z~0_combout\,
	combout => \Z~2_combout\);

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

ww_alu_out(0) <= \alu_out[0]~output_o\;

ww_alu_out(1) <= \alu_out[1]~output_o\;

ww_alu_out(2) <= \alu_out[2]~output_o\;

ww_alu_out(3) <= \alu_out[3]~output_o\;

ww_alu_out(4) <= \alu_out[4]~output_o\;

ww_alu_out(5) <= \alu_out[5]~output_o\;

ww_alu_out(6) <= \alu_out[6]~output_o\;

ww_alu_out(7) <= \alu_out[7]~output_o\;

ww_Z <= \Z~output_o\;
END structure;


