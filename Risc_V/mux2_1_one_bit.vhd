library IEEE;
use IEEE.std_logic_1164.all;

entity mux2_1_one_bit is
--generic(ep :positive:=4);

port (
 A_s: in std_logic;
 B_s: in std_logic;
 Sel_s: in std_logic;
 S_s: out std_logic
);
end mux2_1_one_bit;

architecture mux2_1_one_bit_arch of mux2_1_one_bit is

begin

S_s <= A_s when Sel_s='0' else B_s;

end mux2_1_one_bit_arch;