/*
* Reads PS/2 keyboard and stores button values in one big register
* Code is mostly copied
*/
module Keyboard(
    input wire clk, reset,
    input wire ps2d, ps2c,              // ps2 data and clock lines
    output wire [7:0] scanCode,         // scan_code received from keyboard to process
    output reg [78:0] buttonState,      // register to store button state
    output wire scan_code_ready         // signal to outer control system to sample scan_code
);

//Get slower clk from 25MHz clk
wire slow_clk;
ClockDivider #(
.DIVISOR(25))
 clkDivKeyboard(
.clk_in(clk),
.reset(reset),
.clk_out(slow_clk)
);

// instantiate ps2 receiver
ps2_rx ps2_rx_unit (.clk(slow_clk), .reset(reset), .rx_en(1'b1), .ps2d(ps2d), .ps2c(ps2c), .rx_done_tick(scan_code_ready), .rx_data(scanCode));

reg [1:0] state;
reg [2:0] counter;
reg delayed_ready;

//delay processing scan codes to make sure the codes are ready
always @(posedge slow_clk or posedge reset)
begin
    if (reset)
    begin
        counter <= 3'b0;
        delayed_ready <= 1'b0;
    end
    else 
    begin
        if (scan_code_ready)
            counter <= 3'b0;
        
        if (counter == 3'b110)
            delayed_ready <= 1'b1;
        
        if (counter == 3'b111)
            delayed_ready <= 1'b0;
        else
            counter <= counter + 1'b1;
    end
end
    

always @(posedge delayed_ready or posedge reset)    //when a code is read
begin
    if (reset)
    begin
        buttonState <= 79'd0;
        state <= 2'd0;
    end
    else
    begin

        case(state)
        0:  
        begin
            case (scanCode)
                8'hf0: state <= 1;  //release
                8'he0: state <= 2;  //extended
                8'h76  : buttonState[0] <= 1'b1; //esc
                8'h05  : buttonState[1] <= 1'b1; //f1
                8'h06  : buttonState[2] <= 1'b1; //f2
                8'h04  : buttonState[3] <= 1'b1; //f3
                8'h0c  : buttonState[4] <= 1'b1; //f4
                8'h03  : buttonState[5] <= 1'b1; //f5
                8'h0b  : buttonState[6] <= 1'b1; //f6
                8'h83  : buttonState[7] <= 1'b1; //f7
                8'h0a  : buttonState[8] <= 1'b1; //f8
                8'h01  : buttonState[9] <= 1'b1; //f9
                8'h09  : buttonState[10] <= 1'b1; //f10
                8'h78  : buttonState[11] <= 1'b1; //f11
                8'h07  : buttonState[12] <= 1'b1; //f12
                8'h0e  : buttonState[13] <= 1'b1; //`~
                8'h16  : buttonState[14] <= 1'b1; //1
                8'h1e  : buttonState[15] <= 1'b1; //2
                8'h26  : buttonState[16] <= 1'b1; //3
                8'h25  : buttonState[17] <= 1'b1; //4
                8'h2e  : buttonState[18] <= 1'b1; //5
                8'h36  : buttonState[19] <= 1'b1; //6
                8'h3d  : buttonState[20] <= 1'b1; //7
                8'h3e  : buttonState[21] <= 1'b1; //8
                8'h46  : buttonState[22] <= 1'b1; //9
                8'h45  : buttonState[23] <= 1'b1; //0
                8'h4e  : buttonState[24] <= 1'b1; //-_
                8'h55  : buttonState[25] <= 1'b1; //=+
                8'h5d  : buttonState[26] <= 1'b1; //|\
                8'h15  : buttonState[27] <= 1'b1; //q
                8'h1d  : buttonState[28] <= 1'b1; //w
                8'h24  : buttonState[29] <= 1'b1; //e
                8'h2d  : buttonState[30] <= 1'b1; //r
                8'h2c  : buttonState[31] <= 1'b1; //t
                8'h35  : buttonState[32] <= 1'b1; //y
                8'h3c  : buttonState[33] <= 1'b1; //u
                8'h43  : buttonState[34] <= 1'b1; //i
                8'h44  : buttonState[35] <= 1'b1; //o
                8'h4d  : buttonState[36] <= 1'b1; //p
                8'h1c  : buttonState[37] <= 1'b1; //a
                8'h1b  : buttonState[38] <= 1'b1; //s
                8'h23  : buttonState[39] <= 1'b1; //d
                8'h2b  : buttonState[40] <= 1'b1; //f
                8'h34  : buttonState[41] <= 1'b1; //g
                8'h33  : buttonState[42] <= 1'b1; //h
                8'h3b  : buttonState[43] <= 1'b1; //j
                8'h42  : buttonState[44] <= 1'b1; //k
                8'h4b  : buttonState[45] <= 1'b1; //l
                8'h1a  : buttonState[46] <= 1'b1; //z
                8'h22  : buttonState[47] <= 1'b1; //x
                8'h21  : buttonState[48] <= 1'b1; //c
                8'h2a  : buttonState[49] <= 1'b1; //v
                8'h32  : buttonState[50] <= 1'b1; //b
                8'h31  : buttonState[51] <= 1'b1; //n
                8'h3a  : buttonState[52] <= 1'b1; //m
                8'h54  : buttonState[53] <= 1'b1; //[
                8'h5b  : buttonState[54] <= 1'b1; //]
                8'h4c  : buttonState[55] <= 1'b1; //;:
                8'h52  : buttonState[56] <= 1'b1; //'"
                8'h41  : buttonState[57] <= 1'b1; //,
                8'h49  : buttonState[58] <= 1'b1; //.
                8'h4a  : buttonState[59] <= 1'b1; ///
                8'h0d  : buttonState[60] <= 1'b1; //tab
                8'h58  : buttonState[61] <= 1'b1; //caps
                8'h12  : buttonState[62] <= 1'b1; //shiftl
                8'h59  : buttonState[63] <= 1'b1; //shiftr
                8'h14  : buttonState[64] <= 1'b1; //ctrl
                8'h11  : buttonState[65] <= 1'b1; //altl
                8'h66  : buttonState[66] <= 1'b1; //backspace
                8'h29  : buttonState[67] <= 1'b1; //space
            endcase
        end

        1:
        begin
            state <= 0;
            case (scanCode)
                8'h76  : buttonState[0] <= 1'b0; //esc
                8'h05  : buttonState[1] <= 1'b0; //f1
                8'h06  : buttonState[2] <= 1'b0; //f2
                8'h04  : buttonState[3] <= 1'b0; //f3
                8'h0c  : buttonState[4] <= 1'b0; //f4
                8'h03  : buttonState[5] <= 1'b0; //f5
                8'h0b  : buttonState[6] <= 1'b0; //f6
                8'h83  : buttonState[7] <= 1'b0; //f7
                8'h0a  : buttonState[8] <= 1'b0; //f8
                8'h01  : buttonState[9] <= 1'b0; //f9
                8'h09  : buttonState[10] <= 1'b0; //f10
                8'h78  : buttonState[11] <= 1'b0; //f11
                8'h07  : buttonState[12] <= 1'b0; //f12
                8'h0e  : buttonState[13] <= 1'b0; //`~
                8'h16  : buttonState[14] <= 1'b0; //1
                8'h1e  : buttonState[15] <= 1'b0; //2
                8'h26  : buttonState[16] <= 1'b0; //3
                8'h25  : buttonState[17] <= 1'b0; //4
                8'h2e  : buttonState[18] <= 1'b0; //5
                8'h36  : buttonState[19] <= 1'b0; //6
                8'h3d  : buttonState[20] <= 1'b0; //7
                8'h3e  : buttonState[21] <= 1'b0; //8
                8'h46  : buttonState[22] <= 1'b0; //9
                8'h45  : buttonState[23] <= 1'b0; //0
                8'h4e  : buttonState[24] <= 1'b0; //-_
                8'h55  : buttonState[25] <= 1'b0; //=+
                8'h5d  : buttonState[26] <= 1'b0; //|\
                8'h15  : buttonState[27] <= 1'b0; //q
                8'h1d  : buttonState[28] <= 1'b0; //w
                8'h24  : buttonState[29] <= 1'b0; //e
                8'h2d  : buttonState[30] <= 1'b0; //r
                8'h2c  : buttonState[31] <= 1'b0; //t
                8'h35  : buttonState[32] <= 1'b0; //y
                8'h3c  : buttonState[33] <= 1'b0; //u
                8'h43  : buttonState[34] <= 1'b0; //i
                8'h44  : buttonState[35] <= 1'b0; //o
                8'h4d  : buttonState[36] <= 1'b0; //p
                8'h1c  : buttonState[37] <= 1'b0; //a
                8'h1b  : buttonState[38] <= 1'b0; //s
                8'h23  : buttonState[39] <= 1'b0; //d
                8'h2b  : buttonState[40] <= 1'b0; //f
                8'h34  : buttonState[41] <= 1'b0; //g
                8'h33  : buttonState[42] <= 1'b0; //h
                8'h3b  : buttonState[43] <= 1'b0; //j
                8'h42  : buttonState[44] <= 1'b0; //k
                8'h4b  : buttonState[45] <= 1'b0; //l
                8'h1a  : buttonState[46] <= 1'b0; //z
                8'h22  : buttonState[47] <= 1'b0; //x
                8'h21  : buttonState[48] <= 1'b0; //c
                8'h2a  : buttonState[49] <= 1'b0; //v
                8'h32  : buttonState[50] <= 1'b0; //b
                8'h31  : buttonState[51] <= 1'b0; //n
                8'h3a  : buttonState[52] <= 1'b0; //m
                8'h54  : buttonState[53] <= 1'b0; //[
                8'h5b  : buttonState[54] <= 1'b0; //]
                8'h4c  : buttonState[55] <= 1'b0; //;:
                8'h52  : buttonState[56] <= 1'b0; //'"
                8'h41  : buttonState[57] <= 1'b0; //,
                8'h49  : buttonState[58] <= 1'b0; //.
                8'h4a  : buttonState[59] <= 1'b0; ///
                8'h0d  : buttonState[60] <= 1'b0; //tab
                8'h58  : buttonState[61] <= 1'b0; //caps
                8'h12  : buttonState[62] <= 1'b0; //shiftl
                8'h59  : buttonState[63] <= 1'b0; //shiftr
                8'h14  : buttonState[64] <= 1'b0; //ctrl
                8'h11  : buttonState[65] <= 1'b0; //altl
                8'h66  : buttonState[66] <= 1'b0; //backspace
                8'h29  : buttonState[67] <= 1'b0; //space
            endcase
        end

        2:
        begin
            state <= 0;
            case (scanCode)
                8'hf0: state <= 3;  //release
                
                8'h1f  : buttonState[68] <= 1'b1; //windown E01F 
                8'h6b  : buttonState[69] <= 1'b1; //left E06B
                8'h72  : buttonState[70] <= 1'b1; //down E072
                8'h74  : buttonState[71] <= 1'b1; //right E074
                8'h75  : buttonState[72] <= 1'b1; //up E075
                8'h71  : buttonState[73] <= 1'b1; //del E071
                8'h70  : buttonState[74] <= 1'b1; //ins E070
                8'h6c  : buttonState[75] <= 1'b1; //home E06C
                8'h69  : buttonState[76] <= 1'b1; //end E069
                8'h7d  : buttonState[77] <= 1'b1; //page up E07D
                8'h7a  : buttonState[78] <= 1'b1; //page down E07A
            endcase
        end

        3:
        begin
            state <= 0;
            case (scanCode)                 
                8'h1f  : buttonState[68] <= 1'b0; //windown E01F 
                8'h6b  : buttonState[69] <= 1'b0; //left E06B
                8'h72  : buttonState[70] <= 1'b0; //down E072
                8'h74  : buttonState[71] <= 1'b0; //right E074
                8'h75  : buttonState[72] <= 1'b0; //up E075
                8'h71  : buttonState[73] <= 1'b0; //del E071
                8'h70  : buttonState[74] <= 1'b0; //ins E070
                8'h6c  : buttonState[75] <= 1'b0; //home E06C
                8'h69  : buttonState[76] <= 1'b0; //end E069
                8'h7d  : buttonState[77] <= 1'b0; //page up E07D
                8'h7a  : buttonState[78] <= 1'b0; //page down E07A
            endcase
        end

    endcase
    end
end
    
endmodule


/*
* Second module for receiving PS/2 codes
*/
module ps2_rx
    (
        input wire clk, reset, 
        input wire ps2d, ps2c, rx_en,    // ps2 data and clock inputs, receive enable input
        output reg rx_done_tick,         // ps2 receive done tick
        output wire [7:0] rx_data        // data received 
    );
    
    // FSMD state declaration
    localparam 
        idle = 1'b0,
        rx   = 1'b1;
        
    // internal signal declaration
    reg state_reg, state_next;          // FSMD state register
    reg [7:0] filter_reg;               // shift register filter for ps2c
    wire [7:0] filter_next;             // next state value of ps2c filter register
    reg f_val_reg;                      // reg for ps2c filter value, either 1 or 0
    wire f_val_next;                    // next state for ps2c filter value
    reg [3:0] n_reg, n_next;            // register to keep track of bit number 
    reg [10:0] d_reg, d_next;           // register to shift in rx data
    wire neg_edge;                      // negative edge of ps2c clock filter value
    
    // register for ps2c filter register and filter value
    always @(posedge clk, posedge reset)
        if (reset)
            begin
            filter_reg <= 0;
            f_val_reg  <= 0;
            end
        else
            begin
            filter_reg <= filter_next;
            f_val_reg  <= f_val_next;
            end

    // next state value of ps2c filter: right shift in current ps2c value to register
    assign filter_next = {ps2c, filter_reg[7:1]};
    
    // filter value next state, 1 if all bits are 1, 0 if all bits are 0, else no change
    assign f_val_next = (filter_reg == 8'b11111111) ? 1'b1 :
                (filter_reg == 8'b00000000) ? 1'b0 :
                f_val_reg;
    
    // negative edge of filter value: if current value is 1, and next state value is 0
    assign neg_edge = f_val_reg & ~f_val_next;
    
    // FSMD state, bit number, and data registers
    always @(posedge clk, posedge reset)
        if (reset)
            begin
            state_reg <= idle;
            n_reg <= 0;
            d_reg <= 0;
            end
        else
            begin
            state_reg <= state_next;
            n_reg <= n_next;
            d_reg <= d_next;
            end
    
    // FSMD next state logic
    always @*
        begin
        
        // defaults
        state_next = state_reg;
        rx_done_tick = 1'b0;
        n_next = n_reg;
        d_next = d_reg;
        
        case (state_reg)
            
            idle:
                if (neg_edge & rx_en)                 // start bit received
                    begin
                    n_next = 4'b1010;             // set bit count down to 10
                    state_next = rx;              // go to rx state
                    end
                
            rx:                                           // shift in 8 data, 1 parity, and 1 stop bit
                begin
                if (neg_edge)                         // if ps2c negative edge...
                    begin
                    d_next = {ps2d, d_reg[10:1]}; // sample ps2d, right shift into data register
                    n_next = n_reg - 1;           // decrement bit count
                    end
            
                if (n_reg==0)                         // after 10 bits shifted in, go to done state
                     begin
                     rx_done_tick = 1'b1;         // assert dat received done tick
                     state_next = idle;           // go back to idle
                     end
                end
        endcase
        end
        
    assign rx_data = d_reg[8:1]; // output data bits 
endmodule
