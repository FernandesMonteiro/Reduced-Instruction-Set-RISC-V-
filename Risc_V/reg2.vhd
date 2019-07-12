library ieee;
    use ieee.std_logic_1164.all;

entity reg2 is
    port (
        en    :in  std_logic; -- Enable input
		  clock :in  std_logic;
        reset :in  std_logic; -- Reset input
		  data  :in  std_logic_vector(31 downto 0); -- Data input
        q     :out std_logic_vector(31 downto 0)  -- Q output

    );
end entity;

architecture rtl of reg2 is

begin
    process (en, clock, reset, data) begin
        if (reset = '0') then
            q <= X"00000000"; --18
        elsif (clock'event and clock ='1' and en = '1') then
            q <= data;
        end if;
    end process;

end architecture;