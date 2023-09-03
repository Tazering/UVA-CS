LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY testbench IS 
END testbench;

ARCHITECTURE gate_level OF testbench IS 

  component opcode_decoder IS 
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
  END component;

  signal execute_tb :  STD_LOGIC;
  signal opcode_tb :  STD_LOGIC_VECTOR(2 downto 0);
  signal load_tb :  STD_LOGIC;
  signal store_tb : STD_LOGIC;
  signal add_tb : STD_LOGIC;
  signal sub_tb : STD_LOGIC;
  signal inc_tb : STD_LOGIC;
  signal dec_tb : STD_LOGIC;
  signal bra_tb : STD_LOGIC;
  signal beq_tb : STD_LOGIC;
  signal load_expected :  STD_LOGIC;
  signal store_expected : STD_LOGIC;
  signal add_expected : STD_LOGIC;
  signal sub_expected : STD_LOGIC;
  signal inc_expected : STD_LOGIC;
  signal dec_expected : STD_LOGIC;
  signal bra_expected : STD_LOGIC;
  signal beq_expected : STD_LOGIC;

BEGIN 

  -- Component instantiation of Device Under Test (DUT)
  opcode_decoder_0 : opcode_decoder
    PORT MAP(
      execute => execute_tb,  
      opcode => opcode_tb,
      load => load_tb,
		store => store_tb,
		add => add_tb,
		sub => sub_tb,
		inc => inc_tb,
		dec => dec_tb,
		bra => bra_tb,
		beq => beq_tb
      );

  -- Concurrent process statement that applies input test vectors and
  -- monitors output results
  testbench_process : process
  begin

    -- Assign input and expected output values, and then create
    -- a time delay and compare actual output with expected output.
	 
	 -- when execute is 0
	 -- opcode = 000
    execute_tb <= '0';
    opcode_tb <= "000";
	 
	 load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
	 
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 000" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 000" severity note;
	
	-- when execute is 0
	 -- opcode = 001
    execute_tb <= '0';
    opcode_tb <= "001";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

     assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 001" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 001" severity note;
	 
	 -- when execute is 0
	 -- opcode = 010
    execute_tb <= '0';
    opcode_tb <= "010";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 010" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 010" severity note;
	 
	 
	  -- when execute is 0
	 -- opcode = 011
    execute_tb <= '0';
    opcode_tb <= "011";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 011" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 011" severity note;
	 
	 -- when execute is 0
	 -- opcode = 100
    execute_tb <= '0';
    opcode_tb <= "100";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 100" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 100" severity note;
	 
	 -- when execute is 0
	 -- opcode = 101
    execute_tb <= '0';
    opcode_tb <= "101";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 101" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 101" severity note;
	 
	 -- when execute is 0
	 -- opcode = 110
    execute_tb <= '0';
    opcode_tb <= "110";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 110" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 110" severity note;

	 
	 -- when execute is 0
	 -- opcode = 111
    execute_tb <= '0';
    opcode_tb <= "111";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 111" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 111" severity note;
	 
	 
	 
	 
	 
	 
	 
	 -- when execute = 1 (0)
	 -- opcode = 000
    execute_tb <= '1';
    opcode_tb <= "000";
    load_expected <= '1';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 000" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 000" severity note;
	 
	 
	 --when execute = 1 (1)
	 -- opcode = 001
    execute_tb <= '1';
    opcode_tb <= "001";
    load_expected <= '0';
	 store_expected <= '1';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 001" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 001" severity note;
	 
	 --when execute = 1 (2)
	 -- opcode = 010
    execute_tb <= '1';
    opcode_tb <= "010";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '1';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 010" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 010" severity note;
	 
	 --when execute = 1 (3)
	 -- opcode = 011
    execute_tb <= '1';
    opcode_tb <= "011";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '1';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 011" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 011" severity note;
	 
	 --when execute = 1 (4)
	 -- opcode = 100
    execute_tb <= '1';
    opcode_tb <= "100";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '1';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 100" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 100" severity note;
	 
	 --when execute = 1 (5)
	 -- when execute is 0
	 -- opcode = 101
    execute_tb <= '1';
    opcode_tb <= "101";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '1';
	 bra_expected <= '0';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 101" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 101" severity note;
	 
	 
	 --when execute = 1 (6)
	 -- opcode = 110
    execute_tb <= '1';
    opcode_tb <= "110";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '1';
	 beq_expected <= '0';
    wait for 10 ns;

    -- Compare actual and expected outputs.
    assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 110" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 110" severity note;
	 --when execute = 1 (7)
	 -- opcode = 111
    execute_tb <= '1';
    opcode_tb <= "111";
    load_expected <= '0';
	 store_expected <= '0';
	 add_expected <= '0';
	 sub_expected <= '0';
	 inc_expected <= '0';
	 dec_expected <= '0';
	 bra_expected <= '0';
	 beq_expected <= '1';
    wait for 10 ns;

    -- Compare actual and expected outputs.
      assert (load_tb = load_expected and store_tb = store_expected and add_tb = add_expected and sub_tb = sub_expected and inc_tb = inc_expected and dec_tb = dec_expected and bra_tb = bra_expected and beq_tb = beq_expected) report "Output incorrect for execute = 1 and opcode_tb = 111" severity note;
    assert (load_tb /= load_expected or store_tb /= store_expected or sub_tb /= sub_expected or add_tb /= add_expected or inc_tb /= inc_expected or dec_tb /= dec_expected or bra_tb /= bra_expected or beq_tb /= beq_expected) report "Output correct for execute = 1 and opcode_tb = 111" severity note;

    -- Finally, a wait statement without any time parameter suspends the
    -- process indefintely.
    wait;
    
  end process testbench_process;

END gate_level;