# Specifications
These are the current specifications of the FPGC4:

- 25MHz CPU clock   
- 6.63MHz GPU clock
- 16MiB SPI flash (QSPI) @ 25MHz. 32bit addresses. Read only
- 32MiB SDRAM @ 25MHz. 32bit addresses. Readable and writable, used as main memory
- ~16.4KiB VRAM (SRAM). Combination of 32, 9 and 8bit addresses
- 2KiB ROM as bootloader. 32bit addresses
- 4.125KiB Stack. 32bit addresses
- 16 32bit registers
- 32bit instructions
- 27bit program counter, for a possible address space of 0.5GiB at 32bit
- 320x240 video with 256 colors using 8x8 tiles
- Video rendered over RGBs signal for CRT tv's using 'RGB scart'
- Three CTC timers, third timer currently not attached to an interrupt
- 4 interrupt pins (currently attached to two timers, UART rx and the frameDrawn signal of the FSX2), and 4 extended interrupts (currently attached to the PS/2 controller and an extra timer)
- 2 square wave tone generators with each 4 tones