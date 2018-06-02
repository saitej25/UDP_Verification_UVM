import global_typs_pkg::*;

class udp_transaction extends uvm_sequence_item;
	`uvm_object_utils(udp_transaction)

////// Signals ///////////////


	function new(string name= "");
		super.new(name);
	endfunction


	//rand bit [15:0] dst_port,src_port,data_length;

	rand udp_tx_header_type tx_hdr;


	rand patterns pattern;

	rand bit [7:0] data [*];

	bit tx_data_last;

	constraint data_ln{tx_hdr.data_length dist {0:=1; [1:1471]:=25; 1472:=2; [1473:2343]:=1};}

		constraint dst_prt{tx_hdr.dst_port dist {0:=0; [1:2**12]:=37; [(2**12)+1:2**15]:=1};}

			constraint src_prt{tx_hdr.src_port dist {0:=0; [1:2**12]:=37; [(2**12)+1:2**15]:=1};}

				constraint packet_length {data.size = tx_hdr.data_length;}

				constraint data_c {
					if(pattern == ZERO)
					foreach(data[i]) {
						data[i] == 'h00;}

				else if(pattern == ONES)
				foreach(data[i]) {
					data[i] == 'hFF;}

				else if(pattern == ZEROS_ONES) 
				foreach(data[i]){
				if(i%2==0)
				data[i] == 'h00;
				else
				data[i] == 'hFF;
				}

				else if(pattern==RAMP)
					foreach(data[i]) {
					data[i] == i;}


				else if(pattern==TRIANGLE)
					foreach(data[i]) {
					if(i<=data_length/2)
					data[i] == i;
					else
					data[i] == data_length - i;}

				else if(pattern==LONG_ZERO_ONES)
				foreach(data[i]) {
					if(i<=data_length/2)
					data[i] == 'h00;
					else
					data[i] == 'hFF;}

				else
				foreach(data[i])
					data[i] = $urandom_range(0,255);

				}


endclass: udp_transaction