/*
* Top level design of the FPGC4
*/
module FPGC4(
    input           clock, //50MHz
    input           nreset,

    //VGA video
    output          vga_clk,
    output          vga_hs,
    output          vga_vs,
    output [2:0]    vga_r,
    output [2:0]    vga_g,
    output [1:0]    vga_b,
	 
	 //RGBs video
	 output          crt_sync,
	 output          crt_clk,
    output [2:0]    crt_r,
    output [2:0]    crt_g,
    output [1:0]    crt_b,

    //SDRAM
    output          SDRAM_CLK,
    output          SDRAM_CSn, 
    output          SDRAM_WEn, 
    output          SDRAM_CASn, 
    output          SDRAM_RASn,
    output          SDRAM_CKE, 
    output [12:0]   SDRAM_A,
    output [1:0]    SDRAM_BA,
    output [1:0]    SDRAM_DQM,
    inout  [15:0]   SDRAM_DQ,

    //SPI flash
    output          spi_cs,
    output          spi_clk,
    inout           spi_data, 
    inout           spi_q, 
    inout           spi_wp, 
    inout           spi_hold,

    //Interrupts
    input           nint1,
    input           nint2,
    input           nint3,
    input           nint4,

    //PS/2
    input           ps2d, ps2c,
    //(S)NESpad
    output          nesc, nesl,
    input           nesd,
	 
	 //Led for debugging
    output led,

	 //Tone generator PWM output
    output          tone1_out1, tone1_out2, tone1_out3, tone1_out4,
    output          tone2_out1, tone2_out2, tone2_out3, tone2_out4,
	 
	 //UART
	 output          uart_out,
	 input 			  uart_in,
	 input           uart_dtr,
	 
	 //GPIO
	 input [7:0]     GPI,
    output [7:0]    GPO,
	 
    //SPI
    output          s_clk,
    input           s_miso,
	 input           s_nint,
    output          s_mosi,
	 output 			  s_cs, 		//actually just a copy of GPO[0]
	 output          s_rst
);

wire frameDrawn;    //high when frame just rendered
                    //needs to be stabilized
					  
assign led = uart_dtr;

wire clk;

assign vga_clk = 1'b0;
assign vga_hs = 1'b0;
assign vga_vs = 1'b0;
assign vga_r = 3'd0;
assign vga_g = 3'd0;
assign vga_b = 2'd0;

//PLL for VGA @9MHz and clk @25MHz
pll pll (
.inclk0(clock),
.c0(crt_clk),
.c1(clk)
);


//--------------------Reset-----------------------
//Reset stabilizer I/O
wire nreset_stable, reset, dtr_stable;

Stabilizer resStabilizer (
.clk(clk),
.reset(1'b0), //Since we stabilize a reset signal, we do NOT want to use it here
.unstable(nreset),
.stable(nreset_stable)
);

Stabilizer dtrStabilizer (
.clk(clk),
.reset(1'b0), //Since we stabilize a reset signal, we do NOT want to use it here
.unstable(uart_dtr),
.stable(dtr_stable)
);

wire dtrRst;

DtrReset dtrReset (
.clk(clk),
.dtr(uart_dtr),
.dtrRst(dtrRst)
);

assign reset = (~nreset_stable) || dtrRst;

assign s_cs = GPO[0];
assign s_rst = reset;

//--------------------Clocks----------------------
assign SDRAM_CLK = clk;

//---------------------------VRAM32---------------------------------
//VRAM32 I/O
wire        vram32_gpu_clk;
wire [13:0] vram32_gpu_addr;
wire [31:0] vram32_gpu_d;
wire        vram32_gpu_we;
wire [31:0] vram32_gpu_q;

wire        vram32_cpu_clk;
wire [13:0] vram32_cpu_addr;
wire [31:0] vram32_cpu_d;
wire        vram32_cpu_we; 
wire [31:0] vram32_cpu_q;

//because FSX will not write to VRAM
assign vram32_gpu_we    = 1'b0;
assign vram32_gpu_d     = 32'd0;

VRAM #(
.WIDTH(32), 
.WORDS(1056), 
.LIST("/home/bart/Documents/FPGA/FPGC4/Verilog/memory/vram32.list")
)   vram32(
//CPU port
.cpu_clk    (clk),
.cpu_d      (vram32_cpu_d),
.cpu_addr   (vram32_cpu_addr),
.cpu_we     (vram32_cpu_we),
.cpu_q      (vram32_cpu_q),

//GPU port
.gpu_clk    (crt_clk),
.gpu_d      (vram32_gpu_d),
.gpu_addr   (vram32_gpu_addr),
.gpu_we     (vram32_gpu_we),
.gpu_q      (vram32_gpu_q)
);


//---------------------------VRAM322--------------------------------
//VRAM322 I/O
wire        vram322_gpu_clk;
wire [13:0] vram322_gpu_addr;
wire [31:0] vram322_gpu_d;
wire        vram322_gpu_we;
wire [31:0] vram322_gpu_q;

//because FSX will not write to VRAM
assign vram322_gpu_we    = 1'b0;
assign vram322_gpu_d     = 32'd0;

VRAM #(
.WIDTH(32), 
.WORDS(1056), 
.LIST("/home/bart/Documents/FPGA/FPGC4/Verilog/memory/vram32.list")
)   vram322(
//CPU port
.cpu_clk    (clk),
.cpu_d      (vram32_cpu_d),
.cpu_addr   (vram32_cpu_addr),
.cpu_we     (vram32_cpu_we),
.cpu_q      (),

//GPU port
.gpu_clk    (crt_clk),
.gpu_d      (vram322_gpu_d),
.gpu_addr   (vram322_gpu_addr),
.gpu_we     (vram322_gpu_we),
.gpu_q      (vram322_gpu_q)
);


