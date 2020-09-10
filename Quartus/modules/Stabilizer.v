/*
* Stabilizes unstable signal
*/
module Stabilizer (
    input unstable,
	 input reset, // TODO: remove
    input clk,
    output stable
);

// We use a two-stages shift-register to synchronize unstable to the clk clock domain
reg [1:0] unstableToClk;
always @(posedge clk) 
begin
	unstableToClk[0] <= unstable;
	unstableToClk[1] <= unstableToClk[0];
end

assign stable = unstableToClk[1];
endmodule