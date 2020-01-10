/*
* Renders Background and Window plane
*/
module Spriterenderer
#(
    parameter H_RES = 480,      // horizontal resolution (pixels)
    parameter V_RES = 272,      // vertical resolution (lines)
    parameter H_FP  = 2,        // horizontal front porch
    parameter H_SYNC= 41,       // horizontal sync
    parameter H_BP  = 2,        // horizontal back porch
    parameter V_FP  = 2,        // vertical front porch
    parameter V_SYNC= 10,       // vertical sync
    parameter V_BP  = 2,        // vertical back porch
    parameter H_POL = 0,        // horizontal sync polarity (0:neg, 1:pos)
    parameter V_POL = 0         // vertical sync polarity (0:neg, 1:pos)
) 
(
    //VGA I/O
    input               vga_clk,            //9MHz
    input               vga_hs,
    input               vga_vs,
    output wire [2:0]   vga_r,
    output wire [2:0]   vga_g,
    output wire [1:0]   vga_b,

    input [9:0]         h_count,  // line position in pixels including blanking 
    input [8:0]         v_count,  // frame position in lines including blanking 

    input               o_hs, 
    input               o_vs, 
    input               o_de, 
    input               o_h, 
    input               o_v, 
    input               o_frame,

    //VRAM32
    output [13:0]       vram32_addr,
    input  [31:0]       vram32_q, 

    //TODO
    //Sprite register addresses

    //Draw pixel signal
    output wire         draw_sprite,
    output wire         draw_behind_bg
);

//x:        9b
//y:        8b
//tile:     8b
//palette:  5b
//hflip:    1b
//vflip:    1b
//priority: 1b
//disable : 1b
//------------ +
//         34b

//currently two sprites
reg [33:0] sprites [0:1];

initial
begin
    sprites[1] = 34'b000001000_00001000_00000001_00000_0_0_0_0;
    sprites[0] = 34'b000000100_00000100_00000001_00001_0_0_0_0;
end

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


// counters for tile and position
wire [8:0] v_count_visible;
assign v_count_visible = v_count - V_FP - V_SYNC - V_BP - 8; //-8 because we skip the first line

wire [9:0] h_count_visible;
assign h_count_visible = h_count - H_FP - H_SYNC - H_BP;

wire [5:0] h_tile;
assign h_tile = (h_count_visible / 8);

wire [5:0] v_tile;
assign v_tile = v_count_visible / 8;

wire [2:0] h_tile_pixel;
assign h_tile_pixel = h_count_visible[2:0];

wire [2:0] v_tile_pixel;
assign v_tile_pixel = v_count_visible[2:0];

wire [10:0] tile;
assign tile = (v_tile * (H_RES/8)) + h_tile;

wire [5:0] h_tile_next;
assign h_tile_next = ((h_count - H_FP - H_SYNC - H_BP + 8) / 8);

wire [10:0] tile_next;
assign tile_next = (v_tile * (H_RES/8)) + h_tile_next;


wire [3:0] sprite0Vpixel;
assign sprite0Vpixel = (v_count_visible - sprites[0][24:17]);


reg [5:0] sprite0phase = 0;
reg [5:0] sprite0phaseOffset;

//if (((h_count - H_FP - H_SYNC - H_BP) >= sprites[0][33:25] && (h_count - H_FP - H_SYNC - H_BP) + 8 < sprites[0][33:25]) && ((v_count - V_FP - V_SYNC - V_BP - 8) >= sprites[0][24:17] && (v_count - V_FP - V_SYNC - V_BP - 8) + 8 < sprites[0][24:17]))

always @(negedge vga_clk)
begin
    sprite0phaseOffset <= sprite0phase;
end

always @(posedge vga_clk)
begin
    case (sprite0phase)

        0:  begin
                if ((h_count - H_FP - H_SYNC - H_BP + 3) == sprites[0][33:25] && v_count_visible >= sprites[0][24:17] && v_count_visible < sprites[0][24:17] + 8)
                begin
                    sprite0phase <= 1;
                end
            end

        1:  sprite0phase <= 2;
        2:  sprite0phase <= 3;
        3:  sprite0phase <= 4;
        4:  sprite0phase <= 5;
        5:  sprite0phase <= 6;
        6:  sprite0phase <= 7;
        7:  sprite0phase <= 8;
        8:  sprite0phase <= 9;
        9:  sprite0phase <= 10;
        10:  sprite0phase <= 0;
    endcase
end

//For reversing the tile data
wire [31:0] vram32_q_reverse;
genvar i;
generate
for (i=0; i<=31; i=i+1) begin:m
    assign vram32_q_reverse[31-i] = vram32_q[i];
    end
endgenerate


reg [63:0] rendered_sprite;
reg [15:0] pattern;
reg [31:0] palette;

