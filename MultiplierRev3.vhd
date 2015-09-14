library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
 
entity multiplierRev3 is
  port(Mul1, Mul2 : in std_logic_vector(3 downto 0);
       Start : in std_logic;
       Clk, Reset : in std_logic;
       Done : out std_logic;
       Product : out std_logic_vector(7 downto 0));
end multiplierRev3;
architecture behavior of multiplierRev3 is
  type state is (state0, state1, state2, state3);
  signal current_state, next_state : state := state0;
  signal loadA, shiftA, loadB, loadC, Clear : std_logic :='0';
  signal Ctl : std_logic_vector(1 downto 0) := "00";
  signal a, b, c : std_logic_vector(3 downto 0) := "0000";
  signal d, e, f : std_logic_vector(7 downto 0) := "00000000";
  begin
    c <= (a(0) and b(3)) & (a(0) and b(2)) & (a(0) and b(1)) & (a(0) and b(0));
    Product <= f;
    reg1 : entity work.SReg4(behavior)
      port map(Clk => Clk, Reset => Reset, Load => loadA, SRight => shiftA,
               Parallelin => Mul1, Parallelout => a);
    reg2 : entity work.SReg4(behavior)
      port map(Clk => Clk, Reset => Reset, Load => loadA, SRight => '0',
               Parallelin => Mul2, Parallelout => b);
    reg3 : entity work.SReg8(behavior)
      port map(Clk => Clk, Reset => Clear, Load => loadB, SLeft => '0',
               Parallelin => d, Parallelout => e);
    reg4 : entity work.SReg8(behavior)
      port map(Clk => Clk, Reset => Reset, Load => loadC, SLeft => '0',
               Parallelin => e, Parallelout => f);
    adder : entity work.AddShifter(behavior)
      port map(A => c, B => e, SUM => d, Ctl => Ctl );
        
    process(Clk, Reset)
      begin
        if (Reset = '1') then
          current_state <= state0;
          loadA <= '0';
          loadB <='0';
          loadC <='0';
          shiftA <= '0';
          Ctl <= "00";
          done <= '0';
          clear <= '1';
        else
          if (Clk'event and Clk='1') then
            case current_state is
            when state0 =>
              loadA <= '1';
              Ctl <= "00";
              Clear <= '1';
              shiftA <= '0';
              loadC <= '0';
              Done <= '0';
              if (Start = '1') then
                next_state <= state1;
              else
                next_state <= state0;
              end if;
            when state1 =>
              loadB <= '1';
              loadA <= '0';
              clear <= '0';
              shiftA <= '0';
              if (Ctl < "11") then
                next_state <= state2; 
              else
                next_state <= state3;
              end if;
            when state2 =>
              shiftA <= '1';
              loadB <= '0';
              Ctl <= Ctl + "01";
              next_state <= state1;
            when state3 =>
              loadC <= '1';
              loadB <= '0';
              Done <= '1';
              next_state <= state0;
            when others =>
              next_state <= state0;
            end case;
          end if;
        current_state <= next_state;
      end if;
   end process;
end behavior;
