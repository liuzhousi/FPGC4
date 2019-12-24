module TonePlayer(
    input clk,
    input reset,
    input [31:0] noteID,
    input we,
    output lineOut1, lineOut2, lineOut3, lineOut4
);

SingleTonePlayer stp1(
.clk(clk),
.reset(reset),
.noteID(noteID[6:0]),
.we(we),
.lineOut(lineOut1)
);

SingleTonePlayer stp2(
.clk(clk),
.reset(reset),
.noteID(noteID[14:8]),
.we(we),
.lineOut(lineOut2)
);

SingleTonePlayer stp3(
.clk(clk),
.reset(reset),
.noteID(noteID[22:16]),
.we(we),
.lineOut(lineOut3)
);

SingleTonePlayer stp4(
.clk(clk),
.reset(reset),
.noteID(noteID[30:24]),
.we(we),
.lineOut(lineOut4)
);

endmodule

module SingleTonePlayer(
    input clk,
    input reset,
    input [6:0] noteID,
    input we,
    output reg lineOut
);

wire [4:0] octave;
wire [3:0] note;

reg [6:0] toneID;

always @(negedge clk)
begin
    if (reset)
    begin
        toneID <= 7'd0;
    end
    else 
    begin
        if (we)
        begin
            toneID <= noteID;
        end
    end
   
end


divide_by12 get_octave_and_note(
.numerator({1'b0, toneID}), 
.quotient(octave), 
.remainder(note)
);

reg [8:0] clkdivider;
always @*
case(note)
     0: clkdivider = 9'd511;//A
     1: clkdivider = 9'd482;// A#/Bb
     2: clkdivider = 9'd455;//B
     3: clkdivider = 9'd430;//C
     4: clkdivider = 9'd405;// C#/Db
     5: clkdivider = 9'd383;//D
     6: clkdivider = 9'd361;// D#/Eb
     7: clkdivider = 9'd341;//E
     8: clkdivider = 9'd322;//F
     9: clkdivider = 9'd303;// F#/Gb
    10: clkdivider = 9'd286;//G
    11: clkdivider = 9'd270;// G#/Ab
    default: clkdivider = 9'd0;
endcase

reg [8:0] counter_note;
reg [9:0] counter_octave;


always @(posedge clk) 
begin
    if (reset)
    begin
        counter_note <= 9'd0;
    end
    else 
    begin
        counter_note <= (counter_note == 0 ? clkdivider : counter_note - 9'd1);
    end
end

always @(posedge clk)
begin
    if (reset)
    begin
        counter_octave <= 10'd0;
    end
    else 
    begin
        if(counter_note==0) 
        begin
            counter_octave <= (counter_octave == 0 ? 10'd1023 >> octave : counter_octave - 10'd1);
        end 
    end
    
end

always @(posedge clk) 
begin
    if (reset)
    begin
        lineOut <= 1'b0;
    end
    else 
    begin
        if(counter_note == 0 && counter_octave == 0 && toneID != 0) 
        begin
            lineOut <= ~lineOut;
        end
    end
    
end

initial
begin
    toneID = 7'd0;
    counter_note = 9'd0;
    counter_octave = 10'd0;
    clkdivider = 9'd0;
    lineOut = 1'b0;
end

endmodule


module divide_by12(
    input [7:0] numerator,  // value to be divided by 12
    output [4:0] quotient,   // value to be divided by 12
    output [3:0] remainder
);

assign quotient = numerator / 12;
assign remainder = numerator % 12;

endmodule
