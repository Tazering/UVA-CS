LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY mux_2 IS
	PORT
		(
			sel	:	IN STD_LOGIC;
			in1	:	IN	STD_LOGIC;
			in0	:	IN	STD_LOGIC;
			Z	: OUT STD_LOGIC
		);
END mux_2;

ARCHITECTURE gate_level OF mux_2 IS

BEGIN

	Z <= (sel and in1) or (not(sel) and in0);

END gate_level;