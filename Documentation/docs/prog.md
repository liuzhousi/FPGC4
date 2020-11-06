# Programmer

!!! info "TODO"
	Update with FPGC4 flash programmer WIP option

The Programmer folder contains all files related to programming the FPGC4 and the SPI flash (ROM). 

The compileROM.sh script converts the code.list file, the file with machine instructions, to the code.bin file. The file size will be a multiple of 4096 bytes, because the SPI flash programmer expects a file of this size. Now based on the last line of compileROM.sh, you can either flash the code.bin to the SPI flash (ROM) using an Arduino with flash.sh, or send the binary over UART to the FPGC4 using uartFlasher.py.

## flash.sh
To flash the SPI flash (ROM), I use an Arduino (In my case an Teensy 2.0) and the code from https://github.com/nfd/spi-flash-programmer (Credits to Nicholas FitzRoy-Dale). 
The flash.sh script requires two arguments: the serial port of the Arduino and the filename of the binary. The script will check how long the binary file is and use python3 to send the binary to the Arduino. To verify that the flash was successful, it will read the binary from the Arduino afterwards and compare it to the file that was sent.

## uartFlasher.py
The UART flasher is used to save A LOT of time by not having to turn off the FPGC4, take out the flash module, flash it with an Arduino, put it back in the FPGC4 and turn it back on. It sends the binary to the FPGC4 with an 115200 baud rate. However, this requires the inserted flash module to contain the SPI UART bootloader. Also the FPGC4 should boot in UART mode (see the bootloader section) to prevent having to wait for many seconds. When a Serial port is opened, the FPGC4 will reset allowing for crazy fast programming without having to touch the board.

All of this works by using some fancy tricks in the SPI UART bootloader. The goal is to receive the bitstream from UART and copying it to SDRAM, starting from address 0, and jumping to address 0 after all bits are received. This gives the first problem: the bootloader should not overwrite itself, since it is also located and executed from SDRAM. Since the SPI flash is 16MiB big, we place all the copy instructions to the end of the SPI flash. The first instruction is a HALT, so the PC will always be at the instruction. All the copy instructions are executed from the UART receive interrupt. When a byte is received, it is placed on SDRAM starting from 16MiB. This way the first HALT instruction remains the same. After all bytes are copied, a timer interrupt is used to copy the SDRAM from 16MiB to 0MiB. Then, when the interrupt has ended, the PC will start from the first instruction (where the HALT used to be), which should now be the first instruction of the sent code. See UARTSPIbootloader.asm for the code (warning: large file, because of the offset).

The uartFlasher_win.py version is a special version that should be executed from Windows (for use with WSL2).

After programming the FPGC4, a Serial monitor is opened where you can send text (by typing and pressing enter) and receive text from the FPGC4. Closing the Serial monitor (by pressing Ctrl-C) does NOT reset the FPGC4, only opening a Serial port does.