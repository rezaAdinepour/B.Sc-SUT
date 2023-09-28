--           ******************************************************
--          **   course         : FPGA                            **
--         ***   HomeWork       : 01                              ***
--        ****   Topic          : Numeric Std Functions           ****
--        ****   AUTHOR         : Reza Adinepour                  ****
--         ***   Student ID:    : 9814303                         ***
--          **   Github         : github.com/reza_adinepour/      **
--           ******************************************************

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;


entity main is
    Port ( i_a : in std_logic_vector(3 downto 0);
           i_b : in std_logic_vector(3 downto 0);
           i_clk : in std_logic;
           
           o_add : out std_logic_vector(3 downto 0);
           o_sub : out std_logic_vector(3 downto 0);
           o_prod : out std_logic_vector(7 downto 0);
           o_div : out std_logic_vector(3 downto 0);
           o_rShift : out std_logic_vector(3 downto 0);
           o_lShift : out std_logic_vector(3 downto 0);
           o_rol : out std_logic_vector(3 downto 0);
           o_srl : out std_logic_vector(3 downto 0);
           o_resize : out std_logic_vector(7 downto 0);
           o_abs : out std_logic_vector(3 downto 0);
           o_mod : out std_logic_vector(3 downto 0));
end main;

architecture Behavioral of main is

begin
    process(i_clk)
    begin
        if(rising_edge(i_clk)) then
            o_add <= std_logic_vector(signed(i_a) + signed(i_b) );
            o_sub <= std_logic_vector(signed(i_a) - signed(i_b) );
            o_prod <= std_logic_vector(signed(i_a) * signed(i_b) );
            --o_div <= std_logic_vector( signed(i_a) / signed(i_b));
            o_rShift <= std_logic_vector( shift_right(signed(i_a), 2));
            o_lShift <= std_logic_vector( shift_left(signed(i_a), 2));
            o_rol <= std_logic_vector(ROTATE_LEFT(signed(i_a), 2));
            o_srl <= std_logic_vector(signed(i_a) srl 2);
            o_resize <= std_logic_vector(resize(signed(i_a), 8));
            --o_Mod <= std_logic_vector( signed(i_a) rem signed(i_b) );
            o_abs <= std_logic_vector(abs(signed(i_a)));
        end if;
    end process;
end Behavioral;