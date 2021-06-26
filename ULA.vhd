library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

ENTITY ULA is
	port(
		inA, inB, Cin: in  std_logic;
		sel 			 : in  std_logic_vector (5 downto 0);
		y, Cout	    : out std_logic
	);
end ULA;

architecture comportamento of ULA is
	signal tempY, tempCout, tempCoutSoma, tempCoutSub, soma_resultado, sub_resultado	: std_logic;
	
	component somador 
		port (cin, a, b : IN STD_LOGIC;
            s, cout   : OUT STD_LOGIC
		);
	end component;
	
	component subtrator
    port (cin, a, b : IN STD_LOGIC;
          s, cout   : OUT STD_LOGIC
	 );
	 end component;
	

	begin
		  instancia_somador:   somador   port map (a => inA, b => inB, cin => Cin, cout => tempCoutSoma, s => soma_resultado);
		  instancia_subtrator: subtrator port map (a => inA, b => inB, cin => Cin, cout => tempCoutSub, s => sub_resultado);
		process (inA, inB, sel, soma_resultado, sub_resultado, tempCoutSoma, tempCoutSub, tempCout)
			begin
				case sel is
					when "000000" =>
								tempY    <= soma_resultado;
								tempCout <= tempCoutSoma;
					when "000001" =>
								tempY    <= sub_resultado;
								tempCout <= tempCoutSub;
					when "000010" =>
								tempY <= (inA nand inB) or (not inB);
					when "000011" =>
								tempY <= inA and inB;
					when "000100" =>
								tempY <= inA XOR inB;
					when "000101" =>
								tempY <= NOT inB;
					when others => tempY <= 'X';
				end case;
		end process;
		y <= tempY;
		Cout <= tempCout;
end comportamento;