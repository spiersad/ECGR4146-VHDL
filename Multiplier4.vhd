library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
 
entity multiplier4 is
  port(Mul1, Mul2 : in std_logic_vector(3 downto 0);
       Clk, Reset : in std_logic;
       Product : out std_logic_vector(7 downto 0));
end multiplier4;
architecture behavior of multiplier4 is
  type state is (state0, state1, state2, state3, state4);
  signal current_state, next_state : state := state0;
  signal loadA, shiftA, loadB, shiftB, loadC : std_logic :='0';
  signal a, b : std_logic_vector(3 downto 0) := "0000";
  signal c, d, e, f : std_logic_vector(7 downto 0) := "00000000";
  begin
    c <= ("0000" & (a(0) and b(3)) & (a(0) and b(2)) & (a(0) and b(1)) & (a(0) and b(0)));
    Product <= e;
    reg1 : entity work.SReg4(behavior)
      port map(Clk => Clk, Reset => Reset, Load => loadA, SRight => shiftA,
               Parallelin => Mul1, Parallelout => a);
    reg2 : entity work.SReg4(behavior)
      port map(Clk => Clk, Reset => Reset, Load => loadA, SRight => '0',
               Parallelin => Mul2, Parallelout => b);
    reg3 : entity work.SReg8(behavior)
      port map(Clk => Clk, Reset => Reset, Load => loadB, SLeft => shiftB,
               Parallelin => c, Parallelout => d);
    reg4 : entity work.SReg8(behavior)
      port map(Clk => Clk, Reset => Reset, Load => loadC, SLeft => '0',
               Parallelin => f, Parallelout => e);
    adder : entity work.Adder8(behavior)
      port map(A => d, B => e, SUM => f);
        
    process(Clk, Reset)
      variable count, i : integer :=0;
      begin
        if (Reset = '1') then
          current_state <= state0;
        else
          current_state <= next_state;
        end if;
        if (Clk'event and Clk='1') then
          case current_state is
          when state0 =>
            loadC <= '0';
            loadA <= '1';
            shiftA <= '0';
            count := 0;
            next_state <= state1;
          when state1 =>
            loadC <= '0';
            loadA <= '0';
            loadB <= '1';
            shiftA <= '0';
            i := 0;
            next_state <= state2;
          when state2 =>
            loadB <= '0';
            shiftB <= '0';
            if (i < count) then
              next_state <= state3;
            else
              next_state <= state4;
            end if;
          when state3 =>
            i := i + 1;
            shiftB <= '1';
            next_state <= state2;
          when state4 =>
            loadC <= '1';
            shiftA <= '1';
            count := count + 1;
            if (count < 4) then
              next_state <= state1;
            else
              next_state <= state0;
            end if;
          when others =>
            next_state <= state0;
          end case;
        end if;
   end process;
end behavior;