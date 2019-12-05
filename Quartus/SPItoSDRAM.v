module SPItoSDRAM(
	input clk, reset,

	//CPU side
	input 			start, 
	output 			initDone_l,
	output 			recvDone_l,
	input [23:0] 	address,
	output [31:0] 	q,
	
	//SPI
    output          spi_cs,
    output          spi_clk,
    inout           spi_data, 
    inout           spi_q, 
    inout           spi_wp, 
    inout           spi_hold,
	
    //SDRAM
    output          SDRAM_CSn, 
    output          SDRAM_WEn, 
    output          SDRAM_CASn, 
    output          SDRAM_RASn,
    output          SDRAM_CKE, 
    output [12:0]   SDRAM_A,
    output [1:0]    SDRAM_BA,
    output [1:0]    SDRAM_DQM,
    inout  [15:0]   SDRAM_DQ
);

assign spi_clk = clk;

wire [23:0] sr_addr; 			//address of spi
reg  		sr_start;			//start of spi

wire [31:0] sr_q; 				//q of spi
wire 		sr_initDone; 		//initdone of spi
wire 		sr_recvDone; 		//recvdone of spi

SPIreader sreader (
.clk 		(clk),
.reset 		(reset),
.d 			(spi_data),
.q 			(spi_q),
.wp 		(spi_wp),
.hold 		(spi_hold),
.cs 		(spi_cs),
.address  	(sr_addr),
.instr 		(sr_q),
.start 		(sr_start),
.initDone 	(sr_initDone), 
.recvDone 	(sr_recvDone)
);

//SDRAM controller
wire  		sd_we;
reg 		sd_start;
wire [31:0] sd_d; 
wire [23:0] sd_addr;

wire 		sd_busy;
wire 		sd_q_ready;
wire [31:0] sd_q;

SDRAMcontroller sdramcontroller(
.clk 		(clk),
.reset 		(reset),

.busy 		(sd_busy),       // high if controller is busy
.addr 		(sd_addr),       // addr to read or write
.d 			(sd_d),          // data to write
.we 		(sd_we),         // high if write, low if read
.q 			(sd_q),          // read data output
.q_ready 	(sd_q_ready),    // read data ready
.start 		(sd_start),

// SDRAM
.SDRAM_CKE 	(SDRAM_CKE), 
.SDRAM_CSn 	(SDRAM_CSn),
.SDRAM_WEn 	(SDRAM_WEn), 
.SDRAM_CASn (SDRAM_CASn), 
.SDRAM_RASn (SDRAM_RASn),
.SDRAM_A 	(SDRAM_A),
.SDRAM_BA 	(SDRAM_BA),
.SDRAM_DQM 	(SDRAM_DQM),
.SDRAM_DQ 	(SDRAM_DQ)
);



assign initDone_l = shft_initDone;
assign recvDone_l = shft_recvDone;
assign q = shft_instr;


initial
begin
	sr_start <= 0;
	state <= s_wait;
	sd_start <= 0;

	shft_start <= 0;
	shft_initDone <= 0;
	shft_recvDone <= 0;
	shft_address <= 0;
	shft_instr <= 0;
end

/*
	input start, 
	output wire initDone,
	output wire recvDone,
	input [23:0] address,
	output [31:0] instr,

should be read and sent at negedge of clk
*/
wire initDone, recvDone;
wire [31:0] instr;

reg shft_start;
reg shft_initDone;
reg shft_recvDone;
reg [23:0] shft_address;
reg [31:0] shft_instr;
always @(negedge clk)
begin
	//input
	shft_start <= start;
	shft_address <= address;
	
	//output
	shft_initDone <= initDone;
	shft_recvDone <= recvDone;
	shft_instr <= instr;
end


assign sr_addr = (state == s_copy_read) ? copyCounter :
			0;
assign sd_addr = (state == s_copy_write) ? copyCounter :
				(state == s_read_start || state == s_idle) ? shft_address:
			0;
assign sd_d = (state == s_copy_write || state == s_copy_read) ? sr_q:
			0;

assign sd_we = (state == s_copy_write || state == s_copy_read);

assign recvDone = (state == s_read_done);

assign initDone = (state >= s_idle);

assign instr = sd_q;


reg [5:0] state;
parameter s_wait 		= 0;
parameter s_spi_init 	= 1;
parameter s_sdram_init 	= 2;
parameter s_copy_spi 	= 3;
parameter s_copy_read1 	= 4;
parameter s_copy_read 	= 5;
parameter s_copy_write 	= 6;
parameter s_idle 		= 7;
parameter s_read_start 	= 8;
parameter s_read_done 	= 9;

reg [24:0] copyCounter = 0;
wire [31:0] copyData;

always @(posedge clk) 
begin
	if (reset)
	begin
		sr_start <= 0;
		state <= s_wait;
		sd_start <= 0;
	end
	else 
	begin
		case(state)
			s_wait:
			begin
				if (copyCounter == 7)
				begin
					copyCounter <= 0;
					state <= s_spi_init;
				end
				else 
				begin
					copyCounter <= copyCounter + 1'b1;
				end
			end
			s_spi_init: 
			begin
				if (sr_initDone == 1'b1)
				begin
					state <= s_sdram_init;
				end
			end
			s_sdram_init: 
			begin
				if (sd_busy == 1'b0)
				begin
					state <= s_copy_spi;
				end
			end
			s_copy_spi: 
			begin
				if (copyCounter == 32) //max address + 1 full = 524288
				begin
					state <= s_idle;
				end
				else 
				begin
					state <= s_copy_read1;
					sr_start <= 1;
				end
			end
			s_copy_read1: state <= s_copy_read;
			s_copy_read:
			begin
				sr_start <= 0;
				if (sr_recvDone)
				begin
					sd_start <= 1;
					state <= s_copy_write;
				end
			end
			s_copy_write:
			begin
				sd_start <= 0;
				if (sd_busy == 0)
				begin
					copyCounter <= copyCounter + 1'b1;
					state <= s_copy_spi;
				end
			end
			s_idle:
			begin
				if (shft_start && sd_busy == 0)
				begin
					state <= s_read_start;
					sd_start <= 1;
				end
			end
			s_read_start:
			begin
				sd_start <= 0;
				if (sd_q_ready)
				begin
					state <= s_read_done;
					
				end
			end
			s_read_done:
			begin
				state <= s_idle;
			end

		endcase
	end
end
















endmodule