library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MUX_4to1 is
    Port ( S : in  STD_LOGIC_VECTOR (1 downto 0);
			  ab: in STD_LOGIC_VECTOR (1 downto 0);
           output : out STD_LOGIC);

end MUX_4to1;

architecture Behavioral of MUX_4to1 is

begin

process (S, ab)

begin


if (S <= "00") then
output <= ab(0) and ab(1);

elsif (S <= "01") then
output <= ab(0) or ab(1);

elsif (S <= "10") then
output <= ab(0) xor ab(1);

else
output <= not ab(0);

end if;
end process;
end Behavioral;