class udp_monitor extends uvm_monitor;
	`uvm_component_utils(udp_monitor)
	
	//Declare analysis port to send txn to scoreboard
	uvm_analysis_port #(udp_transaction) monitor_ap;
	
	//Declare config class which has the virtual interface and optional other
	//dut info
	udp_config iface_config;
	
	//Declare virtual interface
	virtual udp_if vif;
	
	extern function new(string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	
endclass: udp_monitor
	
function udp_monitor::new(string name, uvm_component parent);
	super.new(name, parent);
endfunction

function void udp_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	monitor_ap= new("monitor_ap", this);
	
	//Get virtual interface from parent
	assert(uvm_config_db #(udp_config)::get(this, "", "iface_config", iface_config));
	
	vif= iface_config.udp_vif;
endfunction

task udp_monitor::run_phase(uvm_phase phase);
	udp_transaction txn;
	txn= udp_transaction::type_id::create("txn", this);
	
//// Enter code here ///////

	/*txn.HTRANS= new[1];
	txn.HADDR= new[1];
	txn.HWDATA= new[1];
	*/
	forever begin
//// Enter Code here /////		
		//vif.udp_monitor(txn.HTRANS[1], txn.HBURST, txn.HSIZE, txn.HWRITE, txn.HADDR[1], txn.HWDATA[1], txn.HRDATA);
		
		//Send txn to subscribers
		monitor_ap.write(txn);
	end
endtask