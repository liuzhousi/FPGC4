/*
* Graphical processor (Frame Synthesizer)
* Generates video from VRAM
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
    output [13:0]       vram32_addr,
    input  [31:0]       vram32_q, 

    //VRAM8
    output [13:0]       vram8_addr,
    input  [7:0]        vram8_q,

    //Interrupt signal
    output wire         frameDrawn
);
assign vga_blk = 1'b1;

//DISPLAY SIGNAL GENERATION
parameter
    H_RES=480,      // horizontal resolution (pixels)
    V_RES=272,      // vertical resolution (lines)
    H_FP=2,        // horizontal front porch
    H_SYNC=41,      // horizontal sync
    H_BP=2,        // horizontal back porch
    V_FP=2,        // vertical front porch
    V_SYNC=10,       // vertical sync
    V_BP=2,        // vertical back porch
    H_POL=0,        // horizontal sync polarity (0:neg, 1:pos)
    V_POL=0;        // vertical sync polarity (0:neg, 1:pos)
    
// Horizontal: sync, active, and pixels
localparam HS_STA = H_FP - 1;           // sync start (first pixel is 0)
localparam HS_END = HS_STA + H_SYNC;    // sync end
localparam HA_STA = HS_END + H_BP;      // active start
localparam HA_END = HA_STA + H_RES;     // active end 
localparam LINE   = HA_END;             // line pixels 

// Vertical: sync, active, and pixels
localparam VS_STA = V_FP - 1;           // sync start (first line is 0)
localparam VS_END = VS_STA + V_SYNC;    // sync end
localparam VA_STA = VS_END + V_BP;      // active start
localparam VA_END = VA_STA + V_RES;     // active end 
localparam FRAME  = VA_END;             // frame lines 

reg [9:0] h_count;  // line position in pixels including blanking 
reg [8:0] v_count;  // frame position in lines including blanking 

wire o_hs, o_vs, o_de, o_h, o_v, o_frame;

// generate sync signals with correct polarity
assign o_hs = H_POL ? (h_count > HS_STA & h_count <= HS_END)
    : ~(h_count > HS_STA & h_count <= HS_END);
assign vga_hs = o_hs;
assign o_vs = V_POL ? (v_count > VS_STA & v_count <= VS_END)
    : ~(v_count > VS_STA & v_count <= VS_END);
assign vga_vs = o_vs;
    
// display enable: high during active period
assign o_de = h_count > HA_STA & h_count <= HA_END
    & v_count > VA_STA & v_count <= VA_END; 

// keep o_h and o_v bound within active pixels
assign o_h = (o_de & h_count > HA_STA & h_count <= HA_END) ? 
                h_count - (HA_STA + 1): 0;
assign o_v = (o_de & v_count > VA_STA & v_count <= VA_END) ? 
                v_count - (VA_STA + 1): 0;

// o_frame: high for one tick at the start of each frame
assign o_frame = (v_count == 0 & h_count == 0);
 
always @ (posedge vga_clk)
begin
    if (h_count == LINE)  // end of line
    begin
         h_count <= 0;
         if (v_count == FRAME) // end of frame
         begin      
              v_count <= 0;
         end
         else
              v_count <= v_count + 1;
    end
    else 
         h_count <= h_count + 1;
end

initial begin
    h_count = 12'd0;
    v_count = 12'd0;
end

//FRAME TO PICTURE IN SIMULATION
/*
integer file;
integer framecounter = "0";
always @(negedge vga_vs)
begin
    file = $fopen({"/home/bart/Documents/FPGA/FPGC4/Verilog/output/frame",framecounter,".ppm"}, "w");
    $fwrite(file, "P3\n");
    $fwrite(file, "480 272\n");
    $fwrite(file, "7\n");
    framecounter = framecounter + 1;
end

always @(posedge vga_clk)
begin
    if (o_de)
    begin
        $fwrite(file, "%d  %d  %d\n", vga_r, vga_g, {1'b1, vga_b});
    end
end
*/
//RENDERING
reg [5:0] XtileOffset;
reg [2:0] XfineOffset;

