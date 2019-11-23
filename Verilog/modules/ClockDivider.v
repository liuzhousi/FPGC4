/*
* Divides clk_in by the number specified in the DIVISOR parameter
* Division is max
*/
module ClockDivider
#(
    parameter DIVISOR = 25
) 
(
    input clk,
    output reg clk_e
);

reg[$clog2(DIVISOR):0] counter;

always @(posedge clk)
begin
    if (counter < DIVISOR - 1'b1)
        counter <= counter + 1'b1;
    else
        counter <= 0;
end

always @(posedge clk)
begin
    clk_e <= (counter == DIVISOR - 1'b1);
end

initial
begin
    counter = 0;
    clk_e = 0;
end

endmodule