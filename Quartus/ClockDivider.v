/*
* Divides clk_in by the number specified in the DIVISOR parameter
*/
module ClockDivider
#(
    parameter DIVISOR = 25
) 
(
    input clk_in,
    output wire clk_out
);

reg[15:0] counter;

always @(posedge clk_in)
begin
    counter <= counter + 16'd1;
    if (counter >= (DIVISOR-1))
        counter <= 16'd0;
end

assign clk_out = (counter < DIVISOR/2) ? 1'b0:
        1'b1;

initial
begin
    counter = 16'd0;
end

endmodule