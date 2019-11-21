/*
 * Testbench
 * Runs tests on the entire FPGC
*/
//Set timescale
`timescale 1 ns/10 ps

//Include top level design
`include "../modules/FPGC4.v"
//Include modules
//`include "../modules/CPU.v"



//Define testmodule
module FPGC_tb;

//I/O
reg clk;


initial
begin
    //Dump everything for GTKwave
    $dumpfile("../output/wave.vcd");
    $dumpvars;

    repeat(100) #1 clk = ~clk;




    #1 $finish;
end

endmodule