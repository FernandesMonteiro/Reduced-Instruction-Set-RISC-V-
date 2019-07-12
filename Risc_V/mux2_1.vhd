library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_1 is
--generic(ep :positive:=4);

port (
 A: in STD_LOGIC_VECTOR (31 downto 0);
 B: in STD_LOGIC_VECTOR (31 downto 0);
 Sel: in STD_LOGIC;
 S: out STD_LOGIC_VECTOR (31 downto 0)
);
end mux2_1;

architecture mux2_arch of mux2_1 is

begin

S <= A when SEL='0' else B;

end mux2_arch;