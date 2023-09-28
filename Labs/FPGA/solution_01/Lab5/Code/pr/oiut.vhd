-- Company: 
-- Engineer:
--
-- Create Date:    00:07:12 01/01/02
-- Design Name:    
-- Module Name:    pr - Behavioral
-- Project Name:   
-- Target Device:  
-- Tool versions:  
-- Description:
--
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity pr is
   Port (
		 b : in std_logic;
		 clk : in std_logic;
		 Q : out std_logic_vector(5 downto 0);
		 dpp : out std_logic;
		 Z : out std_logic_vector(0 to 6);
		 rest : in std_logic);

end pr;

architecture Behavioral of pr is
	     signal counter1 : std_logic_vector(3 downto 0) := "0000";
		  signal counter2 : std_logic_vector(3 downto 0) := "0000";
		  signal counter3 : std_logic_vector(3 downto 0) := "0000";
		  signal counter4 : std_logic_vector(3 downto 0) := "0000";
		  signal counter5 : std_logic_vector(3 downto 0) := "0000";
		  signal counter6 : std_logic_vector(3 downto 0) := "0000";
		  signal clk_1s : std_logic := '0';
        function Bcd_7seg( s : std_logic_vector(3 downto 0))                            
		  return std_logic_vector is
		  variable y : std_logic_vector(6 downto 0);
		  begin
		  case (s) is
		    when "0000" =>
		    y:= "1111110";
		    when "0001" =>
		    y:= "0110000";
		    when "0010" =>
		    y:= "1101101";
		    when "0011" =>
		    y:= "1111001";
		    when "0100" =>
		    y:= "0110011";
		    when "0101" =>
		    y:= "1011011";
		    when "0110" =>
		    y:= "1011111";
		    when "0111" =>
		    y:= "1110000";
		    when "1000" =>
		    y:= "1111111";
		    when "1001" =>
		    y:= "1111011";
		    when others =>
		    y:= "0000000";
		   end case;
			return y;
			end Bcd_7seg;
begin
	 dpp <= b;
	 
    process (clk)
	 variable counter0 : integer range 0 to 1000:= 0;
	 begin
	    if (clk'event and clk = '1') then
	      counter0 := counter0 + 1;
         if (counter0 < 500) then
			  	clk_1s <= '0';
         elsif (counter0 >= 500) then
			   clk_1s <= '1';
         end if;
       end if;
    end process;
		 process (rest, clk_1s)
		 begin
		 if(rest = '0') then
		 	 counter1 <= "0000";
			 counter2 <= "0000";
			 counter3 <= "0000";
			 counter4 <= "0000";
			 counter5 <= "0000";
			 counter6 <= "0000";
			else
			 	if (clk_1s'event and clk_1s='1')then
			     counter1 <= counter1+1;
				  if (counter1 = "1001") then
				    counter1 <= "0000";
					    counter2 <= counter2+1;
						 if (counter2 = "0101") then
						    counter2 <= "0000";
							 counter3 <= counter3+1;
							 if(counter3 = "1001") then
								counter3 <= "0000";
					    		counter4 <= counter4+1;
								if(counter4 = "0101")then
									counter4 <= "0000";
									counter5 <= counter5+1;
									if(counter5 = "1001") then
										counter5 <= "0000";
										counter6 <= counter6+1;
										if(counter6 = "0010") then
											counter6 <= "0000";
											counter5 <= "0000";
											counter4 <= "0000";
											counter3 <= "0000";
											counter2 <= "0000";
											counter1 <= "0000";				 	
										end if;	
									end if;
								end if;
							 end if;
						 end if; 
	           end if;
	        end if;
		 end if;
       end process;
		 process(clk)
		 variable C: integer range 0 to 5 := 0;
		 begin
		 if (clk'event and clk='1') then
		   C:=C+1;
			  if (C=1)then 
			    Q <= "000001";
				 Z <= Bcd_7seg(counter1);
           elsif (C = 2) then
			    Q <= "000010";
				 Z <= Bcd_7seg(counter2);
				elsif(c = 3) then
					Q <= "000100";
				 	Z <= Bcd_7seg(counter3);
				elsif(c = 4) then
					Q <= "001000";
				 	Z <= Bcd_7seg(counter4);
				elsif(c = 5) then
					Q <= "010000";
				 	Z <= Bcd_7seg(counter5);
				elsif(c = 6) then
					Q <= "100000";
				 	Z <= Bcd_7seg(counter6);				
			  end if;
       end if;
		 end process;
end Behavioral;