LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testbench IS 
END testbench;

ARCHITECTURE gate_level OF testbench IS 

  component majority_voter0
    PORT
      (
        A :  IN  STD_LOGIC;
        B :  IN  STD_LOGIC;
		  C :  IN  STD_LOGIC;
        Z :  OUT  STD_LOGIC
	);
  END component;

  signal inA_tb :  STD_LOGIC;
  signal inB_tb :  STD_LOGIC;
  signal inC_tb :	 STD_LOGIC;
  signal Z_tb :  STD_LOGIC;
  signal Z_expected : STD_LOGIC;

BEGIN 

  -- Component instantiation of Unit Under Test (UUT)
  -- and2_0 instantiation
  majority_voter_0 : majority_voter0
    PORT MAP(
      A => inA_tb,
		B => inB_tb,
      C => inC_tb,
		Z => Z_tb
      );

		

  -- Concurrent process statement that applies input test vectors and
  -- monitors output results
  testbench_process : process
  begin

    -- Assign input and expected output values, and then create
    -- a time delay and compare actual output with expected output.
	 -- 0: 000
    inA_tb <= '0';
    inB_tb <= '0';
	 inC_tb <= '0';
    Z_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (Z_tb = Z_expected) report "Output incorrect for input = 000" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 000" severity note;

	 -- 1: 001
    inA_tb <= '0';
    inB_tb <= '0';
	 inC_tb <= '1';
    Z_expected <= '0';
    wait for 10 ns;

    assert (Z_tb = Z_expected) report "Output incorrect for input = 001" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 001" severity note;

	 -- 2: 010
    inA_tb <= '0';
    inB_tb <= '1';
	 inC_tb <= '0';
    Z_expected <= '0';
    wait for 10 ns;

    assert (Z_tb = Z_expected) report "Output incorrect for input = 010" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 010" severity note;

	 -- 3: 011
    inA_tb <= '0';
    inB_tb <= '1';
	 inC_tb <= '1';
    Z_expected <= '1';
    wait for 10 ns;

    assert (Z_tb = Z_expected) report "Output incorrect for input = 011" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 011" severity note;
	 
	 -- 4: 100
    inA_tb <= '1';
    inB_tb <= '0';
	 inC_tb <= '0';
    Z_expected <= '0';
    wait for 10 ns;

    assert (Z_tb = Z_expected) report "Output incorrect for input = 100" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 100" severity note;
	 
	 -- 5: 101
    inA_tb <= '1';
    inB_tb <= '0';
	 inC_tb <= '1';
    Z_expected <= '1';
    wait for 10 ns;

    assert (Z_tb = Z_expected) report "Output incorrect for input = 101" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 101" severity note;
	 
	 -- 6: 110
    inA_tb <= '1';
    inB_tb <= '1';
	 inC_tb <= '0';
    Z_expected <= '1';
    wait for 10 ns;

    assert (Z_tb = Z_expected) report "Output incorrect for input = 110" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 110" severity note;
	 
	 -- 7: 111
    inA_tb <= '1';
    inB_tb <= '1';
	 inC_tb <= '1';
    Z_expected <= '1';
    wait for 10 ns;

    assert (Z_tb = Z_expected) report "Output incorrect for input = 111" severity note;
    assert (Z_tb /= Z_expected) report "Output correct for input = 111" severity note;
	 

    -- Finally, a wait statement without any time parameter suspends the
    -- process indefintely.
    wait;
    
  end process testbench_process;

END gate_level;
