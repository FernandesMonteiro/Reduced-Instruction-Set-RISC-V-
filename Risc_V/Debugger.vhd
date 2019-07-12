library IEEE;
use IEEE.std_logic_1164.all;

entity Debugger is
--generic(ep :positive:=4);

port (
 DEBUGGER_KEY: in std_logic;
 DEBUGGER_reset: in std_logic;
 sel_DEBUGGER: out STD_LOGIC;
 clk_out: out std_logic
);
end Debugger;

architecture Debugger_arch of Debugger is
signal clk_DEBUG: std_logic;
signal sel_aux: std_logic;
begin

	process (DEBUGGER_KEY, DEBUGGER_reset,sel_aux) begin
      if (DEBUGGER_reset = '0') then
             clk_DEBUG <= '0';
      elsif (rising_edge(DEBUGGER_KEY)  and (sel_aux = '1')) then
             clk_DEBUG <= not clk_DEBUG;
      end if;
   end process;
	
	process (DEBUGGER_KEY, DEBUGGER_reset) begin
		if (DEBUGGER_reset = '0') then
			sel_aux <= '0';
		elsif ((DEBUGGER_KEY = '0') or (sel_aux = '1')) then
			sel_aux <= '1';
		end if;
	
	end process;
	
	clk_out <= clk_DEBUG;
	sel_DEBUGGER <= sel_aux;
end Debugger_arch;