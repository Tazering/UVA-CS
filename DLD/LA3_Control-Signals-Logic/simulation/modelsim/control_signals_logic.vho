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

-- DATE "10/10/2022 11:50:01"

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

ENTITY 	control_signals_logic IS
    PORT (
	reset : IN std_logic;
	clock : IN std_logic;
	load : IN std_logic;
	store : IN std_logic;
	add : IN std_logic;
	sub : IN std_logic;
	inc : IN std_logic;
	dec : IN std_logic;
	bra : IN std_logic;
	beq : IN std_logic;
	t0 : IN std_logic;
	t1 : IN std_logic;
	t2 : IN std_logic;
	t3 : IN std_logic;
	t4 : IN std_logic;
	t5 : IN std_logic;
	t6 : IN std_logic;
	t7 : IN std_logic;
	Z : IN std_logic;
	r : BUFFER std_logic;
	w : BUFFER std_logic;
	cmar : BUFFER std_logic;
	cmbr : BUFFER std_logic;
	embr : BUFFER std_logic;
	cir : BUFFER std_logic;
	eir : BUFFER std_logic;
	cpc : BUFFER std_logic;
	epc : BUFFER std_logic;
	cd0 : BUFFER std_logic;
	ed0 : BUFFER std_logic;
	calu : BUFFER std_logic;
	ealu : BUFFER std_logic;
	F0 : BUFFER std_logic;
	F1 : BUFFER std_logic
	);
END control_signals_logic;

