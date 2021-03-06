library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
 
entity multiplier_TB is
end multiplier_TB;

architecture behavior of multiplier_TB is
  component Multiplier4
    port(Mul1, Mul2 : in std_logic_vector(3 downto 0);
         Clk, Reset : in std_logic;
         Product : out std_logic_vector(7 downto 0));
  end component;
  signal Mul1 : std_logic_vector(3 downto 0) := "0000";
  signal Mul2 : std_logic_vector(3 downto 0) := "0000";
  signal Clk : std_logic := '0';
  signal Reset : std_logic := '0';
  signal Product : std_logic_vector(7 downto 0);
  constant clk_period : time := 1 ns;
begin
  uut: Multiplier4 port map( 
        Mul1 => Mul1,
        Mul2 => Mul2,
        Clk => Clk,
        Reset => Reset,
        Product => Product);

  clk_process : process
    begin
      clk <= '0';
      wait for clk_period/2;
      clk <= '1';
      wait for clk_period/2;
  end process;
  
  process
    begin
      Reset <= '1';
      wait for 5 ns;
      Reset <= '0';
      wait for 5 ns;
      
      Mul1 <= "1001";
      Mul2 <= "1001";
      wait for 5 ns;
      wait;
    end process;
end behavior;