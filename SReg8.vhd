library ieee;
use ieee.std_logic_1164.all;

entity SReg8 is
  port (Clk, Reset, Load, SLeft : in std_logic;
        Parallelin : in std_logic_vector(7 downto 0);
        Parallelout : out std_logic_vector(7 downto 0));
end SReg8;

architecture behavior of SReg8 is
  signal tmp: std_logic_vector(7 downto 0);
  begin
    process(Clk, Reset)
      begin
        if (Clk'event and Clk='1') then
          if (Reset='1') then
            tmp <= "00000000";
          elsif (Load='1') then
            tmp <= Parallelin;
          elsif (SLeft='1') then
            for i in 7 downto 1 loop
              tmp(i) <= tmp(i-1);
            end loop;
            tmp(0) <= '0';
          end if;
        end if;
    end process;
    Parallelout <= tmp;
end behavior;