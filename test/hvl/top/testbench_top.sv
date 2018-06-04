`include "uvm_macros.svh"
import uvm_pkg::*;
import udp_uvm_include_pkg::*;

module testbench_top();
	
	bit clk;
	bit reset;

	initial begin
		clk=1'b0;
		forever #5 clk=~clk;
	end 

	initial begin
		reset=1'b1;
		#5 reset = 1'b0;
	end 
	
	//// Instantiate the interface
	udp_tx_if tx_intf(clk,reset);

	//// Instantiate the DUT
	UDP_TX TX_DUT(
			.udp_tx_start			(tx_intf.udp_tx_start),
			.i_dst_ip_addr 			(tx_intf.udp_txi.hdr.dst_ip_addr),
			.i_dst_port	 			(tx_intf.udp_txi.hdr.dst_port	 ),
			.i_src_port	 			(tx_intf.udp_txi.hdr.src_port	 ),
			.i_data_length			(tx_intf.udp_txi.hdr.data_length),	
			.i_checksum				(tx_intf.udp_txi.hdr.checksum	),
			.i_data_in 				(tx_intf.udp_txi.data.data_out),
			.i_data_in_valid 		(tx_intf.udp_txi.data.data_out_valid),
			.i_data_in_last 		(tx_intf.udp_txi.data.data_out_last),
			.udp_tx_result			(tx_intf.udp_tx_result),
			.udp_tx_data_out_ready	(tx_intf.udp_tx_data_out_ready),
			.clk 					(clk),
			.reset 					(reset),
			.ip_tx_start			(),	
			.o_protocol				(tx_intf.ip_tx.hdr.protocol	),
			.o_data_length			(tx_intf.ip_tx.hdr.data_length),	
			.o_dst_ip_addr 			(tx_intf.ip_tx.hdr.dst_ip_addr ),
			.o_data_out_valid			(tx_intf.ip_tx.data.data_out_valid),
			.o_data_out_last			(tx_intf.ip_tx.data.data_out_last),
			.o_data_out				(tx_intf.ip_tx.data.data_out),
			.ip_tx_result			(tx_intf.ip_tx_result),
			.ip_tx_data_out_ready	(tx_intf.ip_tx_data_out_ready)
			); 

	initial begin
		uvm_config_db #(virtual udp_tx_if)::set(uvm_root::get(), "*", "tx_vif", tx_intf);
		//uvm_config_db #(virtual apb_if)::set(null, "uvm_test_top", "apb_iface", hdl_top.apb_iface);
		
		run_test("udp_test");
	end
endmodule