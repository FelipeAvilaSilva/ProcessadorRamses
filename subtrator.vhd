LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY subtrator IS
    PORT (cin, a, b : IN STD_LOGIC;
          s, cout   : OUT STD_LOGIC);
END subtrator;

ARCHITECTURE comportamento OF subtrator IS
BEGIN	
       cout <= (a AND b) OR (a AND cin) OR (b AND cin);
		 s <= a XOR b XOR cin;
END comportamento;
