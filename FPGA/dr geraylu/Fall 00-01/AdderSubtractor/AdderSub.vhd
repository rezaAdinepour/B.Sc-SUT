library ieee;
use ieee.std_logic_1164.all;
entity add_sub is
port( m : in std_logic;
       A : in std_logic_vector(3 downto 0);
       B : in std_logic_vector(3 downto 0);
       S : out std_logic_vector(3 downto 0);
       Cout : out std_logic);
end add_sub;
architecture mak of add_sub is
begin
process(A,B)
variable c : std_logic_vector(4 downto 0);
variable k : std_logic;
begin
c(0) := m;
for i in 0 to 3 loop
k := B(i) xor m;
S(i) <= A(i) xor k xor C(i);
C(i+1) := (A(i) xor k) or (A(i) and k);
end loop;
Cout <= c(4);
end process;
end mak;