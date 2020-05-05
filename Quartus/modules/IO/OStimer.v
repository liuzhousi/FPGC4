// One shot timer that counts in milliseconds
// Uses a prescaler of 25000

module OStimer(
    input clk,
    input reset,
    input [31:0] timerValue,
    input trigger,
    input setValue,
    output reg interrupt
);

reg [46:0] counterValue;                // 32 bits for timerValue + 15 bits for prescaler multiplication
reg [3:0] keepInterruptHighCounter;     // we want to keep the interrupt high for multiple cycles
reg [1:0] state;                        // state of timer

parameter s_idle        = 0;
parameter s_start       = 1;
parameter s_done        = 2;

parameter prescaler     = 25000;


initial
begin
    counterValue                <= 47'd0;
    state                       <= s_idle;
    keepInterruptHighCounter    <= 4'd0;
    interrupt                   <= 1'b0;
end

always @(negedge clk)
begin
    if (reset)
    begin
        counterValue                <= 32'd0;
        state                       <= s_idle;
        interrupt                   <= 1'd0;  
        keepInterruptHighCounter    <= 4'd0;
    end
    else
    begin
        case (state)
            s_idle:
            begin
                if (trigger)
                begin
                    state <= s_start;
                end
                if (setValue)
                begin
                    counterValue <= prescaler*timerValue;
                end
            end
            s_start:
            begin
                if (setValue)
                begin
                    counterValue <= prescaler*timerValue;
                end
                else if (counterValue == 0)
                begin
                    state <= s_done;
                    interrupt <= 1'b1;
                    keepInterruptHighCounter <= 0;
                end
                else 
                begin
                    counterValue <= counterValue - 1'b1;
                end
            end
            s_done:
            begin
                if (setValue)
                begin
                    counterValue <= prescaler*timerValue;
                end
                else if (trigger)
                begin
                    state <= s_start;
                    interrupt <= 0;
                end
                else if (keepInterruptHighCounter == 4'b1111)
                begin
                    interrupt <= 0;
                    state <= s_idle;
                end
                else 
                begin
                    keepInterruptHighCounter <= keepInterruptHighCounter + 1'b1;
                end
            end

        endcase
    end
end


endmodule


