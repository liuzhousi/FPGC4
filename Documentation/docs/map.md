# Memory map
There are two different memory maps. One for the CPU and one for the GPU.

## CPU memory map
This memory map is used when the CPU accesses memory

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
        | Unused1        $C02624 |
        | Unused2        $C02625 |
        | Timer1_val     $C02626 |
        | Timer1_ctrl    $C02627 |
        | Timer2_val     $C02628 |
        | Timer2_ctrl    $C02629 |
        | Timer3_val     $C0262A |
        | Timer3_ctrl    $C0262B |
        | TonePlayer1    $C0262C |
        | TonePlayer2    $C0262D |
        | UART tx        $C0262E |
        | UART rx        $C0262F |
        | GPIO           $C02630 |
        | SPI (CH376s)   $C02631 |
        |                        |
        |                        | $C02631 
$C02632 +------------------------+ 
        |                        | 
        |       SpriteVRAM       |   
        |                        | $C02731 
        +------------------------+ 

```

## GPU memory map
This memory map is only used in the GPU
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