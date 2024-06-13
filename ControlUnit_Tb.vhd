LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY ControlUnit_Tb IS
END ControlUnit_Tb;
 
ARCHITECTURE behavior OF ControlUnit_Tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ControlUnit
    PORT(
         clk : IN  std_logic;
         opcode : IN  std_logic_vector(5 downto 0);
         reg_dst : OUT  std_logic;
         jump : OUT  std_logic;
         branch : OUT  std_logic;
         mem_read : OUT  std_logic;
         mem_to_reg : OUT  std_logic;
         reg_write : OUT  std_logic;
         mem_write : OUT  std_logic;
         alu_src : OUT  std_logic;
         alu_op : OUT  std_logic_vector(1 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal opcode : std_logic_vector(5 downto 0) := (others => '0');

 	--Outputs
   signal reg_dst : std_logic;
   signal jump : std_logic;
   signal branch : std_logic;
   signal mem_read : std_logic;
   signal mem_to_reg : std_logic;
   signal reg_write : std_logic;
   signal mem_write : std_logic;
   signal alu_src : std_logic;
   signal alu_op : std_logic_vector(1 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ControlUnit PORT MAP (
          clk => clk,
          opcode => opcode,
          reg_dst => reg_dst,
          jump => jump,
          branch => branch,
          mem_read => mem_read,
          mem_to_reg => mem_to_reg,
          reg_write => reg_write,
          mem_write => mem_write,
          alu_src => alu_src,
          alu_op => alu_op
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;
		-- hold reset state for 100 ns.	
		opcode<="000000";
		wait for 100 ns;
		wait for clk_period*10;
		opcode<="100011";
		wait for 100 ns;
		wait for clk_period*10;
		opcode<="101011";
		wait for 100 ns;
		wait for clk_period*10;
		opcode<="000110";
		wait for 100 ns;
		wait for clk_period*10;
		opcode<="000010";
		wait for 100 ns;
		wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
