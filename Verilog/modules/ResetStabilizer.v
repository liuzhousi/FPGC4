/*
* Stabilizes asynchronous reset signal
*/
module ResetStabilizer (
  input		nreset, clk,      
  output	reset
);

assign reset = ~nreset_3;

reg nreset_1, nreset_2, nreset_3; //Register chain to make nreset meta-stable

//Make asynchronous nreset signal stable at the base clock
always @(posedge clk)
begin
  	// nreset_1 is METASTABLE, nreset_2 and nreset_3 are STABLE
    nreset_1 <= nreset;
    nreset_2 <= nreset_1;
    nreset_3 <= nreset_2;
end
    
initial
begin
	nreset_1 = 1;
	nreset_2 = 1;
	nreset_3 = 1;
end

endmodule