-- Modelo en VHDL(ALU) de 4Bits
--Fecha: 02-12-2020
--Version 1.0
--Autor: Veronica Lopez Paladines
--***************************************************
-- Declaracion de librerias

	library IEEE; 
	use ieee.std_logic_1164.all;
	use ieee.std_logic_arith.all;
	use ieee.std_logic_unsigned.all;
	
-- ENTIDAD
	entity alu is 
	port 
		(  
			-- Pines de Entrada
			A       : in std_logic_vector(7 downto 0);
			B       : in std_logic_vector(7 downto 0);
			ALU_Sel  : in std_logic_vector(3 downto 0);
		
			-- Pines de Salida
			NZVC  : out std_logic_vector(3 downto 0);
			Result : out std_logic_vector (7 downto 0)
			
			
	);
end alu;
architecture alu of alu is

begin	
ALU_PROCESS : process (A, B, ALU_Sel)
variable Sum_uns : unsigned(8 downto 0);
begin
if (ALU_Sel = "000")then --ADICION

	--Sum Calculation 
		Sum_uns := unsigned('0' & A) + unsigned ('0' & B);
		Result <= std_logic_vector(Sum_uns(7 downto 0));
	--Negative Flag (N)
		NZVC(3) <= Sum_uns(7);
	--Zero Flag (Z)
		if (std_logic_vector(Sum_uns(7 downto 0)) = "00000000")then 
		NZVC(2) <= '1';
		else 
		NZVC(2) <= '0';
		end if;
	--OverFlow Flag (V)
		if ((A(7)= '0' and B(7)= '0' and Sum_uns(7)= '1') or 
		(A(7)= '1' and B(7)= '1' and Sum_uns(7)= '0'))then 
		NZVC(1) <= '1';
		else 
		NZVC(1) <= '0';
		end if;
	--Carry Flag (C)
		NZVC(0) <= Sum_uns(8);
end if;
end process;
end architecture;		

