typedef uvm_sequencer #(udp_transaction) a_sequencer_t;
//typedef uvm_sequencer #(apb_slave_transaction) b_sequencer_t;

class udp_vseq_base extends uvm_sequence #(uvm_sequence_item);
	`uvm_object_utils(udp_vseq_base)
	
	//Sequencer path will be defined by the calling tests
	a_sequencer_t a_sequencer;
	//b_sequencer_t b_sequencer;
	
	function new(string name= "");
		super.new(name);
	endfunction
	
	task body();
		//override with child class
	endtask
endclass

class udp_simple_vseq extends udp_vseq_base;
	`uvm_object_utils(udp_simple_vseq)
	
	function new(string name= "");
		super.new(name);
	endfunction
	
	task body();
		udp_simple_seq seq1;
		//apb_slave_okay_seq seq2;
		
		seq1= udp_simple_seq::type_id::create("seq1");
		//seq2= apb_slave_okay_seq::type_id::create("seq2");
		
		fork
			seq1.start(a_sequencer);
			//seq2.start(b_sequencer);
		join
	endtask
	
endclass

class udp_complex_vseq extends udp_vseq_base;
	`uvm_object_utils(udp_complex_vseq)
	
	function new(string name= "");
		super.new(name);
	endfunction
	
	task body();
		udp_complex_seq seq1;
		//apb_slave_okay_seq seq2;
		
		seq1= udp_complex_seq::type_id::create("seq1");
		//seq2= apb_slave_okay_seq::type_id::create("seq2");
		
		fork
			seq1.start(a_sequencer);
			//seq2.start(b_sequencer);
		join
	endtask
	
endclass