library ieee;  
use ieee.std_logic_1164.all;  
use ieee.std_logic_unsigned.all; 
 
entity adder8 is  
  port(A,B : in std_logic_vector(7 downto 0);  
      SUM : out std_logic_vector(7 downto 0));  
end adder8;  
architecture behavior of adder8 is  
  begin  
    SUM <= A + B;  
end behavior;