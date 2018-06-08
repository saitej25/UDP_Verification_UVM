class udp_seq extends uvm_sequence #(udp_transaction);
	`uvm_object_utils(udp_seq)

	function new(string name= "");
		super.new(name);
	endfunction

	virtual task body();
		repeat(20) begin
			udp_transaction txn;
			txn= udp_transaction::type_id::create("txn");
			start_item(txn);

			void'(txn.randomize() with {txn.pattern dist {0:=1, 1:=1, 2:=1, 3:=1, 4:=1, 5:=1, 6:=1};} );
			$display("txn.pattern.name=%s",txn.pattern.name);
			finish_item(txn);
		end
	endtask
endclass
