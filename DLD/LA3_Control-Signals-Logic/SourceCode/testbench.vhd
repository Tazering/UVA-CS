LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY testbench IS 
END testbench;

ARCHITECTURE gate_level OF testbench IS 

  component control_signals_logic
    PORT
      (
    reset : in std_logic;
    clock : in std_logic;
    load : in std_logic;
    store : in std_logic;
    add : in std_logic;
    sub : in std_logic;
    inc : in std_logic;
    dec : in std_logic;
    bra : in std_logic;
    beq : in std_logic;
    t0 : in std_logic;
    t1 : in std_logic;
    t2 : in std_logic;
    t3 : in std_logic;
    t4 : in std_logic;
    t5 : in std_logic;
    t6 : in std_logic;
    t7 : in std_logic;
    Z : in std_logic;
    r : out std_logic;
    w : out std_logic;
    cmar : out std_logic;
    cmbr : out std_logic;
    embr : out std_logic;
    cir : out std_logic;
    eir : out std_logic;
    cpc : out std_logic;
    epc : out std_logic;
    cd0 : out std_logic;
    ed0 : out std_logic;
    calu : out std_logic;
    ealu : out std_logic;
    F0 : out std_logic;
    F1 : out std_logic
	);
  END component;

  -- input signals
  signal reset_signal :  STD_LOGIC;
  signal clock_signal :  STD_LOGIC;
  signal load_signal :  STD_LOGIC;
  signal store_signal :  STD_LOGIC;
  signal add_signal :  STD_LOGIC;
  signal sub_signal :  STD_LOGIC;
  signal inc_signal :  STD_LOGIC;
  signal dec_signal :  STD_LOGIC;
  signal bra_signal :  STD_LOGIC;
  signal beq_signal :  STD_LOGIC;
  signal t0_signal :  STD_LOGIC;
  signal t1_signal :  STD_LOGIC;
  signal t2_signal :  STD_LOGIC;
  signal t3_signal :  STD_LOGIC;
  signal t4_signal :  STD_LOGIC;
  signal t5_signal :  STD_LOGIC;
  signal t6_signal :  STD_LOGIC;
  signal t7_signal :  STD_LOGIC;
  signal Z_signal :  STD_LOGIC;

  -- output signals
  signal r_signal :  STD_LOGIC;
  signal w_signal :  STD_LOGIC;
  signal cmar_signal :  STD_LOGIC;
  signal cmbr_signal :  STD_LOGIC;
  signal embr_signal :  STD_LOGIC;
  signal cir_signal :  STD_LOGIC;
  signal eir_signal :  STD_LOGIC;
  signal cpc_signal :  STD_LOGIC;
  signal epc_signal :  STD_LOGIC;
  signal cd0_signal :  STD_LOGIC;
  signal ed0_signal :  STD_LOGIC;
  signal calu_signal :  STD_LOGIC;
  signal ealu_signal :  STD_LOGIC;
  signal f0_signal :  STD_LOGIC;
  signal f1_signal :  STD_LOGIC;

  signal r_expected :  STD_LOGIC;
  signal w_expected :  STD_LOGIC;
  signal cmar_expected :  STD_LOGIC;
  signal cmbr_expected :  STD_LOGIC;
  signal embr_expected :  STD_LOGIC;
  signal cir_expected :  STD_LOGIC;
  signal eir_expected :  STD_LOGIC;
  signal cpc_expected :  STD_LOGIC;
  signal epc_expected :  STD_LOGIC;
  signal cd0_expected :  STD_LOGIC;
  signal ed0_expected :  STD_LOGIC;
  signal calu_expected :  STD_LOGIC;
  signal ealu_expected :  STD_LOGIC;
  signal f0_expected :  STD_LOGIC;
  signal f1_expected :  STD_LOGIC;