-- Design Ports Information
-- reset	=>  Location: PIN_T6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clock	=>  Location: PIN_P4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- r	=>  Location: PIN_H3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- w	=>  Location: PIN_J9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cmar	=>  Location: PIN_C6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cmbr	=>  Location: PIN_K4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- embr	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cir	=>  Location: PIN_A5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- eir	=>  Location: PIN_J3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cpc	=>  Location: PIN_D3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- epc	=>  Location: PIN_D7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- cd0	=>  Location: PIN_H4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ed0	=>  Location: PIN_A3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- calu	=>  Location: PIN_K6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- ealu	=>  Location: PIN_C1,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F0	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- F1	=>  Location: PIN_F3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t5	=>  Location: PIN_A2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t1	=>  Location: PIN_D8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- dec	=>  Location: PIN_D2,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- add	=>  Location: PIN_B3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- sub	=>  Location: PIN_E4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- inc	=>  Location: PIN_F5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- load	=>  Location: PIN_G4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- store	=>  Location: PIN_F4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t7	=>  Location: PIN_G3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t4	=>  Location: PIN_E3,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t0	=>  Location: PIN_A4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t6	=>  Location: PIN_J4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- bra	=>  Location: PIN_J8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- beq	=>  Location: PIN_B7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- Z	=>  Location: PIN_K5,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t3	=>  Location: PIN_K9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- t2	=>  Location: PIN_E9,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF control_signals_logic IS
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
SIGNAL ww_load : std_logic;
SIGNAL ww_store : std_logic;
SIGNAL ww_add : std_logic;
SIGNAL ww_sub : std_logic;
SIGNAL ww_inc : std_logic;
SIGNAL ww_dec : std_logic;
SIGNAL ww_bra : std_logic;
SIGNAL ww_beq : std_logic;
SIGNAL ww_t0 : std_logic;
SIGNAL ww_t1 : std_logic;
SIGNAL ww_t2 : std_logic;
SIGNAL ww_t3 : std_logic;
SIGNAL ww_t4 : std_logic;
SIGNAL ww_t5 : std_logic;
SIGNAL ww_t6 : std_logic;
SIGNAL ww_t7 : std_logic;
SIGNAL ww_Z : std_logic;
SIGNAL ww_r : std_logic;
SIGNAL ww_w : std_logic;
SIGNAL ww_cmar : std_logic;
SIGNAL ww_cmbr : std_logic;
SIGNAL ww_embr : std_logic;
SIGNAL ww_cir : std_logic;
SIGNAL ww_eir : std_logic;
SIGNAL ww_cpc : std_logic;
SIGNAL ww_epc : std_logic;
SIGNAL ww_cd0 : std_logic;
SIGNAL ww_ed0 : std_logic;
SIGNAL ww_calu : std_logic;
SIGNAL ww_ealu : std_logic;
SIGNAL ww_F0 : std_logic;
SIGNAL ww_F1 : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~_CHSEL_bus\ : std_logic_vector(4 DOWNTO 0);
SIGNAL \reset~input_o\ : std_logic;
SIGNAL \clock~input_o\ : std_logic;
SIGNAL \~QUARTUS_CREATED_GND~I_combout\ : std_logic;
SIGNAL \~QUARTUS_CREATED_UNVM~~busy\ : std_logic;
SIGNAL \~QUARTUS_CREATED_ADC1~~eoc\ : std_logic;
SIGNAL \r~output_o\ : std_logic;
SIGNAL \w~output_o\ : std_logic;
SIGNAL \cmar~output_o\ : std_logic;
SIGNAL \cmbr~output_o\ : std_logic;
SIGNAL \embr~output_o\ : std_logic;
SIGNAL \cir~output_o\ : std_logic;
SIGNAL \eir~output_o\ : std_logic;
SIGNAL \cpc~output_o\ : std_logic;
SIGNAL \epc~output_o\ : std_logic;
SIGNAL \cd0~output_o\ : std_logic;
SIGNAL \ed0~output_o\ : std_logic;
SIGNAL \calu~output_o\ : std_logic;
SIGNAL \ealu~output_o\ : std_logic;
SIGNAL \F0~output_o\ : std_logic;
SIGNAL \F1~output_o\ : std_logic;
SIGNAL \t5~input_o\ : std_logic;
SIGNAL \sub~input_o\ : std_logic;
SIGNAL \inc~input_o\ : std_logic;
SIGNAL \load~input_o\ : std_logic;
SIGNAL \add~input_o\ : std_logic;
SIGNAL \r~0_combout\ : std_logic;
SIGNAL \dec~input_o\ : std_logic;
SIGNAL \t1~input_o\ : std_logic;
SIGNAL \r~1_combout\ : std_logic;
SIGNAL \t7~input_o\ : std_logic;
SIGNAL \store~input_o\ : std_logic;
SIGNAL \w~0_combout\ : std_logic;
SIGNAL \w~1_combout\ : std_logic;
SIGNAL \t4~input_o\ : std_logic;
SIGNAL \cmar~0_combout\ : std_logic;
SIGNAL \t0~input_o\ : std_logic;
SIGNAL \cmar~1_combout\ : std_logic;
SIGNAL \cmar~2_combout\ : std_logic;
SIGNAL \cmbr~0_combout\ : std_logic;
SIGNAL \t6~input_o\ : std_logic;
SIGNAL \embr~0_combout\ : std_logic;
SIGNAL \embr~1_combout\ : std_logic;
SIGNAL \Z~input_o\ : std_logic;
SIGNAL \beq~input_o\ : std_logic;
SIGNAL \eir~0_combout\ : std_logic;
SIGNAL \bra~input_o\ : std_logic;
SIGNAL \eir~1_combout\ : std_logic;
SIGNAL \t3~input_o\ : std_logic;
SIGNAL \cpc~0_combout\ : std_logic;
SIGNAL \cpc~1_combout\ : std_logic;
SIGNAL \t2~input_o\ : std_logic;
SIGNAL \epc~0_combout\ : std_logic;
SIGNAL \r~2_combout\ : std_logic;
SIGNAL \cd0~0_combout\ : std_logic;
SIGNAL \calu~0_combout\ : std_logic;
SIGNAL \ealu~0_combout\ : std_logic;
SIGNAL \F0~0_combout\ : std_logic;
SIGNAL \F1~0_combout\ : std_logic;

COMPONENT hard_block
    PORT (
	devoe : IN std_logic;
	devclrn : IN std_logic;
	devpor : IN std_logic);
END COMPONENT;

BEGIN

