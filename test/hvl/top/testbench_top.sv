`include "uvm_macros.svh"
`include "udp_uvm_include_pkg.sv"

import uvm_pkg::*;

module testbench_top();
	
	bit clk;
	bit reset;

	initial begin
		clk=1'b0;
		#5 forever clk=1'b1;
	end 

	initial begin
		reset=1'b1;
		#5 reset = 1'b0;
	end 
	
	//// Instantiate the DUT
	UDP_TX TX_DUT(.clk(clk), .reset(reset), .udp_tx_start(tx_intf.udp_tx_start), .udp_txi(tx_intf.udp_txi), .udp_tx_result(tx_intf.udp_tx_result), .udp_tx_data_out_ready(tx_intf.udp_tx_data_out_ready), .ip_tx_start(tx_intf.ip_tx_start), .ip_tx(tx_intf.ip_tx), .ip_tx_result(tx_intf.ip_tx_result), .ip_tx_data_out_ready(tx_intf.ip_tx_data_out_ready));

	//// Instantiate the interface
	udp_tx_if tx_intf(clk,reset);

	initial begin
		uvm_config_db #(virtual udp_tx_if)::set(null, "*", "tx_vif", tx_intf);
		//uvm_config_db #(virtual apb_if)::set(null, "uvm_test_top", "apb_iface", hdl_top.apb_iface);
		
		run_test();
	end
endmodule