`include "uvm_macros.svh"
import uvm_pkg::*;
import udp_uvm_include_pkg::*;

module testbench_top();

	bit clk  ;
	bit reset;

	initial begin
		clk=1'b0;
		forever #5 clk=~clk;
	end

	initial begin
		reset=1'b1;
		#100 reset = 1'b0;
	end

	//// Instantiate the interface
	udp_tx_if tx_intf (clk);

	//// Instantiate coverage
	udp_coverage cov;

	//// Instantiate the DUT
	UDP_TX TX_DUT (
		.udp_tx_start         (tx_intf.udp_tx_start               ),
		.i_dst_ip_addr        (tx_intf.udp_txi.hdr.dst_ip_addr    ),
		.i_dst_port           (tx_intf.udp_txi.hdr.dst_port       ),
		.i_src_port           (tx_intf.udp_txi.hdr.src_port       ),
		.i_data_length        (tx_intf.udp_txi.hdr.data_length    ),
		.i_checksum           (tx_intf.udp_txi.hdr.checksum       ),
		.i_data_in            (tx_intf.udp_txi.data.data_out      ),
		.i_data_in_valid      (tx_intf.udp_txi.data.data_out_valid),
		.i_data_in_last       (tx_intf.udp_txi.data.data_out_last ),
		.udp_tx_result        (tx_intf.udp_tx_result              ),
		.udp_tx_data_out_ready(tx_intf.udp_tx_data_out_ready      ),
		.clk                  (clk                                ),
		.reset                (tx_intf.reset                      ),
		.ip_tx_start          (ip_tx_start                        ),
		.o_protocol           (tx_intf.ip_tx.hdr.protocol         ),
		.o_data_length        (tx_intf.ip_tx.hdr.data_length      ),
		.o_dst_ip_addr        (tx_intf.ip_tx.hdr.dst_ip_addr      ),
		.o_data_out_valid     (tx_intf.ip_tx.data.data_out_valid  ),
		.o_data_out_last      (tx_intf.ip_tx.data.data_out_last   ),
		.o_data_out           (tx_intf.ip_tx.data.data_out        ),
		.ip_tx_result         (tx_intf.ip_tx_result               ),
		.ip_tx_data_out_ready (tx_intf.ip_tx_data_out_ready       )
	);



	UDP_RX RX_DUT (
		.udp_rx_start      (tx_intf.udp_rx_start               ),
		.o_is_valid        (                                   ),
		.o_src_ip_addr     (tx_intf.udp_rxi.hdr.src_ip_addr    ),
		.o_src_port        (tx_intf.udp_rxi.hdr.src_port       ),
		.o_dst_port        (tx_intf.udp_rxi.hdr.dst_port       ),
		.o_data_length     (tx_intf.udp_rxi.hdr.data_length    ),
		.o_data_out_valid  (tx_intf.udp_rxi.data.data_in_valid),
		.o_data_out_last   (tx_intf.udp_rxi.data.data_in_last ),
		.o_data_out        (tx_intf.udp_rxi.data.data_in      ),
		.clk               (clk                                ),
		.reset             (tx_intf.reset                      ),
		.ip_rx_start       (ip_tx_start                        ),
		.i_is_valid        (1'b0                               ),
		.i_protocol        (tx_intf.ip_tx.hdr.protocol         ),
		.i_data_length     (tx_intf.ip_tx.hdr.data_length      ),
		.i_src_ip_addr     (tx_intf.ip_tx.hdr.dst_ip_addr      ),
		.i_num_frame_errors(8'b0                               ),
		.i_last_error_code (4'b0                               ),
		.i_is_broadcast    (1'b0                               ),
		.i_data_in         (tx_intf.ip_tx.data.data_out  	   ),
		.i_data_in_valid   (tx_intf.ip_tx.data.data_out_valid  ),
		.i_data_in_last    (tx_intf.ip_tx.data.data_out_last   )
	);

	initial begin
		uvm_config_db #(virtual udp_tx_if)::set(uvm_root::get(), "*", "tx_vif", tx_intf);
		end

/////////////// Run Test //////////////////////
	initial begin	
		run_test("udp_test");
	end

/////////////  Execute Coverage  ///////////////////
	initial begin
		cov = new(tx_intf);
		cov.execute();
	end 
endmodule