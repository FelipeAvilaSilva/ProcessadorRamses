library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity registradorNbits is
	generic(bits: INTEGER := 8);
	port(
		entrada: in STD_LOGIC_VECTOR(bits-1 downto 0);
		clk, reset, carga: in STD_LOGIC;
		saida: out STD_LOGIC_VECTOR(bits-1 downto 0)
	);
end registradorNbits;
architecture comportamento of registradorNbits is
	signal temp_D, temp_Q: STD_LOGIC_VECTOR(bits-1 downto 0);
	
	component FlipFlopD 
		port(
			D, reset, clk: in STD_LOGIC;
			Q: out STD_LOGIC
		);
	end component;
	
	begin				
		laco: for i in 0 to bits-1 generate
			cria_flipflopD: FlipFlopD port map(reset => reset, D => temp_D(i), clk => clk, Q => temp_Q(i));
		end generate;		
		temp_D <= 
				entrada when carga = '1' --controla quais registradores receberao saida da ULA
				else temp_Q;	
		saida <= temp_Q;	
end comportamento;
