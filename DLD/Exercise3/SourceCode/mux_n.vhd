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

-- PROGRAM		"Quartus Prime"
-- VERSION		"Version 20.1.1 Build 720 11/11/2020 SJ Lite Edition"
-- CREATED		"Tue Sep 20 17:11:27 2022"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY work;

ENTITY mux_n IS 
	PORT
	(
		in_n :  IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
		sel :  IN  STD_LOGIC_VECTOR(1 DOWNTO 0);
		Z :  OUT  STD_LOGIC
	);
END mux_n;

ARCHITECTURE bdf_type OF mux_n IS 

COMPONENT mux_2
	PORT(sel : IN STD_LOGIC;
		 in1 : IN STD_LOGIC;
		 in0 : IN STD_LOGIC;
		 Z : OUT STD_LOGIC
	);
END COMPONENT;

SIGNAL	SYNTHESIZED_WIRE_0 :  STD_LOGIC;
SIGNAL	SYNTHESIZED_WIRE_1 :  STD_LOGIC;


BEGIN 



b2v_inst : mux_2
PORT MAP(sel => sel(1),
		 in1 => in_n(2),
		 in0 => in_n(0),
		 Z => SYNTHESIZED_WIRE_1);


b2v_inst1 : mux_2
PORT MAP(sel => sel(1),
		 in1 => in_n(3),
		 in0 => in_n(1),
		 Z => SYNTHESIZED_WIRE_0);


b2v_inst2 : mux_2
PORT MAP(sel => sel(0),
		 in1 => SYNTHESIZED_WIRE_0,
		 in0 => SYNTHESIZED_WIRE_1,
		 Z => Z);


END bdf_type;