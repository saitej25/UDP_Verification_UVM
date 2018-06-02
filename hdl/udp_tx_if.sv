import global_typs_pkg::*;

	interface udp_tx_if (
		input logic clk,
		input logic reset
	);

	//UDP Layer signals
	logic              udp_tx_start         ;
	logic udp_tx_type  udp_txi              ;
	logic              udp_tx_result        ;
	logic              udp_tx_data_out_ready;
	//IP layer TX signals
	logic              ip_tx_start           ;
	logic ipv4_tx_type ip_tx                 ;
	logic              ip_tx_result          ;
	logic              ip_tx_data_out_ready  ;


task send_pkt(input udp_tx_header_type hdr, input byte unsigned data[], input size);

endtask : send_pkt

endinterface