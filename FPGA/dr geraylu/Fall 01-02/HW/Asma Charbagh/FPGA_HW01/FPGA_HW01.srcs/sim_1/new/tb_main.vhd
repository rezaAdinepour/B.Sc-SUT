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


entity tb_main is
--  Port ( );
end tb_main;

architecture Behavioral of tb_main is
    
    -- Component Declaration for the Unit Under Test (UUT)
    component main 
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
           o_mod : out std_logic_vector(3 downto 0) );
    end component;
    
    --input signals
    signal i_a : std_logic_vector(3 downto 0) := (others => '0');
    signal i_b : std_logic_vector(3 downto 0) := (others => '0');
	signal i_clk : std_logic := '0';
    constant clkPeriod : time := 100 ns;
    
    --output signals
    signal o_add : std_logic_vector(3 downto 0) := (others => '0');
    signal o_sub : std_logic_vector(3 downto 0) := (others => '0');
    signal o_prod : std_logic_vector(7 downto 0) := (others => '0');
    signal o_div : std_logic_vector(3 downto 0) := (others => '0');
    signal o_rShift : std_logic_vector(3 downto 0) := (others => '0');
    signal o_lShift : std_logic_vector(3 downto 0) := (others => '0');
    signal o_rol : std_logic_vector(3 downto 0) := (others => '0');
    signal o_srl : std_logic_vector(3 downto 0) := (others => '0');
    signal o_resize : std_logic_vector(7 downto 0) := (others => '0');
    signal o_abs : std_logic_vector(3 downto 0) := (others => '0');
    signal o_mod : std_logic_vector(3 downto 0) := (others => '0');

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: main port map(
                        i_a => i_a,
                        i_b => i_b,
                        i_clk => i_clk,
                        o_add => o_add,
                        o_sub => o_sub,
                        o_prod => o_prod,
                        o_div => o_div,
                        o_rShift => o_rShift,
                        o_lShift => o_lShift,
                        o_rol => o_rol,
                        o_srl => o_srl,
                        o_resize => o_resize,
                        o_abs => o_abs,
                        o_mod => o_mod
                       );
							
							
	-- Clock process definitions
	CLK_process: process
	begin
		i_clk <= '0';
		wait for clkPeriod/2;
		i_clk <= '1';
		wait for clkPeriod/2;
   end process;
   
    
    -- Stimulus process
    stim_process: process
    begin
        -- hold rest state for 100 ns
        wait for 100 ns;
        -- insert stimulus here
        
        i_a <= "0101";
        i_b <= "1010";
        wait for 100 ns;
        
        i_a <= "1101";
        i_b <= "0010";
        wait for 100 ns;
        
        i_a <= "0100";
        i_b <= "0010";
        wait for 100 ns;
        
        i_a <= "1101";
        i_b <= "1011";
        wait for 100 ns;
        
        i_a <= "0110";
        i_b <= "0110";
        wait for 100 ns;
        
        i_a <= "1111";
        i_b <= "0000";
        wait for 100 ns;
        
        i_a <= "1000";
        i_b <= "0010";
        wait for 100 ns;
        
        i_a <= "0001";
        i_b <= "1000";
        wait for 100 ns;
        
    
    
        
        wait;
    end process;
end Behavioral;
