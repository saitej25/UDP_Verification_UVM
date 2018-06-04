package global_typs_pkg;

// --------------
// -- AXI --
// --------------
	typedef struct {
		bit           data_out_valid;
		bit           data_out_last ;
		byte unsigned data_out      ;
	} axi_out_type;

	typedef struct{
		byte unsigned data_in      ;
		bit           data_in_valid;
		bit           data_in_last ;
	}axi_in_type;


// --------------
// -- UDP --
// --------------

//---------------------UDP TX-------------------//
	localparam UDPTX_RESULT_NONE    = 0;
	localparam UDPTX_RESULT_SENDING = 1;
	localparam UDPTX_RESULT_ERR     = 2;
	localparam UDPTX_RESULT_SENT    = 3;

	typedef struct {
		rand int      unsigned dst_ip_addr;
		rand shortint unsigned dst_port   ;
		rand shortint unsigned src_port   ;
		rand shortint unsigned data_length;
		rand shortint unsigned checksum   ;
	} udp_tx_header_type;

	typedef struct {
		udp_tx_header_type hdr ;
		axi_out_type       data;
	} udp_tx_type;

//---------------------UDP RX-------------------//

	typedef struct {
		bit               is_valid   ;
		int      unsigned src_ip_addr;
		shortint unsigned src_port   ;
		shortint unsigned dst_port   ;
		shortint unsigned data_length;
	}udp_rx_header_type;

	typedef struct{
		udp_rx_header_type hdr ;
		axi_in_type        data;
	}udp_rx_type;

	typedef struct {
		int      unsigned ip_addr ;
		shortint unsigned port_num;
	} udp_addr_type;


// --------------
// -- IPv4 --
// --------------
//---------------------IP TX-------------------//
	localparam IP_BC_ADDR  = 'hffffffff    ;
	localparam MAC_BC_ADDR = 'hffffffffffff;

	localparam IPTX_RESULT_NONE    = 0;
	localparam IPTX_RESULT_SENDING = 1;
	localparam IPTX_RESULT_ERR     = 2;
	localparam IPTX_RESULT_SENT    = 3;

	typedef struct{
		byte     unsigned protocol   ;
		shortint unsigned data_length;
		int      unsigned dst_ip_addr;
	}ipv4_tx_header_type;

	typedef struct{
		ipv4_tx_header_type hdr ;
		axi_out_type        data;
	} ipv4_tx_type;

//---------------------IP RX-------------------//
	localparam RX_EC_NONE    = 0;
	localparam RX_EC_ET_ETH  = 1;
	localparam RX_EC_ET_IP   = 2;
	localparam RX_EC_ET_USER = 3;

	typedef struct{
		bit                     is_valid        ;
		byte     unsigned       protocol        ;
		shortint unsigned       data_length     ;
		int      unsigned       src_ip_addr     ;
		byte     unsigned       num_frame_errors;
		bit               [3:0] last_error_code ;
		bit                     is_broadcast    ;
	}ipv4_rx_header_type;

	typedef struct{
		ipv4_rx_header_type hdr ;
		axi_in_type         data;
	}ipv4_rx_type;

	typedef enum logic [3:0] {ZEROS,ONES,ZEROS_ONES,LONG_ZERO_ONES,RAMP,TRIANGLE,PRBS} patterns;

endpackage : global_typs_pkg