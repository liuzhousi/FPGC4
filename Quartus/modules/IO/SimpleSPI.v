module SimpleSPI
#(
    parameter reg_width = 8,
    parameter speed_div = 25
)
(
    // System side
    input reset,
    input clk,
    input t_start,
    input [reg_width-1:0] d_in,
    output reg [reg_width-1:0] d_out,
    output reg busy,

    // SPI side
    input miso,
    output wire mosi,
    output wire spi_clk,
    output reg cs
);
    //get slower clock from 25MHz clock
    wire slow_clk;
    ClockDivider #(
    .DIVISOR(speed_div))
     clkDivSPI(
    .clk_in(clk),
    .reset(reset),
    .clk_out(slow_clk)
    );

    localparam counter_width = $clog2(reg_width);
    localparam rst = 0, idle = 1, load = 2, transact = 3, unload = 4;

    reg [reg_width-1:0] mosi_d;
    reg [reg_width-1:0] miso_d;
    reg [counter_width:0] count;
    reg [2:0] state;
    reg slow_start;

    always @(negedge clk)
    begin
        if (state == transact)
        begin
            slow_start <= 0;
        end
        else
        begin
            if (state == unload)
            begin
                busy <= 0;
            end
            else
            begin
                if (t_start)
                begin
                    slow_start <= 1;
                    busy <= 1;
                end
            end
        end            
    end

    reg spi_clk_prev;
    always @(negedge clk)
    begin
        spi_clk_prev <= spi_clk;

        case (state)
            rst:
            begin
                d_out <= 0;
                cs <= 1;
            end
            idle:
            begin
                cs <= 1;
            end
            load:
            begin
                mosi_d <= d_in;
                count <= reg_width;
                cs <= 0;
            end
            transact:
            begin
                cs <= 0;
                //rising
                if (spi_clk && ~spi_clk_prev)
                begin
                    miso_d <= {miso_d[reg_width-2:0], miso};
                end
                //falling
                if (~spi_clk && spi_clk_prev)
                begin
                    mosi_d <= {mosi_d[reg_width-2:0], 1'b0};
                    count <= count-1;
                end
            end
            unload:
            begin
                d_out <= miso_d;
                cs <= 0;
            end

            default:
                state = rst;
        endcase
    end

    
    always @(posedge slow_clk)
    begin
        case (state)
            rst:
                if (slow_start)
                    state = load;
                else
                    state = idle;
            idle:
                if (slow_start)
                    state = load;
            load:
                if (count != 0)
                    state = transact;
                else
                    state = rst;
            transact:
                if (count != 0)
                    state = transact;
                else
                    state = unload;
            unload:
                if (slow_start)
                    state = load;
                else
                    state = idle;
        endcase
    end
    // end state machine

    // begin SPI logic
    assign mosi = ( ~cs ) ? mosi_d[reg_width-1] : 1'bz;
    assign spi_clk = ( state == transact ) ? slow_clk : 1'b0;
    // end SPI logic

    initial
    begin
        d_out = 0;
        mosi_d = 0;
        miso_d = 0;
        state = 0;
        count = 0;
        cs = 0;
        busy = 0;
        slow_start = 0;
        spi_clk_prev = 0;
    end

endmodule