library ieee;
use ieee.std_logic_1164.all;

library work;

entity instruction_sequencer is
	port (
		opcode : in std_logic_vector(2 downto 0);
		reset : in std_logic;
		clock : in std_logic;
		t0 : out std_logic;
		t1 : out std_logic;
		t2 : out std_logic;
		t3 : out std_logic;
		t4 : out std_logic;
		t5 : out std_logic;
		t6 : out std_logic;
		t7 : out std_logic;
		execute : out std_logic
	);
end instruction_sequencer;

architecture bdf_type of instruction_sequencer is
	component d_ff
		port(
			reset : in std_logic;
			clock : in std_logic;
			d : in std_logic;
			q : out std_logic
			);
	end component;

signal q0 : std_logic;
signal q1 : std_logic;
signal q2 : std_logic;
signal q0_next : std_logic;
signal q1_next : std_logic;
signal q2_next : std_logic;

begin 

	-- current state logic
	q0_ff : d_ff
		port map(
			reset => reset,
			clock => clock,
			d => q0_next,
			q => q0
		);
	
	q1_ff : d_ff
		port map(
			reset => reset,
			clock => clock,
			d => q1_next,
			q => q1
		);
	
	q2_ff : d_ff
		port map(
			reset => reset,
			clock => clock,
			d => q2_next,
			q => q2
		);
		
	-- next state logic
	q0_next <= (not(opcode(1)) and not(q0)) or (not(opcode(2)) and not(q0)) or (not(q2) and not(q0));
	q1_next <= (q1 and not(q0)) or (opcode(2) and not(q1) and q0) or (not(opcode(2)) and not(opcode(1)) and not(q2) and not(q1) and q0) or (not(opcode(2)) and opcode(1) and not(q1) and q0);
	q2_next <= (q2 and q1 and not(q0)) or (not(opcode(1)) and not(q2) and q1 and q0) or (opcode(1) and not(q2) and q1 and q0) or (opcode(2) and not(opcode(1)) and q2 and not(q1)) or (not(opcode(2)) and opcode(1) and q2 and not(q1)) or (not(opcode(2)) and q2 and not(q1) and not(q0));
	
	--output logic
	t0 <= not(q2) and not(q1) and not(q0);
	t1 <= not(q2) and not(q1) and q0;
	t2 <= not(q2) and q1 and not(q0);
	t3 <= not(q2) and q1 and q0;
	t4 <= q2 and not(q1) and not(q0);
	t5 <= q2 and not(q1) and q0;
	t6 <= q2 and q1 and not(q0);
	t7 <= q2 and q1 and q0;
	execute <= q2;
	

end bdf_type;