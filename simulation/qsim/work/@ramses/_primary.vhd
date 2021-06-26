library verilog;
use verilog.vl_types.all;
entity Ramses is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        wren            : in     vl_logic;
        endereco        : in     vl_logic_vector(7 downto 0);
        testeValorEnd   : out    vl_logic_vector(7 downto 0)
    );
end Ramses;
