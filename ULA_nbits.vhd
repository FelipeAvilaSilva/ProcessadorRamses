library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ULA_nBits is
	generic(n : INTEGER := 8);
	port (
		inA, inB : in  std_LOGIC_VECTOR (n-1 downto 0);
		sel      : in  std_LOGIC_VECTOR (5 downto 0);
		Y,Cout   : out std_LOGIC_VECTOR (n-1 downto 0);
		z, neg, o: out STD_LOGIC
	);
end ULA_nBits;

architecture comportamento of ULA_nBits is 
	signal tempY, tempCout, notB, b : std_LOGIC_VECTOR (n-1 downto 0);
	signal tempOverflow, tempZero, tempNegativo, carryIn : std_LOGIC;
	
	component ULA 
		port(
		inA, inB, Cin: in  std_logic;
		sel 			 : in  std_logic_vector (5 downto 0);
		y, Cout	    : out std_logic
	);
	end component;
	
	begin		
		process (sel, inB)
			begin
				case sel is
					when "000001" => --se for negativo, faz complemento de 2 de inB
											b       <= not inB;
											carryIn <= '1';
					when others  => 
											b       <= inB;
											carryIn <= '0';
				end case;
		end process;
		
		primeira_instancia_ULA: ula port map(inA => inA(0), inB => b(0), Cin => carryIn, sel => sel, y => tempY(0), Cout => tempCout(0));
	
		oi: for i in 1 to n-1 generate
			proximas_n_instancias: ula port map(inA => inA(i), inB => b(i), Cin => tempCout(i-1), sel => sel, y => tempY(i), Cout => tempCout(i));
		end generate;
		
		
		process (tempY, tempCout)
			begin	
				case tempY is
					when "00000000" => tempZero <= '1';					
					when others  => tempZero <= '0';
				end case;
				
				case tempY(n-1) is
					when '1'    => tempNegativo <= '1';	
					when others => tempNegativo <= '0';
				end case;
				
				case tempCout(n-1) xor tempCout (n-2) is
					when '1'    => tempOverflow <= '1';	
					when others => tempOverflow <= '0';
				end case;
		end process;

		
		Cout <= tempCout;
		Y    <= tempY;
		z	  <= tempZero;
		o 	  <= tempOverflow;
		neg  <= tempNegativo;
		
end comportamento;