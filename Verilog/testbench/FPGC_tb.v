/*
 * Testbench
 * Simulates the entire FPGC
*/
//Set timescale
`timescale 1 ns/1 ns

//Include top level design
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/FPGC4.v"
//Include modules
//`include "../modules/ClockDivider.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Stabilizer.v"

`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/GPU/FSX.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/GPU/VGA.v"

`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Memory/VRAM.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Memory/mt48lc16m16a2.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Memory/w25q128jv.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Memory/SDRAMcontroller.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Memory/SPIreader.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Memory/ROM.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/Memory/MemoryUnit.v"

`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/CPU.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/ALU.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/ControlUnit.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/InstructionDecoder.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/PC.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/Regbank.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/Stack.v"
`include "/home/bart/Documents/FPGA/FPGC4/Verilog/modules/CPU/Timer.v"



//Define testmodule
module FPGC_tb;

//I/O
reg clk;
reg nreset;
reg int1, int2, int3, int4;

//SPI Flash
wire spi_clk;
wire spi_cs; 
wire spi_data; 
wire spi_wp;
wire spi_q;  
wire spi_hold; 

W25Q128JV spiFlash (
.CLK 	(spi_clk), 
.DIO 	(spi_data), 
.CSn 	(spi_cs), 
.WPn 	(spi_wp), 
.HOLDn 	(spi_hold), 
.DO 	(spi_q)
); 

//SDRAM
wire 			 sdram_clk;		// SDRAM clock
wire    [15 : 0] sdram_dq;		// SDRAM I/O
wire	[12 : 0] sdram_addr;    // SDRAM Address
wire    [1 : 0]  sdram_ba;      // Bank Address
wire             sdram_cke;     // Synchronous Clock Enable
wire             sdram_cs_n;    // CS#
wire             sdram_ras_n;   // RAS#
wire             sdram_cas_n;   // CAS#
wire             sdram_we_n;    // WE#
wire    [1 : 0]  sdram_dqm;     // Mask

wire    [15 : 0] sdram_DQ = sdram_dq;

mt48lc16m16a2 sdram (
.Dq 	(sdram_DQ), 
.Addr 	(sdram_addr), 
.Ba 	(sdram_ba), 
.Clk 	(sdram_clk), 
.Cke 	(sdram_cke), 
.Cs_n 	(sdram_cs_n), 
.Ras_n 	(sdram_ras_n), 
.Cas_n 	(sdram_cas_n), 
.We_n 	(sdram_we_n), 
.Dqm 	(sdram_dqm)
);

//VGA
wire 		vga_clk;
wire 		vga_hs;
wire 		vga_vs;
wire [2:0] 	vga_r;
wire [2:0] 	vga_g;
wire [1:0] 	vga_b;
wire 		vga_blk;

FPGC4 fpgc (
//Clock and reset
.clk 		(clk),
.nreset 	(nreset),

//VGA
.vga_clk 	(vga_clk),
.vga_hs 	(vga_hs),
.vga_vs 	(vga_vs),
.vga_r 		(vga_r),
.vga_g 		(vga_g),
.vga_b 		(vga_b),
.vga_blk 	(vga_blk),


//SDRAM
.SDRAM_CLK  (sdram_clk),
.SDRAM_CKE 	(sdram_cke), 
.SDRAM_CSn 	(sdram_cs_n),
.SDRAM_WEn 	(sdram_we_n), 
.SDRAM_CASn (sdram_cas_n), 
.SDRAM_RASn (sdram_ras_n),
.SDRAM_A 	(sdram_addr),
.SDRAM_BA 	(sdram_ba),
.SDRAM_DQM 	(sdram_dqm),
.SDRAM_DQ 	(sdram_DQ),


//SPI
.spi_clk 	(spi_clk),
.spi_data 	(spi_data),
.spi_q 		(spi_q),
.spi_wp 	(spi_wp),
.spi_hold 	(spi_hold),
.spi_cs 	(spi_cs),


//Interrupts
.int1           (int1), 
.int2           (int2), 
.int3           (int3), 
.int4           (int4)
);


initial
begin
    //Dump everything for GTKwave
    $dumpfile("/home/bart/Documents/FPGA/FPGC4/Verilog/output/wave.vcd");
    $dumpvars;
    int1 = 0;
    int2 = 0;
    int3 = 0;
    int4 = 0;
    clk = 0;
    nreset = 1;

    repeat(497) #20 clk = ~clk; //25MHz
    //int3 = 1;
    repeat(100) #20 clk = ~clk; //25MHz
    //int3 = 0;
    repeat(50000) #20 clk = ~clk; //25MHz

    #1 $finish;
end

endmodule
