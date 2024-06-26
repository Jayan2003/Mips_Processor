LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY PipelinedMips_Tb IS
END PipelinedMips_Tb;
 
ARCHITECTURE behavior OF PipelinedMips_Tb IS
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Pipelined_Mips
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
   

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
-- Instantiate the Unit Under Test (UUT)
   uut: Pipelined_Mips PORT MAP (
          clk => clk,
          rst => rst
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
      rst <= '1'; -- Assert reset
      wait for 400 ns;
      rst <= '0'; -- Deassert reset after 400 ns
      wait for 400 ns;
      assert false report "End of Test" severity failure;
      -- insert stimulus here
   end process;

END behavior;