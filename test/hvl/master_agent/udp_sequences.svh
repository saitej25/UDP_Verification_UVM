class udp_seq extends uvm_sequence #(udp_transaction);
	`uvm_object_utils(udp_seq)
	
	function new(string name= "");
		super.new(name);
	endfunction
	
	virtual task body();
		udp_transaction txn;
		txn= udp_transaction::type_id::create("txn");
		//wait_for_grant();
		start_item(txn);
		$display("yes1");
		void'(txn.randomize());
		$display("yes2");
		finish_item(txn);
		$display("yes3");
		//send_request(req);
		//wait_for_item_done();
	endtask
endclass

/*
class udp_simple_seq extends uvm_sequence #(udp_transaction);
	`uvm_object_utils(udp_simple_seq)
	
	function new(string name= "");
		super.new(name);
	endfunction
	
	task body();
		udp_transaction txn;
		txn= udp_transaction::type_id::create("txn");
		start_item(txn);
		
////////// Enter code here /////

		assert(txn.randomize() with {HBURST inside{ZEROS,ONES,ZEROS_ONES,LONG_ZERO_ONES,RAMP,TRIANGLE,PRBS,MUL_SAME_PKTS};});
		//$display("ahb_master_wrap_seq: txn.HBURST= %0d, txn.HADDR.size= %0d", txn.HBURST, txn.HADDR.size);
		finish_item(txn);
	endtask
	
endclass

class udp_complex_seq extends uvm_sequence #(udp_transaction);
	`uvm_object_utils(udp_complex_seq)
	
	function new(string name= "");
		super.new(name);
	endfunction
	
	task body();
		udp_transaction txn;
		txn= udp_transaction::type_id::create("txn");
		start_item(txn);
		// Enter code here /////

		//assert(txn.randomize() with {HBURST inside{INCR4, INCR8, INCR16};});
		finish_item(txn);
	endtask


endclass
*/