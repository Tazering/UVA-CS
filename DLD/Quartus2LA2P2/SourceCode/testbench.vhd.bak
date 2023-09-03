LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testbench IS 
END testbench;

ARCHITECTURE gate_level OF testbench IS 

  component and_2
    PORT
      (
        in1 :  IN  STD_LOGIC;
        in2 :  IN  STD_LOGIC;
        out1 :  OUT  STD_LOGIC
	);
  END component;

  signal in1_tb :  STD_LOGIC;
  signal in2_tb :  STD_LOGIC;
  signal out1_tb :  STD_LOGIC;
  signal out1_expected : STD_LOGIC;

BEGIN 

  -- Component instantiation of Unit Under Test (UUT)
  and2_0 : and_2
    PORT MAP(
      in1 => in1_tb,  
      in2 => in2_tb,  
      out1 => out1_tb
      );

  -- Concurrent process statement that applies input test vectors and
  -- monitors output results
  testbench_process : process
  begin

    -- Assign input and expected output values, and then create
    -- a time delay and compare actual output with expected output.
    in1_tb <= '0';
    in2_tb <= '0';
    out1_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (out1_tb = out1_expected) report "Output incorrect for input = 00" severity note;
    assert (out1_tb /= out1_expected) report "Output correct for input = 00" severity note;

    in1_tb <= '0';
    in2_tb <= '1';
    out1_expected <= '0';
    wait for 10 ns;

    assert (out1_tb = out1_expected) report "Output incorrect for input = 01" severity note;
    assert (out1_tb /= out1_expected) report "Output correct for input = 01" severity note;

    in1_tb <= '1';
    in2_tb <= '0';
    out1_expected <= '0';
    wait for 10 ns;

    assert (out1_tb = out1_expected) report "Output incorrect for input = 10" severity note;
    assert (out1_tb /= out1_expected) report "Output correct for input = 10" severity note;

    in1_tb <= '1';
    in2_tb <= '1';
    out1_expected <= '1';
    wait for 10 ns;

    assert (out1_tb = out1_expected) report "Output incorrect for input = 11" severity note;
    assert (out1_tb /= out1_expected) report "Output correct for input = 11" severity note;

    -- Finally, a wait statement without any time parameter suspends the
    -- process indefintely.
    wait;
    
  end process testbench_process;

END gate_level;
