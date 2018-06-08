class udp_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(udp_scoreboard)
  uvm_analysis_imp #(udp_transaction, udp_scoreboard) item_collected_export;

  // new - constructor
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_collected_export = new("item_collected_export", this);
  endfunction: build_phase

  // write
  virtual function void write(udp_transaction txn);

    if (txn.udp_rxi.hdr.src_ip_addr==txn.tx_hdr.dst_ip_addr &&
      txn.udp_rxi.hdr.src_port==txn.tx_hdr.src_port &&
      txn.udp_rxi.hdr.dst_port==txn.tx_hdr.dst_port)
    $display("SCB PASS: Matched");
    else
      $display("SCB FAIL: Didnt match");
  endfunction : write

endclass : udp_scoreboard