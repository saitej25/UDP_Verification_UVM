class udp_driver extends uvm_driver #(udp_transaction);
	`uvm_component_utils(udp_driver);
	
	//Declare config class which has the virtual interface and optional other
	//dut info
	udp_config iface_config;
	
	//Declare virtual interface
	virtual udp_if vif;
	
	extern function new(string name, uvm_component parent);
	extern function void build_phase(uvm_phase phase);
	extern task run_phase(uvm_phase phase);
	
endclass: udp_driver
	
function udp_driver::new(string name, uvm_component parent);
	super.new(name, parent);
endfunction: new

function void udp_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	//Get virtual interface
	assert(uvm_config_db #(udp_config)::get(this, "", "iface_config", iface_config))
	else begin 
		`uvm_fatal(get_full_name(), "Cannot get iface_config from uvm_config_db");
	end
	
	vif= iface_config.udp_vif;
endfunction: build_phase

task udp_driver::run_phase(uvm_phase phase);
	udp_transaction txn;
	
	forever begin
		seq_item_port.get_next_item(txn);
		
/////// Insert code here /////////////////

		/*foreach(txn.HADDR[i]) begin
			//Call task from interface
			//$display("ahb_master_driver: txn.HBURST= %0d, txn.HADDR= %0h", txn.HBURST, txn.HADDR[i]);
			vif.ahb_master_driver(txn.HTRANS[i], txn.HBURST, txn.HSIZE, txn.HWRITE, txn.HADDR[i], txn.HWDATA[i]);
		end
		*/
		seq_item_port.item_done();
	end
endtask: run_phase