initial
begin
    XtileOffset <= 6'd0;
    XfineOffset <= 3'd0;
end

assign frameDrawn = (v_tile == 32);


wire [8:0] v_count_visible;
assign v_count_visible = v_count - V_FP - V_SYNC - V_BP - 8; //-8 because we skip the first line

wire [9:0] h_count_visible;
assign h_count_visible = h_count - H_FP - H_SYNC - H_BP + XfineOffset; //+XfineOffset for fine scrolling

wire [9:0] h_count_visible_noscroll;
assign h_count_visible_noscroll = h_count - H_FP - H_SYNC - H_BP;

wire [5:0] h_tile;
assign h_tile = (h_count_visible / 8)  + XtileOffset;

wire [5:0] h_tile_noscroll;
assign h_tile_noscroll = (h_count_visible_noscroll / 8);

wire [5:0] v_tile;
assign v_tile = v_count_visible / 8;

wire [2:0] h_tile_pixel;
assign h_tile_pixel = h_count_visible[2:0];

wire [2:0] h_tile_pixel_noscroll;
assign h_tile_pixel_noscroll = h_count_visible_noscroll[2:0];

wire [2:0] v_tile_pixel;
assign v_tile_pixel = v_count_visible[2:0];

wire [10:0] tile;
assign tile = (v_tile * (512/8)) + h_tile; //512, because this gives us room for scrolling

wire [10:0] tile_noscroll;
assign tile_noscroll = (v_tile * (H_RES/8)) + h_tile_noscroll;

wire [5:0] h_tile_next;
assign h_tile_next = ((h_count - H_FP - H_SYNC - H_BP + XfineOffset + 8) / 8)  + XtileOffset;

wire [5:0] h_tile_next_noscroll;
assign h_tile_next_noscroll = ((h_count - H_FP - H_SYNC - H_BP + 8) / 8);

wire [5:0] h_tile_next_noscroll2;
assign h_tile_next_noscroll2 = (h_count < 40) ?  0:
                            h_tile_next_noscroll;

wire [10:0] tile_next;
assign tile_next = (v_tile * (512/8)) + h_tile_next; //512, because this gives us room for scrolling

wire [10:0] tile_next_noscroll;
assign tile_next_noscroll = (v_tile * (H_RES/8)) + h_tile_next_noscroll;

wire [10:0] tile_next_noscroll2;
assign tile_next_noscroll2 = (v_tile * (H_RES/8)) + h_tile_next_noscroll2;

parameter
    fetch_bg_tile       = 0,
    fetch_pattern_bg    = 1,
    fetch_bg_color      = 2,
    fetch_palette_bg    = 3,

    fetch_wind_tile     = 4,
    fetch_pattern_wind  = 5,
    fetch_wind_color    = 6,
    fetch_palette_wind  = 7;

/*
8 cycles per tile:
 1. fetch bg tile table address with next tile
 2. fetch pattern table with tile id from 1
 3. fetch bg color table address with next tile
 4. fetch palette table with palette id from 3
 5. fetch window tile table address with next tile
 6. fetch pattern table with tile id from 5
 7. fetch window color table
 8. fetch palette table with palette id from 7
*/
wire [2:0] fetchState;
assign fetchState = (h_tile_pixel == 0) ? fetch_bg_tile:
                    (h_tile_pixel == 1) ? fetch_pattern_bg:
                    (h_tile_pixel == 2) ? fetch_bg_color:
                    (h_tile_pixel == 3) ? fetch_palette_bg:
                    (h_tile_pixel == 4) ? fetch_wind_tile:
                    (h_tile_pixel == 5) ? fetch_pattern_wind:
                    (h_tile_pixel == 6) ? fetch_wind_color:
                    (h_tile_pixel == 7) ? fetch_palette_wind:
                    0;

reg [2:0] fetchStateOffset;
reg [2:0] fetchStateOffset_noscroll;
always @(negedge vga_clk)
begin
    fetchStateOffset <= fetchState;
    fetchStateOffset_noscroll <= fetchState - XfineOffset;
end

