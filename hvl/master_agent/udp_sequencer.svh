class udp_sequencer extends uvm_sequencer #(udp_transaction);
	`uvm_component_utils(udp_sequencer)
	
	function new(string name= "", uvm_component parent);
		super.new(name, parent);
	endfunction
endclass