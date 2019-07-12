library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity alu is
	port (	op1:	in std_logic_vector(31 downto 0);
				op2:	in std_logic_vector(31 downto 0);
				alu_op:	in std_logic_vector(3 downto 0);
				result:	out std_logic_vector(31 downto 0);
				zero:	out std_logic;
				less_than:	out std_logic
	);
end alu;

architecture arch_alu of alu is

component Booth_Multiplier is
	port(
		mr,md		: in	std_logic_vector(31 downto 0);
		saida		: out std_logic_vector(31 downto 0)
	);
end component;

	signal shift1l, shift2l, shift4l, shift8l, shift16l : std_logic_vector(31 downto 0);
	signal shift1r, shift2r, shift4r, shift8r, shift16r : std_logic_vector(31 downto 0);
	signal r, shift: std_logic_vector(31 downto 0);
	signal shift_op2: std_logic_vector(4 downto 0);
	signal addsub: std_logic_vector(32 downto 0);
	signal less, left, logical: std_logic;
	signal fill : std_logic_vector(31 downto 16);
	
	signal out_mult: std_logic_vector(31 downto 0);
	
	
begin
	process(op1, op2, alu_op, addsub, less, shift_op2, shift, out_mult)
	begin
		case alu_op is
			when "0000" => r <= op1 and op2;
			when "0001" => r <= op1 or op2;
			when "0010" => r <= op1 xor op2;
			when "0100" | "0101" => r <= addsub(31 downto 0);
			when "0110" => r <= op2;
			when "0111" | "1000" => r <= x"0000000" & "000" & less;
			when "1111" => r <= out_mult;
			when others => r <= shift;
		end case;
	end process;

	addsub <= ('0' & op1) - ('0' & op2) when alu_op > "0100" else ('0' & op1) + ('0' & op2);
	less <= addsub(32) when op1(31) = op2(31) or alu_op = "1000" else op1(31);
	less_than <= less;
	--zero <= not (r(31) or r(30) or r(29) or r(28) or r(27) or r(26) or r(25) or r(24) or
	--		r(23) or r(22) or r(21) or r(20) or r(19) or r(18) or r(17) or r(16) or
	--		r(15) or r(14) or r(13) or r(12) or r(11) or r(10) or r(9) or r(8) or
	--		r(7) or r(6) or r(5) or r(4) or r(3) or r(2) or r(1) or r(0));
	zero <= r(31) or r(30) or r(29) or r(28) or r(27) or r(26) or r(25) or r(24) or
			r(23) or r(22) or r(21) or r(20) or r(19) or r(18) or r(17) or r(16) or
			r(15) or r(14) or r(13) or r(12) or r(11) or r(10) or r(9) or r(8) or
			r(7) or r(6) or r(5) or r(4) or r(3) or r(2) or r(1) or r(0);

	shift_op2 <= op2(4 downto 0);

	left <= '1' when alu_op(0) = '1' else '0';
	logical <= '1' when alu_op(2) = '0' else '0';

	--barrel_shifter: entity work.bshift
	--port map(	left => left,
	--		logical => logical,
	--		shift => shift_op2,
	--		input => op1,
	--		output => shift
	--);
	
	fill <= (others => op1(31)) when logical = '0' else x"0000";
	
	shift1l  <= op1(30 downto 0) & '0' when shift_op2(0) = '1' else op1;
	shift2l  <= shift1l(29 downto 0) & "00" when shift_op2(1) = '1' else shift1l;
	shift4l  <= shift2l(27 downto 0) & x"0" when shift_op2(2) = '1' else shift2l;
	shift8l  <= shift4l(23 downto 0) & x"00" when shift_op2(3) = '1' else shift4l;
	shift16l <= shift8l(15 downto 0) & x"0000" when shift_op2(4) = '1' else shift8l;
 
	shift1r  <= fill(31) & op1(31 downto 1) when shift_op2(0) = '1' else op1;
	shift2r  <= fill(31 downto 30) & shift1r(31 downto 2) when shift_op2(1) = '1' else shift1r;
	shift4r  <= fill(31 downto 28) & shift2r(31 downto 4) when shift_op2(2) = '1' else shift2r;
	shift8r  <= fill(31 downto 24) & shift4r(31 downto 8)  when shift_op2(3) = '1' else shift4r;
	shift16r <= fill(31 downto 16) & shift8r(31 downto 16) when shift_op2(4) = '1' else shift8r;

	shift <= shift16r when left = '0' else shift16l;
	
	MULTI: Booth_Multiplier port map(op1,op2,out_mult);
	
	result <= r;

end arch_alu;