reg [7:0] tile_index;
reg [15:0] pattern_bg_tile;
reg [15:0] pattern_wind_tile;
reg [7:0] color_index;
reg [31:0] palette;



reg [63:0] rendered_bg_tile_next;
reg [63:0] rendered_bg_tile;

wire [2:0] data_bg_r, data_bg_g;
wire [1:0] data_bg_b;
assign data_bg_r = (h_tile_pixel == 0) ? rendered_bg_tile[0*8 +7: 0*8 +5]:
                (h_tile_pixel == 1) ? rendered_bg_tile[1*8 +7: 1*8 +5]:
                (h_tile_pixel == 2) ? rendered_bg_tile[2*8 +7: 2*8 +5]:
                (h_tile_pixel == 3) ? rendered_bg_tile[3*8 +7: 3*8 +5]:
                (h_tile_pixel == 4) ? rendered_bg_tile[4*8 +7: 4*8 +5]:
                (h_tile_pixel == 5) ? rendered_bg_tile[5*8 +7: 5*8 +5]:
                (h_tile_pixel == 6) ? rendered_bg_tile[6*8 +7: 6*8 +5]:
                (h_tile_pixel == 7) ? rendered_bg_tile[7*8 +7: 7*8 +5]:
            3'd0;

assign data_bg_g = (h_tile_pixel == 0) ? rendered_bg_tile[0*8 +4: 0*8 +2]:
                (h_tile_pixel == 1) ? rendered_bg_tile[1*8 +4: 1*8 +2]:
                (h_tile_pixel == 2) ? rendered_bg_tile[2*8 +4: 2*8 +2]:
                (h_tile_pixel == 3) ? rendered_bg_tile[3*8 +4: 3*8 +2]:
                (h_tile_pixel == 4) ? rendered_bg_tile[4*8 +4: 4*8 +2]:
                (h_tile_pixel == 5) ? rendered_bg_tile[5*8 +4: 5*8 +2]:
                (h_tile_pixel == 6) ? rendered_bg_tile[6*8 +4: 6*8 +2]:
                (h_tile_pixel == 7) ? rendered_bg_tile[7*8 +4: 7*8 +2]:
            3'd0;

assign data_bg_b = (h_tile_pixel == 0) ? rendered_bg_tile[0*8 +1: 0*8 +0]:
                (h_tile_pixel == 1) ? rendered_bg_tile[1*8 +1: 1*8 +0]:
                (h_tile_pixel == 2) ? rendered_bg_tile[2*8 +1: 2*8 +0]:
                (h_tile_pixel == 3) ? rendered_bg_tile[3*8 +1: 3*8 +0]:
                (h_tile_pixel == 4) ? rendered_bg_tile[4*8 +1: 4*8 +0]:
                (h_tile_pixel == 5) ? rendered_bg_tile[5*8 +1: 5*8 +0]:
                (h_tile_pixel == 6) ? rendered_bg_tile[6*8 +1: 6*8 +0]:
                (h_tile_pixel == 7) ? rendered_bg_tile[7*8 +1: 7*8 +0]:
            2'd0;

reg [63:0] rendered_wind_tile_next;
reg [63:0] rendered_wind_tile;

wire [2:0] data_wind_r, data_wind_g;
wire [1:0] data_wind_b;
assign data_wind_r = (h_tile_pixel_noscroll == 0) ? rendered_wind_tile[0*8 +7: 0*8 +5]:
                (h_tile_pixel_noscroll == 1) ? rendered_wind_tile[1*8 +7: 1*8 +5]:
                (h_tile_pixel_noscroll == 2) ? rendered_wind_tile[2*8 +7: 2*8 +5]:
                (h_tile_pixel_noscroll == 3) ? rendered_wind_tile[3*8 +7: 3*8 +5]:
                (h_tile_pixel_noscroll == 4) ? rendered_wind_tile[4*8 +7: 4*8 +5]:
                (h_tile_pixel_noscroll == 5) ? rendered_wind_tile[5*8 +7: 5*8 +5]:
                (h_tile_pixel_noscroll == 6) ? rendered_wind_tile[6*8 +7: 6*8 +5]:
                (h_tile_pixel_noscroll == 7) ? rendered_wind_tile[7*8 +7: 7*8 +5]:
            3'd0;

