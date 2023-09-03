LIBRARY ieee;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;

ENTITY testbench IS 
END testbench;

ARCHITECTURE gate_level OF testbench IS 

  component Datapath
    port
      (
        reset :  IN  STD_LOGIC;
        clock :  IN  STD_LOGIC;
        cmar :  IN  STD_LOGIC;
        cmbr :  IN  STD_LOGIC;
        embr :  IN  STD_LOGIC;
        cir :  IN  STD_LOGIC;
        eir :  IN  STD_LOGIC;
        cpc :  IN  STD_LOGIC;
        epc :  IN  STD_LOGIC;
        cd0 :  IN  STD_LOGIC;
        ed0 :  IN  STD_LOGIC;
        calu :  IN  STD_LOGIC;
        ealu :  IN  STD_LOGIC;
        F0 :  IN  STD_LOGIC;
        F1 :  IN  STD_LOGIC;
        data_bus :  INOUT  STD_LOGIC_VECTOR(7 DOWNTO 0);
        address_bus :  OUT  STD_LOGIC_VECTOR(4 DOWNTO 0);
        opcode :  OUT  STD_LOGIC_VECTOR(2 DOWNTO 0);
        Z :  OUT  STD_LOGIC
        );
  END component;

  signal reset_signal :  STD_LOGIC := '0';
  signal clock_signal :  STD_LOGIC := '0';
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
  signal data_bus :  STD_LOGIC_VECTOR(7 DOWNTO 0);
  signal address_bus :  STD_LOGIC_VECTOR(4 DOWNTO 0);
  signal opcode :  STD_LOGIC_VECTOR(2 DOWNTO 0);
  signal Z :  STD_LOGIC;

BEGIN 

  datapath_0 : Datapath
    PORT MAP(
      reset => reset_signal,
      clock => clock_signal,
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
      F1 => f1_signal,
      data_bus => data_bus,
      address_bus => address_bus,
      opcode => opcode,
      Z => z
      );

  clock_process : process
  begin
    wait for 50 ns;
    clock_signal <= not clock_signal;
  end process;

  testbench_process : process
  begin

    -- Begin by initializing the input control signals.
    cmar_signal <= '0';
    cmbr_signal <= '0';
    embr_signal <= '0';
    cir_signal <= '0';
    eir_signal <= '0';
    cpc_signal <= '0';
    epc_signal <= '0';
    cd0_signal <= '0';
    ed0_signal <= '0';
    calu_signal <= '0';
    ealu_signal <= '0';
    f0_signal <= '0';
    f1_signal <= '0';
    data_bus <= (others => 'Z');

    -- Then initialize the registers at reset.
    reset_signal <= '1';
    wait for 10 ns;
    reset_signal <= '0';

    -- Now, load each register with a value from the data_bus.
    -- Memory Address Register (MAR)
    data_bus <= "11111111";
    cmar_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
    cmar_signal <= '0' after 5 ns;
	   
    -- Memory Buffer Register (MBR)
    data_bus <= "00000001";
    cmbr_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
    cmbr_signal <= '0' after 5 ns;

    -- Instruction Register (IR)
    data_bus <= "11100010";
    cir_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
    cir_signal <= '0' after 5 ns;

    -- Program Counter (PC)
    data_bus <= "00000011";
    cpc_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
    cpc_signal <= '0' after 5 ns;

    -- Data Register 0 (D0)
    data_bus <= "00000100";
    cd0_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
    cd0_signal <= '0' after 5 ns;

    -- ALU register (fPQ)
    data_bus <= "00000001";
    calu_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
    calu_signal <= '0' after 5 ns;

    -- Now, confirm that the registers have been loading by having
    -- each register drive the data bus.
    data_bus <= (others => 'Z');

    -- MBR
    embr_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
	 assert (data_bus = "00000001") report "Output incorrect for reading from MBR register, data_bus output should be 00000001" severity note;
	 assert (data_bus /= "00000001") report "Output correct for reading from MBR register, data_bus output should be 00000001" severity note;
    embr_signal <= '0' after 5 ns;

    -- IR
    eir_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
	 assert (data_bus = "11100010") report "Output incorrect for reading from IR register, data_bus output should be 11100010" severity note;
	 assert (data_bus /= "11100010") report "Output correct for reading from IR register, data_bus output should be 11100010" severity note;
    eir_signal <= '0' after 5 ns;

    -- PC
    epc_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
	 assert (data_bus = "00000011") report "Output incorrect for reading from PC register, data_bus output should be 00000011" severity note;
	 assert (data_bus /= "00000011") report "Output correct for reading from PC register, data_bus output should be 00000011" severity note;
    epc_signal <= '0' after 5 ns;

    -- D0
    ed0_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
	 assert (data_bus = "00000100") report "Output incorrect for reading from D0 register, data_bus output should be 00000100" severity note;
	 assert (data_bus /= "00000100") report "Output correct for reading from D0 register, data_bus output should be 00000100" severity note;
    ed0_signal <= '0' after 5 ns;

    -- fPQ
    ealu_signal <= '1' after 5 ns;
    wait until rising_edge(clock_signal);
	 assert (data_bus = "00000101") report "Output incorrect for reading from fPQ register, data_bus output should be 00000101" severity note;
	 assert (data_bus /= "00000101") report "Output correct for reading from fPQ register, data_bus output should be 00000101" severity note;
    ealu_signal <= '0' after 5 ns;

    wait;
    
  end process testbench_process;

END gate_level;