ww_reset <= reset;
ww_clock <= clock;
ww_load <= load;
ww_store <= store;
ww_add <= add;
ww_sub <= sub;
ww_inc <= inc;
ww_dec <= dec;
ww_bra <= bra;
ww_beq <= beq;
ww_t0 <= t0;
ww_t1 <= t1;
ww_t2 <= t2;
ww_t3 <= t3;
ww_t4 <= t4;
ww_t5 <= t5;
ww_t6 <= t6;
ww_t7 <= t7;
ww_Z <= Z;
r <= ww_r;
w <= ww_w;
cmar <= ww_cmar;
cmbr <= ww_cmbr;
embr <= ww_embr;
cir <= ww_cir;
eir <= ww_eir;
cpc <= ww_cpc;
epc <= ww_epc;
cd0 <= ww_cd0;
ed0 <= ww_ed0;
calu <= ww_calu;
ealu <= ww_ealu;
F0 <= ww_F0;
F1 <= ww_F1;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\~QUARTUS_CREATED_ADC1~_CHSEL_bus\ <= (\~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\ & \~QUARTUS_CREATED_GND~I_combout\);
auto_generated_inst : hard_block
PORT MAP (
	devoe => ww_devoe,
	devclrn => ww_devclrn,
	devpor => ww_devpor);

-- Location: LCCOMB_X11_Y24_N24
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

-- Location: IOOBUF_X10_Y20_N23
\r~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \r~1_combout\,
	devoe => ww_devoe,
	o => \r~output_o\);

-- Location: IOOBUF_X10_Y21_N23
\w~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \w~1_combout\,
	devoe => ww_devoe,
	o => \w~output_o\);

-- Location: IOOBUF_X13_Y25_N23
\cmar~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \cmar~2_combout\,
	devoe => ww_devoe,
	o => \cmar~output_o\);

-- Location: IOOBUF_X10_Y19_N2
\cmbr~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \cmbr~0_combout\,
	devoe => ww_devoe,
	o => \cmbr~output_o\);

-- Location: IOOBUF_X10_Y18_N16
\embr~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \embr~1_combout\,
	devoe => ww_devoe,
	o => \embr~output_o\);

-- Location: IOOBUF_X15_Y25_N30
\cir~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \t1~input_o\,
	devoe => ww_devoe,
	o => \cir~output_o\);

-- Location: IOOBUF_X10_Y19_N9
\eir~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \eir~1_combout\,
	devoe => ww_devoe,
	o => \eir~output_o\);

-- Location: IOOBUF_X10_Y18_N2
\cpc~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \cpc~1_combout\,
	devoe => ww_devoe,
	o => \cpc~output_o\);

-- Location: IOOBUF_X13_Y25_N30
\epc~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \epc~0_combout\,
	devoe => ww_devoe,
	o => \epc~output_o\);

-- Location: IOOBUF_X10_Y20_N2
\cd0~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \cd0~0_combout\,
	devoe => ww_devoe,
	o => \cd0~output_o\);

-- Location: IOOBUF_X11_Y25_N23
\ed0~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \w~0_combout\,
	devoe => ww_devoe,
	o => \ed0~output_o\);

-- Location: IOOBUF_X10_Y19_N23
\calu~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \calu~0_combout\,
	devoe => ww_devoe,
	o => \calu~output_o\);

-- Location: IOOBUF_X10_Y17_N2
\ealu~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ealu~0_combout\,
	devoe => ww_devoe,
	o => \ealu~output_o\);

-- Location: IOOBUF_X13_Y25_N9
\F0~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \F0~0_combout\,
	devoe => ww_devoe,
	o => \F0~output_o\);

-- Location: IOOBUF_X10_Y21_N9
\F1~output\ : fiftyfivenm_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \F1~0_combout\,
	devoe => ww_devoe,
	o => \F1~output_o\);

-- Location: IOIBUF_X11_Y25_N15
\t5~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t5,
	o => \t5~input_o\);

-- Location: IOIBUF_X10_Y22_N1
\sub~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_sub,
	o => \sub~input_o\);

-- Location: IOIBUF_X10_Y22_N15
\inc~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_inc,
	o => \inc~input_o\);

-- Location: IOIBUF_X10_Y21_N1
\load~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_load,
	o => \load~input_o\);

-- Location: IOIBUF_X11_Y25_N29
\add~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_add,
	o => \add~input_o\);

-- Location: LCCOMB_X11_Y22_N16
\r~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \r~0_combout\ = (\sub~input_o\) # ((\inc~input_o\) # ((\load~input_o\) # (\add~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sub~input_o\,
	datab => \inc~input_o\,
	datac => \load~input_o\,
	datad => \add~input_o\,
	combout => \r~0_combout\);

-- Location: IOIBUF_X10_Y18_N8
\dec~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_dec,
	o => \dec~input_o\);

