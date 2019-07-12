library IEEE;
use IEEE.std_logic_1164.all;

entity Immediate is
	port (
		Immediate_in: in STD_LOGIC_VECTOR (31 downto 0);
		Immediate_out: out STD_LOGIC_VECTOR (31 downto 0)
);
end Immediate;

architecture Immediate_RTL of Immediate is

--signal EXT1,EXT2,EXT3: STD_LOGIC_VECTOR (31 downto 0);
begin


--EXT1 <= x"00000" & Immediate_in(31 downto 20);
--EXT2 <= x"00000" & Immediate_in(31 downto 25) & Immediate_in(11 downto 7);
--EXT3 <= x"00000" & Immediate_in(31) & Immediate_in(7) & Immediate_in(30 downto 25) & Immediate_in(11 downto 8);
--Immediate_out <= EXT1 when Immediate_in(14 downto 12) = "00001" else (others => '0');

process(Immediate_in)
begin
	if Immediate_in(6 downto 0) = "0010011" or Immediate_in(6 downto 0) = "0000011" then --I type
		if Immediate_in(31) = '0' then
			Immediate_out <= x"00000" & Immediate_in(31 downto 20);
		else
			Immediate_out <= x"FFFFF" & Immediate_in(31 downto 20);
		end if;	
	elsif Immediate_in(6 downto 0) = "0100011" then  --S type
		if Immediate_in(31) = '0' then
			Immediate_out <= x"00000" & Immediate_in(31 downto 25) & Immediate_in(11 downto 7);
		else
			Immediate_out <= x"FFFFF" & Immediate_in(31 downto 25) & Immediate_in(11 downto 7);
		end if;	
	elsif Immediate_in(6 downto 0) = "1100011" then -- B type
		if Immediate_in(31) = '0' then
			Immediate_out <= x"00000" & Immediate_in(7) & Immediate_in(30 downto 25) & Immediate_in(11 downto 8) & '0';
		else
			Immediate_out <= x"FFFFF" & Immediate_in(7) & Immediate_in(30 downto 25) & Immediate_in(11 downto 8) & '0';
		end if;	
	elsif Immediate_in(6 downto 0) = "1100111" then
		if Immediate_in(31) = '0' then
			Immediate_out <= x"00000" & Immediate_in(31 downto 25) & Immediate_in(24 downto 21) & Immediate_in(20);
		else
			Immediate_out <= x"FFFFF" & Immediate_in(31 downto 25) & Immediate_in(24 downto 21) & Immediate_in(20);
		end if;	
	elsif Immediate_in(6 downto 0) = "0010111" then -- U type
		if Immediate_in(31) = '0' then
			Immediate_out <= '0' & Immediate_in(30 downto 20) & Immediate_in(19 downto 12) & "000000000000";
		else
			Immediate_out <= '1' & Immediate_in(30 downto 20) & Immediate_in(19 downto 12) & "000000000000";
		end if;	 
	elsif Immediate_in(6 downto 0) = "1101111" then -- J type
		if Immediate_in(31) = '0' then
			Immediate_out <= x"000" & Immediate_in(19 downto 12) & Immediate_in(20) & Immediate_in(30 downto 25) & Immediate_in(24 downto 21) & '0';
		else
			Immediate_out <= x"FFF" & Immediate_in(19 downto 12) & Immediate_in(20) & Immediate_in(30 downto 25) & Immediate_in(24 downto 21) & '0';
		end if;	
	--elsif Immediate_in(6 downto 0) = "1100011" then
	--	Immediate_out <= x"00000" & Immediate_in(31 downto 25) & Immediate_in(11 downto 7);
	--else	
	--	Immediate_out <= x"00000" & Immediate_in(31) & Immediate_in(7) & Immediate_in(30 downto 25) & Immediate_in(11 downto 8);
	end if;
end process;

end Immediate_RTL;