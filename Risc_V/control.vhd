library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


--package P_BIT_COMPARISON is
--function "="(L: STD_LOGIC_VECTOR(6 DOWNTO 0); R: STD_LOGIC_VECTOR(6 DOWNTO 0)) return STD_LOGIC is
-- variable result : std_logic;
--begin
--    result <= '1' when L = R else '0';
--    return result; 
--end;
--end P_BIT_COMPARISON;

entity control is
    generic (
		  MULT :STD_LOGIC_VECTOR := "0111110";
		  LUI  :STD_LOGIC_VECTOR := "0110111";
		  JAL  :STD_LOGIC_VECTOR := "1101111";
		  JALR :STD_LOGIC_VECTOR := "1100111";
		  AUIPC:STD_LOGIC_VECTOR := "0010111";
		  BR   :STD_LOGIC_VECTOR := "1100011";
		  R_TYPE:STD_LOGIC_VECTOR := "0110011";   -- computation
		  R_TYPE_I:STD_LOGIC_VECTOR := "0010011"; --Imm
        LW   :STD_LOGIC_VECTOR := "0000011";    --L_All
        SW   :STD_LOGIC_VECTOR := "0100011" --bit_vector
    );
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
end control;

architecture arch_control of control is
begin

	reg_write <= '1' when opcode=AUIPC or opcode=LUI or opcode=R_TYPE or opcode=LW or opcode = R_TYPE_I or opcode = JALR or opcode = JAL else '0'; --or opcode = MULT
	alu_src 	 <= '1' when opcode=LW or opcode=SW or opcode=R_TYPE_I or opcode=AUIPC else '0';
	branch 	 <= '1' when opcode=BR else '0';
	mem_write <= '1' when opcode=SW else '0';--or opcode=JALR
	mem_read  <= '1' when opcode=LW else '0';
	MemtoReg  <= '1' when opcode=LW else '0';
	
	
	--alu_op(0) <= '1' when opcode=BR or  else '0';
	--process(opcode, io_rg_zero)
	--begin
	--	case opcode is
	--		when "0000011" =>				-- loads
	--			case io_rg_zero is
	--				when "00000" =>
	--					io_out <= "01";
	--				when others =>
	--					io_out <= "00";
	--			end case;
	--		when "0100011" =>					-- stores
	--			case io_rg_zero is
	--				when "00000" =>
	--					io_out <= "11";
	--				when others =>
	--					io_out <= "00";
	--		when others =>
	--			io_out <= "00";
	--	end case;
	--end process;
	
	process(opcode, funct3, funct7)
	begin
		case opcode is							-- load immediate / jumps
			--when "0111110" =>             -- MULT
			--	alu_op <= "1111";
			when "0110111" =>					-- LUI
				alu_op <= "0110";
			when "0010111" =>             -- AUIPC
				alu_op <= "0100";
			when "1101111" =>             -- JAL
				alu_op <= "0110";
			when "1100111" =>             -- JALR
				alu_op <= "0110";
			when "1100011" =>				--Branch
				case funct3 is
					when "000" =>	
						alu_op <= "0101";
					when "001" =>	
						alu_op <= "0101";
					when "100" =>
						alu_op <= "0111";
					when "101" =>
						alu_op <= "0111";
					when "110" =>	
						alu_op <= "1000";
					when "111" =>
						alu_op <= "1000";
					when others =>
						alu_op <= "0000";
				end case;
			when "0000011" =>				-- loads
				case funct3 is
					when "000" =>
						alu_op <= "0100";
					when "001" =>
						alu_op <= "0100";
					when "010" =>
						alu_op <= "0100";
					when "100" =>
						alu_op <= "0100";
					when "101" =>
						alu_op <= "0100";
					when others =>
						alu_op <= "0000";
				end case;
			when "0100011" =>					-- stores
				case funct3 is
					when "000" =>
						alu_op <= "0100";
					when "001" =>	
						alu_op <= "0100";
					when "010" =>	
						alu_op <= "0100";
					when others =>
						alu_op <= "0000";
				end case;
			when "0010011" =>					-- imm 
				case funct3 is
					when "000" =>
						alu_op <= "0100";
					when "010" =>
						alu_op <= "0111";
					when "011" =>
						alu_op <= "1000";
					when "100" =>	
						alu_op <= "0010";
					when "110" =>
						alu_op <= "0001";
					when "111" =>
						alu_op <= "0000";
					when "001" =>
						alu_op <= "1001";
					when "101" =>
						case funct7 is
							when "0000000" =>
								alu_op <= "1010";
							when "0100000" =>
								alu_op <= "1100";
							when others =>
								alu_op <= "0000";
						end case;
					when others =>
						alu_op <= "0000";
				end case;
			when "0110011" =>					-- R type
				case funct3 is
					when "000" =>
						case funct7 is
							when "0000000" => -- ADD
								alu_op <= "0100";
							when "0100000" =>	-- SUB
								alu_op <= "0101";
							when "0000001" =>	-- MULT
								alu_op <= "1111";
							when others =>
								alu_op <= "0000";
						end case;
					when "001" =>
						alu_op <= "1001";
					when "010" =>
						alu_op <= "0111";
					when "011" =>	
						alu_op <= "1000";
					when "100" =>
						alu_op <= "0010";
					when "101" =>
						case funct7 is
							when "0000000" =>
								alu_op <= "1010";
							when "0100000" =>
								alu_op <= "1100";
							when others =>
								alu_op <= "0000";
						end case;
					when "110" =>	
						alu_op <= "0001";
					when "111" =>	
						alu_op <= "0000";
					when others =>
						alu_op <= "0000";
				end case;
			when "1110011" =>
				alu_op <= "0000"; 
			when others =>
				alu_op <= "0000";
		end case;
	end process;
				
	
end arch_control;