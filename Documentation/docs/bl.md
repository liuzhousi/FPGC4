# Bootloader code
The bootloader, located at the first address of the internal ROM (see memory map for the address), is the first thing that is executed by the CPU, even though it is not located at address 0. The bootloader is used to copy a program from the relatively slow SPI flash to the faster SDRAM, or to copy a UART bootloader in SDRAM to allow for a program to be sent over UART. In either case, the bootloader ends with jumping to SDRAM address 0 after clearing all registers to 0, which starts the program or UART bootloader. Since the bootloader has room for 512 words (32 bit), a POST test has been added as well. This means that at the start of the bootloader, the FPGC4 logo is printed on the display in the color white. When the bootloader is almost done (just before clearing the registers and jumping to address 0), the color is changed to blue/green as indication that the bootloader has finished.

!!! info "TODO"
    Change this part below when new PCB is assembled. New PCB has a dip switch to set the mode, and this variables should get its own address on the memory map, to save GPIO.

There are two modes for the bootloader:
- If GPI[0] is high (which should be by default, because of a pull-up resistor), then the bootloader will copy the UART bootloader, which is stored in the ROM as well, to SDRAM.
- If GPI[0] is low, then the bootloader will copy X addresses, where X is the number in (32 bit) address 5 of the SPI flash.

I chose to make the UART mode the default mode, since this mode is currently used >99% of the time. This will likely change when I have developed an OS. In the next PCB revision, I should use a (piano?) switch instead, and a seperate memory address to free GPIO pins.
Furthermore, all registers are reset before jumping to address 0, because the UARTbootloader has to halt in the first instruction and therefore has to assume all registers are empty (hard to explain, see UART bootloader code).
