class udp_env extends uvm_env;
	`uvm_component_utils(udp_env)
	
	udp_agent udp_agent_h;
	udp_scoreboard udp_scoreboard_h;
	virtual udp_tx_if tx_vif;
		
	extern function new(string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern function void connect_phase(uvm_phase phase);
endclass

function udp_env::new(string name, uvm_component parent);
	super.new(name, parent);
endfunction: new

function void udp_env::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	assert(uvm_config_db #(virtual udp_tx_if)::get(this, "", "tx_vif", tx_vif))
	else begin 
		`uvm_fatal(get_full_name(), "Cannot get iface_config from uvm_config_db");
	end

	udp_agent_h= udp_agent::type_id::create("udp_agent_h", this);
	udp_scoreboard_h= udp_scoreboard::type_id::create("udp_scoreboard_h", this);
endfunction: build_phase

function void udp_env::connect_phase(uvm_phase phase);
    udp_agent_h.monitor_h.monitor_ap.connect(udp_scoreboard_h.item_collected_export);
endfunction : connect_phase