always @(posedge vga_clk)
begin
    if (sprite0phaseOffset == 1)
    begin
        //get pattern
        if (sprite0Vpixel[0] == 1)
            pattern <= vram32_q_reverse[31:16];
        else
            pattern <= vram32_q_reverse[15:0];
    end
    if (sprite0phaseOffset == 2)
    begin
        //get color
        palette <= vram32_q;
        case (pattern[1:0])
            2'b00: rendered_sprite[7:0] <= vram32_q[31:24];
            2'b01: rendered_sprite[7:0] <= vram32_q[23:16];
            2'b10: rendered_sprite[7:0] <= vram32_q[15:8];
            2'b11: rendered_sprite[7:0] <= vram32_q[7:0];
        endcase
        case (pattern[3:2])
            2'b00: rendered_sprite[15:8] <= vram32_q[31:24];
            2'b01: rendered_sprite[15:8] <= vram32_q[23:16];
            2'b10: rendered_sprite[15:8] <= vram32_q[15:8];
            2'b11: rendered_sprite[15:8] <= vram32_q[7:0];
        endcase
        case (pattern[5:4])
            2'b00: rendered_sprite[23:16] <= vram32_q[31:24];
            2'b01: rendered_sprite[23:16] <= vram32_q[23:16];
            2'b10: rendered_sprite[23:16] <= vram32_q[15:8];
            2'b11: rendered_sprite[23:16] <= vram32_q[7:0];
        endcase
        case (pattern[7:6])
            2'b00: rendered_sprite[31:24] <= vram32_q[31:24];
            2'b01: rendered_sprite[31:24] <= vram32_q[23:16];
            2'b10: rendered_sprite[31:24] <= vram32_q[15:8];
            2'b11: rendered_sprite[31:24] <= vram32_q[7:0];
        endcase
        case (pattern[9:8])
            2'b00: rendered_sprite[39:32] <= vram32_q[31:24];
            2'b01: rendered_sprite[39:32] <= vram32_q[23:16];
            2'b10: rendered_sprite[39:32] <= vram32_q[15:8];
            2'b11: rendered_sprite[39:32] <= vram32_q[7:0];
        endcase
        case (pattern[11:10])
            2'b00: rendered_sprite[47:40] <= vram32_q[31:24];
            2'b01: rendered_sprite[47:40] <= vram32_q[23:16];
            2'b10: rendered_sprite[47:40] <= vram32_q[15:8];
            2'b11: rendered_sprite[47:40] <= vram32_q[7:0];
        endcase
        case (pattern[13:12])
            2'b00: rendered_sprite[55:48] <= vram32_q[31:24];
            2'b01: rendered_sprite[55:48] <= vram32_q[23:16];
            2'b10: rendered_sprite[55:48] <= vram32_q[15:8];
            2'b11: rendered_sprite[55:48] <= vram32_q[7:0];
        endcase
        case (pattern[15:14])
            2'b00: rendered_sprite[63:56] <= vram32_q[31:24];
            2'b01: rendered_sprite[63:56] <= vram32_q[23:16];
            2'b10: rendered_sprite[63:56] <= vram32_q[15:8];
            2'b11: rendered_sprite[63:56] <= vram32_q[7:0];
        endcase
    end
end


assign vram32_addr = (sprite0phase == 1) ? (sprites[0][16:9] * 4) + (sprite0Vpixel)/2 : // sprites[0][16:9] == tile idx, (sprites[0][24:17] - v_count_visible)/2 == vertical offset
                     (sprite0phase == 2) ? 1024 + sprites[0][8:4]:
                    14'd0;

//RENDERING
assign draw_sprite = 1'b0;
assign draw_behind_bg = 1'b0;

assign vga_r =  (sprite0phase == 3) ? rendered_sprite[0*8 +7: 0*8 +5]:
                (sprite0phase == 4) ? rendered_sprite[1*8 +7: 1*8 +5]:
                (sprite0phase == 5) ? rendered_sprite[2*8 +7: 2*8 +5]:
                (sprite0phase == 6) ? rendered_sprite[3*8 +7: 3*8 +5]:
                (sprite0phase == 7) ? rendered_sprite[4*8 +7: 4*8 +5]:
                (sprite0phase == 8) ? rendered_sprite[5*8 +7: 5*8 +5]:
                (sprite0phase == 9) ? rendered_sprite[6*8 +7: 6*8 +5]:
                (sprite0phase == 10) ? rendered_sprite[7*8 +7: 7*8 +5]:
            3'd0;

assign vga_g =  (sprite0phase == 3) ? rendered_sprite[0*8 +4: 0*8 +2]:
                (sprite0phase == 4) ? rendered_sprite[1*8 +4: 1*8 +2]:
                (sprite0phase == 5) ? rendered_sprite[2*8 +4: 2*8 +2]:
                (sprite0phase == 6) ? rendered_sprite[3*8 +4: 3*8 +2]:
                (sprite0phase == 7) ? rendered_sprite[4*8 +4: 4*8 +2]:
                (sprite0phase == 8) ? rendered_sprite[5*8 +4: 5*8 +2]:
                (sprite0phase == 9) ? rendered_sprite[6*8 +4: 6*8 +2]:
                (sprite0phase == 10) ? rendered_sprite[7*8 +4: 7*8 +2]:
            3'd0;

assign vga_b =  (sprite0phase == 3) ? rendered_sprite[0*8 +1: 0*8 +0]:
                (sprite0phase == 4) ? rendered_sprite[1*8 +1: 1*8 +0]:
                (sprite0phase == 5) ? rendered_sprite[2*8 +1: 2*8 +0]:
                (sprite0phase == 6) ? rendered_sprite[3*8 +1: 3*8 +0]:
                (sprite0phase == 7) ? rendered_sprite[4*8 +1: 4*8 +0]:
                (sprite0phase == 8) ? rendered_sprite[5*8 +1: 5*8 +0]:
                (sprite0phase == 9) ? rendered_sprite[6*8 +1: 6*8 +0]:
                (sprite0phase == 10) ? rendered_sprite[7*8 +1: 7*8 +0]:
            2'd0;


endmodule