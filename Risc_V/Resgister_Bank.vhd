library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity Resgister_Bank is
--generic(ep :positive:=4);

port (
 System_CLOCK_REG,System_Reset_REG: in STD_LOGIC;
 --System_Reset_REG: in STD_LOGIC;
 Instruction_19_15,Instruction_20_24,Instruction_11_7: in STD_LOGIC_VECTOR (4 downto 0);
 Write_Data: in STD_LOGIC_VECTOR (31 downto 0);
 Reg_Write: in STD_LOGIC;
 Read_Data1,Read_Data2: out STD_LOGIC_VECTOR (31 downto 0)
);
end Resgister_Bank;

architecture Resgister_Bank_Behavior of Resgister_Bank is

component reg is 
	port (
		CLK, RST: in std_logic;
		D: in std_logic_vector(31 downto 0);
		Q: out std_logic_vector(31 downto 0)
	);
end component;
--------------------------------------------------------------------
--------------------------------------------------------------------
type bank is array(0 to 31) of std_logic_vector(31 downto 0);
signal registers: bank := (others => (others => '0'));

signal  Register_0_out,Register_1_out,Register_1_in: STD_LOGIC_VECTOR (31 downto 0);
signal  Register_2_out,Register_2_in: STD_LOGIC_VECTOR (31 downto 0);
signal  Register_3_out,Register_3_in: STD_LOGIC_VECTOR (31 downto 0);
signal  Register_4_out,Register_4_in: STD_LOGIC_VECTOR (31 downto 0);
signal  Register_5_out,Register_5_in: STD_LOGIC_VECTOR (31 downto 0);
signal  error_register_bank: STD_LOGIC;

begin



 Registerx_0: reg port map(System_CLOCK_REG,System_Reset_REG,x"00000000",Register_0_out);
 Registerx_1: reg port map(System_CLOCK_REG,System_Reset_REG,Register_1_in,Register_1_out);
 Registerx_2: reg port map(System_CLOCK_REG,System_Reset_REG,Register_2_in,Register_2_out);
 Registerx_3: reg port map(System_CLOCK_REG,System_Reset_REG,Register_3_in,Register_3_out);
 Registerx_4: reg port map(System_CLOCK_REG,System_Reset_REG,Register_4_in,Register_4_out);
 Registerx_5: reg port map(System_CLOCK_REG,System_Reset_REG,Register_5_in,Register_5_out);
 
 --Read_Data1 <= Register_1_out when Instruction_19_15 = "00001" else (others => '0');	
 --Read_Data1 <= Register_2_out when Instruction_19_15 = "00010" else (others => '0');	
 --Read_Data1 <= Register_3_out when Instruction_19_15 = "00011" else (others => '0');
 --Read_Data1 <= Register_4_out when Instruction_19_15 = "00100" else (others => '0');
 --Read_Data1 <= Register_5_out when Instruction_19_15 = "00101" else (others => '0');
			
 --Read_Data2 <= Register_1_out when Instruction_20_24 = "00001" else (others => '0');
 --Read_Data2 <= Register_2_out when Instruction_20_24 = "00010" else (others => '0');	
 --Read_Data2 <= Register_3_out when Instruction_20_24 = "00011" else (others => '0');	
 --Read_Data2 <= Register_4_out when Instruction_20_24 = "00100" else (others => '0');
 --Read_Data2 <= Register_5_out when Instruction_20_24 = "00101" else (others => '0');	
 
 Register_1_in <= Write_Data when Instruction_11_7 = "00001" else (others => '0');
 Register_2_in <= Write_Data when Instruction_11_7 = "00010" else (others => '0');
 Register_3_in <= Write_Data when Instruction_11_7 = "00011" else (others => '0');
 Register_4_in <= Write_Data when Instruction_11_7 = "00100" else (others => '0');
 Register_5_in <= Write_Data when Instruction_11_7 = "00101" else (others => '0');
 
 Read_Data1 <= registers(conv_integer(Instruction_19_15)) when Instruction_19_15 /= "00000" else (others => '0');
 Read_Data2 <= registers(conv_integer(Instruction_20_24)) when Instruction_20_24 /= "00000" else (others => '0');
 
 process (System_CLOCK_REG,System_Reset_REG,Instruction_19_15,Instruction_20_24,Instruction_11_7,Write_Data,Reg_Write)
 begin
	if System_CLOCK_REG'event and System_CLOCK_REG = '1' then
		if Instruction_11_7 /= "00000" and Reg_Write = '1' then
				registers(conv_integer(Instruction_11_7)) <= Write_Data;
		end if;
	end if;
 end process;

 --process (System_CLOCK_REG,System_Reset_REG,Instruction_19_15,Instruction_20_24,Instruction_11_7,Write_Data,Reg_Write)
 --begin
  --if System_CLOCK_REG'event and System_CLOCK_REG = '1' then
  -- if (System_Reset_REG = '0') then
	--   Register_1_in <= x"00000000";
	--	Register_2_in <= x"00000000";
	--	Register_3_in <= x"00000000";
	--	Register_4_in <= x"00000000";
	--	Register_5_in <= x"00000000";
	--elsif (Reg_Write = '1') then                          --PROBLEMA DE TEMPORIZACAO
	--	case (Instruction_11_7) is                      --TALVEZ COLOCAR UM LATCH AQUI *** 
	--		when "00001" => Register_1_in <= Write_Data;	--(VER PRIMEIRO WRITE_dATA DEPOIS ATUALIZAR SAIDAS)
	--	   when "00010" => Register_2_in <= Write_Data;	
	--	   when "00011" => Register_3_in <= Write_Data;	
	--		when "00100" => Register_4_in <= Write_Data;
	--	   when "00101" => Register_5_in <= Write_Data;		
	--		when others => error_register_bank <= '1';
	--	end case;
   --end if;
  --end if;
 --end process;
          --System_CLOCK_REG,
 --process (System_Reset_REG,Instruction_19_15,Instruction_20_24,Instruction_11_7,Write_Data,Reg_Write)
 --begin
    --if System_CLOCK_REG'event then
		--case (Instruction_19_15) is
		
			--when others => error_register_bank <= '1';
		--end case;
	 --end if;
 --end process;
 
 --process (System_Reset_REG,Instruction_19_15,Instruction_20_24,Instruction_11_7,Write_Data,Reg_Write)
 --begin
    --if System_CLOCK_REG'event then
		--case (Instruction_20_24) is
	
			--when others => error_register_bank <= '1' /= "00000" else (others => '0');
		--end case;
   --end if;
 --end process;

 --REALIZAR UM OR LOGICO ENTRE 
 --ADICIONAR RESET NOS PROCESS
 
end Resgister_Bank_Behavior;