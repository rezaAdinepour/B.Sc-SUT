library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity main is
    port( clk : in std_logic;
		  y : out std_logic_vector(7 downto 0);
		  sel_0 : out std_logic;
		  sel_1 : out std_logic );
end main;

architecture Behavioral of main is
    signal div_clk: std_logic := '0';
	signal counter : std_logic_vector(3 downto 0):= "0000";
	signal counter_1 : std_logic_vector(3 downto 0):= "0000";
	signal counter_2 : std_logic_vector(3 downto 0):= "0000";
	signal counter_3 : std_logic_vector(3 downto 0):= "0000";
	signal temp_sel : std_logic := '0';
	
	function bcd_to_7seg (x : in std_logic_vector (3 downto 0))  
	   return std_logic_vector is
	variable y : std_logic_vector(7 downto 0);
	begin 
        case(x) is
	       when "0000" =>
	           y := "11111100";
		   when "0001" =>
		       y := "01100000";
		   when "0010" => 
		       y := "11011010";
		   when "0011" => 
		       y := "11110010";
		   when "0100" => 
		       y := "01100110";
		   when "0101" => 
		       y := "10110110";
		   when "0110" => 
		       y := "10111110";
		   when "0111" => 
		       y := "11100000";
		   when "1000" => 
		       y := "11111110";
		   when "1001" => 
		       y := "11100110";
		   when others => null;
        end case;
    return y;
end bcd_to_7seg;

begin

    process(clk)
	variable i : integer range 0 to 1000 := 0;
	variable c : integer range 0 to 3 := 0;
	begin
		--temp_sel := not temp_sel;
	   if(clk'event and clk = '1') then
	       i := i + 1;
	           if i < 500 then
	               div_clk <= '0';
			   elsif i > 500 then
                   div_clk <= '1';
               end if;
       end if;
       
       if(clk'event and clk = '1') then
            c := c + 1;
			if c = 1 then
				temp_sel <= '0';
			elsif c = 3 then
				temp_sel <= '1';
			end if;
		end if;
	end process;  
	
    process(div_clk)
	begin
	   if(div_clk'event and div_clk = '1') then
			counter <= counter + 1;
	   end if;
	   if(counter = "1010") then  
	       counter <= "0000";
		   counter_1 <= counter_1 + 1;		
	   end if;
	   if(counter_1 = "1010") then  
	       counter_1 <= "0000";
		   counter_2 <= counter_2 + 1;
	   end if;
	   if(counter_2 = "1010") then  
	       counter_2 <= "0000";
	   end if;
    end process;
    
    process(temp_sel)
	begin
		if temp_sel = '0' then
			sel_0 <= '1';
			sel_1 <= '0'; 
			y <= bcd_to_7seg(counter);
		elsif temp_sel = '1' then
			sel_0 <= '0';
			sel_1 <= '1';
			y <= bcd_to_7seg(counter_1);
		end if;
	end process;
end Behavioral;