library IEEE;
use IEEE.std_logic_1164.all;


-- BUGS
-- Salva dados na memoria em endereços multiplos 200 228 240 (C8 E.. F0)
-- Observar o resultado de mem("""conv_integer(address_0)""")

-- MEMORIA DE 8 BITS


-- TESTAR IO

-- FAZER PROGRAMAS

-- import assignments ****

entity RISC_V is
--generic(ep :positive:=4);
-- IO toda vez que houver store reg posicao [0,1,2,3] ler io com mux
port (
 CLOCK_50: in STD_LOGIC;--;
 SW: in STD_LOGIC_VECTOR (9 downto 0);
 KEY: in STD_LOGIC_VECTOR (3 downto 0);
 LEDR: out STD_LOGIC_VECTOR (9 downto 0);
 HEX0: out STD_LOGIC_VECTOR (6 downto 0);
 HEX1: out STD_LOGIC_VECTOR (6 downto 0);
 HEX2: out STD_LOGIC_VECTOR (6 downto 0);
 HEX3: out STD_LOGIC_VECTOR (6 downto 0);
 HEX4: out STD_LOGIC_VECTOR (6 downto 0);
 HEX5: out STD_LOGIC_VECTOR (6 downto 0)
);
end RISC_V;

architecture R1 of RISC_V is
--------------------------------------------------------------------
component mux2_1 is
	port (
		A: in STD_LOGIC_VECTOR (31 downto 0);
		B: in STD_LOGIC_VECTOR (31 downto 0);
		Sel: in STD_LOGIC;
		S: out STD_LOGIC_VECTOR (31 downto 0)
	);
end component;

component reg2 is 
	port (
		--CLK, RST: in std_logic;
		--D: in STD_LOGIC_VECTOR(31 downto 0);
		--Q: out std_logic_vector(31 downto 0)
		  en    :in  std_logic;
		  clock :in  std_logic; -- Clock input
        reset :in  std_logic; -- Reset input
		  data  :in  std_logic_vector(31 downto 0); -- Data input
        q     :out std_logic_vector(31 downto 0)  -- Q output

	);
end component;

component add_high_level is
port (
 add_in_1,add_in_2: in STD_LOGIC_VECTOR (31 downto 0);
 RST_adder: in std_logic;
 add_out: out STD_LOGIC_VECTOR (31 downto 0)
);
end component;

component rom is
    port (
        ce      :in  std_logic;                      -- Chip Enable
        read_en :in  std_logic;                      -- Read Enable
        address :in  std_logic_vector (31 downto 0); -- Address input
        data    :out std_logic_vector (31 downto 0)  -- Data output
    );
end component;

component Resgister_Bank is
	port (
		System_CLOCK_REG,System_Reset_REG: in STD_LOGIC;
		Instruction_19_15,Instruction_20_24,Instruction_11_7: in STD_LOGIC_VECTOR (4 downto 0);
		Write_Data: in STD_LOGIC_VECTOR (31 downto 0);
		Reg_Write: in STD_LOGIC;
		Read_Data1,Read_Data2: out STD_LOGIC_VECTOR (31 downto 0)
);
end component;

component alu is
	port (	op1:	in std_logic_vector(31 downto 0);
				op2:	in std_logic_vector(31 downto 0);
				alu_op:	in std_logic_vector(3 downto 0);
				result:	out std_logic_vector(31 downto 0);
				zero:	out std_logic;
				less_than:	out std_logic
	);
end component;

component ram_dualport_as is
    port (
        --address_0 :in    std_logic_vector (31 downto 0);  -- address_0 Input
		  address_0 :in    std_logic_vector (7 downto 0);  -- address_0 Input
        data_0    :in    std_logic_vector (31 downto 0);  -- data_0 bi-directional   --- INOUT
        cs_0      :in    std_logic;                                 -- Chip Select
        we_0      :in    std_logic;                                 -- Write Enable/Read Enable
        oe_0      :in    std_logic;                                 -- Output Enable
        switches  :in    std_logic_vector (9 downto 0);
		  keys      :in    std_logic_vector (3 downto 0);
		  LEDS      :out    std_logic_vector (9 downto 0);
		  HEX_raw   :out STD_LOGIC_VECTOR (31 downto 0);
		  --address_1 :in    std_logic_vector (31 downto 0);  -- address_1 Input
        data_1    :out std_logic_vector (31 downto 0);  -- data_1 bi-directional     ----INOUT
        --cs_1      :in    std_logic;                                 -- Chip Select
        we_1      :in    std_logic                                 -- Write Enable/Read Enable
        --oe_1      :in    std_logic                                  -- Output Enable
    );
