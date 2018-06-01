`include "uvm_macros.svh"
`include "udp_uvm_include_pkg.sv"

import uvm_pkg::*;

module testbench_top();
	initial begin
		uvm_config_db #(virtual udp_if)::set(null, "uvm_test_top", "uvm_iface", hdl_top.udp_iface);
		//uvm_config_db #(virtual apb_if)::set(null, "uvm_test_top", "apb_iface", hdl_top.apb_iface);
		
		run_test();
	end
endmodule