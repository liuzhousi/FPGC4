/*
* Top level design of the FPGC4
*/
module FPGC4(
    input           clock, //50MHz
    input           nreset,

    //VGA for GM7123 module
    output          vga_clk,
    output          vga_hs,
    output          vga_vs,
    output [2:0]    vga_r,
    output [2:0]    vga_g,
    output [1:0]    vga_b,
    output          vga_blk,

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

    //SPI
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
	 
    output led

);

wire frameDrawn;    //high when frame just rendered
                    //needs to be stabilized

assign led = 1'b1;

wire int1;
wire int2;
wire int3;
wire int4;

assign int1 = ~nint1;
assign int2 = 1'b0;//~nint2;
assign int3 = 1'b0;//~nint3;
assign int4 = frameDrawn;

wire clk;

//PLL for VGA @9MHz and clk @25MHz
pll pll (
.inclk0(clock),
.c0(vga_clk),
.c1(clk)
);


//----------------Reset Stabilizer-------------------
//Reset stabilizer I/O
wire nreset_stable, reset;

assign reset = ~nreset_stable;

Stabilizer resStabilizer (
.clk(clk),
.reset(1'b0), //Since we stabilize the reset signal, we do NOT want to use it here
.unstable(nreset),
.stable(nreset_stable)
);


//--------------------Clocks----------------------
assign SDRAM_CLK = clk;
wire gpu_clk, gpu_clk2;

//---------------------------VRAM32---------------------------------
//VRAM32 I/O
wire        vram32_gpu_clk;
wire [11:0] vram32_gpu_addr;
wire [31:0] vram32_gpu_d;
wire        vram32_gpu_we;
wire [31:0] vram32_gpu_q;

wire        vram32_cpu_clk;
wire [11:0] vram32_cpu_addr;
wire [31:0] vram32_cpu_d;
wire        vram32_cpu_we; 
wire [31:0] vram32_cpu_q;

//because FSX will not write to VRAM
assign vram32_gpu_we    = 1'b0;
assign vram32_gpu_d     = 32'd0;

VRAM #(
.WIDTH(32), 
.WORDS(1040), 
.LIST("/home/bart/Documents/FPGA/FPGC4/Verilog/memory/vram32.list")
)   vram32(
//CPU port
.cpu_clk    (clk),
.cpu_d      (vram32_cpu_d),
.cpu_addr   (vram32_cpu_addr),
.cpu_we     (vram32_cpu_we),
.cpu_q      (vram32_cpu_q),

//GPU port
.gpu_clk    (gpu_clk),
.gpu_d      (vram32_gpu_d),
.gpu_addr   (vram32_gpu_addr),
.gpu_we     (vram32_gpu_we),
.gpu_q      (vram32_gpu_q)
);


//--------------------------VRAM8--------------------------------
//VRAM8 I/O
wire        vram8_gpu_clk;
wire [11:0] vram8_gpu_addr;
wire [7:0]  vram8_gpu_d;
wire        vram8_gpu_we;
wire [7:0]  vram8_gpu_q;

wire        vram8_cpu_clk;
wire [11:0] vram8_cpu_addr;
wire [7:0]  vram8_cpu_d;
wire        vram8_cpu_we;
wire [7:0]  vram8_cpu_q;

//because FSX will not write to VRAM
assign vram8_gpu_we     = 1'b0;
assign vram8_gpu_d      = 8'd0;

VRAM #(
.WIDTH(8), 
.WORDS(4080), 
.LIST("/home/bart/Documents/FPGA/FPGC4/Verilog/memory/vram8.list")
)   vram8(
//CPU port
.cpu_clk    (clk),
.cpu_d      (vram8_cpu_d),
.cpu_addr   (vram8_cpu_addr),
.cpu_we     (vram8_cpu_we),
.cpu_q      (vram8_cpu_q),

//GPU port
.gpu_clk    (gpu_clk2),
.gpu_d      (vram8_gpu_d),
.gpu_addr   (vram8_gpu_addr),
.gpu_we     (vram8_gpu_we),
.gpu_q      (vram8_gpu_q)
);


//-----------------------FSX-------------------------
//FSX I/O

FSX fsx(
//VGA
.vga_clk        (vga_clk),
.vga_r          (vga_r),
.vga_g          (vga_g),
.vga_b          (vga_b),
.vga_hs         (vga_hs),
.vga_vs         (vga_vs),
.vga_blk        (vga_blk),

//VRAM32
.gpu_clk        (gpu_clk),
.vram32_addr    (vram32_gpu_addr),
.vram32_q       (vram32_gpu_q),

//VRAM8
.gpu_clk2       (gpu_clk2),
.vram8_addr     (vram8_gpu_addr),
.vram8_q        (vram8_gpu_q),

//Interrupt signal
.frameDrawn     (frameDrawn)
);


//-------------------ROM-------------------------
//ROM I/O
wire [8:0] rom_addr;
wire [31:0] rom_q;

ROM rom(
.clk            (clk),
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

//(S)NESpad
.nesc(nesc), 
.nesl(nesl),
.nesd(nesd)
);


//---------------CPU----------------
//CPU I/O

CPU cpu(
.clk            (clk),
.reset          (reset),
.int1           (int1), 
.int2           (int2), 
.int3           (int3), 
.int4           (int4),
.address        (address),
.data           (data),
.we             (we),
.q              (q),
.start          (start),
.busy           (busy)
);

endmodule