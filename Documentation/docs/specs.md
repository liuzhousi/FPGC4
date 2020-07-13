# Specifications
These are the current specifications of the FPGC4:

- 25MHz CPU clock   
- 6.63MHz GPU clock
- 16MiB external SPI flash (QSPI with continous read mode) @ 25MHz. 32bit addresses. Used as ROM
- 32MiB SDRAM @ 25MHz. 32bit addresses. Readable and writable. Used as main memory
- ~16.4KiB VRAM (SRAM). Combination of 32, 9 and 8bit addresses (three seperate modules)
- 2KiB internal ROM for the Bootloader. 32bit addresses
- 4.125KiB Hardware Stack (SRAM). 32bit addresses
- 16 32bit registers, of which 15 are General Purpose
- 32bit instructions
- 27bit program counter for a possible address space of 0.5GiB at 32bit
- 320x240 video output (analog, RGBs) with 256 colors
- Optional (secondary) VGA output. Currently unused
- Two layers of 8x8 Tiles of which one layer has horizontal hardware scrolling support
- One Sprite layer with support for 64 Sprites. Max 16 Sprites per horizontal line (double the amount of the NES!)
- Memory mapped I/O
- Three One Shot (OS) timers
- SNES Controller support
- PS/2 Keyboard support
- UART and power over USB
- 8 GPI and 8 GPO pins
- ESP32 as APU, connected via secondary UART port.
- 16bit I2S DAC for ESP32 APU
- USB host with FAT(12/16/32) file system support using a CH376T controller over SPI
- 8 interrupts, of which 4 normal interrupts (currently attached to two OS timers, UART RX and the frameDrawn signal of the FSX2), and 4 extended interrupts (currently attached to the PS/2 controller, a third OS timer and UART2 RX (ESP32 APU))
- <1W Power draw (without USB device plugged in), so can easily be powered by a single laptop USB port, and no heatsinks/cooling is required