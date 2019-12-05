/*
* VGA signal generator
* For different signals/resolutions, see commented out parameters
*/
module VGA(
    input               clk,         // clock
    output wire         o_hs,        // horizontal sync
    output wire         o_vs,        // vertical sync
    output wire         o_de,        // display enable: high during active video
    output wire         o_frame,     // high for one tick at the start of each frame
    output wire [11:0]  o_h,         // vertical pixel position
    output wire [11:0]  o_v          // horizontal pixel position
);

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
    
/* 1080p
    H_RES=1920,      // horizontal resolution (pixels)
    V_RES=1080,      // vertical resolution (lines)
    H_FP=88,        // horizontal front porch
    H_SYNC=44,      // horizontal sync
    H_BP=148,        // horizontal back porch
    V_FP=4,        // vertical front porch
    V_SYNC=5,       // vertical sync
    V_BP=36,        // vertical back porch
    H_POL=1,        // horizontal sync polarity (0:neg, 1:pos)
    V_POL=1;        // vertical sync polarity (0:neg, 1:pos)
*/
    
/* 720p
    H_RES=1280,      // horizontal resolution (pixels)
    V_RES=720,      // vertical resolution (lines)
    H_FP=110,        // horizontal front porch
    H_SYNC=40,      // horizontal sync
    H_BP=220,        // horizontal back porch
    V_FP=5,        // vertical front porch
    V_SYNC=5,       // vertical sync
    V_BP=20,        // vertical back porch
    H_POL=1,        // horizontal sync polarity (0:neg, 1:pos)
    V_POL=1;        // vertical sync polarity (0:neg, 1:pos)
*/

/* 480p
    H_RES=640,      // horizontal resolution (pixels)
    V_RES=480,      // vertical resolution (lines)
    H_FP=16,        // horizontal front porch
    H_SYNC=96,      // horizontal sync
    H_BP=48,        // horizontal back porch
    V_FP=11,        // vertical front porch
    V_SYNC=2,       // vertical sync
    V_BP=31,        // vertical back porch
    H_POL=0,        // horizontal sync polarity (0:neg, 1:pos)
    V_POL=0;        // vertical sync polarity (0:neg, 1:pos)
*/
    
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

reg [11:0] h_count;  // line position in pixels including blanking 
reg [11:0] v_count;  // frame position in lines including blanking 

// generate sync signals with correct polarity
assign o_hs = H_POL ? (h_count > HS_STA & h_count <= HS_END)
    : ~(h_count > HS_STA & h_count <= HS_END);
assign o_vs = V_POL ? (v_count > VS_STA & v_count <= VS_END)
    : ~(v_count > VS_STA & v_count <= VS_END);
    
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
 
always @ (posedge clk)
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

endmodule