//--------------------------VRAM8--------------------------------
//VRAM8 I/O
wire        vram8_gpu_clk;
wire [13:0] vram8_gpu_addr;
wire [7:0]  vram8_gpu_d;
wire        vram8_gpu_we;
wire [7:0]  vram8_gpu_q;

wire        vram8_cpu_clk;
wire [13:0] vram8_cpu_addr;
wire [7:0]  vram8_cpu_d;
wire        vram8_cpu_we;
wire [7:0]  vram8_cpu_q;

//because FSX will not write to VRAM
assign vram8_gpu_we     = 1'b0;
assign vram8_gpu_d      = 8'd0;

VRAM #(
.WIDTH(8), 
.WORDS(8194), 
.LIST("/home/bart/Documents/FPGA/FPGC4/Verilog/memory/vram8.list")
)   vram8(
//CPU port
.cpu_clk    (clk),
.cpu_d      (vram8_cpu_d),
.cpu_addr   (vram8_cpu_addr),
.cpu_we     (vram8_cpu_we),
.cpu_q      (vram8_cpu_q),

//GPU port
.gpu_clk    (crt_clk),
.gpu_d      (vram8_gpu_d),
.gpu_addr   (vram8_gpu_addr),
.gpu_we     (vram8_gpu_we),
.gpu_q      (vram8_gpu_q)
);


//--------------------------VRAMSPR--------------------------------
//VRAMSPR I/O
wire        vramSPR_gpu_clk;
wire [13:0] vramSPR_gpu_addr;
wire [8:0]  vramSPR_gpu_d;
wire        vramSPR_gpu_we;
wire [8:0]  vramSPR_gpu_q;

wire        vramSPR_cpu_clk;
wire [13:0] vramSPR_cpu_addr;
wire [8:0]  vramSPR_cpu_d;
wire        vramSPR_cpu_we;
wire [8:0]  vramSPR_cpu_q;

//because FSX will not write to VRAM
assign vramSPR_gpu_we     = 1'b0;
assign vramSPR_gpu_d      = 9'd0;

VRAM #(
.WIDTH(9), 
.WORDS(256), 
.LIST("/home/bart/Documents/FPGA/FPGC4/Verilog/memory/vramSPR.list")
)   vramSPR(
//CPU port
.cpu_clk    (clk),
.cpu_d      (vramSPR_cpu_d),
.cpu_addr   (vramSPR_cpu_addr),
.cpu_we     (vramSPR_cpu_we),
.cpu_q      (vramSPR_cpu_q),

//GPU port
.gpu_clk    (crt_clk),
.gpu_d      (vramSPR_gpu_d),
.gpu_addr   (vramSPR_gpu_addr),
.gpu_we     (vramSPR_gpu_we),
.gpu_q      (vramSPR_gpu_q)
);


//-----------------------FSX-------------------------
//FSX I/O

FSX fsx(
//VGA
/*
.vga_clk        (vga_clk),
.vga_r          (vga_r),
.vga_g          (vga_g),
.vga_b          (vga_b),
.vga_hs         (vga_hs),
.vga_vs         (vga_vs),
.vga_blk        (vga_blk),
*/

.vga_clk(crt_clk),
.crt_sync(crt_sync),
.crt_r(crt_r),
.crt_g(crt_g),
.crt_b(crt_b),

//VRAM32
.vram32_addr    (vram32_gpu_addr),
.vram32_q       (vram32_gpu_q),

//VRAM32
.vram322_addr   (vram322_gpu_addr),
.vram322_q      (vram322_gpu_q),

//VRAM8
.vram8_addr     (vram8_gpu_addr),
.vram8_q        (vram8_gpu_q),

//VRAMSPR
.vramSPR_addr   (vramSPR_gpu_addr),
.vramSPR_q      (vramSPR_gpu_q),

//Interrupt signal
.frameDrawn     (frameDrawn)
);

