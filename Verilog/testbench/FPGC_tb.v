/*
 * Testbench
 * Simulates the entire FPGC
*/
//Set timescale
`timescale 1 ns/1 ns

//Include top level design
`include "../modules/FPGC4.v"
//Include modules
//`include "../modules/CPU.v"
`include "../modules/ClockDivider.v"
`include "../modules/ResetStabilizer.v"
`include "../modules/VRAM.v"
`include "../modules/FSX.v"
`include "../modules/VGA.v"

//Define testmodule
module FPGC_tb;

//I/O
reg clk;
reg nreset;
wire vga_clk;
wire vga_hs;
wire vga_vs;
wire [7:0] vga_r;
wire [7:0] vga_g;
wire [7:0] vga_b;
wire vga_blk;

FPGC4 fpgc (
.clk(clk),
.nreset(nreset),
.vga_clk(vga_clk),
.vga_hs(vga_hs),
.vga_vs(vga_vs),
.vga_r(vga_r),
.vga_g(vga_g),
.vga_b(vga_b),
.vga_blk(vga_blk)
);

initial
begin
    //Dump everything for GTKwave
    $dumpfile("../output/wave.vcd");
    $dumpvars;
    clk = 0;
    nreset = 1;

    repeat(500000) #5 clk = ~clk; //100MHz

    #1 $finish;
end

endmodule
