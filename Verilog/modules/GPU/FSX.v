/*
* Graphical processor (Frame Synthesizer)
* Generates video from VRAM
* Designed for 640x480@60Hz VGA with 25MHz pixel clock
* Should run completely seperate from other logic, so can have its own clock domain
*/
module FSX(
    //VGA I/O
    input               vga_clk,            //9MHz
    output wire [2:0]   vga_r,
    output wire [2:0]   vga_g,
    output wire [1:0]   vga_b,
    output wire         vga_hs,
    output wire         vga_vs,
    output wire         vga_blk,

    //VRAM32
    output              gpu_clk,
    output [11:0]       vram32_addr,
    input  [31:0]       vram32_q, 

    //VRAM8
    output              gpu_clk2,
    output [11:0]       vram8_addr,
    input  [7:0]        vram8_q,

    //Interrupt signal
    output wire         frameDrawn
);

assign frameDrawn = (CounterY == 271 && CounterX > 460);

//-----------------------VGA-------------------------
//VGA I/O
wire            inDisplayArea;
wire            o_frame;
wire [11:0]     CounterX;
wire [11:0]     CounterY;
        
assign vga_blk = 1'b1;

VGA displayGen(
    .clk        (vga_clk),
    .o_hs       (vga_hs),
    .o_vs       (vga_vs),
    .o_frame    (o_frame),
    .o_h        (CounterX),
    .o_v        (CounterY),
    .o_de       (inDisplayArea)
);

//Start positions of image
parameter HDAT_BEGIN = 8;
parameter VDAT_BEGIN = 0;

//vram fetching state machine
reg [1:0] stateCounter;     
always @(posedge vga_clk)
begin
    if (!vga_hs)
        stateCounter <= 2'd0;
    else
        stateCounter <= stateCounter + 1'b1;
end

//BG TILE PROCESS
wire fetchBGnameTable; //trigger for when to fetch bg name table
assign fetchBGnameTable = stateCounter == 2'b00;

wire [7:0] tileID; //tile ID as result of fetching bg name table
assign tileID = vram8_q;

//PATTERN TABLE FETCHING
wire fetchPatternTable; //trigger for when to fetch pattern table
assign fetchPatternTable = stateCounter == 2'b01;


//BG PALETTE FETCHING
wire fetchBGPaletteTable; //trigger for when to fetch bg palette table
assign fetchBGPaletteTable = stateCounter == 2'b10;


wire [3:0] paletteID; //palette ID as result of fetching bg palette table
assign paletteID = vram8_q[3:0];


//PALETTE FETCHING
wire fetchPaletteTable; //trigger for when to fetch Palette table
assign fetchPaletteTable = stateCounter == 2'b11;


//CounterX divided by four, since there are four fetching states
wire [11:0] CounterXdiv4;
assign CounterXdiv4 = (CounterX>>2);

//VRAM I/O FOR FETCHING PROCESS

assign gpu_clk =    (fetchPatternTable && ~vga_clk) || (fetchPaletteTable && ~vga_clk);

assign gpu_clk2 =   (fetchBGnameTable && ~vga_clk) || (fetchBGPaletteTable && ~vga_clk);



assign vram32_addr =   (fetchPatternTable && CounterXdiv4 < 58  && inDisplayArea)      ? 11'h000 + (tileID << 2) + (alwaysVtilePixel>>1) :
                    (fetchPaletteTable && CounterXdiv4 < 58  && inDisplayArea)      ? 11'h400 + paletteID :
                    11'd0;

assign vram8_addr =  (fetchBGnameTable && CounterXdiv4 < 58  && inDisplayArea)       ? 11'h000 + CounterXdiv4 + ( ((CounterY - VDAT_BEGIN) >> 3) *57 ):
                    (fetchBGPaletteTable && CounterXdiv4 < 58  && inDisplayArea)    ? 11'h7F8 + CounterXdiv4 + ( ((CounterY - VDAT_BEGIN)  >> 3) *57 ):
                    11'd0;


reg [1:0] lineDataBuffer [463:0];   //buffer for tile data for current line
reg [7:0] lineBuffer [463:0];       //buffer for color data for current line (complete line)

//reverse tile data bits
wire [31:0] reversevram32_q;
//reverse bits using assing statements
genvar i;
generate
for (i=0; i<=31; i=i+1) begin:m
    assign reversevram32_q[31-i] = vram32_q[i];
    end
endgenerate

