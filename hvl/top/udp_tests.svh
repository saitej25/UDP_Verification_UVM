class udp_test extends uvm_test;
	
	`uvm_component_utils(udp_test)
	
	udp_env env;
	udp_seq seq;
	//uvm_config iface_config;
	
	function new(string name="udp_test", uvm_component parent=null);
		super.new(name, parent);
	endfunction
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		//iface_config= new();
		
		//Get udp virtual interface 
		/*assert(uvm_config_db #(virtual udp_tx_if)::get(this, "", "tx_vif", tx_vif));
		else begin 
			`uvm_fatal(get_full_name(), "Cannot get vif from uvm_config_db");
		end
		/*assert(uvm_config_db #(virtual apb_if)::get(this, "", "apb_iface", iface_config.apb_vif))
		else begin 
			`uvm_fatal(get_full_name(), "Cannot get vif from uvm_config_db");
		end
		*/
		//
		//Send vif to driver and monitor
		//uvm_config_db #(udp_config)::set(this, "*", "iface_config", iface_config);
		
		//txn= udp_transaction::type_id::create("txn");
		env= udp_env::type_id::create("env", this);
		seq= udp_seq::type_id::create("seq");

	endfunction
	
	task run_phase(uvm_phase phase);
		phase.raise_objection(this);
		seq.start(env.udp_agent_h.sequencer_h);
		phase.drop_objection(this);
	endtask : run_phase
	
	/*Default sequencer. If you need to change the sequencer override this function
	//in child tests
	function void default_seqr(udp_vseq_base vseq);
		vseq.a_sequencer= env.udp_agent_h.sequencer_h;
		//vseq.b_sequencer= env.slave_agent_h.sequencer_h;
	endfunction
	*/

endclass: udp_test


/*class ahb_apb_incr_test extends ahb_apb_base_test;

	`uvm_component_utils(ahb_apb_incr_test)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		ahb_apb_incr_vseq vseq;
		vseq= ahb_apb_incr_vseq::type_id::create("vseq");
		
		phase.raise_objection(this);
		default_seqr(vseq);
		
		//Virtual sequence doesn't run on any sequencer
		vseq.start(null);
		phase.drop_objection(this);
	endtask

endclass

class ahb_apb_wrap_test extends ahb_apb_base_test;

	`uvm_component_utils(ahb_apb_wrap_test)
	
	function new(string name, uvm_component parent);
		super.new(name, parent);
	endfunction
	
	task run_phase(uvm_phase phase);
		ahb_apb_wrap_vseq vseq;
		vseq= ahb_apb_wrap_vseq::type_id::create("vseq");
		
		phase.raise_objection(this);
		default_seqr(vseq);
		
		repeat(30000) begin
			
			//Virtual sequence doesn't run on any sequencer
			vseq.start(null);
		end
		phase.drop_objection(this);
	endtask

endclass
*/