assign data_wind_g = (h_tile_pixel_noscroll == 0) ? rendered_wind_tile[0*8 +4: 0*8 +2]:
                (h_tile_pixel_noscroll == 1) ? rendered_wind_tile[1*8 +4: 1*8 +2]:
                (h_tile_pixel_noscroll == 2) ? rendered_wind_tile[2*8 +4: 2*8 +2]:
                (h_tile_pixel_noscroll == 3) ? rendered_wind_tile[3*8 +4: 3*8 +2]:
                (h_tile_pixel_noscroll == 4) ? rendered_wind_tile[4*8 +4: 4*8 +2]:
                (h_tile_pixel_noscroll == 5) ? rendered_wind_tile[5*8 +4: 5*8 +2]:
                (h_tile_pixel_noscroll == 6) ? rendered_wind_tile[6*8 +4: 6*8 +2]:
                (h_tile_pixel_noscroll == 7) ? rendered_wind_tile[7*8 +4: 7*8 +2]:
            3'd0;

assign data_wind_b = (h_tile_pixel_noscroll == 0) ? rendered_wind_tile[0*8 +1: 0*8 +0]:
                (h_tile_pixel_noscroll == 1) ? rendered_wind_tile[1*8 +1: 1*8 +0]:
                (h_tile_pixel_noscroll == 2) ? rendered_wind_tile[2*8 +1: 2*8 +0]:
                (h_tile_pixel_noscroll == 3) ? rendered_wind_tile[3*8 +1: 3*8 +0]:
                (h_tile_pixel_noscroll == 4) ? rendered_wind_tile[4*8 +1: 4*8 +0]:
                (h_tile_pixel_noscroll == 5) ? rendered_wind_tile[5*8 +1: 5*8 +0]:
                (h_tile_pixel_noscroll == 6) ? rendered_wind_tile[6*8 +1: 6*8 +0]:
                (h_tile_pixel_noscroll == 7) ? rendered_wind_tile[7*8 +1: 7*8 +0]:
            2'd0;

initial
begin
    fetchStateOffset = 0;
    fetchStateOffset_noscroll = 0;
    tile_index = 0;
    pattern_bg_tile = 0;
    pattern_wind_tile = 0;
    color_index = 0;
    palette = 0;
    rendered_bg_tile = 0;
    rendered_bg_tile_next = 0;
    rendered_wind_tile = 0;
    rendered_wind_tile_next = 0;
end

//For reversing the tile data
wire [31:0] vram32_q_reverse;
genvar i;
generate
for (i=0; i<=31; i=i+1) begin:m
    assign vram32_q_reverse[31-i] = vram32_q[i];
    end
endgenerate

