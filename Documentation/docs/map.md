# Memory map
The FPGC4 uses two memory maps to access all different types of memory and I/O.
One map is used by the CPU (and implemented by the MU) and the other map is used by the GPU. The GPU memory map is only useful when developing the GPU (in Verilog), so for writing code, you only need to understand the CPU memory map.

## CPU memory map
When the CPU gets a `READ`, `WRITE` or `COPY` instruction, it will use the following memory map. This means that, for example, reading from address `0xC02622` will read the button states of the (S)NES controller, and writing to address `0xC0041F` will write an entry in the Palette Table for the GPU.
The memory map is not really ordered that well (like how Sprite VRAM is between two I/O blocks). This is because I added and removed certain things while developing this project, and 'sorting' it would force me to change addresses in code I already wrote.

``` text
$000000 +------------------------+ 
        |                        | 
        |         SDRAM          | 
        |                        | $7FFFFF 
$800000 +------------------------+ 
        |                        | 
        |       SPI FLASH        | 
        |                        | $BFFFFF 
$C00000 +------------------------+ 
        |                        | 
        |         VRAM32         | 
        |                        | 
        | $C00000                | 
        |     Pattern Table      | 
        |                $C003FF | 
        |                        | 
        | $C04000                | 
        |     Palette Table      | 
        |                $C0041F | 
        |                        | $C0041F 
$C00420 +------------------------+ 
        |                        | 
        |         VRAM8          | 
        |                        | 
        | $C00420                | 
        |    BG Pattern Table    | 
        |                $C00C1F | 
        |                        | 
        | $C00C20                | 
        |    BG Palette Table    | 
        |                $C0141F | 
        |                        | $C02421 
        | $C01420                | 
        |  Window Pattern Table  | 
        |                $C01C1F | 
        |                        | 
        | $C01C20                | 
        |  Window Palette Table  | 
        |                $C0241F | 
        | $C02420                | 
        |       Parameters       | 
        |                $C02421 |  
        |                        | $C02421 
$C02422 +------------------------+ 
        |                        | 
        |          ROM           | 
        |                        | $C02621
$C02622 +------------------------+ 
        |                        | 
        |          I/O           | 
        |                        |
        | NESpad         $C02622 |
        | Keyboard       $C02623 |
        | CH376_nInt     $C02624 |
        | Unused         $C02625 |
        | Timer1_val     $C02626 |
        | Timer1_ctrl    $C02627 |
        | Timer2_val     $C02628 |
        | Timer2_ctrl    $C02629 |
        | Timer3_val     $C0262A |
        | Timer3_ctrl    $C0262B |
        | Unused         $C0262C |
        | Unused         $C0262D |
        | UART tx        $C0262E |
        | UART rx        $C0262F |
        | GPIO           $C02630 |
        | SPI (CH376T)   $C02631 |
        |                        |
        |                        | $C02631 
$C02632 +------------------------+ 
        |                        |
        |       SpriteVRAM       |
        |                        | $C02731 
        +------------------------+ 
$C02732 |                        |
        |          I/O           |
        |                        |
        | UART2 tx (APU) $C02732 |
        | UART2 rx (APU) $C02733 |
        | SPI2 (W5500)   $C02734 |
        | SPI3 (FLASH)   $C02735 |
        | SPI3_Enable    $C02736 |
        +------------------------+ $C02736

```

## GPU memory map
This memory map is only used in the GPU. These are basically the content read from the GPU port of VRAM. This map is only internal to the GPU hardware, and should not be used when writing code (use the CPU memory map instead for this!). This map is only useful when making modifications to the GPU in Verilog (for example when adding VGA rendering)
``` text
VRAM32
$000  +------------------------+ 
      |                        | 
      |     Pattern Table      | 
      |                        | $3FF
$400  +------------------------+ 
      |                        |
      |     Palette Table      |
      |                        | $41F
      +------------------------+


VRAM8
$000  +------------------------+
      |                        | 
      |     BG Tile Table      | 
      |                        | $7FF
$800  +------------------------+ 
      |                        |
      |     BG Color Table     |
      |                        | $FFF
$1000 +------------------------+
      |                        | 
      |   Window Tile Table    | 
      |                        | $17FF
$1800 +------------------------+ 
      |                        |
      |   Window Color Table   |
      |                        | $1FFF
$2000 +------------------------+
      |                        |
      |       Parameters       |
      |                        | $2001
      +------------------------+

SpriteVRAM
$000  +------------------------+
      |                        | 
      |    %0: X pos           | 
      |    %1: Y pos           | 
      |    %2: Tile            | 
      |    %3: Palette+flags   | 
      |                        | $FF
      +------------------------+ 
```