//-------------------ROM-------------------------
//ROM I/O
wire [8:0] rom_addr;
wire [31:0] rom_q;

ROM rom(
.clk            (clk),
.reset          (reset),
.address        (rom_addr),
.q              (rom_q)
);

//----------------Memory Unit--------------------
//Memory Unit I/O
wire [26:0] address;
wire [31:0] data;
wire        we;
wire        start;
wire        initDone;
wire        busy;
wire [31:0] q;
wire        t1_interrupt;
wire        t2_interrupt;
wire        t3_interrupt;
wire 			uart_rx_interrupt;
wire        scan_code_ready;

MemoryUnit mu(
//clocks
.clk            (clk),
.reset          (reset),

//I/O
.address        (address),
.data           (data),
.we             (we),
.start          (start),
.initDone       (initDone),       //High when initialization is done
.busy           (busy),
.q              (q),

//vram32 cpu side
.vram32_cpu_d   (vram32_cpu_d),        
.vram32_cpu_addr(vram32_cpu_addr), 
.vram32_cpu_we  (vram32_cpu_we),
.vram32_cpu_q   (vram32_cpu_q),

//vram8 cpu side
.vram8_cpu_d    (vram8_cpu_d),
.vram8_cpu_addr (vram8_cpu_addr), 
.vram8_cpu_we   (vram8_cpu_we),
.vram8_cpu_q    (vram8_cpu_q),

//vramSPR cpu side
.vramSPR_cpu_d    (vramSPR_cpu_d),
.vramSPR_cpu_addr (vramSPR_cpu_addr), 
.vramSPR_cpu_we   (vramSPR_cpu_we),
.vramSPR_cpu_q    (vramSPR_cpu_q),

//ROM
.rom_addr       (rom_addr),
.rom_q          (rom_q),

//SPI
.spi_data       (spi_data), 
.spi_q          (spi_q), 
.spi_wp         (spi_wp), 
.spi_hold       (spi_hold),
.spi_cs         (spi_cs), 
.spi_clk        (spi_clk),

//SDRAM
.SDRAM_CSn      (SDRAM_CSn), 
.SDRAM_WEn      (SDRAM_WEn), 
.SDRAM_CASn     (SDRAM_CASn),
.SDRAM_CKE      (SDRAM_CKE), 
.SDRAM_RASn     (SDRAM_RASn),
.SDRAM_A        (SDRAM_A),
.SDRAM_BA       (SDRAM_BA),
.SDRAM_DQM      (SDRAM_DQM),
.SDRAM_DQ       (SDRAM_DQ),

//PS/2
.ps2d(ps2d), 
.ps2c(ps2c),
.scan_code_ready(scan_code_ready),

//(S)NESpad
.nesc(nesc), 
.nesl(nesl),
.nesd(nesd),

.t1_interrupt(t1_interrupt),
.t2_interrupt(t2_interrupt),
.t3_interrupt(t3_interrupt),

.tone1_out1(tone1_out1),
.tone1_out2(tone1_out2),
.tone1_out3(tone1_out3),
.tone1_out4(tone1_out4),
.tone2_out1(tone2_out1),
.tone2_out2(tone2_out2),
.tone2_out3(tone2_out3),
.tone2_out4(tone2_out4),

.uart_out(uart_out),
.uart_in(uart_in),
.uart_rx_interrupt(uart_rx_interrupt),

.GPI(GPI),
.GPO(GPO),

.s_clk(s_clk),
.s_mosi(s_mosi),
.s_miso(s_miso)
);


//---------------CPU----------------
//CPU I/O

CPU cpu(
.clk            (clk),
.reset          (reset),
.int1           (t1_interrupt),             //timer1
.int2           (t2_interrupt),             //timer2
.int3           (uart_rx_interrupt),        //UART rx
.int4           (frameDrawn),               //Frame Drawn
.ext_int1       (t3_interrupt),             //timer3
.ext_int2       (scan_code_ready),          //PS/2 scancode ready
.ext_int3       (1'b0),
.ext_int4       (1'b0),
.address        (address),
.data           (data),
.we             (we),
.q              (q),
.start          (start),
.busy           (busy)
);

endmodule