end component;

component Immediate is
	port (
		Immediate_in: in STD_LOGIC_VECTOR (31 downto 0);
		Immediate_out: out STD_LOGIC_VECTOR (31 downto 0)
);
end component;

component add_high_level_with_SL is
port (
 add_in_1_sl,add_in_2_sl: in STD_LOGIC_VECTOR (31 downto 0);
 RST_adder_sl: in std_logic;
 add_out_sl: out STD_LOGIC_VECTOR (31 downto 0)
);
end component;

component control is
	port (	opcode:			in std_logic_vector(6 downto 0);
				funct3:			in std_logic_vector(2 downto 0);
				funct7:			in std_logic_vector(6 downto 0);
				--io_rg_zero:    in std_logic_vector(4 downto 0);
				--io_out:        out std_logic_vector(1 downto 0);
				reg_write:		out std_logic;
				alu_src:			out std_logic;
				alu_op:			out std_logic_vector(3 downto 0);
				--jump:			out std_logic_vector(1 downto 0);
				branch:			out std_logic;--std_logic_vector(2 downto 0);
				mem_write:		out std_logic;--std_logic_vector(1 downto 0);
				mem_read:		out std_logic;--std_logic_vector(1 downto 0);
				MemtoReg:		out std_logic
	);
end component;

component Debugger is
port (
 DEBUGGER_KEY: in std_logic;
 DEBUGGER_reset: in std_logic;
 sel_DEBUGGER: out STD_LOGIC;
 clk_out: out std_logic
);
end component;

component  mux2_1_one_bit is
--generic(ep :positive:=4);

port (
 A_s: in std_logic;
 B_s: in std_logic;
 Sel_s: in std_logic;
 S_s: out std_logic
);
end component;

component decoder_using_select is
    port (
        --enable      :in  std_logic;                     --  Enable for the decoder
        binary_in   :in  std_logic_vector (31 downto 0); --  4-bit input
        decoder_out0 :out std_logic_vector (6 downto 0); --  16-bit output
		  decoder_out1 :out std_logic_vector (6 downto 0); --  16-bit output
		  decoder_out2 :out std_logic_vector (6 downto 0); --  16-bit output
		  decoder_out3 :out std_logic_vector (6 downto 0); --  16-bit output
		  decoder_out4 :out std_logic_vector (6 downto 0); --  16-bit output
		  decoder_out5 :out std_logic_vector (6 downto 0) --  16-bit output

    );
end component;


--------------------------------------------------------------------
signal PC_reset : std_logic;
signal PC_in: STD_LOGIC_VECTOR (31 downto 0);
signal PC_out : STD_LOGIC_VECTOR (31 downto 0);
signal ADDER1_out,ADDER2_out : STD_LOGIC_VECTOR (31 downto 0);
--signal MUX_Zero_OUT : STD_LOGIC_VECTOR (31 downto 0);
--signal MUX_PC_A_in, MUX_PC_B_in, MUX_PC_out : STD_LOGIC_VECTOR (31 downto 0);
signal Sel_PC : std_logic;
signal INSTRUCTION_ROM_DATA : STD_LOGIC_VECTOR (31 downto 0);
signal MEM_BACK_TO_REG_DATA: STD_LOGIC_VECTOR (31 downto 0);
signal REGBANK_OUT1,REGBANK_OUT2: STD_LOGIC_VECTOR (31 downto 0);
signal IMMEDIATE_OUTPUT,OUT_MUX_ALU: STD_LOGIC_VECTOR (31 downto 0);
signal ALU_RESULT: STD_LOGIC_VECTOR (31 downto 0);
signal ALU_ZERO,ALU_LESS_THAN: std_logic;
signal RAM_Data: STD_LOGIC_VECTOR (31 downto 0);
signal Control_REG_Write: std_logic;
signal Control_Branch: std_logic;
signal Control_ALU_OP: std_logic_vector(3 downto 0);
signal Control_MEM_Write,Control_MEM_Read,Control_MEM_to_REG: std_logic;
signal ALUSrc: std_logic;

signal clock_system,clock_DEBUG :std_logic;
signal sel_debug: std_logic;
signal HEX_raw_IO: std_logic_vector(31 downto 0);

--signal out_io: std_logic_vector(1 downto 0);