always @(posedge vga_clk)
begin
    if (!vga_vs && !vga_hs) //this is when we want to fetch the gpu parameters from vram8
    begin
        case (fetchStateOffset)
            fetch_bg_tile:      begin
                                    XtileOffset <= vram8_q;
                                end
            fetch_pattern_bg:  begin
                                    XfineOffset <= vram8_q;
                                end
        endcase
    end
    else 
    begin
        if (fetchStateOffset_noscroll == fetch_palette_wind)
        begin
            rendered_wind_tile <= rendered_wind_tile_next;
        end

        case (fetchStateOffset)
        fetch_bg_tile:      begin
                                tile_index <= vram8_q;
                            end
        fetch_pattern_bg:   begin //bg pattern is in vram32_q
                                //odd lines use right side of pattern
                                if (v_tile_pixel[0] == 1)
                                    pattern_bg_tile <= vram32_q_reverse[31:16];
                                else
                                    pattern_bg_tile <= vram32_q_reverse[15:0];
                            end
        fetch_bg_color:     begin 
                                color_index <= vram8_q;
                            end
        fetch_palette_bg:   begin //bg palette is in vram32_q
                                palette <= vram32_q;
                                case (pattern_bg_tile[1:0])
                                    2'b00: rendered_bg_tile_next[7:0] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[7:0] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[7:0] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[7:0] <= vram32_q[7:0];
                                endcase
                                case (pattern_bg_tile[3:2])
                                    2'b00: rendered_bg_tile_next[15:8] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[15:8] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[15:8] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[15:8] <= vram32_q[7:0];
                                endcase
                                case (pattern_bg_tile[5:4])
                                    2'b00: rendered_bg_tile_next[23:16] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[23:16] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[23:16] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[23:16] <= vram32_q[7:0];
                                endcase
                                case (pattern_bg_tile[7:6])
                                    2'b00: rendered_bg_tile_next[31:24] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[31:24] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[31:24] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[31:24] <= vram32_q[7:0];
                                endcase
                                case (pattern_bg_tile[9:8])
                                    2'b00: rendered_bg_tile_next[39:32] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[39:32] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[39:32] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[39:32] <= vram32_q[7:0];
                                endcase
                                case (pattern_bg_tile[11:10])
                                    2'b00: rendered_bg_tile_next[47:40] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[47:40] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[47:40] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[47:40] <= vram32_q[7:0];
                                endcase
                                case (pattern_bg_tile[13:12])
                                    2'b00: rendered_bg_tile_next[55:48] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[55:48] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[55:48] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[55:48] <= vram32_q[7:0];
                                endcase
                                case (pattern_bg_tile[15:14])
                                    2'b00: rendered_bg_tile_next[63:56] <= vram32_q[31:24];
                                    2'b01: rendered_bg_tile_next[63:56] <= vram32_q[23:16];
                                    2'b10: rendered_bg_tile_next[63:56] <= vram32_q[15:8];
                                    2'b11: rendered_bg_tile_next[63:56] <= vram32_q[7:0];
                                endcase
                            end
        fetch_wind_tile:    begin
                                tile_index <= vram8_q;
                            end
        fetch_pattern_wind: begin //wind pattern is in vram32_q
                                //odd lines use right side of pattern
                                if (v_tile_pixel[0] == 1)
                                    pattern_wind_tile <= vram32_q_reverse[31:16];
                                else
                                    pattern_wind_tile <= vram32_q_reverse[15:0];
                            end
        fetch_wind_color:   begin
                                color_index <= vram8_q;
                            end
        fetch_palette_wind: begin //wind palette is in vram32_q (might have to write to rendered_tile here)
                                palette <= vram32_q;
                                rendered_bg_tile <= rendered_bg_tile_next;
                                if (XfineOffset == 0)
                                begin
                                    case (pattern_wind_tile[1:0])
                                        2'b00: rendered_wind_tile[7:0] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[7:0] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[7:0] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[7:0] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[3:2])
                                        2'b00: rendered_wind_tile[15:8] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[15:8] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[15:8] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[15:8] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[5:4])
                                        2'b00: rendered_wind_tile[23:16] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[23:16] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[23:16] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[23:16] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[7:6])
                                        2'b00: rendered_wind_tile[31:24] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[31:24] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[31:24] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[31:24] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[9:8])
                                        2'b00: rendered_wind_tile[39:32] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[39:32] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[39:32] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[39:32] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[11:10])
                                        2'b00: rendered_wind_tile[47:40] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[47:40] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[47:40] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[47:40] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[13:12])
                                        2'b00: rendered_wind_tile[55:48] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[55:48] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[55:48] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[55:48] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[15:14])
                                        2'b00: rendered_wind_tile[63:56] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile[63:56] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile[63:56] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile[63:56] <= vram32_q[7:0];
                                    endcase
                                end
                                else 
                                begin
                                    case (pattern_wind_tile[1:0])
                                        2'b00: rendered_wind_tile_next[7:0] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[7:0] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[7:0] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[7:0] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[3:2])
                                        2'b00: rendered_wind_tile_next[15:8] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[15:8] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[15:8] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[15:8] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[5:4])
                                        2'b00: rendered_wind_tile_next[23:16] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[23:16] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[23:16] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[23:16] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[7:6])
                                        2'b00: rendered_wind_tile_next[31:24] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[31:24] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[31:24] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[31:24] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[9:8])
                                        2'b00: rendered_wind_tile_next[39:32] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[39:32] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[39:32] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[39:32] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[11:10])
                                        2'b00: rendered_wind_tile_next[47:40] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[47:40] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[47:40] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[47:40] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[13:12])
                                        2'b00: rendered_wind_tile_next[55:48] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[55:48] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[55:48] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[55:48] <= vram32_q[7:0];
                                    endcase
                                    case (pattern_wind_tile[15:14])
                                        2'b00: rendered_wind_tile_next[63:56] <= vram32_q[31:24];
                                        2'b01: rendered_wind_tile_next[63:56] <= vram32_q[23:16];
                                        2'b10: rendered_wind_tile_next[63:56] <= vram32_q[15:8];
                                        2'b11: rendered_wind_tile_next[63:56] <= vram32_q[7:0];
                                    endcase
                                end
                                
                            end
        endcase
    end
    