BEGIN 

  control_signals_logic_0 : control_signals_logic
    PORT MAP(
    reset => reset_signal,
    clock => clock_signal,
    load => load_signal,
    store => store_signal,
    add => add_signal,
    sub => sub_signal,
    inc => inc_signal,
    dec => dec_signal,
    bra => bra_signal,
    beq => beq_signal,
    t0 => t0_signal,
    t1 => t1_signal,
    t2 => t2_signal,
    t3 => t3_signal,
    t4 => t4_signal,
    t5 => t5_signal,
    t6 => t6_signal,
    t7 => t7_signal,
    Z => Z_signal,
    r => r_signal,
    w => w_signal,
    cmar => cmar_signal,
    cmbr => cmbr_signal,
    embr => embr_signal,
    cir => cir_signal,
    eir => eir_signal,
    cpc => cpc_signal,
    epc => epc_signal,
    cd0 => cd0_signal,
    ed0 => ed0_signal,
    calu => calu_signal,
    ealu => ealu_signal,
    F0 => f0_signal,
    F1 => f1_signal
      );

  testbench_process : process
  begin
    -- Input signals: Reset Clock Load Store Add Sub Inc Dec Bra Beq T0 T1 T2 T3 T4 T5 T6 T7 Z
    -- Output signals:  R W Cmar Cmbr Cpc Cir Cd0 Calu Embr Epc Eir Ed0 Ealu F1 F0

    -- Initialize input signals and expected values
    reset_signal <= '0';
    clock_signal <= '0';
    load_signal <= '0';
    store_signal <= '0';
    add_signal <= '0';
    sub_signal <= '0';
    inc_signal <= '0';
    dec_signal <= '0';
    bra_signal <= '0';
    beq_signal <= '0';
    t0_signal <= '0';
    t1_signal <= '0';
    t2_signal <= '0';
    t3_signal <= '0';
    t4_signal <= '0';
    t5_signal <= '0';
    t6_signal <= '0';
    t7_signal <= '0';
    Z_signal <= '0';
    
    r_expected <= '0';
    w_expected <= '0';
    cmar_expected <= '0';
    cmbr_expected <= '0';
    cpc_expected <= '0';
    cir_expected <= '0';
    cd0_expected <= '0';
    calu_expected <= '0';
    embr_expected <= '0';
    epc_expected <= '0';
    eir_expected <= '0';
    ed0_expected <= '0';
    ealu_expected <= '0';
    f1_expected <= '0';
    f0_expected <= '0';

    wait for 10 ns;

    -- Load instruction
    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';
	 
	 
	-- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;
	 
    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';
	 

    -- ALU (Q) <- [PC]
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    load_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] LOAD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] LOAD" severity note;

    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] LOAD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] LOAD" severity note;


    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';

    -- MAR <- [IR]
    clock_signal <= not clock_signal;
    t4_signal <= '1';
    cmar_expected <= '1';
    eir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MAR <- [IR] LOAD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MAR <- [IR] LOAD" severity note;

    
    t4_signal <= '0';
    cmar_expected <= '0';
    eir_expected <= '0';

    -- D0 <- [MAR]
    clock_signal <= not clock_signal;
    t5_signal <= '1';
    r_expected <= '1';
    cd0_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for D0 <- [MAR] LOAD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for D0 <- [MAR] LOAD" severity note;
 
    load_signal <= '0';
    t5_signal <= '0';
    r_expected <= '0';
    cd0_expected <= '0';
	 
	 
	 

    -- Store instruction
    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    store_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] STORE" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] STORE" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] STORE" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] STORE" severity note;


    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
	 
   -- MAR <- [IR] --
    clock_signal <= not clock_signal;
    t4_signal <= '1';
    cmar_expected <= '1';
    eir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MAR <- [IR] STORE" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MAR <- [IR] STORE" severity note;
    
    t4_signal <= '0';
    cmar_expected <= '0';
    eir_expected <= '0';
	 
    -- [MAR] <- [D0]
	 t5_signal <= '1';
	 w_expected <= '1';
	 ed0_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for D0 <- [MAR] STORE" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for D0 <- [MAR] STORE" severity note;
 
	 
	 store_signal <= '0';
	 t5_signal <= '0';
	 w_expected <= '0';
	 ed0_expected <= '0';
	 
	 
	 

    -- Add instruction
    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]--
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    add_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] ADD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] ADD" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]--
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] ADD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] ADD" severity note;

    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
	 
	 
    -- MAR <- [IR]--
    clock_signal <= not clock_signal;
    t4_signal <= '1';
    cmar_expected <= '1';
    eir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MAR <- [IR] ADD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MAR <- [IR] ADD" severity note;

    
    t4_signal <= '0';
    cmar_expected <= '0';
    eir_expected <= '0';
	 
    -- MBR <- [MAR] --
	 clock_signal <= not clock_signal;
	 t5_signal <= '1';
	 r_expected <= '1';
	 cmbr_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MBR <- [MAR] ADD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MBR <- [MAR] ADD" severity note;

	 
	 t5_signal <= '0';
	 r_expected <= '0';
	 cmbr_expected <= '0';
	 
    -- ALU (P) <- [MBR]
	 clock_signal <= not clock_signal;
	 t6_signal <= '1';
	 calu_expected <= '1';
	 embr_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for ALU (P) <- [MBR] ADD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for ALU (P) <- [MBR] ADD" severity note;

	 
	 t6_signal <= '0';
	 calu_expected <= '0';
	 embr_expected <= '0';
	 
    -- D0 <- [ALU] --
	 clock_signal <= not clock_signal;
	 t7_signal <= '1';
	 cd0_expected <= '1';
	 ealu_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for D0 <- [ALU] ADD" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for D0 <- [ALU] ADD" severity note;

	 
	 t7_signal <= '0';
	 cd0_expected <= '0';
	 ealu_expected <= '0';
	 add_signal <= '0';
	 
	 

    -- Sub instruction
    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]--
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    sub_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] sub" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] sub" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]--
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] sub" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] sub" severity note;

    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
	 
	 
    -- MAR <- [IR]--
    clock_signal <= not clock_signal;
    t4_signal <= '1';
    cmar_expected <= '1';
    eir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MAR <- [IR] sub" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MAR <- [IR] sub" severity note;

    
    t4_signal <= '0';
    cmar_expected <= '0';
    eir_expected <= '0';
	 
    -- MBR <- [MAR] --
	 clock_signal <= not clock_signal;
	 t5_signal <= '1';
	 r_expected <= '1';
	 cmbr_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MBR <- [MAR] sub" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MBR <- [MAR] sub" severity note;

	 
	 t5_signal <= '0';
	 r_expected <= '0';
	 cmbr_expected <= '0';
	 
    -- ALU (P) <- [MBR]
	 clock_signal <= not clock_signal;
	 t6_signal <= '1';
	 calu_expected <= '1';
	 embr_expected <= '1';
	 f0_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for ALU (P) <- [MBR] sub" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for ALU (P) <- [MBR] sub" severity note;

	 f0_expected <= '0';
	 t6_signal <= '0';
	 calu_expected <= '0';
	 embr_expected <= '0';
	 
    -- D0 <- [ALU] --
	 clock_signal <= not clock_signal;
	 t7_signal <= '1';
	 cd0_expected <= '1';
	 ealu_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for D0 <- [ALU] sub" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for D0 <- [ALU] sub" severity note;

	 sub_signal <= '0';
	 t7_signal <= '0';
	 cd0_expected <= '0';
	 ealu_expected <= '0';
	 
	 

    -- Inc instruction
    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]--
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    inc_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] inc" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] inc" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]--
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] inc" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] inc" severity note;

    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
	 
	 
    -- MAR <- [IR] --
	 clock_signal <= not clock_signal;
	 t4_signal <= '1';
	 cmar_expected <= '1';
	 eir_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MAR <- [IR] inc" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MAR <- [IR] inc" severity note;

	 t4_signal <= '0';
	 cmar_expected <= '0';
	 eir_expected <= '0';
	 
    -- MBR <- [MAR]--
	 clock_signal <= not clock_signal;
	 t5_signal <= '1';
	 r_expected <= '1';
	 cmbr_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MBR <- [MAR] inc" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MBR <- [MAR] inc" severity note;

	 t5_signal <= '0';
	 r_expected <= '0';
	 cmbr_expected <= '0';
	 
    -- ALU (P) <- [MBR] --
	 clock_signal <= not clock_signal;
	 t6_signal <= '1';
	 calu_expected <= '1';
	 embr_expected <= '1';
	 f1_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for ALU (P) <- [MBR] inc" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for ALU (P) <- [MBR] inc" severity note;

	 t6_signal <= '0';
	 calu_expected <= '0';
	 embr_expected <= '0';
	 f1_expected <= '0';
	 
    -- D0 <- [ALU]
	 clock_signal <= not clock_signal;
	 t7_signal <= '1';
	 w_expected <= '1';
	 ealu_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for D0 <- [ALU] inc" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for D0 <- [ALU] inc" severity note;
		
	 t7_signal <= '0';
	 w_expected <= '0';
	 ealu_expected <= '0';
	 inc_signal <= '0';
	 
	 
	 
    -- Dec instruction
    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]--
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    dec_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] dec" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] dec" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]--
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] dec" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] dec" severity note;

    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
	 
	 
    -- MAR <- [IR] --
	 clock_signal <= not clock_signal;
	 t4_signal <= '1';
	 cmar_expected <= '1';
	 eir_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MAR <- [IR] dec" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MAR <- [IR] dec" severity note;

	 t4_signal <= '0';
	 cmar_expected <= '0';
	 eir_expected <= '0';
	 
    -- MBR <- [MAR]--
	 clock_signal <= not clock_signal;
	 t5_signal <= '1';
	 r_expected <= '1';
	 cmbr_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for MBR <- [MAR] dec" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for MBR <- [MAR] dec" severity note;

	 t5_signal <= '0';
	 r_expected <= '0';
	 cmbr_expected <= '0';
	 
    -- ALU (P) <- [MBR] --
	 clock_signal <= not clock_signal;
	 t6_signal <= '1';
	 calu_expected <= '1';
	 embr_expected <= '1';
	 f1_expected <= '1';
	 f0_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for ALU (P) <- [MBR] dec" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for ALU (P) <- [MBR] dec" severity note;

	 t6_signal <= '0';
	 calu_expected <= '0';
	 embr_expected <= '0';
	 f1_expected <= '0';
	 f0_expected <= '0';
	 
    -- D0 <- [ALU]
	 clock_signal <= not clock_signal;
	 t7_signal <= '1';
	 w_expected <= '1';
	 ealu_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for D0 <- [ALU] dec" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for D0 <- [ALU] dec" severity note;
		
	 t7_signal <= '0';
	 w_expected <= '0';
	 ealu_expected <= '0';
	 dec_signal <= '0';

	 
	 
	 
    -- Bra instruction
    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]--
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    bra_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] bra" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] bra" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]--
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] bra" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] bra" severity note;

    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
    
	 -- PC <- [IR]
	 clock_signal <= not clock_signal;
	 t4_signal <= '1';
	 cpc_expected <= '1';
	 eir_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for PC <- IR bra" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for PC <- IR bra" severity note;

	 t4_signal <= '0';
	 cpc_expected <= '0';
	 eir_expected <= '0';
	 bra_signal <= '0';
	 

    -- Beq instruction
    -- To test the Beq instruction, we must use test vectors that assign Z = 0 and Z = 1.

    -- Assign Z = 1 and ensure the value is stored during T6 before the branch
    -- instruction.
	 clock_signal <= not clock_signal;
	 t6_signal <= '1';
	 add_signal <= '1';
	 Z_signal <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 t6_signal <= '0';
	 add_signal <= '0';
	 Z_signal <= '0';
	 

    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]--
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    beq_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] beq" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] beq" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]--
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] beq" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] beq" severity note;

    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
	 
    -- PC <- [IR] when Z = 1
	 t4_signal <= '1';
	 Z_signal <= '1';
	 cpc_expected <= '1';
	 eir_expected <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for PC <- [IR] beq when Z = 1" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for PC <- [IR] beq when Z = 1" severity note;

	 t4_signal <= '0';
	 Z_signal <= '0';
	 cpc_expected <= '0';
	 eir_expected <= '0';
	 beq_signal <= '0';
	 
	 
	 
	 
    -- Then, assign Z = 0 and once again ensure the value is stored before the
    -- branch.
	 
	 -- Assign Z = 0 and ensure the value is stored during T6 before the branch
    -- instruction.
	 clock_signal <= not clock_signal;
	 t6_signal <= '1';
	 add_signal <= '1';
	 Z_signal <= '1';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 t6_signal <= '0';
	 add_signal <= '0';
	 Z_signal <= '0';

    -- Fetch
    -- MAR <- [PC]
    clock_signal <= not clock_signal;
    t0_signal <= '1';
    cmar_expected <= '1';
    epc_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch MAR <- [PC]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch MAR <- [PC]" severity note;
   

    t0_signal <= '0';
    cmar_expected <= '0';
    epc_expected <= '0';

    -- IR <- [MAR]
    clock_signal <= not clock_signal;
    t1_signal <= '1';
    r_expected <= '1';
    cir_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch IR <- [MAR]" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch IR <- [MAR]" severity note;


    t1_signal <= '0';
    r_expected <= '0';
    cir_expected <= '0';

    -- ALU (Q) <- [PC]--
    clock_signal <= not clock_signal;
    t2_signal <= '1';
    beq_signal <= '1';
    calu_expected <= '1';
    epc_expected <= '1';
    f1_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;

	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch ALU (Q) <- [PC] beq" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch ALU (Q) <- [PC] beq" severity note;

	 
    t2_signal <= '0';
    calu_expected <= '0';
    epc_expected <= '0';
    f1_expected <= '0';

    -- PC <- [ALU]--
    clock_signal <= not clock_signal;
    t3_signal <= '1';
    cpc_expected <= '1';
    ealu_expected <= '1';

    wait for 10 ns;
    clock_signal <= not clock_signal;
    wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for Fetch PC <- [ALU] beq" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for Fetch PC <- [ALU] beq" severity note;

    t3_signal <= '0';
    cpc_expected <= '0';
    ealu_expected <= '0';
	 
    -- PC <- [IR] when Z = 0
	 t4_signal <= '1';
	 Z_signal <= '0';
	 
	 wait for 10 ns;
	 clock_signal <= not clock_signal;
	 wait for 10 ns;
	 
	 assert(r_expected = r_signal and w_expected = w_signal and cmar_expected = cmar_signal and cmbr_expected = cmbr_signal and cpc_expected = cpc_signal and cir_expected = cir_signal and cd0_expected = cd0_signal and calu_expected = calu_signal and embr_expected = embr_signal and epc_expected = epc_signal and eir_expected = eir_signal and ed0_expected = ed0_signal and ealu_expected = ealu_signal and f1_expected = f1_signal and f0_expected = f0_signal) report "Output incorrect for PC <- [IR] beq when Z = 0" severity note;
	 assert(r_expected /= r_signal and w_expected /= w_signal and cmar_expected /= cmar_signal and cmbr_expected /= cmbr_signal and cpc_expected /= cpc_signal and cir_expected /= cir_signal and cd0_expected /= cd0_signal and calu_expected /= calu_signal and embr_expected /= embr_signal and epc_expected /= epc_signal and eir_expected /= eir_signal and ed0_expected /= ed0_signal and ealu_expected /= ealu_signal and f1_expected /= f1_signal and f0_expected /= f0_signal) report "Output correct for PC <- [IR] beq when Z = 0" severity note;

	 t4_signal <= '0';
	 Z_signal <= '0';
	 beq_signal <= '0';

    -- Once all of the tests are complete, a wait statement without any timing
    -- parameters will halt the concurrent process.
    wait;
    
  end process testbench_process;

END gate_level;
