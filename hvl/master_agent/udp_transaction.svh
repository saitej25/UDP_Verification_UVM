import global_typs_pkg::*;
	 

class udp_transaction extends uvm_sequence_item;
	`uvm_object_utils(udp_transaction)
	///// Signals ///////////////
	function new(string name= "udp_transaction");
		super.new(name);
	endfunction

	//rand bit [15:0] dst_port,src_port,data_length;

	/*typedef struct {
		rand int      unsigned dst_ip_addr;
		rand shortint unsigned dst_port   ;
		rand shortint unsigned src_port   ;
		rand shortint unsigned data_length;
		rand shortint unsigned checksum   ;
	} udp_tx_header_type;
	*/

	rand udp_tx_header_type tx_hdr;
	rand patterns pattern;
	rand bit [7:0] data [2500] ;
	bit tx_data_last;

	/*`uvm_object_utils_begin(udp_transaction)
	`uvm_field_int(tx_hdr,UVM_ALL_ON)
	`uvm_field_int(pattern,UVM_ALL_ON)
	`uvm_field_int(data,UVM_ALL_ON)
	`uvm_field_int(tx_data_last,UVM_ALL_ON)
	`uvm_object_utils_end
	*/

	constraint data_ln{tx_hdr.data_length dist {0:=1, [1:1471]:=25, 1472:=2, [1473:2343]:=1};}

	constraint dst_prt{tx_hdr.dst_port dist {0:=0, [1:2**12]:=37, [(2**12)+1:2**15]:=1};}

	constraint src_prt{tx_hdr.src_port dist {0:=0, [1:2**12]:=37, [(2**12)+1:2**15]:=1};}

	//constraint packet_length {data.size == tx_hdr.data_length;}

	/*function void post_randomize();
	for(int i = 0; i < data.size()); i++) begin
	data[i]=new();

	end
	endfunction
	*/

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

		/*else
		foreach(data[i]) {
			//data[i]=new[tx_hdr.data_length];
			data[i] == $urandom();
		} */
	}

/*function ramp(ref m);
	m=m+1;
	return m;
endfunction : ramp
*/

/*function void post_randomize();
	data.sort;
	endfunction 
*/
endclass: udp_transaction