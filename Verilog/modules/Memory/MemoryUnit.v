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
    input           nesd,

    //CTCtimers
    output          t1_interrupt,
    output          t2_interrupt,
    output          t3_interrupt,

    //ToneGenerators
    output          tone1_out1, tone1_out2, tone1_out3, tone1_out4,
    output          tone2_out1, tone2_out2, tone2_out3, tone2_out4,

    //UART
    output          uart_out,
    output          uart_rx_interrupt,
    input           uart_in,

    //GPIO
    input [7:0]     GPI,
    output reg [7:0]GPO
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
.reset(reset),
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

//----------------CTC timer 1----------------------
//CTC timer 1 I/O
wire [7:0] t1_controlReg;
wire [31:0] t1_value;

CTCtimer ctcTimer1(
.clk(clk),
.reset(reset),
.timerValue(t1_value),
.controlReg(t1_controlReg),
.interrupt(t1_interrupt)
);

//----------------CTC timer 2----------------------
//CTC timer 2 I/O
wire [7:0] t2_controlReg;
wire [31:0] t2_value;

CTCtimer ctcTimer2(
.clk(clk),
.reset(reset),
.timerValue(t2_value),
.controlReg(t2_controlReg),
.interrupt(t2_interrupt)
);

//----------------CTC timer 3----------------------
//CTC timer 3 I/O
wire [7:0] t3_controlReg;
wire [31:0] t3_value;

CTCtimer ctcTimer3(
.clk(clk),
.reset(reset),
.timerValue(t3_value),
.controlReg(t3_controlReg),
.interrupt(t3_interrupt)
);

//---------------Tone Generator 1-------------------
//CTC timer 3 I/O
wire [31:0] tg1_note;
wire tg1_we;

TonePlayer tonePlayer1(
.clk(clk),
.reset(reset),
.we(tg1_we),
.noteID(tg1_note),
.lineOut1(tone1_out1),
.lineOut2(tone1_out2),
.lineOut3(tone1_out3),
.lineOut4(tone1_out4)
);

//---------------Tone Generator 2-------------------
//Tone Generator 2 I/O
wire [31:0] tg2_note;
wire tg2_we;

TonePlayer tonePlayer2(
.clk(clk),
.reset(reset),
.we(tg2_we),
.noteID(tg2_note),
.lineOut1(tone2_out1),
.lineOut2(tone2_out2),
.lineOut3(tone2_out3),
.lineOut4(tone2_out4)
);

//-------------------UART TX-----------------------
//UART TX I/O
wire r_Tx_DV, w_Tx_Done;
wire [7:0] r_Tx_Byte;

UARTtx uart_tx(
.i_Clock    (clk),
.reset      (reset),
.i_Tx_DV    (r_Tx_DV),
.i_Tx_Byte  (r_Tx_Byte),
.o_Tx_Active(),
.o_Tx_Serial(uart_out),
.o_Tx_Done_l(w_Tx_Done)
);

//-------------------UART RX-----------------------
//UART RX I/O
wire [7:0] w_Rx_Byte;


UARTrx uart_rx(
.i_Clock    (clk),
.reset      (reset),
.i_Rx_Serial(uart_in),
.o_Rx_DV    (uart_rx_interrupt),
.o_Rx_Byte  (w_Rx_Byte)
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

assign t1_value         = (address == 27'hC02626)                           ? data                      : 32'd0;
assign t1_controlReg    = (address == 27'hC02627)                           ? data                      : 8'd0;
assign t2_value         = (address == 27'hC02628)                           ? data                      : 32'd0;
assign t2_controlReg    = (address == 27'hC02629)                           ? data                      : 8'd0;
assign t3_value         = (address == 27'hC0262A)                           ? data                      : 32'd0;
assign t3_controlReg    = (address == 27'hC0262B)                           ? data                      : 8'd0;

assign tg1_note         = (address == 27'hC0262C)                           ? data                      : 32'd0;
assign tg1_we           = (address == 27'hC0262C)                           ? 1'b1                      : 1'b0;
assign tg2_note         = (address == 27'hC0262D)                           ? data                      : 32'd0;
assign tg2_we           = (address == 27'hC0262D)                           ? 1'b1                      : 1'b0;

assign r_Tx_DV          = (address == 27'hC0262E)                           ? 1'b1                      : 1'b0;
assign r_Tx_Byte        = (address == 27'hC0262E)                           ? data                      : 8'd0;

initial
begin
    busy <= 0;
    q <= 32'd0;
    GPO <= 8'd0;
end

always @(negedge clk)
begin
    if (reset)
    begin
        busy <= 0;
        q <= 32'd0;
        GPO <= 8'd0;
    end
    else 
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

        //CTCtimers and NotePlayers
        if (busy && address >= 27'hC02626 && address < 27'hC0262E)
        begin
            busy <= 0;
            q <= 32'd0;
        end

        //UART TX
        if (busy && address == 27'hC0262E)
        begin
            if (w_Tx_Done)
            begin
                busy <= 0;
                q <=32'd0;
            end
        end

        //UART RX
        if (busy && address == 27'hC0262F)
        begin
            busy <= 0;
            q <= w_Rx_Byte;
        end

        //GPIO
        if (busy && address == 27'hC02630)
        begin
            if (we)
            begin
                GPO <= data[15:8];
            end
            busy <= 0;
            q <= {GPO,GPI};
        end

        //Prevent lockups
        if (busy && address >= 27'hC02631)
        begin
            busy <= 0;
            q <= 32'd0;
        end


    end
    
end

endmodule