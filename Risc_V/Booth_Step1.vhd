LIBRARY ieee ;
USE ieee.std_logic_1164.all ;

ENTITY Booth_Step1 IS
	PORT (	
		CarryIn, val1, val2: IN STD_LOGIC;
		SomaResult, CarryOut: OUT STD_LOGIC 
	);
END Booth_Step1 ;

ARCHITECTURE RTL_Booth_Step1 OF Booth_Step1 IS

BEGIN
	SomaResult <= (val1 XOR val2) XOR CarryIn;
	CarryOut <= (val1 AND val2) OR (CarryIn AND val1) OR (CarryIn AND val2);
END RTL_Booth_Step1 ;

