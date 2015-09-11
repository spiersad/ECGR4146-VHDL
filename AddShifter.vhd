library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
 
entity AddShifter is  
  port(A : in std_logic_vector(3 downto 0);
       B : in std_logic_vector(7 downto 0);
       Ctl : in std_logic_vector(1 downto 0); 
       SUM : out std_logic_vector(7 downto 0));  
end AddShifter;  
architecture behavior of AddShifter is  
  begin
    process(A, B, Ctl)
      begin
        case Ctl is
        when "00" =>
          SUM <= ("0000" & A) + B;
        when "01" =>
          SUM <= ("000" & A & '0') + B;
        when "10" =>
          SUM <= ("00" & A & "00") + B;
        when "11" =>
          SUM <= ('0' & A & "000") + B;
        when others =>
          SUM <= "00000000";
        end case;
      end process;
end behavior;