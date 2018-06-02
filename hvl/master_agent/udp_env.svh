class udp_env extends uvm_env;
	`uvm_component_utils(udp_env)
	
	udp_agent udp_agent_h;
	udp_scoreboard udp_scoreboard_h;
	
	//udp_coverage coverage_h;
	
	extern function new(string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
		
endclass

function udp_env::new(string name, uvm_component parent);
	super.new(name, parent);
endfunction: new

function void udp_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	udp_agent_h= udp_agent::type_id::create("udp_agent_h", this);
	udp_scoreboard_h= udp_scoreboard::type_id::create("udp_scoreboard_h", this);
	
endfunction: build_phase

function void connect_phase(uvm_phase phase);
    udp_agent_h.monitor_h.monitor_ap.connect(udp_scoreboard_h.item_collected_export);
    //mem_agnt.monitor.item_collected_port.connect(mem_scb.item_collected_export);
endfunction : connect_phase

endclass