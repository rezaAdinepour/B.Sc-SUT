LIBRARY ieee;
USE ieee.std_logic_1164.all;
ENTITY addsubtract IS PORT ( S : IN STD_LOGIC;
 A, B : IN STD_LOGIC_VECTOR (3 DOWNTO 0); 
 Sout : OUT STD_LOGIC_VECTOR (3 DOWNTO 0); 
 Cout : OUT STD_LOGIC);
END adderlpm;
ARCHITECTURE structural OF addsubtract IS
COMPONENT full_add PORT( a, b, c_in : IN STD_LOGIC;
c_out : OUT STD_LOGIC);
END COMPONENT;
-- Define a signal for internal carry bits
SIGNAL C : STD_LOGIC_VECTOR (4 downto 0);
SIGNAL B_comp : STD_LOGIC_VECTOR (4 downto 0);
-- add/subtract select to carry input (S = 1 for subtract)
C(0) <= S;
adders:
FOR i IN 1 to 4 GENERATE
--invert B for subtract function (B(i) xor 1,)
--do not invert B for add function (B(i) xor 0)
B_comp(i) <= B(i) xor S;
adder: full_add PORT MAP (A(i),B_comp(i),C(I -1),C(i),Sout(i));
END GENERATE;
Cout <= C(4);
END structural;