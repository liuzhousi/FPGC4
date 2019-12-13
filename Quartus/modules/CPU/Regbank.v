/*
* Register Bank
*/
module Regbank(
    input               clk, reset,
    input               getRegs, writeBack,

    input       [3:0]   addr_a, addr_b, addr_d,
    input       [31:0]  data_d,
    output reg  [31:0]  data_a, data_b, 

    input               we, we_high,
    //Memory
    input               read_mem,
    input       [31:0]  mem_q
);

reg [15:0] regsH [0:15];    //highest 16 bits of regbank
reg [15:0] regsL [0:15];    //lowest 16 bits of regbank

//read at negedge clock
always @(negedge clk) 
begin
    if (getRegs)
    begin
        if (addr_a == 4'd0)
        begin
            data_a <= 32'd0;
        end
        else
        begin
            data_a <= {regsH[addr_a], regsL[addr_a]};
        end

        if (addr_b == 4'd0)
        begin
            data_b <= 32'd0;
        end
        else
        begin
            data_b <= {regsH[addr_b], regsL[addr_b]};
        end
    end
end

//write at negedge clock
always @(negedge clk) 
begin
    if (writeBack && we)
    begin
        if (read_mem) //when read_mem is high, ignore data from ALU and use data from memory instead
        begin
            regsL[addr_d] <= mem_q[15:0];
            regsH[addr_d] <= mem_q[31:16];
        end
        else
        begin
            if (we_high)
            begin
                regsH[addr_d] <= data_d[15:0];
            end
            else 
            begin
                regsL[addr_d] <= data_d[15:0];
                regsH[addr_d] <= data_d[31:16];
            end
        end
    end
end

integer i;
initial
begin
    data_a = 32'd0;
    data_b = 32'd0;

end

endmodule