class udp_test extends uvm_test;
	
	`uvm_component_utils(udp_test)
	
	udp_env env;
	udp_seq seq;
	
	function new(string name="udp_test", uvm_component parent=null);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		env= udp_env::type_id::create("env", this);
		seq= udp_seq::type_id::create("seq");
		
	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq.start(env.udp_agent_h.sequencer_h);
		phase.drop_objection(this);
	endtask : run_phase
	
endclass: udp_test
