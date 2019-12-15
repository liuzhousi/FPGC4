/*
* Memory Unit
*/
module MemoryUnit(
    //clocks
    input clk, reset,

    //I/O
    input  [26:0]   address,
    input  [31:0]   data,
    input           we,
    input           start,          //Start should be high until busy = low
    output          initDone,       //High when initialization is done
    output reg      busy,
    output reg [31:0]  q,


    //vram32 cpu side
    output [31:0]   vram32_cpu_d,
    output [13:0]   vram32_cpu_addr, 
    output          vram32_cpu_we,
    input  [31:0]   vram32_cpu_q,

    //vram8 cpu side
    output [7:0]    vram8_cpu_d,
    output [13:0]   vram8_cpu_addr, 
    output          vram8_cpu_we,
    input  [7:0]    vram8_cpu_q,

    //ROM
    output [8:0]    rom_addr,
    input  [31:0]   rom_q,

    //SPI
    inout           spi_data, spi_q, spi_wp, spi_hold,
    output          spi_cs, 
    output          spi_clk,

    //SDRAM
    output          SDRAM_CSn, SDRAM_WEn, SDRAM_CASn,
    output          SDRAM_CKE, SDRAM_RASn,
    output [12:0]   SDRAM_A,
    output [1:0]    SDRAM_BA,
    output [1:0]    SDRAM_DQM,
    inout [15:0]    SDRAM_DQ,

    //PS/2
    input           ps2d, ps2c,
    
    //(S)NESpad
    output          nesc, nesl,
    input           nesd
);  

    //SDRAMcontroller, SPIreader, vram, and I/O should work on negedge clock

    assign spi_clk = clk;

    wire [23:0] sr_addr;            //address of spi
    wire        sr_start;           //start of spi

    wire [31:0] sr_q;               //q of spi
    wire        sr_initDone;        //initdone of spi
    wire        sr_recvDone;        //recvdone of spi TODO might change this to busy

    SPIreader sreader (
    .clk        (spi_clk),
    .reset      (reset),
    .d          (spi_data),
    .q          (spi_q),
    .wp         (spi_wp),
    .hold       (spi_hold),
    .cs         (spi_cs),
    .address    (sr_addr),
    .instr      (sr_q),
    .start      (sr_start),
    .initDone   (sr_initDone), 
    .recvDone   (sr_recvDone)
    );


    //----SDRAM----
    wire        sd_we;
    wire        sd_start;
    wire [31:0] sd_d; 
    wire [23:0] sd_addr;

    wire        sd_busy;
    wire        sd_initDone;
    wire        sd_q_ready;
    wire [31:0] sd_q;

    SDRAMcontroller sdramcontroller(
    .clk        (clk),
    .reset      (reset),

    .busy       (sd_busy),       // high if controller is busy
    .addr       (sd_addr),       // addr to read or write
    .d          (sd_d),          // data to write
    .we         (sd_we),         // high if write, low if read
    .q          (sd_q),          // read data output
    .q_ready_delay(sd_q_ready),    // read data ready
    .start      (sd_start),
    .initDone   (sd_initDone),

    // SDRAM
    .SDRAM_CKE  (SDRAM_CKE), 
    .SDRAM_CSn  (SDRAM_CSn),
    .SDRAM_WEn  (SDRAM_WEn), 
    .SDRAM_CASn (SDRAM_CASn), 
    .SDRAM_RASn (SDRAM_RASn),
    .SDRAM_A    (SDRAM_A),
    .SDRAM_BA   (SDRAM_BA),
    .SDRAM_DQM  (SDRAM_DQM),
    .SDRAM_DQ   (SDRAM_DQ)
    );

//-----------------NES Controller-------------------
//Controller I/O
wire [15:0] nesState;

NESpadReader npr (
.clk(clk),
.nesc(nesc),
.nesl(nesl),
.nesd(nesd),
.nesState(nesState)
);


//-----------------PS/2 Keyboard-------------------
//PS/2 Keyboard I/O
wire [7:0] scanCode;
wire scan_code_ready;
wire [78:0] buttonState;

Keyboard keyboard(
.clk(clk),
.reset(reset),
.scan_code_ready(scan_code_ready),
.ps2c(ps2c),                    //PS/2 clock
.ps2d(ps2d),                    //PS/2 data
.scanCode(scanCode),
.buttonState(buttonState)   //pressed state of all buttons (79 buttons)
);


assign initDone         = (sr_initDone && sd_initDone);

assign sd_addr          = (address < 27'h800000)                            ? address                   : 24'd0;
assign sd_d             = (address < 27'h800000)                            ? data                      : 32'd0;
assign sd_we            = (address < 27'h800000)                            ? we                        : 1'd0;
assign sd_start         = (address < 27'h800000)                            ? start                     : 1'd0;

assign sr_addr          = (address >= 27'h800000 && address < 27'hC00000)   ? address - 27'h800000      : 24'd0;
assign sr_start         = (address >= 27'h800000 && address < 27'hC00000)   ? start                     : 1'd0;


assign vram32_cpu_addr  = (address >= 27'hC00000 && address < 27'hC00420)   ? address - 27'hC00000      : 14'd0;
assign vram32_cpu_d     = (address >= 27'hC00000 && address < 27'hC00420)   ? data                      : 32'd0;
assign vram32_cpu_we    = (address >= 27'hC00000 && address < 27'hC00420)   ? we                        : 1'd0;

assign vram8_cpu_addr   = (address >= 27'hC00420 && address < 27'hC02422)   ? address - 27'hC00420      : 14'd0;
assign vram8_cpu_d      = (address >= 27'hC00420 && address < 27'hC02422)   ? data                      : 8'd0;
assign vram8_cpu_we     = (address >= 27'hC00420 && address < 27'hC02422)   ? we                        : 1'd0;

assign rom_addr         = (address >= 27'hC02422 && address < 27'hC02622)   ? address - 27'hC02422      : 9'd0;

initial
begin
    busy <= 0;
    q <= 32'd0;
end

always @(negedge clk)
begin
    if (start)
        busy <= 1;
        
    //SDRAM
    if (busy && sr_recvDone)
    begin
        busy <= 0;
        q <= sr_q;
    end

    //SPI FLASH
    if (busy && sd_q_ready)
    begin
        busy <= 0;
        q <= sd_q;
    end

    //VRAM32
    if (busy && address >= 27'hC00000 && address < 27'hC00420)
    begin
        busy <= 0;
        q <= vram32_cpu_q;
    end

    //VRAM8
    if (busy && address >= 27'hC00420 && address < 27'hC02422)
    begin
        busy <= 0;
        q <= {24'd0, vram8_cpu_q};
    end

    //ROM
    if (busy && address >= 27'hC02422 && address < 27'hC02622)
    begin
        busy <= 0;
        q <= rom_q;
    end

    //NESPAD
    if (busy && address == 27'hC02622)
    begin
        busy <= 0;
        q <= {16'd0, nesState};
    end

    //Keyboard1
    if (busy && address == 27'hC02623)
    begin
        busy <= 0;
        q <= buttonState[31:16];
    end

    //Keyboard2
    if (busy && address == 27'hC02624)
    begin
        busy <= 0;
        q <= buttonState[63:32];
    end

    //Keyboard3
    if (busy && address == 27'hC02625)
    begin
        busy <= 0;
        q <= buttonState[78:64];
    end
end

endmodule