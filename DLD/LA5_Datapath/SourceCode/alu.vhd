library ieee;
use ieee.std_logic_1164.all;

entity alu is
	port (
		p : in std_logic_vector(7 downto 0);
		q : in std_logic_vector(7 downto 0);
		f0 : in std_logic;
		f1 : in std_logic;
		alu_out : out std_logic_vector(7 downto 0);
		Z : out std_logic
	);
end alu;

architecture rtl of alu is 

	component adder_subtractor
		port (
				a : in std_logic_vector(7 downto 0);
				b : in std_logic_vector(7 downto 0);
				cin : in std_logic;
				sel : in std_logic;
				sum : out std_logic_vector(7 downto 0);
				cout : out std_logic
		);
	end component;

	signal a_value : std_logic_vector(7 downto 0);
	signal b_value : std_logic_vector(7 downto 0);
	signal one_constant : std_logic_vector(7 downto 0) := "00000001";
	signal alu_out_internal : std_logic_vector(7 downto 0);
	signal cout_internal : std_logic;

begin --rtl

-- f(0) = f0 => straight addition or increment
-- f(1) = f1 => negative of operation
-- 00 => signed(P) + signed(Q); 01 => signed(P) - signed(Q)
-- 10 => signed(Q) + 1; 11 => signed(Q) - 1


a_value(0) <= (not(f1) and p(0)) or (f1 and q(0));
a_value(1) <= (not(f1) and p(1)) or (f1 and q(1));
a_value(2) <= (not(f1) and p(2)) or (f1 and q(2));
a_value(3) <= (not(f1) and p(3)) or (f1 and q(3));
a_value(4) <= (not(f1) and p(4)) or (f1 and q(4));
a_value(5) <= (not(f1) and p(5)) or (f1 and q(5));
a_value(6) <= (not(f1) and p(6)) or (f1 and q(6));
a_value(7) <= (not(f1) and p(7)) or (f1 and q(7));	

b_value(0) <= (not(f1) and q(0)) or (f1 and one_constant(0));
b_value(1) <= (not(f1) and q(1)) or (f1 and one_constant(1));
b_value(2) <= (not(f1) and q(2)) or (f1 and one_constant(2));
b_value(3) <= (not(f1) and q(3)) or (f1 and one_constant(3));
b_value(4) <= (not(f1) and q(4)) or (f1 and one_constant(4));
b_value(5) <= (not(f1) and q(5)) or (f1 and one_constant(5));
b_value(6) <= (not(f1) and q(6)) or (f1 and one_constant(6));
b_value(7) <= (not(f1) and q(7)) or (f1 and one_constant(6));

adder_subtractor0 : adder_subtractor
	port map(
		a => a_value,
		b => b_value,
		cin => f0,
		sel => f0,
		sum => alu_out_internal,
		cout => cout_internal
		
	);

alu_out <= alu_out_internal;
Z <= not(alu_out_internal(0) or alu_out_internal(1) or
			alu_out_internal(2) or alu_out_internal(3) or 
			alu_out_internal(4) or alu_out_internal(5) or
			alu_out_internal(6) or alu_out_internal(7));
	
end rtl;