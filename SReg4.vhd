library ieee;
use ieee.std_logic_1164.all;

entity SReg4 is
  port (Clk, Reset, Load, SRight : in std_logic;
        Parallelin : in std_logic_vector(3 downto 0);
        Parallelout : out std_logic_vector(3 downto 0));
end SReg4;

architecture behavior of SReg4 is
  signal tmp: std_logic_vector(3 downto 0);
  begin
    process(Clk, Reset)
      begin
        if (Clk'event and Clk='1') then
          if (Reset='1') then
            tmp <= "0000";
          elsif (Load='1') then
            tmp <= Parallelin;
          elsif (SRight='1') then
            for i in 0 to 2 loop
              tmp(i) <= tmp(i+1);
            end loop;
            tmp(3) <= '0';
          end if;
        end if;
    end process;
    Parallelout <= tmp;
end behavior;