library ieee;
use ieee.std_logic_1164.all;

entity adder_subtractor is
	port (
			a : in std_logic_vector(7 downto 0);
			b : in std_logic_vector(7 downto 0);
			cin : in std_logic;
			sel : in std_logic;
			sum : out std_logic_vector(7 downto 0);
			cout : out std_logic
	);
end adder_subtractor;

architecture gate_level of adder_subtractor is

	component full_adder
		port (
				a : in std_logic;
				b : in std_logic;
				cin : in std_logic;
				cout : out std_logic;
				s : out std_logic
		);
	end component;
	

	signal cout0To1 : std_logic;
	signal cout1To2 : std_logic;
	signal cout2To3 : std_logic;
	signal cout3To4 : std_logic;
	signal cout4To5 : std_logic;
	signal cout5To6 : std_logic;
	signal cout6To7 : std_logic;
	signal b_after_sel : std_logic_vector(7 downto 0);

begin --rtl

	-- sel = 1 => subtraction; sel = 0 => addition
	b_after_sel(7) <= b(7) xor sel;
	b_after_sel(6) <= b(6) xor sel;
	b_after_sel(5) <= b(5) xor sel;
	b_after_sel(4) <= b(4) xor sel;
	b_after_sel(3) <= b(3) xor sel;
	b_after_sel(2) <= b(2) xor sel;
	b_after_sel(1) <= b(1) xor sel;
	b_after_sel(0) <= b(0) xor sel;
	
	full_adder0 : full_adder -- bit 0
		port map(
				a => a(0),
				cin => cin,
				b => b_after_sel(0),
				cout => cout0To1,
				s => sum(0)
		);
	
	full_adder1 : full_adder -- bit 1
		port map(
				a => a(1),
				cin => cout0To1,
				b => b_after_sel(1),
				cout => cout1To2,
				s => sum(1)
		);
	
	full_adder2 : full_adder -- bit 2
		port map(
				a => a(2),
				cin => cout1To2,
				b => b_after_sel(2),
				cout => cout2To3,
				s => sum(2)
		);
	
	full_adder3 : full_adder -- bit 3
		port map(
				a => a(3),
				cin => cout2To3,
				b => b_after_sel(3),
				cout => cout3To4,
				s => sum(3)
		);
		
	full_adder4 : full_adder -- bit 4
		port map(
				a => a(4),
				cin => cout3To4,
				b => b_after_sel(4),
				cout => cout4To5,
				s => sum(4)
		);	
	
	full_adder5 : full_adder --bit 5
		port map(
				a => a(5),
				cin => cout4To5,
				b => b_after_sel(5),
				cout => cout5To6,
				s => sum(5)
		);
	
	full_adder6 : full_adder --bit 6
		port map(
				a => a(6),
				cin => cout5To6,
				b => b_after_sel(6),
				cout => cout6To7,
				s => sum(6)
		);
	
	full_adder7 : full_adder -- bit 7
		port map(
				a => a(7),
				cin => cout6To7,
				b => b_after_sel(7),
				cout => cout,
				s => sum(7)
		);
	

end gate_level;