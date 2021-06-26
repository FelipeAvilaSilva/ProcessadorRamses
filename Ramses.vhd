library ieee;
USE ieee.std_logic_1164.all;

entity Ramses is
	port (
		clk, reset, wren: in std_logic;
		--s1,s2,s3,s4: in std_logic;	
		endereco: in std_logic_vector (7 downto 0);
		testeValorEnd: out std_logic_vector (7 downto 0);
		testeSaidaMux02: out std_logic_vector (7 downto 0)
		
	);
end Ramses;

architecture comportamento of Ramses is
signal inA, inB, inRX, inAux, inPC, inREM, inRDM_1,inRDM_2, outA, outB, outRX, outAux, outPC, outREM, outRDM_1, outRDM_2, outMux_01, outMux_02, out_ULA, cout_ULA: std_logic_vector (7 downto 0);
signal z, neg, o: std_logic;

signal s1,s2,s3,s4:  std_logic;
signal cargaRA, cargaRB, cargaRX, cargaPC, cargaRaux, cargaREM, cargaRDM_1, cargaRDM_2:  std_logic;
signal sel_ULA: std_logic_vector (5 downto 0);


type estado is (t0, t1, t2, t3);
signal estado_atual, proximo_estado: estado;

component registradorNbits
	generic(bits: INTEGER := 8);
	port(
		entrada: in STD_LOGIC_VECTOR(bits-1 downto 0);
		clk, reset, carga: in STD_LOGIC;
		saida: out STD_LOGIC_VECTOR(bits-1 downto 0)
	);
end component;

component ULA_nbits
	generic(n : INTEGER := 8);
	port (
		inA, inB : in  std_LOGIC_VECTOR (n-1 downto 0);
		sel      : in  std_LOGIC_VECTOR (5 downto 0);
		Y,Cout   : out std_LOGIC_VECTOR (n-1 downto 0);
		z, neg, o: out STD_LOGIC
	);
end component;

component mux3to1
	PORT
	(
		data0x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data1x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		data2x		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		sel			: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
		result		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

component memoria
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

begin
inA     <= out_ULA;
inB     <= out_ULA;
inRX    <= out_ULA;
inAux   <= out_ULA;
inPC    <= out_ULA;
inRDM_1 <= out_ULA;

mem:			memoria 			  port map (endereco,  clk, outRDM_1, wren, inRDM_2);

testeValorEnd 	 <= outRDM_2;
testeSaidaMux02 <= outMux_02;

reg_A:   	registradorNbits port map (inA,   	clk, reset, cargaRA,    outA);
reg_B:   	registradorNbits port map (inB,   	clk, reset, cargaRB,    outB);
reg_RX:  	registradorNbits port map (inRX,  	clk, reset, cargaRX,    outRX);
reg_Aux: 	registradorNbits port map (inAux, 	clk, reset, cargaRaux,  outAux);
reg_PC:		registradorNbits port map (inPC,  	clk, reset, cargaPC,    outPC);
reg_REM:		registradorNbits port map (inREM,  	clk, reset, cargaREM,   outREM);
reg_RDM_1:	registradorNbits port map (inRDM_1, clk, reset, cargaRDM_1, outRDM_1);
reg_RDM_2:	registradorNbits port map (inRDM_2, clk, reset, cargaRDM_2, outRDM_2);

mux01:  mux3to1 port map (outA, outB, outRX, s1&s2, outMux_01);
mux02:  mux3to1 port map (outAux, outPC, outRDM_2, s3&s4, outMux_02);

ULA:    ula_nbits port map (outMux_01, outMux_02, sel_ULA, out_ULA, cout_ULA, z, neg, o);

process (clk, reset)
	begin
		if (rising_edge(clk)) then	
			estado_atual <= proximo_estado;
		end if;
end process;

process (inA, inB, inRX, inAux, inPC, inREM, inRDM_1,inRDM_2, outA, outB, outRX, outAux, outPC, outREM, outRDM_1, outRDM_2, outMux_01, outMux_02, out_ULA, cout_ULA) 
	begin	
		s1 <= '0';  s2 <= '0'; s3 <= '0'; s4 <= '0'; cargaRA <= '0';
		cargaRB 	 <= '0';  cargaRX	  <= '0'; cargaPC	  <= '0'; cargaRaux <= '0'; cargaREM <= '0'; cargaRDM_1 <= '0'; cargaRDM_2 <= '0';
		sel_ULA <= "000000";
		
		case estado_atual is
			when t0 =>
				cargaRDM_2 <= '1';
				proximo_estado <= t1;
			when t1 =>
				cargaRDM_2 <= '1';
				proximo_estado <= t2;
			when t2 =>
				cargaRDM_2 <= '1';
				proximo_estado <= t3;
			when t3 =>
				cargaRDM_2 <= '0';
				s1 <= '1'; s2 <= '1'; s3 <= '1'; s4 <= '0';			
		end case;
	end process;	
end comportamento;