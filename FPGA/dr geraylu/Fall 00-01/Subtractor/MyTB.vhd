
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
  
ENTITY MyTB IS
END MyTB;
 
ARCHITECTURE behavior OF MyTB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT full_sub
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         c : IN  std_logic_vector(3 downto 0);
         sub : OUT  std_logic_vector(3 downto 0);
         borrow : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal c : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal sub : std_logic_vector(3 downto 0);
   signal borrow : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: full_sub PORT MAP (
          a => a,
          b => b,
          c => c,
          sub => sub,
          borrow => borrow
        );
 -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      a   <=   "1111";
		b   <=   "0000";
		
		 wait for 100 ns;	

      a   <=   "1000";
		b   <=   "0100";
		
		 wait for 100 ns;	

      a   <=   "1100";
		b   <=   "0011";

      -- insert stimulus here 

      wait;
   end process;

END;
