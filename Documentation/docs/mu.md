# MU
The MU, or memory unit, handles all memory access between the CPU and all the different memories used in the FPGC4. The MU makes use of a memory map so it knows from or to which memory it should read or write. The goal of the MU is to have the CPU access all memories without the having to care about the type or timing of the memory, making an easy memory interface for the CPU. This is achieved using a start signal from the CPU to the MU to indicate the start of a memory read or write, and a busy signal from the MU to the CPU which only goes high when the start signal is received, and goes low when the data is read or written. However, there is one cycle of overhead per operation on the MU.

The MU is connected to the following memories:

## SPI flash
The SPI flash contains the program of FPGC4, since it is located on a modular chip which can be easily removed and then reprogrammed by something like an Arduino. The size of the flash currently in use is 16MiB. The MU makes use of an SPI flash controller which accesses the flash chip in quad SPI mode with continuous reading for faster performance. The maximum speed without modifying the amount of dummy clocks for each read is 25MHz, which is currently the speed of most of the FPGC4, which is very convenient. Only read instructions are implemented, so no writing or erasing is possible on the FPGC4 (this is by design). Because of the SPI interface, it takes many cycles to read one 32 bit instruction. Therefore, the contents are copied to the faster SDRAM by the bootloader. While the SPI flash chip uses 8 bit addresses internally, the controller can be addressed by 32 bit words. The values of 'empty' addresses are all ones.

To test the timing system, I added a simulation model of a W25Q128JV SPI chip, which is compatible with the W25Q128BV I use in hardware. The SPI flash controller reads from this chip when a trigger occurs. When done reading it sets the recvDone signal high. Before all of this can happen, the chip has to be initialized. This is done by sending a 'reset continuous reading' command and a read command with the continuous reading bits set. This way each read does not have to start with an 8 cycle instruction. After initialization, an initDone signal is set high. When the MU gets a request from the CPU to read from SPI flash while the chip is not initialized yet, then the MU will wait until initialization is done before reading.

## SDRAM
The SDRAM is used as the main memory for the FPGC4. It has a size of 32MiB. Since it is SDRAM, it requires a controller that handles all access and refreshes. The MU contains such controller to interface with the SDRAM. During initialization, the chip is set to a CAS latency of 2 and a programmable burst length of 2 (since we have 32 bit words, and the chip uses 16 bit data). The controller also handles refreshes. To reduce the amount of latency, the MU sets its busy flag low right after the read data is available or the written data is sent to the SDRAM chip. This way the CPU does not have to wait for row closing operations to be performed. If the MU gets a request from the CPU to read from or write to SDRAM, while the SDRAM controller is busy, then the MU will wait until the SDRAM controller is ready. While the SDRAM chip uses 16 bit addresses internally, the controller can be addressed by 32 bit words. The data of the SDRAM at powerup is undefined, but probably zero.

The first addresses of the SDRAM contain the program copied from SPI flash by the bootloader. I also added a simulation model of the SDRAM to the project. The currently used SDRAM chip is the Winbond W9825G6KH-6 (an older revision uses the Micron MT48LC16M16A2 chip. I originally started with this chip and it also works. The Verilog SDRAM simulation model is even based on Micron chip).

## ROM
Internally on the FPGA, 2KiB of SRAM/Block RAM is used as ROM. It contains the bootloader of the FPGC4, which copies data from SPI flash to SDRAM, and jumps to SDRAM. This code is read only and can only be modified by reprogramming the FPGA.

## VRAM32
VRAM32 is the 32 bit wide dual port dual clock video RAM used by the CPU and the GPU. It contains the pattern table and palette table for the GPU. It is implemented using internal SRAM/Block RAM. There are two VRAM32 modules in use at the same time (the contents are duplicated), allowing the Background/Window and Sprite rendering part of GPU to access the memory at the same time. This greatly reduces the complexity of the GPU while only slightly increasing the block RAM usage.
The values of this memory at power up are all zero.

## VRAM8
VRAM8 is the 8 bit wide dual port dual clock video RAM used by the CPU and the GPU. It contains the background tile table, background color table, window tile table and window color table for the GPU. It is implemented using internal SRAM/Block RAM. The final two addresses are the horizontal tile offset and horizontal pixel offset for scrolling.
The values of this memory at power up are all zero.

## SpriteVRAM
SpriteVRAM is the 9 bit wide dual port dual clock video RAM used by the CPU and the GPU. It contains the sprite table for the GPU. It is implemented using internal SRAM/Block RAM. The memory has room for 64 sprites, where each sprite as a separate address for X position, Y position, tile index and color index+flags.
The values of this memory at power up are all zero.

## I/O
All other I/O devices are mapped to the I/O memory block. The following list describes the currently attached I/O devices.

### NESpad
A NES/SNES controller reader. Tested with both NES and SNES controllers. All button pressed states are written to a 16 bit register, and is readable from the memory map. The button values are stored on the right side of the 32 bit word.
``` text
TODO: Test the button values!!!
Button | Bit
------------------
A      | 00000000000X
B      | 0000000000X0
Sel    | 000000000X00
Start  | 00000000X000
Up     | 0000000X0000
Down   | 000000X00000
Left   | 00000X000000
Right  | 0000X0000000
X      | 000X00000000
Y      | 00X000000000
L      | 0X0000000000
R      | X00000000000
```

### PS/2 Keyboard
A PS/2 Keyboard reader. Throws an interrupt when a scan code is received. The scan code can then be read from memory. A software library is required to keep track of which button is pressed.

### OSimer
The OStimer (one stop timer) can be used to generate an interrupt after a programmable amount of time. Each timer has two memory addresses. One specifies the time in milliseconds by using a prescaler of 25000, the other address acts as a trigger if it is written to (it does not matter what value). An interrupt is raised for 16 clock cycles after the countdown has finished.

### Tone player
The tone player can play up to four notes at the same time. It generates square wave tones based on the contents written to the tone player via the memory map. Each 8 bits in the 32 bit data represents a note. Using the MidiConverter program it is possible to convert some basic MIDI's to note indexes.

### UART
Using the addresses mapped on the UART RX and UART TX modules, it is possible to communicate with devices like a PC using UART. The baud rate is always set to 115200. When a byte is received, an interrupt is triggered and the byte can be read from the memory map.

### SPI (CH376)
The SPI module is specifically made for hardware SPI mode. The chip select pin is currently unattached and should be used using GPIO pins so transferring multiple bytes per SPI transfer is possible. This module is currently attached to the CH376 USB chip for mass storage.

Using the CH376T USB controller chip over SPI, it is relatively simple to read and write files to an USB stick with a FAT partition table. It is also possible to do other things, like reading USB MIDI keyboards and HID devices. 

### GPIO
This one address on the memory map is mapped to GPIO pins on the FPGA. Only the right 16 bits are used. The left 8 of these 16 bits are read only and are the state of the 8 input ports. The right 8 of these 16 bits are the state of the 8 output ports. The output ports can also be read.
``` text
TODO: Make a list pins with bit value and in/out
```