begin
   --PC: reg2 port map('1',CLOCK_50,PC_reset,PC_in,PC_out); --PC_in
	PC: reg2 port map('1',clock_system,PC_reset,PC_in,PC_out); --PC_in  --DEBUG
	ADDER1: add_high_level_with_SL port map(PC_out,x"00000004",PC_reset,ADDER1_out);
   MUX_PC: mux2_1 port map(ADDER1_out,ADDER2_out,Sel_PC,PC_in);
	INSTRUCTION_ROM: rom port map('1','1',PC_out,INSTRUCTION_ROM_DATA);
	BANK_REG: Resgister_Bank port map(CLOCK_50,PC_reset,INSTRUCTION_ROM_DATA(19 downto 15),INSTRUCTION_ROM_DATA(24 downto 20),INSTRUCTION_ROM_DATA(11 downto 7),MEM_BACK_TO_REG_DATA,Control_REG_Write,REGBANK_OUT1,REGBANK_OUT2);
	MUX_ALU: mux2_1 port map(REGBANK_OUT2,IMMEDIATE_OUTPUT, ALUSrc, OUT_MUX_ALU);
	RISC_V_ALU: alu port map(REGBANK_OUT1,OUT_MUX_ALU,Control_ALU_OP,ALU_RESULT,ALU_ZERO,ALU_LESS_THAN);

	--DATA_RAM: ram_dualport_as port map(ALU_RESULT(7 downto 0),REGBANK_OUT2,'1',Control_MEM_Write,'1',RAM_Data,Control_MEM_Read);
	DATA_RAM: ram_dualport_as port map(ALU_RESULT(7 downto 0),REGBANK_OUT2,'1',Control_MEM_Write,'1',SW,KEY,LEDR,HEX_raw_IO,RAM_Data,Control_MEM_Read);
	
	MUX_RAM: mux2_1 port map(ALU_RESULT, RAM_Data, Control_MEM_to_REG, MEM_BACK_TO_REG_DATA);
	IMMEDIATE_DATA_HANDLER: Immediate port map(INSTRUCTION_ROM_DATA,IMMEDIATE_OUTPUT);    -- VERIFICAR IMEDIATO PARA
	ADDER2: add_high_level_with_SL port map(PC_out,IMMEDIATE_OUTPUT,PC_reset,ADDER2_out); -- BRANCH
	

	

	--RISC_V_CONTROL: control port map(INSTRUCTION_ROM_DATA(6 downto 0),INSTRUCTION_ROM_DATA(14 downto 12),INSTRUCTION_ROM_DATA(31 downto 25),INSTRUCTION_ROM_DATA(11 downto 7),out_io,Control_REG_Write,ALUSrc,Control_ALU_OP,Control_Branch,Control_MEM_Write,Control_MEM_Read,Control_MEM_to_REG);
	RISC_V_CONTROL: control port map(INSTRUCTION_ROM_DATA(6 downto 0),INSTRUCTION_ROM_DATA(14 downto 12),INSTRUCTION_ROM_DATA(31 downto 25),Control_REG_Write,ALUSrc,Control_ALU_OP,Control_Branch,Control_MEM_Write,Control_MEM_Read,Control_MEM_to_REG);
	IO: decoder_using_select port map(HEX_raw_IO,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
	
	RISC_V_DEBUGGER: Debugger port map(KEY(1),PC_reset,sel_debug,clock_DEBUG);
	MUX_CLOCK_DEBUG: mux2_1_one_bit port map(CLOCK_50,clock_DEBUG,sel_debug,clock_system);
	
	Sel_PC <= (Control_Branch and (ALU_ZERO or ALU_LESS_THAN)) when ((PC_reset = '1') and (Control_Branch = '1')) else '0';
	
	
	
	PC_reset <= KEY(0);
	--clock_DEBUG_KEY <= KEY(3);

	--LEDR <= HEX_raw_IO(9 DOWNTO 0);
	
end R1;
 
  
---------------------------------------------------------------
--------------------------------------------------------------- 

--  ClockGen: process
--  begin
--    while TRUE loop
--      CLOCK_50 <= '0';
--      wait for 5 NS;
--      CLOCK_50 <= '1';
--      wait for 5 NS;
--    end loop;
--    wait;
--  end process ClockGen;

---------------------------------------------------------------
---------------------------------------------------------------
--process
  --begin
    --a_in <= X"00000001";
    --b_in <= X"00000000";
	 --Sel_test <= '0';
    --wait for 1 ns;
	 --wait until a_in = b_in;
    --assert(q_out='0') report "Fail 0/0" severity error;
    --Sel_test <= '0';
    --wait for 1 ns;
    -- Clear inputs
    --a_in <= '0';
    --b_in <= '0';
    --assert false report "Test done." severity note;
    --wait;
	
  --end process;

-- MUDANCAS

-- REG COM ENABLE
-- RST NO MUX



