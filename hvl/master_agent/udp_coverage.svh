class udp_coverage; 

virtual udp_tx_if tx_vif; 

/////////////////////// Input Coverage /////////////////////

covergroup UDP_coverage_ip; 

tx_start : coverpoint tx_vif.udp_tx_start {
			bins min = {0};
			bins max = {1};
			}

tx_data_length : coverpoint tx_vif.udp_txi.hdr.data_length {
		bins min = {'0};
		bins max = {'d1472};
		bins others = {[16'd1:16'd1499]};
		illegal_bins illegal = {[16'd1501 : '1]};
		} 	
					
port_of_src : coverpoint tx_vif.udp_txi.hdr.src_port {
		bins range[5] = {[16'h0001 : 16'h1000]}; 
		bins others[3] = {[16'h1001 : 16'h8000]};
		illegal_bins ia[2] = {[16'h8001:16'hFFFF]};  
		}
			
port_of_dst : coverpoint tx_vif.udp_txi.hdr.dst_port {
		bins range[5] = {[16'h0001 : 16'h1000]};
		bins others[3] = {[16'h1001 : 16'h8000]};
		illegal_bins ib[2] = {[16'h8001:16'hFFFF]}; 
		}

addr_of_ipdst : coverpoint tx_vif.udp_txi.hdr.dst_ip_addr {
		bins min = { '0 }; 
		bins max = { '1 }; 
		bins others = {[32'h1:32'hFFFF_FFFE]}; 
		}
		
tx_data : coverpoint tx_vif.udp_txi.data.data_out {
		bins min = {'0};
		bins max = {'1};
		bins others = {['d1:('1 - 1'd1)]}; }

tx_data_valid: coverpoint tx_vif.udp_txi.data.data_out_valid {
		bins min = {'0};
		bins max = {'1}; }

tx_data_last: coverpoint tx_vif.udp_txi.data.data_out_last {
		bins min = {'0};
		bins max = {'1}; }


cross_scr_dst : cross port_of_src, port_of_dst;
endgroup 

///////////////// Output coverage ////////////////////

covergroup UDP_coverage_op; 
rx_start : coverpoint tx_vif.udp_rx_start {
			bins min = {0};
			bins max = {1};
			}

rx_data_length : coverpoint tx_vif.udp_rxi.hdr.data_length {
		bins min = {'0};
		bins max = {'d1472};
		bins others = {[16'd1:16'd1499]};
		illegal_bins illegal = {[16'd1501 : '1]};
		}

port_of_src : coverpoint tx_vif.udp_rxi.hdr.src_port {
		bins range[5] = {[16'h0001 : 16'h1000]}; 
		bins others[3] = {[16'h1001 : 16'h8000]};
		illegal_bins ia[2] = {[16'h8001:16'hFFFF]};  
		}
			
port_of_dst : coverpoint tx_vif.udp_rxi.hdr.dst_port {
		bins range[5] = {[16'h0001 : 16'h1000]};
		bins others[3] = {[16'h1001 : 16'h8000]};
		illegal_bins ib[2] = {[16'h8001:16'hFFFF]}; 
		}
src_ip_addr : coverpoint tx_vif.udp_rxi.hdr.src_ip_addr {
		bins min = { '0 }; 
		bins max = { '1 }; 
		bins others = {[32'h1:32'hFFFF_FFFE]};
}

rx_data : coverpoint tx_vif.udp_rxi.data.data_in {
		bins min = {'0};
		bins max = {'1};
		bins others = {['d1:('1 - 1'd1)]}; }

rx_data_valid: coverpoint tx_vif.udp_rxi.data.data_in_valid {
		bins min = {'0};
		bins max = {'1}; }

rx_data_last: coverpoint tx_vif.udp_rxi.data.data_in_last {
		bins min = {'0};
		bins max = {'1}; }


cross_scr_dst : cross port_of_src, port_of_dst;

endgroup 

//////////////////// Constructor ///////////////////

function new (virtual udp_tx_if b); 
			 UDP_coverage_ip = new(); 
			 UDP_coverage_op = new();
			 tx_vif = b; 
endfunction : new

///////////////////// Sampling  block //////////////////

task execute(); 
	forever fork : sampling_block
		@(posedge tx_vif.clk); 
		UDP_coverage_ip.sample();
		UDP_coverage_op.sample();
	join: sampling_block
endtask : execute

endclass : udp_coverage 
