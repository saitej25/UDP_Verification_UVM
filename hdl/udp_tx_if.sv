import global_typs_pkg::*;

	interface udp_tx_if (
		input logic clk,
		input logic reset
	);

	//UDP Layer signals
	logic udp_tx_start		   ;
	logic udp_tx_type  udp_txi ;
	logic udp_tx_result        ;
	logic udp_tx_data_out_ready;
	//IP layer TX signals
	logic ip_tx_start		  ;
	logic ipv4_tx_type ip_tx  ;
	logic ip_tx_result        ;
	logic ip_tx_data_out_ready;


	task send_hdr(input udp_tx_header_type hdr);
		wait(ip_tx_data_out_ready)
		udp_tx_start = 1;
		udp_txi.hdr = hdr;
		@(posedge clk);
		udp_tx_start = 0;
		repeat(9)@(posedge clk);
	endtask : send_pkt

	task send_data(input byte unsigned data ,input last);
		udp_txi.data.data_out = data;
		udp_txi.data.data_out_valid = 1;
		udp_txi.data.data_out_last = last;
	endtask : send_data

	task clear_valid();
	udp_txi.data.data_out_valid = 0;
	endtask : clear_fields

endinterface