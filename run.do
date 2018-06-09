#Replace tb with your design name

if [file exists "work"] {vdel -all}
vlib work

vcom ./hdl/arp_types.vhd
vcom ./hdl/axi.vhd
vcom ./hdl/ipv4_types.vhd
vcom ./hdl/*.vhd
vlog ./hdl/global_packages.svh
vlog ./hdl/udp_tx_if.sv


vlog +cover ./hvl/top/udp_uvm_include_pkg.sv
vlog +cover ./hvl/top/testbench_top.sv

vsim testbench_top -coverage
set NoQuitOnFinish 1
onbreak {resume}
log /* -r
run -all
coverage save testbench_top.ucdb
vcover report testbench_top.ucdb 
vcover report testbech_top.ucdb -cvg -details
quit