-- Location: IOIBUF_X15_Y25_N15
\t1~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t1,
	o => \t1~input_o\);

-- Location: LCCOMB_X11_Y22_N10
\r~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \r~1_combout\ = (\t1~input_o\) # ((\t5~input_o\ & ((\r~0_combout\) # (\dec~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t5~input_o\,
	datab => \r~0_combout\,
	datac => \dec~input_o\,
	datad => \t1~input_o\,
	combout => \r~1_combout\);

-- Location: IOIBUF_X10_Y20_N8
\t7~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t7,
	o => \t7~input_o\);

-- Location: IOIBUF_X10_Y22_N22
\store~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_store,
	o => \store~input_o\);

-- Location: LCCOMB_X11_Y22_N12
\w~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \w~0_combout\ = (\store~input_o\ & \t5~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \store~input_o\,
	datac => \t5~input_o\,
	combout => \w~0_combout\);

-- Location: LCCOMB_X11_Y22_N22
\w~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \w~1_combout\ = (\w~0_combout\) # ((\t7~input_o\ & ((\inc~input_o\) # (\dec~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t7~input_o\,
	datab => \inc~input_o\,
	datac => \dec~input_o\,
	datad => \w~0_combout\,
	combout => \w~1_combout\);

-- Location: IOIBUF_X10_Y22_N8
\t4~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t4,
	o => \t4~input_o\);

-- Location: LCCOMB_X11_Y22_N8
\cmar~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \cmar~0_combout\ = (\t4~input_o\ & ((\sub~input_o\) # ((\add~input_o\) # (\load~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sub~input_o\,
	datab => \add~input_o\,
	datac => \load~input_o\,
	datad => \t4~input_o\,
	combout => \cmar~0_combout\);

-- Location: IOIBUF_X13_Y25_N1
\t0~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t0,
	o => \t0~input_o\);

-- Location: LCCOMB_X11_Y22_N26
\cmar~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \cmar~1_combout\ = (\t4~input_o\ & ((\inc~input_o\) # ((\dec~input_o\) # (\store~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t4~input_o\,
	datab => \inc~input_o\,
	datac => \dec~input_o\,
	datad => \store~input_o\,
	combout => \cmar~1_combout\);

-- Location: LCCOMB_X12_Y22_N8
\cmar~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \cmar~2_combout\ = (\cmar~0_combout\) # ((\t0~input_o\) # (\cmar~1_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \cmar~0_combout\,
	datab => \t0~input_o\,
	datac => \cmar~1_combout\,
	combout => \cmar~2_combout\);

-- Location: LCCOMB_X11_Y22_N28
\cmbr~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \cmbr~0_combout\ = (\t5~input_o\ & ((\sub~input_o\) # ((\inc~input_o\) # (\add~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000011100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sub~input_o\,
	datab => \inc~input_o\,
	datac => \t5~input_o\,
	datad => \add~input_o\,
	combout => \cmbr~0_combout\);

-- Location: IOIBUF_X10_Y20_N15
\t6~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t6,
	o => \t6~input_o\);

-- Location: LCCOMB_X11_Y22_N6
\embr~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \embr~0_combout\ = (!\sub~input_o\ & (!\inc~input_o\ & (!\dec~input_o\ & !\add~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sub~input_o\,
	datab => \inc~input_o\,
	datac => \dec~input_o\,
	datad => \add~input_o\,
	combout => \embr~0_combout\);

-- Location: LCCOMB_X11_Y18_N16
\embr~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \embr~1_combout\ = (\t6~input_o\ & !\embr~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \t6~input_o\,
	datad => \embr~0_combout\,
	combout => \embr~1_combout\);

-- Location: IOIBUF_X10_Y19_N15
\Z~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_Z,
	o => \Z~input_o\);

-- Location: IOIBUF_X15_Y25_N1
\beq~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_beq,
	o => \beq~input_o\);

-- Location: LCCOMB_X11_Y22_N0
\eir~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \eir~0_combout\ = (\store~input_o\) # ((\load~input_o\) # ((\Z~input_o\ & \beq~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \store~input_o\,
	datab => \Z~input_o\,
	datac => \load~input_o\,
	datad => \beq~input_o\,
	combout => \eir~0_combout\);

-- Location: IOIBUF_X10_Y21_N15
\bra~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_bra,
	o => \bra~input_o\);