end

assign vram8_addr = ((!vga_vs && !vga_hs) && fetchState == fetch_bg_tile) ? 8192:
                    ((!vga_vs && !vga_hs) && fetchState == fetch_pattern_bg) ? 8193:
                    (fetchState == fetch_bg_tile) ? tile_next:
                    (fetchState == fetch_bg_color) ? 2048 + tile_next:
                    (fetchState == fetch_wind_tile && XfineOffset <= 4) ? 4096 + tile_next_noscroll2:
                    (fetchState == fetch_wind_tile && XfineOffset > 4 && h_tile_next_noscroll2 != 0) ? 4096 + tile_next_noscroll2 + 1:
                    (fetchState == fetch_wind_tile && XfineOffset > 4 && h_tile_next_noscroll2 == 0 && h_tile_next_noscroll == 0) ? 4096 + tile_next_noscroll2 + 1:
                    (fetchState == fetch_wind_tile && XfineOffset > 4 && h_tile_next_noscroll2 == 0 && h_tile_next_noscroll != 0) ? 4096 + tile_next_noscroll2:
                    (fetchState == fetch_wind_color && XfineOffset <= 4) ? 6144 + tile_next_noscroll2:
                    (fetchState == fetch_wind_color && XfineOffset > 4 && h_tile_next_noscroll2 != 0) ? 6144 + tile_next_noscroll2 + 1:
                    (fetchState == fetch_wind_color && XfineOffset > 4 && h_tile_next_noscroll2 == 0 && h_tile_next_noscroll == 0) ? 6144 + tile_next_noscroll2 + 1:
                    (fetchState == fetch_wind_color && XfineOffset > 4 && h_tile_next_noscroll2 == 0 && h_tile_next_noscroll != 0) ? 6144 + tile_next_noscroll2:
                    14'd0;

assign vram32_addr = (fetchState == fetch_pattern_bg) ? (tile_index * 4) + (v_tile_pixel/2): //*4 because 4 addresses per tile
                     (fetchState == fetch_palette_bg) ? 1024 + color_index:
                     (fetchState == fetch_pattern_wind) ? (tile_index * 4) + (v_tile_pixel/2): //*4 because 4 addresses per tile
                     (fetchState == fetch_palette_wind) ? 1024 + color_index:
                    14'd0;



//BG or Window selector

wire window_drawn;
assign window_drawn = (data_wind_r != 3'd0 || data_wind_g != 3'd0 || data_wind_b != 2'd0) ? 1'b1:
                    1'b0;

assign vga_r =  (v_tile < 32 && o_de && window_drawn) ? data_wind_r: 
                (v_tile < 32 && o_de && !window_drawn) ? data_bg_r: 
                3'd0;
assign vga_g =  (v_tile < 32 && o_de && window_drawn) ? data_wind_g: 
                (v_tile < 32 && o_de && !window_drawn) ? data_bg_g: 
                3'd0;
assign vga_b =  (v_tile < 32 && o_de && window_drawn) ? data_wind_b: 
                (v_tile < 32 && o_de && !window_drawn) ? data_bg_b: 
                3'd0;

endmodule