import global_typs_pkg::*;

	interface udp_tx_if (input logic clk); 

	bit reset;
	//UDP Layer TX signals
	logic             udp_tx_start         ;
	udp_tx_type       udp_txi              ;
	logic       [1:0] udp_tx_result        ;
	logic             udp_tx_data_out_ready;
	//UDP Layer RX
	logic             udp_rx_start         ;
	udp_rx_type       udp_rxi              ;
	logic       [1:0] udp_rx_result        ;
	logic             udp_rx_data_out_ready;
	//IP layer TX signals
	logic              ip_tx_start         ;
	ipv4_tx_type       ip_tx               ;
	logic        [1:0] ip_tx_result        ;
	logic              ip_tx_data_out_ready;


	task reset_sys ();
		reset = 1;
		#100; reset = 0;
	endtask

	task send_hdr(input udp_tx_header_type hdr);
		wait(1);
		//$display("yes6");
		udp_tx_start = 1;
		udp_txi.hdr = hdr;
		@(posedge clk);
		udp_tx_start = 0;
		repeat(9) @(posedge clk);
	endtask : send_hdr

	task send_data(input byte unsigned data ,input bit last);
		@(posedge clk);
		udp_txi.data.data_out = data;
		//$display("data_out",udp_txi.data.data_out);
		udp_txi.data.data_out_valid = 1;
		udp_txi.data.data_out_last = last;

		if(last==1'b1)
			begin
				@(posedge clk);
				clear_valid();
				udp_txi.data.data_out_last=1'b0;
			end
	endtask : send_data

	task clear_valid();
		udp_txi.data.data_out_valid = 0;
	endtask : clear_valid

	task read_hdr(output udp_rx_header_type hdr);
		wait(udp_rx_start);
		hdr = udp_rxi.hdr;
	endtask : read_hdr

	 task read_rx_data(output byte unsigned data_read);
		wait(udp_rxi.data.data_in_valid); begin
		@(negedge clk);
		if(udp_rxi.data.data_in_valid)
		data_read=udp_rxi.data.data_in;
		end
		endtask

	task read_tx_data(output byte unsigned data_read);
		wait(udp_txi.data.data_out_valid) begin
		 @(negedge clk);
		if(udp_txi.data.data_out_valid)
		data_read=udp_txi.data.data_out; end
	endtask : read_tx_data
		
	endinterface