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
    output [11:0]   vram32_cpu_addr, 
    output          vram32_cpu_we,
    input  [31:0]   vram32_cpu_q,

    //vram8 cpu side
    output [7:0]    vram8_cpu_d,
    output [11:0]   vram8_cpu_addr, 
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
    inout [15:0]    SDRAM_DQ
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


assign initDone         = (sr_initDone && sd_initDone);

assign sd_addr          = (address < 27'h800000)                            ? address                   : 24'd0;
assign sd_d             = (address < 27'h800000)                            ? data                      : 32'd0;
assign sd_we            = (address < 27'h800000)                            ? we                        : 1'd0;
assign sd_start         = (address < 27'h800000)                            ? start                     : 1'd0;

assign sr_addr          = (address >= 27'h800000 && address < 27'hC00000)   ? address - 27'h800000      : 24'd0;
assign sr_start         = (address >= 27'h800000 && address < 27'hC00000)   ? start                     : 1'd0;


assign vram32_cpu_addr  = (address >= 27'hC00000 && address < 27'hC00410)   ? address - 27'hC00000      : 12'd0;
assign vram32_cpu_d     = (address >= 27'hC00000 && address < 27'hC00410)   ? data                      : 32'd0;
assign vram32_cpu_we    = (address >= 27'hC00000 && address < 27'hC00410)   ? we                        : 1'd0;

assign vram8_cpu_addr   = (address >= 27'hC00410 && address < 27'hC01400)   ? address - 27'hC00410      : 12'd0;
assign vram8_cpu_d      = (address >= 27'hC00410 && address < 27'hC01400)   ? data                      : 8'd0;
assign vram8_cpu_we     = (address >= 27'hC00410 && address < 27'hC01400)   ? we                        : 1'd0;

assign rom_addr         = (address >= 27'hC01400 && address < 27'hC01600)   ? address - 27'hC01400      : 9'd0;

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
    if (busy && address >= 27'hC00000 && address < 27'hC00410)
    begin
        busy <= 0;
        q <= vram32_cpu_q;
    end

    //VRAM8
    if (busy && address >= 27'hC00410 && address < 27'hC01400)
    begin
        busy <= 0;
        q <= {24'd0, vram8_cpu_q};
    end

    //ROM
    if (busy && address >= 27'hC01400 && address < 27'hC01600)
    begin
        busy <= 0;
        q <= {rom_q};
    end
end

endmodule