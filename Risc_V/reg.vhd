library ieee;
use ieee.std_logic_1164.all;

entity reg is port (
CLK, RST: in std_logic;
D: in std_logic_vector(31 downto 0);
Q: out std_logic_vector(31 downto 0)
);
end reg;
architecture reg_behavior of reg is 

--signal aux1,aux2,aux3: std_logic_vector(31 downto 0);

begin


process (CLK, RST, D)
begin
--if CLK'event and CLK = '1' then
	if RST = '0' then
		Q <= X"00000000";
	--else 
	elsif CLK'event and CLK = '1' then
		Q <= D;
	end if;
--end if;
end process;

--Q <= D when RST='1' else X"00000000";


end reg_behavior;