//Write pixel data to linebuffer
always @(posedge fetchBGPaletteTable) //this is when BG tile data is available
begin
    if (CounterXdiv4 < 58 && inDisplayArea)
    begin
        if (alwaysVtilePixel[0])
        begin
            lineDataBuffer[(CounterXdiv4 <<3) + 0] <= {reversevram32_q[17:16]};
            lineDataBuffer[(CounterXdiv4 <<3) + 1] <= {reversevram32_q[19:18]};
            lineDataBuffer[(CounterXdiv4 <<3) + 2] <= {reversevram32_q[21:20]};
            lineDataBuffer[(CounterXdiv4 <<3) + 3] <= {reversevram32_q[23:22]};
            lineDataBuffer[(CounterXdiv4 <<3) + 4] <= {reversevram32_q[25:24]};
            lineDataBuffer[(CounterXdiv4 <<3) + 5] <= {reversevram32_q[27:26]};
            lineDataBuffer[(CounterXdiv4 <<3) + 6] <= {reversevram32_q[29:28]};
            lineDataBuffer[(CounterXdiv4 <<3) + 7] <= {reversevram32_q[31:30]};
        end
        else
        begin
            lineDataBuffer[(CounterXdiv4 <<3) + 0] <= {reversevram32_q[1:0]};
            lineDataBuffer[(CounterXdiv4 <<3) + 1] <= {reversevram32_q[3:2]};
            lineDataBuffer[(CounterXdiv4 <<3) + 2] <= {reversevram32_q[5:4]};
            lineDataBuffer[(CounterXdiv4 <<3) + 3] <= {reversevram32_q[7:6]};
            lineDataBuffer[(CounterXdiv4 <<3) + 4] <= {reversevram32_q[9:8]};
            lineDataBuffer[(CounterXdiv4 <<3) + 5] <= {reversevram32_q[11:10]};
            lineDataBuffer[(CounterXdiv4 <<3) + 6] <= {reversevram32_q[13:12]};
            lineDataBuffer[(CounterXdiv4 <<3) + 7] <= {reversevram32_q[15:14]};
        end
    end

end

//Apply color data to linebuffer, store in new buffer
integer j;
always @(negedge fetchBGnameTable)
begin
    if (CounterXdiv4 > 0 && CounterXdiv4 < 59 && inDisplayArea)
    begin

        for (j = 0; j < 8; j = j +1)
        begin
            if (lineDataBuffer[(CounterXdiv4-1 <<3) + j] == 2'b11)
                lineBuffer[(CounterXdiv4-1 <<3) + j] <= vram32_q[ 7: 0];

            else 
            if (lineDataBuffer[(CounterXdiv4-1 <<3) + j] == 2'b10)
                lineBuffer[(CounterXdiv4-1 <<3) + j] <= vram32_q[15: 8];

            else 
            if (lineDataBuffer[(CounterXdiv4-1 <<3) + j] == 2'b01)
                lineBuffer[(CounterXdiv4-1 <<3) + j] <= vram32_q[23:16];

            else 
            if (lineDataBuffer[(CounterXdiv4-1 <<3) + j] == 2'b00)
                lineBuffer[(CounterXdiv4-1 <<3) + j] <= vram32_q[31:24];
        end
    end
    
end



//COUNTERS FOR CURRENT POSITION ON SCREEN
wire [12:0] currentTile; //current tile the pixel_clk is on

wire ontile_h; //when pixel clock horizontally on a tile
wire ontile_v; //when pixel clock vertically on a tile
wire ontile, ondoubletile; //when pixel clock is on a tile
wire [9:0] currentHpixel, currentVpixel; //current horizontal/vertical pixel the pixel_clk is on
wire [9:0] currentHtile, currentVtile; //current horiontal/vertical tile the pixel_clk is on
wire [2:0] currentHtilePixel; //current horizontal pixel in current tile
wire [2:0] currentVtilePixel; //current vertical pixel in current tile
wire tileClock; //pulse at start of tile

assign ontile_h = (CounterX >= (HDAT_BEGIN) && CounterX < (HDAT_BEGIN + 464)) ? 1'b1:
                 1'b0;

assign ontile_v = (CounterY >= (VDAT_BEGIN) && CounterY < (VDAT_BEGIN + 272)) ? 1'b1 :
                 1'b0;

assign ontile = ontile_h && ontile_v;

assign currentHpixel = (ontile) ? CounterX - HDAT_BEGIN:
                9'd511;

assign currentVpixel = (ontile) ? (CounterY - VDAT_BEGIN):
                9'd511;

assign currentHtile = currentHpixel >> 3;
assign currentVtile = currentVpixel >> 3;

assign currentTile = (ontile) ? (currentVtile * 58) + currentHtile:
                        13'b1111111111111;

assign currentHtilePixel = currentHpixel[2:0];
assign currentVtilePixel = currentVpixel[2:0];

assign tileClock = (currentHtilePixel == 9'd0);


wire [11:0] alwaysVpixel;
wire [2:0] alwaysVtilePixel;
assign alwaysVpixel = (CounterY - VDAT_BEGIN);
assign alwaysVtilePixel = alwaysVpixel[2:0];


//COLOR DATA ASSIGNMENTS
wire [2:0]   data_R, data_G, data_B_2bit;   //color data

assign data_R = (!ontile) ? 3'b000:
                lineBuffer[(CounterX - HDAT_BEGIN)][7:5];

assign data_G = (!ontile) ? 3'b000:
                lineBuffer[(CounterX - HDAT_BEGIN)][4:2];
                //currentHtile[2:0];

assign data_B_2bit = (!ontile) ? 2'b00:
                lineBuffer[(CounterX - HDAT_BEGIN)][1:0];


assign vga_r = {data_R[2], data_R[1], data_R[1], data_R[0], data_R[0], data_R[0], data_R[0], data_R[0]};
assign vga_g = {data_G[2], data_G[1], data_G[1], data_G[0], data_G[0], data_G[0], data_G[0], data_G[0]};
assign vga_b = {data_B_2bit[1], data_B_2bit[1], data_B_2bit[0], data_B_2bit[0], data_B_2bit[0], data_B_2bit[0], data_B_2bit[0], data_B_2bit[0]};

initial
begin
    stateCounter = 2'd0;
end

endmodule