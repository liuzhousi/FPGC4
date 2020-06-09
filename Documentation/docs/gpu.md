# GPU (FSX2)
The GPU generates a progressive 320x240@60hz RGBs signal using a pixel clock of ~6.6MHz. 

The GPU uses a tile based rendering system inspired by the NES PPU in order to prevent having to use a frame buffer and therefore save video RAM (since the FPGA only has ~64KB of SRAM/block RAM). Tile rendering works as follows:


!!! info "TODO"
	Rewrite the following text to make it more readable and understandable

For each tile, the GPU has to read the BG Tile table, Pattern table, BG Color table, Palette table, Window Tile table, Pattern table, Window Color table and Palette table (in this order) to know which color to draw.
The Pattern table allows for 256 different tiles on a single screen.
The Palette table allows for 32 different palettes per screen with four colors per palette.
Each address in the tile tables and the color tables is mapped to one tile on screen.
Two layers of tiles are rendered, the background layer which can be scrolled horizontally and the window layer, which draws on top of the background layer and does not scroll.
Aside from these tiles, the GPU also renders Sprites, which are basically just tiles which can be placed at any position (so without snapping to a grid). These are way more expensive to render and therefore have more constraints (see section Sprites).

## Background layer
The background layer consists of 512x240 pixels. They are indexed by tiles of 8x8 pixels making 64x30 tiles. The background is horizontally scrollable by using the tile offset parameter and fine offset parameter. The tile offset parameter specifies how many tiles the background has to be scrolled to the left. The fine offset parameter specifies how many pixels (ranging from 0 to 7) the background has to be scrolled to the left. The background wraps around horizontally.

## Window layer
The window layer consists of 320x240 pixels. They are indexed by tiles of 8x8 pixels making 40x30 tiles. The window is not scrollable and is rendered above the background. When a pixel is black, it will not be rendered which makes the background visible. The window is especially useful for static UI things like text, score and a life bar for example.

## Sprites
The sprite layer can consist of a maximum of 64 sprites. Only 16 of these sprites can be rendered on the same horizontal line. Each sprite has four different addresses that can be written to, with the following functions:
1. X position (9 bits)
2. Y position (8 bits)
3. Tile index (8 bits)
4. Color index (5 bits), hflip, vflip, priority, disable (all 1 bit)
hflip, vflip, priority and disable are currently not implemented.
The sprites are rendered on top of the window and background layers. When a pixel is black, it will not be rendered which makes the window or background visible. Sprites are useful for things that move per pixel on the screen independently, such as the ball in pong or a mouse cursor.


## Video timing
The timing of the video signal is as follows:
``` text
H_RES   = 320,      // horizontal resolution (pixels)
V_RES   = 240,      // vertical resolution (lines)
H_FP    = 24,       // horizontal front porch
H_SYNC  = 32,       // horizontal sync
H_BP    = 46,       // horizontal back porch
V_FP    = 3,        // vertical front porch
V_SYNC  = 5,        // vertical sync
V_BP    = 14,       // vertical back porch
H_POL   = 0,        // horizontal sync polarity (0:neg, 1:pos)
V_POL   = 0;        // vertical sync polarity

H_TOTAL = 320+24+32+46  = 422 //Horizontal total pixels
V_TOTAL = 240+3+5+14    = 262 //Vertical total lines

422 pixels * 262 lines * 60 FPS = 6.633840 MHz (6.632653MHz works fine)
```
The PLL responsible for generating the GPU clock is configured to multiply 50MHz by 13, and divide it by 98. This makes the refresh rate 59.989Hz.
Since a real CRT TV is used, and NTSC is officially 59.94Hz, this may or may not cause some issues. Though I am not sure if 60Hz or 59.94Hz would be better, since I do not use NTSC color encoding. For my relatively new Trinitron, 60Hz is not an issue.

!!! info "TODO"
	Change the pixel clock to match 59.94Hz more closely and test in hardware.