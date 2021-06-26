library ieee;
USE ieee.std_logic_1164.all;

entity unidadeDeControle is
	port (
		testeValorEndereco: in std_logic_vector (7 downto 0);
		clk, reset: in std_logic
	);
end unidadeDeControle;

architecture comportamento of unidadeDeControle is
type estado is (t0, t1, t2, t3, t4, t5);
signal estado_atual, proximo_estado: estado;

signal wren: std_logic;
signal sel_ULA: std_logic_vector (5 downto 0);
signal sel_MUX01, sel_MUX02, sel_MUX03, sel_MUX04: std_logic;
signal cargaRA, cargaRB, cargaRX, cargaPC, cargaRaux, cargaREM, cargaRDM_1, cargaRDM_2: std_logic;
signal endereco: std_logic_vector (7 downto 0);
component Ramses 
	port (
		clk, reset, wren: in std_logic;
		s1,s2,s3,s4: in std_logic;
		cargaRA, cargaRB, cargaRX, cargaPC, cargaRaux, cargaREM, cargaRDM_1, cargaRDM_2: in std_logic;
		endereco: in std_logic_vector (7 downto 0);
		sel_UAL: in std_logic_vector (5 downto 0)
	);
end component;

begin

	
end comportamento;