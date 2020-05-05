module CTCtimer(
    input clk,
    input reset,
    input [31:0] timerValue,
    input [7:0] controlReg,
    output reg interrupt
);

/* Control Register:
1.  start
2.  stop
*/

reg [42:0] counterValue; //enough room for 2 days
reg doWork;
reg [4:0] keepInterruptHighCounter;

always @(negedge clk)
begin
    if (reset)
    begin
        counterValue <= 32'd0;
        doWork <= 1'd0;  
        interrupt <= 1'd0;  
        keepInterruptHighCounter <= 5'd0;
    end
    else
    begin
        case (controlReg)
            8'd1: //start 
            begin
                doWork <= 1'b1;
            end
            8'd2: //stop
            begin
                doWork <= 1'b0;
            end
        endcase

        if (timerValue != 0)
        begin
            counterValue <= timerValue * 25000;
        end

        if (doWork)
        begin
            if (counterValue == 0)
            begin
                interrupt <= 1'b1;
                keepInterruptHighCounter <= 5'b11111;
                doWork <= 1'b0;
            end
            else 
            begin
                counterValue <= counterValue - 1'b1;
            end
        end
        else 
        begin
            if (keepInterruptHighCounter == 0)
            begin
                interrupt <= 1'b0;
            end
            else 
            begin
                keepInterruptHighCounter <= keepInterruptHighCounter - 1'b1;
            end
        end
    end
end



initial
begin
    counterValue = 32'd0;
    doWork = 1'd0;  
    interrupt = 1'd0;  
    keepInterruptHighCounter = 5'd0;
end

endmodule


