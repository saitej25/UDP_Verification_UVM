import global_typs_pkg::*;

module udp_vhdl_sv (
	udp_tx_if udp_tx_if_inst
	);

//Instance 
UDP_TX TX_DUT(.clk(clk), .reset(reset), .udp_tx_start(tx_intf.udp_tx_start), .udp_txi(tx_intf.udp_txi), .udp_tx_result(tx_intf.udp_tx_result), .udp_tx_data_out_ready(tx_intf.udp_tx_data_out_ready), .ip_tx_start(tx_intf.ip_tx_start), .ip_tx(tx_intf.ip_tx), .ip_tx_result(tx_intf.ip_tx_result), .ip_tx_data_out_ready(tx_intf.ip_tx_data_out_ready));

//assign udp_tx_if_inst.udp_txi.hdr.dst_ip_addr = 


endmodule