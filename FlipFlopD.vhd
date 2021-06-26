library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity FlipFlopD is 
	port(
		D, reset, clk: in STD_LOGIC;
		Q: out STD_LOGIC
	);
end FlipFlopD;
architecture comportamento of FlipFlopD is
	begin
		process(clk, reset)
		begin
			if reset = '1' then
				Q <= '0';
			elsif rising_edge(clk) then
				Q <= D;
			end if;
		end process;
end comportamento;