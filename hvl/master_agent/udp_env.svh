class udp_env extends uvm_env;
	`uvm_component_utils(udp_env)
	
	udp_agent udp_agent_h;
	//apb_slave_agent slave_agent_h;
	
	//udp_coverage coverage_h;
	
	extern function new(string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	//extern function void connect_phase(uvm_phase phase);
		
endclass

function udp_env::new(string name, uvm_component parent);
	super.new(name, parent);
endfunction

function void udp_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	udp_agent_h= udp_agent::type_id::create("udp_agent_h", this);
	
	//slave_agent_h= apb_slave_agent::type_id::create("slave_agent_h", this);
	
endfunction