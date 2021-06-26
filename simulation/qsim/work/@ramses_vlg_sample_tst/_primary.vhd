library verilog;
use verilog.vl_types.all;
entity Ramses_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        endereco        : in     vl_logic_vector(7 downto 0);
        reset           : in     vl_logic;
        wren            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end Ramses_vlg_sample_tst;
