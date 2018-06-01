class udp_config extends uvm_object;
	`uvm_object_utils(udp_config)
	
	virtual udp_if udp_vif;
	//virtual apb_if apb_vif;
	
	function new(string name= "udp_config");
		super.new(name);
	endfunction
	
endclass