-- Location: LCCOMB_X11_Y22_N2
\eir~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \eir~1_combout\ = (\t4~input_o\ & ((\eir~0_combout\) # ((\bra~input_o\) # (!\embr~0_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t4~input_o\,
	datab => \eir~0_combout\,
	datac => \bra~input_o\,
	datad => \embr~0_combout\,
	combout => \eir~1_combout\);

-- Location: IOIBUF_X10_Y18_N22
\t3~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t3,
	o => \t3~input_o\);

-- Location: LCCOMB_X11_Y22_N20
\cpc~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \cpc~0_combout\ = (\t4~input_o\ & ((\bra~input_o\) # ((\Z~input_o\ & \beq~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t4~input_o\,
	datab => \Z~input_o\,
	datac => \bra~input_o\,
	datad => \beq~input_o\,
	combout => \cpc~0_combout\);

-- Location: LCCOMB_X11_Y18_N18
\cpc~1\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \cpc~1_combout\ = (\t3~input_o\) # (\cpc~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t3~input_o\,
	datac => \cpc~0_combout\,
	combout => \cpc~1_combout\);

-- Location: IOIBUF_X13_Y25_N15
\t2~input\ : fiftyfivenm_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	listen_to_nsleep_signal => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_t2,
	o => \t2~input_o\);

-- Location: LCCOMB_X12_Y22_N10
\epc~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \epc~0_combout\ = (\t2~input_o\) # (\t0~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t2~input_o\,
	datac => \t0~input_o\,
	combout => \epc~0_combout\);

-- Location: LCCOMB_X11_Y22_N14
\r~2\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \r~2_combout\ = (\t5~input_o\ & \load~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t5~input_o\,
	datac => \load~input_o\,
	combout => \r~2_combout\);

-- Location: LCCOMB_X11_Y22_N24
\cd0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \cd0~0_combout\ = (\r~2_combout\) # ((\t7~input_o\ & ((\sub~input_o\) # (\add~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110011101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \sub~input_o\,
	datab => \r~2_combout\,
	datac => \t7~input_o\,
	datad => \add~input_o\,
	combout => \cd0~0_combout\);

-- Location: LCCOMB_X11_Y22_N18
\calu~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \calu~0_combout\ = (\t2~input_o\) # ((\t6~input_o\ & !\embr~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011101110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t6~input_o\,
	datab => \t2~input_o\,
	datad => \embr~0_combout\,
	combout => \calu~0_combout\);

-- Location: LCCOMB_X11_Y18_N20
\ealu~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \ealu~0_combout\ = (\t3~input_o\) # ((\t7~input_o\ & !\embr~0_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011111010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t3~input_o\,
	datac => \t7~input_o\,
	datad => \embr~0_combout\,
	combout => \ealu~0_combout\);

-- Location: LCCOMB_X11_Y22_N4
\F0~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \F0~0_combout\ = (\t6~input_o\ & ((\dec~input_o\) # (\sub~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t6~input_o\,
	datac => \dec~input_o\,
	datad => \sub~input_o\,
	combout => \F0~0_combout\);

-- Location: LCCOMB_X11_Y22_N30
\F1~0\ : fiftyfivenm_lcell_comb
-- Equation(s):
-- \F1~0_combout\ = (\t2~input_o\) # ((\t6~input_o\ & ((\inc~input_o\) # (\dec~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111110101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \t6~input_o\,
	datab => \inc~input_o\,
	datac => \dec~input_o\,
	datad => \t2~input_o\,
	combout => \F1~0_combout\);

-- Location: IOIBUF_X0_Y2_N22
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

-- Location: IOIBUF_X0_Y7_N1
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

ww_r <= \r~output_o\;

ww_w <= \w~output_o\;

ww_cmar <= \cmar~output_o\;

ww_cmbr <= \cmbr~output_o\;

ww_embr <= \embr~output_o\;

ww_cir <= \cir~output_o\;

ww_eir <= \eir~output_o\;

ww_cpc <= \cpc~output_o\;

ww_epc <= \epc~output_o\;

ww_cd0 <= \cd0~output_o\;

ww_ed0 <= \ed0~output_o\;

ww_calu <= \calu~output_o\;

ww_ealu <= \ealu~output_o\;

ww_F0 <= \F0~output_o\;

ww_F1 <= \F1~output_o\;
END structure;


