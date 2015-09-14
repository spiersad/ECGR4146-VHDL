library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
 
entity multiplierRev3_TB is
end multiplierRev3_TB;

architecture behavior of multiplierRev3_TB is
  component MultiplierRev3
    port(Mul1, Mul2 : in std_logic_vector(3 downto 0);
         Start : in std_logic;
         Clk, Reset : in std_logic;
         Done : out std_logic;
         Product : out std_logic_vector(7 downto 0));
  end component;
  signal Mul1 : std_logic_vector(3 downto 0) := "0000";
  signal Mul2 : std_logic_vector(3 downto 0) := "0000";
  signal Start : std_logic := '0';
  signal Clk : std_logic := '0';
  signal Reset : std_logic := '0';
  signal Done : std_logic := '0';
  signal Product : std_logic_vector(7 downto 0);
  constant clk_period : time := 1 ns;
begin
  uut: MultiplierRev3 port map( 
        Mul1 => Mul1,
        Mul2 => Mul2,
        Start => Start,
        Clk => Clk,
        Reset => Reset,
        Done => Done,
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
      Start <= '1';
      wait for 1 ns;
      Start <= '0';
      wait until (done = '0' and done'event);
      wait for 1 ns;
      
      Mul1 <= "1110";
      Mul2 <= "0011";
      Start <= '1';
      wait for 1 ns;
      Start <= '0';
      wait until (done = '0' and done'event);
      wait for 1 ns;
      
      Mul1 <= "1011";
      Mul2 <= "0110";
      Start <= '1';
      wait for 1 ns;
      Start <= '0';
      wait until (done = '0' and done'event);
      wait for 1 ns;
      
      Mul1 <= "1111";
      Mul2 <= "1000";
      Start <= '1';
      wait for 1 ns;
      Start <= '0';
      wait until (done = '0' and done'event);
      wait for 1 ns;
      
      Mul1 <= "1010";
      Mul2 <= "0101";
      Start <= '1';
      wait for 1 ns;
      Start <= '0';
      wait until (done = '0' and done'event);
      wait for 1 ns;
      
      Mul1 <= "1100";
      Mul2 <= "0101";
      Start <= '1';
      wait for 1 ns;
      Start <= '0';
      wait until (done = '0' and done'event);
      wait for 1 ns;
      
      Mul1 <= "0111";
      Mul2 <= "0011";
      Start <= '1';
      wait for 1 ns;
      Start <= '0';
      wait until (done = '0' and done'event);
      wait for 1 ns;
      wait;
    end process;
end behavior;