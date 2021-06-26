onerror {quit -f}
vlib work
vlog -work work Ramses.vo
vlog -work work Ramses.vt
vsim -novopt -c -t 1ps -L cycloneii_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.Ramses_vlg_vec_tst
vcd file -direction Ramses.msim.vcd
vcd add -internal Ramses_vlg_vec_tst/*
vcd add -internal Ramses_vlg_vec_tst/i1/*
add wave /*
run -all
