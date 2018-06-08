//`ifndef udp_uvm_include_pkg
//`define udp_uvm_include_pkg

package udp_uvm_include_pkg;
	import uvm_pkg::*;
	`include "uvm_macros.svh"
	
	`include "udp_config.svh"
	`include "../master_agent/udp_transaction.svh"
	`include "../master_agent/udp_coverage.svh"
	`include "../master_agent/udp_sequences.svh"
	`include "../master_agent/udp_sequencer.svh"
	`include "../master_agent/udp_driver.svh"
	`include "../master_agent/udp_monitor.svh"
	`include "../master_agent/udp_agent.svh"
	`include "../master_agent/udp_scoreboard.svh"
	`include "../master_agent/udp_env.svh"
	`include "udp_tests.svh"
endpackage

//import udp_uvm_include_pkg::*;

//`endif