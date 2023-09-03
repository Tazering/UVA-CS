LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testbench IS 
END testbench;

ARCHITECTURE gate_level OF testbench IS 

  component alu IS 
    PORT
      (
        p : in std_logic_vector(7 downto 0);
		  q : in std_logic_vector(7 downto 0);
		  f0 : in std_logic;
		  f1 : in std_logic;
		  alu_out : out std_logic_vector(7 downto 0);
		  Z : out std_logic
	);
  END component;

  signal p_tb : std_logic_vector(7 downto 0);
  signal q_tb : std_logic_vector(7 downto 0);
  signal f0_tb : std_logic;
  signal f1_tb: std_logic;
  signal alu_out_tb : std_logic_vector(7 downto 0);
  signal Z_tb : std_logic;
  signal alu_out_expected: std_logic_vector(7 downto 0);
  signal Z_expected : std_logic;
  

BEGIN 

  -- Component instantiation of Device Under Test (DUT)
  alu0 : alu
    PORT MAP(
      p => p_tb,  
      q => q_tb,
      Z => Z_tb,
		f0 => f0_tb,
		f1 => f1_tb,
		alu_out => alu_out_tb
      );

  -- Concurrent process statement that applies input test vectors and
  -- monitors output results
  testbench_process : process
  begin

    -- Assign input and expected output values, and then create
    -- a time delay and compare actual output with expected output.
    f0_tb <= '0';
	 f1_tb <= '0';
    p_tb <= "00000010";
    q_tb <= "00000101";
	 Z_expected <= '0';
	 alu_out_expected <= "00000111";
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (Z_expected = Z_tb and alu_out_expected = alu_out_tb) report "Output incorrect for 2 + 5 = 7 (testing addition)" severity note;
    assert (alu_out_tb /= alu_out_expected or alu_out_expected /= alu_out_tb) report "Output correct for 2 + 5 = 7 (testing addition)" severity note;
    -- Finally, a wait statement without any time parameter suspends the
    -- process indefintely.
    
	 f0_tb <= '1';
	 f1_tb <= '0';
	 p_tb <= "00000111";
	 q_tb <= "00000100";
	 Z_expected <= '0';
	 alu_out_expected <= "00000011";
	 wait for 10 ns;
	 
	 assert (Z_expected = Z_tb and alu_out_expected = alu_out_tb) report "Output incorrect for 7 - 4 = 3 (testing subtraction)" severity note;
    assert (alu_out_tb /= alu_out_expected or alu_out_expected /= alu_out_tb) report "Output correct for 7 - 4 = 3 (testing subtraction)" severity note;
	 
	 
	 
	 f0_tb <= '0';
	 f1_tb <= '1';
	 p_tb <= "11111111";
	 q_tb <= "00000000";
	 Z_expected <= '0';
	 alu_out_expected <= "00000001";
	 wait for 10 ns;
	 
	 assert (Z_expected = Z_tb and alu_out_expected = alu_out_tb) report "Output incorrect for inc 1111 1111 (testing increment on max value)" severity note;
    assert (alu_out_tb /= alu_out_expected or alu_out_expected /= alu_out_tb) report "Output correct for inc 1111 1111 (testing increment on max value)" severity note;
	 
	 
	 f0_tb <= '1';
	 f1_tb <= '1';
	 p_tb <= "00000000";
	 q_tb <= "00000000";
	 Z_expected <= '0';
	 alu_out_expected <= "11111111";
	 wait for 10 ns;
	 
	 assert (Z_expected = Z_tb and alu_out_expected = alu_out_tb) report "Output incorrect for dec 0 (testing dec on 0 value)" severity note;
    assert (alu_out_tb /= alu_out_expected or alu_out_expected /= alu_out_tb) report "Output correct for dec 0 (testing decrement on 0 value)" severity note;
	 
	 
	 
	 f0_tb <= '1';
	 f1_tb <= '0';
	 p_tb <= "00000001";
	 q_tb <= "00000001";
	 Z_expected <= '1';
	 alu_out_expected <= "00000000";
	 wait for 10 ns;
	 
	 assert (Z_expected = Z_tb and alu_out_expected = alu_out_tb) report "Output incorrect for testing if z = 1" severity note;
    assert (alu_out_tb /= alu_out_expected or alu_out_expected /= alu_out_tb) report "Output correct for testing if z = 1" severity note;
	 
	 wait;
    
  end process testbench_process;

END gate_level;