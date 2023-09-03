LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testbench IS 
END testbench;

ARCHITECTURE gate_level OF testbench IS 

  component mux_n IS 
    PORT
      (
        sel :  IN  STD_LOGIC_VECTOR(1 downto 0);
        in_n :  IN  STD_LOGIC_VECTOR(3 downto 0);
        Z :  OUT  STD_LOGIC
	);
  END component;

  signal sel_tb :  STD_LOGIC_VECTOR(1 downto 0);
  signal in_n_tb :  STD_LOGIC_VECTOR(3 downto 0);
  signal z_tb :  STD_LOGIC;
  signal z_expected : STD_LOGIC;

BEGIN 

  -- Component instantiation of Device Under Test (DUT)
  mux_n_0 : mux_n
    PORT MAP(
      sel => sel_tb,  
      in_n => in_n_tb,
      Z => z_tb
      );

  -- Concurrent process statement that applies input test vectors and
  -- monitors output results
  testbench_process : process
  begin

    -- Assign input and expected output values, and then create
    -- a time delay and compare actual output with expected output.
    sel_tb <= "00";
    in_n_tb <= "0000";
    z_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[0] = 0" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[0] = 0" severity note;

    in_n_tb <= "0001";
    z_expected <= '1';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[0] = 1" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[0] = 1" severity note;

    sel_tb <= "01";
    in_n_tb <= "0000";
    z_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[1] = 0" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[1] = 0" severity note;

    in_n_tb <= "0010";
    z_expected <= '1';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[1] = 1" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[1] = 1" severity note;

    sel_tb <= "10";
    in_n_tb <= "0000";
    z_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[2] = 0" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[2] = 0" severity note;

    in_n_tb <= "0100";
    z_expected <= '1';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[2] = 1" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[2] = 1" severity note;

    sel_tb <= "11";
    in_n_tb <= "0000";
    z_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[3] = 0" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[3] = 0" severity note;

    in_n_tb <= "1000";
    z_expected <= '1';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (z_tb = z_expected) report "Output incorrect for in_n[3] = 1" severity note;
    assert (z_tb /= z_expected) report "Output correct for in_n[3] = 1" severity note;

    -- Finally, a wait statement without any time parameter suspends the
    -- process indefintely.
    wait;
    
  end process testbench_process;

END gate_level;