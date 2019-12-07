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

//reg0 practically does not exist, because it's always zero
reg [31:0] reg1;
reg [31:0] reg2;
reg [31:0] reg3;
reg [31:0] reg4;
reg [31:0] reg5;
reg [31:0] reg6;
reg [31:0] reg7;
reg [31:0] reg8;
reg [31:0] reg9;
reg [31:0] reg10;
reg [31:0] reg11;
reg [31:0] reg12;
reg [31:0] reg13;
reg [31:0] reg14;
reg [31:0] reg15;

//read at negedge clock
always @(negedge clk) 
begin
    if (getRegs)
    begin
        case (addr_a)
            4'd0 :  data_a <= 32'd0;
            4'd1 :  data_a <= reg1;
            4'd2 :  data_a <= reg2;
            4'd3 :  data_a <= reg3;
            4'd4 :  data_a <= reg4;
            4'd5 :  data_a <= reg5;
            4'd6 :  data_a <= reg6;
            4'd7 :  data_a <= reg7;
            4'd8 :  data_a <= reg8;
            4'd9 :  data_a <= reg9;
            4'd10:  data_a <= reg10;
            4'd11:  data_a <= reg11;
            4'd12:  data_a <= reg12;
            4'd13:  data_a <= reg13;
            4'd14:  data_a <= reg14;
            4'd15:  data_a <= reg15;
        endcase

        case (addr_b)
            4'd0 :  data_b <= 32'd0;
            4'd1 :  data_b <= reg1;
            4'd2 :  data_b <= reg2;
            4'd3 :  data_b <= reg3;
            4'd4 :  data_b <= reg4;
            4'd5 :  data_b <= reg5;
            4'd6 :  data_b <= reg6;
            4'd7 :  data_b <= reg7;
            4'd8 :  data_b <= reg8;
            4'd9 :  data_b <= reg9;
            4'd10:  data_b <= reg10;
            4'd11:  data_b <= reg11;
            4'd12:  data_b <= reg12;
            4'd13:  data_b <= reg13;
            4'd14:  data_b <= reg14;
            4'd15:  data_b <= reg15;
        endcase
    end
end



//write at negedge clock
always @(negedge clk) 
begin
    if (reset)
    begin
        reg1 <= 32'd0;
        reg2 <= 32'd0;
        reg3 <= 32'd0;
        reg4 <= 32'd0;
        reg5 <= 32'd0;
        reg6 <= 32'd0;
        reg7 <= 32'd0;
        reg8 <= 32'd0;
        reg9 <= 32'd0;
        reg10 <= 32'd0;
        reg11 <= 32'd0;
        reg12 <= 32'd0;
        reg13 <= 32'd0;
        reg14 <= 32'd0;
        reg15 <= 32'd0; 
    end
    else
    begin
        if (writeBack && we)
            if (read_mem) //when read_mem is high, ignore data from ALU and use data from memory instead
                case (addr_d)
                    4'd1: reg1 <= mem_q;
                    4'd2: reg2 <= mem_q;
                    4'd3: reg3 <= mem_q;
                    4'd4: reg4 <= mem_q;
                    4'd5: reg5 <= mem_q;
                    4'd6: reg6 <= mem_q;
                    4'd7: reg7 <= mem_q;
                    4'd8: reg8 <= mem_q;
                    4'd9: reg9 <= mem_q;
                    4'd10: reg10 <= mem_q;
                    4'd11: reg11 <= mem_q;
                    4'd12: reg12 <= mem_q;
                    4'd13: reg13 <= mem_q;
                    4'd14: reg14 <= mem_q;
                    4'd15: reg15 <= mem_q;
                endcase
            else
            begin
                if (we_high)
                    case (addr_d)
                        4'd1: reg1[31:16] <= data_d[15:0];
                        4'd2: reg2[31:16] <= data_d[15:0];
                        4'd3: reg3[31:16] <= data_d[15:0];
                        4'd4: reg4[31:16] <= data_d[15:0];
                        4'd5: reg5[31:16] <= data_d[15:0];
                        4'd6: reg6[31:16] <= data_d[15:0];
                        4'd7: reg7[31:16] <= data_d[15:0];
                        4'd8: reg8[31:16] <= data_d[15:0];
                        4'd9: reg9[31:16] <= data_d[15:0];
                        4'd10: reg10[31:16] <= data_d[15:0];
                        4'd11: reg11[31:16] <= data_d[15:0];
                        4'd12: reg12[31:16] <= data_d[15:0];
                        4'd13: reg13[31:16] <= data_d[15:0];
                        4'd14: reg14[31:16] <= data_d[15:0];
                        4'd15: reg15[31:16] <= data_d[15:0];
                    endcase
                else 
                    case (addr_d)
                        4'd1: reg1 <= data_d;
                        4'd2: reg2 <= data_d;
                        4'd3: reg3 <= data_d;
                        4'd4: reg4 <= data_d;
                        4'd5: reg5 <= data_d;
                        4'd6: reg6 <= data_d;
                        4'd7: reg7 <= data_d;
                        4'd8: reg8 <= data_d;
                        4'd9: reg9 <= data_d;
                        4'd10: reg10 <= data_d;
                        4'd11: reg11 <= data_d;
                        4'd12: reg12 <= data_d;
                        4'd13: reg13 <= data_d;
                        4'd14: reg14 <= data_d;
                        4'd15: reg15 <= data_d;
                    endcase
            end
    end
end

initial
begin
    reg1 = 32'd0;
    reg2 = 32'd0;
    reg3 = 32'd0;
    reg4 = 32'd0;
    reg5 = 32'd0;
    reg6 = 32'd0;
    reg7 = 32'd0;
    reg8 = 32'd0;
    reg9 = 32'd0;
    reg10 = 32'd0;
    reg11 = 32'd0;
    reg12 = 32'd0;
    reg13 = 32'd0;
    reg14 = 32'd0;
    reg15 = 32'd0;
    data_a = 32'd0;
    data_b = 32'd0;
end

endmodule