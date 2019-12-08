/*
* Performs basic arithmatic operations on a and b, based on the opcode
* Also sets flags
* TODO convert to assigns and use parameters
*/
module ALU(
    input       [31:0]  a, b,
    input       [3:0]   opcode,
    input               skip,   //do not do any operation, pass on b
    output reg  [31:0]  y,
    output              bga,    //b greater than a
    output              bea     //b equals a
);

assign bga  = (b >  a);
assign bea  = (b == a);

always @*
begin
    if (!skip)
    begin
        case (opcode)
            4'b0000: y = a       | b;       //OR
            4'b0001: y = a       & b;       //AND
            4'b0010: y = a       ^ b;       //XOR
            4'b0011: y = a       + b;       //ADD
            4'b0100: y = a       - b;       //SUB
            4'b0101: y = a      << b[5:0];  //SHIFTL
            4'b0110: y = a      >> b[5:0];  //SHIFTR
            4'b0111: y = a[15:0] * b[15:0]; //MULT
            4'b1000: y =         ~ b;       //NOTB
            4'b1001: y = 32'd0;             //UNIMPLEMENTED
            4'b1010: y = 32'd0;             //UNIMPLEMENTED
            4'b1011: y = 32'd0;             //UNIMPLEMENTED
            4'b1100: y = 32'd0;             //UNIMPLEMENTED
            4'b1101: y = 32'd0;             //UNIMPLEMENTED
            4'b1110: y = 32'd0;             //UNIMPLEMENTED
            4'b1111: y = 32'd0;             //UNIMPLEMENTED
        endcase
    end
    else 
    begin
        y = b;
    end
end
    
endmodule