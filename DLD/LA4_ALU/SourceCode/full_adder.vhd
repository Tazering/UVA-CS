library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
	port(
			a : in std_logic;
			b : in std_logic;
			cin : in std_logic;
			s : out std_logic;
			cout : out std_logic
	);
end full_adder;

architecture rtl of full_adder is

begin --rtl

	s <= a xor b xor cin;
	cout <= (a and b) or (b and cin) or (a and cin);

end rtl;