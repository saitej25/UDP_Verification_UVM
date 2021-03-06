class udp_monitor extends uvm_monitor;
	`uvm_component_utils(udp_monitor)

	//Declare analysis port to send txn to scoreboard
	uvm_analysis_port #(udp_transaction) monitor_ap;

	//Declare virtual interface
	virtual udp_tx_if tx_vif;


	extern function new(string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);

endclass: udp_monitor

function udp_monitor::new(string name, uvm_component parent);
	super.new(name, parent);
	monitor_ap= new("monitor_ap", this);
endfunction

function void udp_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);

	//Get virtual interface from parent
	assert(uvm_config_db #(virtual udp_tx_if)::get(this, "", "tx_vif", tx_vif));

endfunction

task udp_monitor::run_phase(uvm_phase phase);
	udp_transaction txn;
	txn= udp_transaction::type_id::create("txn", this);

	forever begin
		txn.tx_hdr=tx_vif.udp_txi.hdr;
		tx_vif.read_hdr(txn.udp_rxi.hdr);
		for (int i=0; i<txn.udp_rxi.hdr.data_length; i++)
			fork
				tx_vif.read_tx_data(txn.data[i]);
				tx_vif.read_rx_data(txn.data_rx[i]);
			join

			monitor_ap.write(txn);

	end
endtask