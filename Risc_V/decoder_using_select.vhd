library ieee;
    use ieee.std_logic_1164.all;

entity decoder_using_select is
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
end entity;

architecture behavior_decoder_using_select of decoder_using_select is

signal Disp0,Disp1,Disp2,Disp3,Disp4: std_logic_vector (3 downto 0);
signal Disp5: std_logic_vector (1 downto 0);

begin

Disp0 <= binary_in(13 downto 10);
Disp1 <= binary_in(17 downto 14);
Disp2 <= binary_in(21 downto 18);
Disp3 <= binary_in(25 downto 22);
Disp4 <= binary_in(29 downto 26);
Disp5 <= binary_in(31 downto 30);

 process (Disp0) begin
    case (Disp0) is
    when "0000" => decoder_out0 <= "0000001"; 
    when "0001" => decoder_out0 <= "1001111"; 
    when "0010" => decoder_out0 <= "0010010"; 
    when "0011" => decoder_out0 <= "0000110"; 
    when "0100" => decoder_out0 <= "1001100"; 
    when "0101" => decoder_out0 <= "0100100"; 
    when "0110" => decoder_out0 <= "0100000"; 
    when "0111" => decoder_out0 <= "0001111"; 
    when "1000" => decoder_out0 <= "0000000"; 
    when "1001" => decoder_out0 <= "0000100"; 
    when "1010" => decoder_out0 <= "0000010"; 
    when "1011" => decoder_out0 <= "1100000";
    when "1100" => decoder_out0 <= "0110001"; 
    when "1101" => decoder_out0 <= "1000010"; 
    when "1110" => decoder_out0 <= "0110000"; 
    when "1111" => decoder_out0 <= "0111000"; 
    when others => decoder_out0 <= "0000001"; 
	 end case;
 end process;
 
  process (Disp1) begin
    case (Disp1) is
    when "0000" => decoder_out1 <= "0000001"; 
    when "0001" => decoder_out1 <= "1001111"; 
    when "0010" => decoder_out1 <= "0010010"; 
    when "0011" => decoder_out1 <= "0000110"; 
    when "0100" => decoder_out1 <= "1001100"; 
    when "0101" => decoder_out1 <= "0100100"; 
    when "0110" => decoder_out1 <= "0100000"; 
    when "0111" => decoder_out1 <= "0001111"; 
    when "1000" => decoder_out1 <= "0000000"; 
    when "1001" => decoder_out1 <= "0000100"; 
    when "1010" => decoder_out1 <= "0000010"; 
    when "1011" => decoder_out1 <= "1100000";
    when "1100" => decoder_out1 <= "0110001"; 
    when "1101" => decoder_out1 <= "1000010"; 
    when "1110" => decoder_out1 <= "0110000"; 
    when "1111" => decoder_out1 <= "0111000"; 
    when others => decoder_out1 <= "0000001"; 
	 end case;
 end process;
 
 process (Disp2) begin
    case (Disp2) is
    when "0000" => decoder_out2 <= "0000001"; 
    when "0001" => decoder_out2 <= "1001111"; 
    when "0010" => decoder_out2 <= "0010010"; 
    when "0011" => decoder_out2 <= "0000110"; 
    when "0100" => decoder_out2 <= "1001100"; 
    when "0101" => decoder_out2 <= "0100100"; 
    when "0110" => decoder_out2 <= "0100000"; 
    when "0111" => decoder_out2 <= "0001111"; 
    when "1000" => decoder_out2 <= "0000000"; 
    when "1001" => decoder_out2 <= "0000100"; 
    when "1010" => decoder_out2 <= "0000010"; 
    when "1011" => decoder_out2 <= "1100000";
    when "1100" => decoder_out2 <= "0110001"; 
    when "1101" => decoder_out2 <= "1000010"; 
    when "1110" => decoder_out2 <= "0110000"; 
    when "1111" => decoder_out2 <= "0111000"; 
    when others => decoder_out2 <= "0000001"; 
	 end case;
 end process;

 process (Disp3) begin
    case (Disp3) is
    when "0000" => decoder_out3 <= "0000001"; 
    when "0001" => decoder_out3 <= "1001111"; 
    when "0010" => decoder_out3 <= "0010010"; 
    when "0011" => decoder_out3 <= "0000110"; 
    when "0100" => decoder_out3 <= "1001100"; 
    when "0101" => decoder_out3 <= "0100100"; 
    when "0110" => decoder_out3 <= "0100000"; 
    when "0111" => decoder_out3 <= "0001111"; 
    when "1000" => decoder_out3 <= "0000000"; 
    when "1001" => decoder_out3 <= "0000100"; 
    when "1010" => decoder_out3 <= "0000010"; 
    when "1011" => decoder_out3 <= "1100000";
    when "1100" => decoder_out3 <= "0110001"; 
    when "1101" => decoder_out3 <= "1000010"; 
    when "1110" => decoder_out3 <= "0110000"; 
    when "1111" => decoder_out3 <= "0111000"; 
    when others => decoder_out3 <= "0000001"; 
	 end case;
 end process;

 process (Disp4) begin
    case (Disp4) is
    when "0000" => decoder_out4 <= "0000001"; 
    when "0001" => decoder_out4 <= "1001111"; 
    when "0010" => decoder_out4 <= "0010010"; 
    when "0011" => decoder_out4 <= "0000110"; 
    when "0100" => decoder_out4 <= "1001100"; 
    when "0101" => decoder_out4 <= "0100100"; 
    when "0110" => decoder_out4 <= "0100000"; 
    when "0111" => decoder_out4 <= "0001111"; 
    when "1000" => decoder_out4 <= "0000000"; 
    when "1001" => decoder_out4 <= "0000100"; 
    when "1010" => decoder_out4 <= "0000010"; 
    when "1011" => decoder_out4 <= "1100000";
    when "1100" => decoder_out4 <= "0110001"; 
    when "1101" => decoder_out4 <= "1000010"; 
    when "1110" => decoder_out4 <= "0110000"; 
    when "1111" => decoder_out4 <= "0111000"; 
    when others => decoder_out4 <= "0000001"; 
	 end case;
 end process; 

 process (Disp5) begin
    case (Disp5) is
    when "00" => decoder_out5 <= "0000001"; 
    when "01" => decoder_out5 <= "1001111"; 
    when "10" => decoder_out5 <= "0010010"; 
    when "11" => decoder_out5 <= "0000110"; 
    when others => decoder_out5 <= "0000001"; 
	 end case;
 end process;
						 
	--with (binary_in) select
   -- decoder_out <= "1111110" when x"00000000",
   --                "0110000" when x"00000001",
   --                "1101101" when x"00000010",
   --                "1111001" when x"00000011",
   --                "0110011" when x"00000100",
   --                "1011011" when X"00000101",
   --                "1011111" when X"00000110",
   --                "1110000" when X"00000111",
   --                "1111111" when X"00001000",
   --                "1111011" when X"00001001",
   --                "1111101" when X"00001010",
   --                "0011111" when X"00001011",
   --                "1001110" when X"00001100",
   --                "0111101" when X"00001101",
   --                "1001111" when X"00001110",
   --                "1000111" when X"00001111",
   --                "1111110" when others;
                   
                   
end architecture;