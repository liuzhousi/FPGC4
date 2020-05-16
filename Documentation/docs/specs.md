# Specifications
These are the current specifications of the FPGC4:

- 25MHz CPU clock   
- 6.63MHz GPU clock
- 16MiB external SPI flash (QSPI with continous read mode) @ 25MHz. 32bit addresses. Used as ROM
- 32MiB SDRAM @ 25MHz. 32bit addresses. Readable and writable. Used as main memory
- ~16.4KiB VRAM (SRAM). Combination of 32, 9 and 8bit addresses
- 2KiB internal ROM for the Bootloader. 32bit addresses
- 4.125KiB Hardware Stack (SRAM). 32bit addresses
- 16 32bit registers, of which 15 are General Purpose
- 32bit instructions
- 27bit program counter for a possible address space of 0.5GiB at 32bit
- 320x240 video with 256 colors
- Two layers of 8x8 Tiles of which one layer has horizontal hardware scrolling support
- One Sprite layer with support for 64 Sprites. Max 16 Sprites per horizontal line
- Video rendered over RGBs signal for CRT TV's over 'RGB SCART'
- Optional (secondary) VGA output. Currently unused
- Memory mapped I/O
- Three One Shot (OS) timers
- SNES Controller support
- PS/2 Keyboard support
- UART and power over USB
- 8 GPI and 8 GPO pins
- USB host with file system using a CH376T controller
- 2 Square wave tone generators with each 4 tones
- 8 interrupts, of which 4 normal interrupts (currently attached to two OS timers, UART RX and the frameDrawn signal of the FSX2), and 4 extended interrupts (currently attached to the PS/2 controller and a third OS timer)
- 0.7W Power draw (without USB device plugged in), so can easily be powered by a single laptop USB port