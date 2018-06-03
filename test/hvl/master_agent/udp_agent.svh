class udp_agent extends uvm_agent;
	`uvm_component_utils(udp_agent)
	
	udp_sequencer sequencer_h;
	udp_driver driver_h;
	udp_monitor monitor_h;
	//udp_scoreboard scoreboard_h;

	//uvm_analysis_port #(udp_transaction) agent_ap;
	
	extern function new(string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
	
endclass

function udp_agent::new(string name, uvm_component parent);
	super.new(name, parent);
endfunction

function void udp_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	sequencer_h= udp_sequencer::type_id::create("sequencer_h", this);
	driver_h= udp_driver::type_id::create("driver_h", this);
	monitor_h= udp_monitor::type_id::create("monitor_h", this);
	//scoreboard_h= udp_scoreboard::type_id::create("scoreboard_h", this);
endfunction

function void udp_agent::connect_phase(uvm_phase phase);
	super.connect_phase(phase);
	
	//monitor_h.monitor_ap.connect(agent_ap);
	driver_h.seq_item_port.connect(sequencer_h.seq_item_export);
	
endfunction