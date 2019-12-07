/*
* Stabilizes unstable signal
*/
module Stabilizer (
  input     clk, reset, unstable,  
  output    stable
);

assign stable = unstable_3;

//Register chain to make unstable signal stable
reg unstable_1, unstable_2, unstable_3; 

//Make unstable signal stable at the base clock
always @(posedge clk)
begin
    if (reset)
    begin
        unstable_1 <= 1'b0;
        unstable_2 <= 1'b0;
        unstable_3 <= 1'b0;
    end
    // unstable_1 is METASTABLE, unstable_2 and unstable_3 are STABLE
    unstable_1 <= unstable;
    unstable_2 <= unstable_1;
    unstable_3 <= unstable_2;
end
    
initial
begin
    unstable_1 <= 1'b0;
    unstable_2 <= 1'b0;
    unstable_3 <= 1'b0;
end

endmodule