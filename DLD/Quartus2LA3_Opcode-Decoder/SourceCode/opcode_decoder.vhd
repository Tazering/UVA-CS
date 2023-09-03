LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY opcode_decoder IS
	PORT
		(
			execute : IN STD_LOGIC;
			opcode : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			load : OUT STD_LOGIC;
			store : 	OUT STD_LOGIC;
			add : OUT STD_LOGIC;
			sub : OUT STD_LOGIC;
			inc : OUT STD_LOGIC;
			dec : OUT STD_LOGIC;
			bra : OUT STD_LOGIC;
			beq : OUT STD_LOGIC
		);
END opcode_decoder;

ARCHITECTURE gate_level OF opcode_decoder IS

BEGIN

	load <= execute AND (NOT(opcode(2)) AND NOT(opcode(1)) AND NOT(opcode(0)));  -- y0
	store <= execute AND (NOT(opcode(2)) AND NOT(opcode(1)) AND opcode(0)); -- y1
	add <= execute AND (NOT(opcode(2)) AND opcode(1) AND NOT(opcode(0))); -- y2
	sub <= execute AND (NOT(opcode(2)) AND opcode(1) AND opcode(0)); -- y3
	inc <= execute AND (opcode(2) AND NOT(opcode(1)) AND NOT(opcode(0))); -- y4
	dec <= execute AND (opcode(2) AND NOT(opcode(1)) AND opcode(0)); -- y5
	bra <= execute AND (opcode(2) AND opcode(1) AND NOT(opcode(0))); -- y6
	beq <= execute AND (opcode(2) AND opcode(1) AND opcode(0)); -- y7
	
	

END gate_level;
	