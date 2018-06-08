import global_typs_pkg::*;

class udp_transaction extends uvm_sequence_item;
	`uvm_object_utils(udp_transaction)
	///// Signals ///////////////
	function new(string name= "udp_transaction");
		super.new(name);
	endfunction

	rand udp_tx_header_type tx_hdr;
	rand patterns pattern;
	rand bit [2499:0] [7:0] data ;
	bit [2499:0] [7:0] data_rx ;
	bit tx_data_last;

	//UDP Layer RX
	logic             udp_rx_start         ;
	udp_rx_type       udp_rxi              ;
	logic       [1:0] udp_rx_result        ;
	logic             udp_rx_data_out_ready;


	constraint data_ln{tx_hdr.data_length dist {0:=1, [1:1471]:=25, 1472:=2, [1473:2343]:=1};}

	constraint dst_prt{tx_hdr.dst_port dist {[1:2**12]:=40, [(2**12)+1:2**15]:=1};}

	constraint src_prt{tx_hdr.src_port dist {[1:2**12]:=40, [(2**12)+1:2**15]:=1};}

	constraint dst_ip_addr{tx_hdr.dst_ip_addr dist {0:=1, [32'h1:32'hFFFF_FFFE]:=5, '1:=1};}
	//constraint packet_length {data.size == tx_hdr.data_length;}


	constraint data_c {
		if(pattern == ZEROS)    {
			foreach(data[i]) {
				data[i] == 'h00;} }


		else if(pattern == ONES)
		foreach(data[i]) {
			// data[i]=new[tx_hdr.data_length];
			data[i] == 'hFF;}

		else if(pattern == ZEROS_ONES)
		foreach(data[i]) {
			if(i%2==0) {
				//data[i]=new[tx_hdr.data_length];
				data[i] == 'h00;
			}
			else {
				//data[i]=new[tx_hdr.data_length];
				data[i] == 'hFF;
			}
		}

		else if(pattern==RAMP)
		foreach(data[i]) {
			data[i] == i%256;
		}

		else if(pattern==TRIANGLE) {
			foreach(data[i]) {
				if(i%256<128) {
					//data[i]=new[tx_hdr.data_length];
					data[i] == i%256; }
				else {
					//data[i]=new[tx_hdr.data_length];
					data[i] == 8'd255 - i%256;
				}
			} }

		else if(pattern==LONG_ZERO_ONES)
		foreach(data[i]) {
			//data[i]=new[tx_hdr.data_length];
			if(i<=tx_hdr.data_length/2)
			data[i] == 'h00;
			else
			data[i] == 'hFF; }

	}

endclass: udp_transaction