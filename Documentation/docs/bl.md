# Bootloader code
The bootloader, located at the first address of the internal ROM (see memory map for the address), is the first thing that is executed by the CPU, even though it is not located at address 0. The bootloader is used to copy a program from the relatively slow SPI flash to the faster SDRAM, or to copy a UART bootloader in SDRAM to allow for a program to be sent over UART. In either case, the bootloader ends with jumping to SDRAM address 0 after clearing all registers to 0, which starts the program or UART bootloader. Since the bootloader has room for 512 words (32 bit) and currently only 174 words are used, I will probably add a boot screen with logo (if it fits and looks cool).

There are two modes for the bootloader:
- If GPI[0] is high (which should be by default, because of a pull-up resistor), then the bootloader will copy the UART bootloader, which is stored in the ROM as well, to SDRAM.
- If GPI[0] is low, then the bootloader will copy X addresses, where X is the number in (32 bit) address 5 of the SPI flash.

I chose to make the UART mode the default mode, since this mode is currently used >99% of the time. This will likely change when I have developed an OS. In the next PCB revision, I should use a (piano?) switch instead, and a seperate memory address to free GPIO pins.
Furthermore, all registers are reset before jumping to address 0, because the UARTbootloader has to halt in the first instruction and therefore has to assume all registers are empty (hard to explain, see UART bootloader code). The bootloader code could be space optimized by jumping to one of the two clear registers code, if needed.

<details>
<summary>The assembly code of the bootloader</summary>

``` asm
; New bootloader code with UART option, now defaults to UART
; copies SPI to SDRAM, or copies UART bootloader from ROM to SDRAM, and finally jumps to SDRAM after clearing all registers
; lines with a . in the comments indicate a change over the previous version, where the UART bootloader was stored in SPI flash instead

load 0x2630 r1
loadhi 0xC0 r1          ; r1 = GPIO address: 0xC02630
read 0 r1 r2            ; r2 = GPIO values
load 0b00000001 r3      ; r3 = bitmask for GPI[0]
and r2 r3 r3            ; r3 = GPI[0]

; if GPI[0] is high (button has pullup), then jump to UART optimized copy function
beq r0 r3 2
    jump CopyUartLoader


load 0 r1
loadhi 0x80 r1          ; r1 = address 0 of SPI: 0x800000
load 0 r2               ; r2 = address 0 of SDRAM: 0x00, and loop var
read 5 r1 r3            ; r3 = last address to copy +1, which is in line 6 of SPI code

CopyLoop:
    copy 0 r1 r2            ; copy SPI to SDRAM

    add r1 1 r1             ; incr SPI address 
    add r2 1 r2             ; incr SDRAM address

    beq r2 r3 2             ; copy is done when SDRAM address == number of lines to copy
    jump CopyLoop           ; copy is not done yet, copy next address

; clear registers
load 0 r1
load 0 r2
load 0 r3
load 0 r4
load 0 r5
load 0 r6
load 0 r7
load 0 r8
load 0 r9
load 0 r10
load 0 r11
load 0 r12
load 0 r13
load 0 r14
load 0 r15

jump 0                  ; copy is done, jump to sdram
halt                    ; should not get here, halt if we do


CopyUartLoader:

    load 0x246A r1          ; .
    loadhi 0xC0 r1          ; . r1 = address of first part of UART bootloader data in ROM: 0xC02422 + 72 = 0xC0246A
    load 0 r2               ;   r2 = address 0 of SDRAM: 0x00, and loop var
    or r0 r0 r0             ; . r3 was unused, so I set it to NOP, to not mess up existing jump addresses, since this is a mod of a compiled binary
    load 7 r4               ; . r4 = number of words to copy at the start

    CopyStartLoop:
        copy 0 r1 r2            ; copy ROM to SDRAM

        add r1 1 r1             ; incr ROM address 
        add r2 1 r2             ; incr SDRAM address

        beq r2 r4 2             ; copy is done when SDRAM address == number of words to copy at the start
        jump CopyStartLoop      ; copy is not done yet, copy next address


    load 0x2471 r1          ; .
    loadhi 0xC0 r1          ; . r1 = address of second part of UART bootloader data in ROM: 0xC02422 + 79 = 0xC02471
    load 0xDE07 r2          ; . r2 = address 4185607 of SDRAM: 0x3FDE07, and loop var
    loadhi 0x3F r2          ; .
    load 0xDE66 r3          ; . r3 = r2 + number of words to copy = 0x3FDE07 + 95 = 0x3FDE66
    loadhi 0x3F r3          ; .
    or r0 r0 r0             ; . NOP, to not mess up existing jump addresses, since this is a mod of a compiled binary

    CopyEndLoop:
        copy 0 r1 r2            ; copy ROM to SDRAM

        add r1 1 r1             ; incr ROM address 
        add r2 1 r2             ; incr SDRAM address

        beq r2 r3 2             ; copy is done when SDRAM address == number of lines to copy
        jump CopyEndLoop        ; copy is not done yet, copy next address

    ; clear registers
    load 0 r1
    load 0 r2
    load 0 r3
    load 0 r4
    load 0 r5
    load 0 r6
    load 0 r7
    load 0 r8
    load 0 r9
    load 0 r10
    load 0 r11
    load 0 r12
    load 0 r13
    load 0 r14
    load 0 r15

    jump 0                  ; copy is done, jump to sdram
    halt                    ; should not get here, halt if we do 
```

</details>


<details>
<summary>Binary code of bootloader (with comments)</summary>

``` text
01110010011000110000000000000001 //Set r1 to 0x2630     (this is address 0xC02422)
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
11100000000000000000000100000010 //Read at address in r1 with offset 0 to r2
01110000000000000001000000000011 //Set r3 to 0b00000001
00000000100000000000001000110011 //Compute r2 AND r3 and write result to r3
01100000000000000010000000110000 //If r0 == r3, then jump to offset 2
10010001100000000100100010000110 //Jump to load r1 instruction in line 34 (0xC02422 + 34 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001000110000 //If r2 == r3, then jump to offset 2
10010001100000000100100001011010 //Jump to copy instruction in line 12 (0xC02422 + 12 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000000000000000000000010 //Set r2 to 0
01110000000000000000000000000011 //Set r3 to 0
01110000000000000000000000000100 //Set r4 to 0
01110000000000000000000000000101 //Set r5 to 0
01110000000000000000000000000110 //Set r6 to 0
01110000000000000000000000000111 //Set r7 to 0
01110000000000000000000000001000 //Set r8 to 0
01110000000000000000000000001001 //Set r9 to 0
01110000000000000000000000001010 //Set r10 to 0
01110000000000000000000000001011 //Set r11 to 0
01110000000000000000000000001100 //Set r12 to 0
01110000000000000000000000001101 //Set r13 to 0
01110000000000000000000000001110 //Set r14 to 0
01110000000000000000000000001111 //Set r15 to 0
10010000000000000000000000000000 //Jump to constant address 0
11111111111111111111111111111111 //Halt
01110010010001101010000000000001 //Set r1 to 0x246A
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
01110000000000000000000000000010 //Set r2 to 0
00000000000000000000000000000000 //Compute r0 OR r0 and write result to r0
01110000000000000111000000000100 //Set r4 to 7
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001001000000 //If r2 == r4, then jump to offset 2
10010001100000000100100010010000 //Jump to copy instruction in line 39 (0xC02422 + 39 - 1)
01110010010001110001000000000001 //Set r1 to 0x2471
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
01111101111000000111000000000010 //Set r2 to 0xDE07
01110000000000111111000100000010 //Set highest 16 bits of r2 to 0x3F
01111101111001100110000000000011 //Set r3 to 0xDE66
01110000000000111111000100000011 //Set highest 16 bits of r3 to 0x3F
00000000000000000000000000000000 //Compute r0 OR r0 and write result to r0
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001000110000 //If r2 == r3, then jump to offset 2
10010001100000000100100010101000 //Jump to copy instruction in line 51 (0xC02422 + 51 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000000000000000000000010 //Set r2 to 0
01110000000000000000000000000011 //Set r3 to 0
01110000000000000000000000000100 //Set r4 to 0
01110000000000000000000000000101 //Set r5 to 0
01110000000000000000000000000110 //Set r6 to 0
01110000000000000000000000000111 //Set r7 to 0
01110000000000000000000000001000 //Set r8 to 0
01110000000000000000000000001001 //Set r9 to 0
01110000000000000000000000001010 //Set r10 to 0
01110000000000000000000000001011 //Set r11 to 0
01110000000000000000000000001100 //Set r12 to 0
01110000000000000000000000001101 //Set r13 to 0
01110000000000000000000000001110 //Set r14 to 0
01110000000000000000000000001111 //Set r15 to 0
10010000000000000000000000000000 //Jump to constant address 0
11111111111111111111111111111111 //Halt
10010000000000000000000000001100 //Jump to constant address 6 // first part of of UART bootloader data (to SDRAM 0, 7 words long)
10010000011111111011110001001000 //Jump to constant address 4185636
10010000011111111011110001100010 //Jump to constant address 4185649
10010000011111111011110001100100 //Jump to constant address 4185650
10010000011111111011110011001010 //Jump to constant address 4185701
00000000001111111101111001100110 //Length of program
11111111111111111111111111111111 //Halt
01110010011000101110000000000001 //Set r1 to 0x262E  // second part of UART bootloader data (to SDRAM 4185607, 95 words long)
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
11100000000000000001000100000010 //Read at address in r1 with offset 1 to r2
01110000000000000000000000000100 //Set r4 to 0
01010000000000000010010011010000 //If r4 != r13, then jump to offset 2
00001010100000011000001000000010 //Compute r2 << 24 and write result to r2
01110000000000000001000000000100 //Set r4 to 1
01010000000000000010010011010000 //If r4 != r13, then jump to offset 2
00001010100000010000001000000010 //Compute r2 << 16 and write result to r2
01110000000000000010000000000100 //Set r4 to 2
01010000000000000010010011010000 //If r4 != r13, then jump to offset 2
00001010100000001000001000000010 //Compute r2 << 8 and write result to r2
01110000000000000011000000000100 //Set r4 to 3
01010000000000000010010011010000 //If r4 != r13, then jump to offset 2
00001010100000000000001000000010 //Compute r2 << 0 and write result to r2
00001001100000000001110100001101 //Compute r13 + 1 and write result to r13
00000001100000000000001011101110 //Compute r2 + r14 and write result to r14
01110000000000000100000000000100 //Set r4 to 4
01100000000000000010010011010000 //If r4 == r13, then jump to offset 2
00010000000000000000000000000000 //Return from interrupt
00001011000000011000111000000100 //Compute r14 >> 24 and write result to r4
11010000000000000000000101000000 //Write value in r4 to address in r1 with offset 0
00001011000000010000111000000100 //Compute r14 >> 16 and write result to r4
11010000000000000000000101000000 //Write value in r4 to address in r1 with offset 0
00001011000000001000111000000100 //Compute r14 >> 8 and write result to r4
11010000000000000000000101000000 //Write value in r4 to address in r1 with offset 0
00001011000000000000111000000100 //Compute r14 >> 0 and write result to r4
11010000000000000000000101000000 //Write value in r4 to address in r1 with offset 0
00010000000000000000000000000000 //Return from interrupt
01110000000000000000000000000001 //Set r1 to 0x0000
01110000000001000000000100000001 //Set highest 16 bits of r1 to 0x40
01110000000000000000000000000010 //Set r2 to 0
01110000000000000000000000000011 //Set r3 to 0
00000000000000000000001000000101 //Compute r2 OR r0 and write result to r5
00000000000000000000000100000110 //Compute r1 OR r0 and write result to r6
11000000000000000000011001010000 //Copy from address in r6 to address in r5 with offset 0
00001001100000000001010100000101 //Compute r5 + 1 and write result to r5
00001001100000000001011000000110 //Compute r6 + 1 and write result to r6
00001001100000000001001100000011 //Compute r3 + 1 and write result to r3
01100000000000000010001111100000 //If r3 == r14, then jump to offset 2
10010000011111111011110001010100 //Jump to constant address 4185642
00010000000000000000000000000000 //Return from interrupt
00010000000000000000000000000000 //Return from interrupt
01110000000000000100000000000001 //Set r1 to 4
01100000000000000010110100010000 //If r13 == r1, then jump to offset 2
10010000011111111011110000001110 //Jump to constant address 4185607
01110010011000101110000000000001 //Set r1 to 0x262E
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
11100000000000000001000100000010 //Read at address in r1 with offset 1 to r2
01110000000000000000000000000011 //Set r3 to 0
01010000000000000010001111000000 //If r3 != r12, then jump to offset 2
00001010100000011000001000000010 //Compute r2 << 24 and write result to r2
01110000000000000001000000000011 //Set r3 to 1
01010000000000000010001111000000 //If r3 != r12, then jump to offset 2
00001010100000010000001000000010 //Compute r2 << 16 and write result to r2
01110000000000000010000000000011 //Set r3 to 2
01010000000000000010001111000000 //If r3 != r12, then jump to offset 2
00001010100000001000001000000010 //Compute r2 << 8 and write result to r2
01110000000000000011000000000011 //Set r3 to 3
01010000000000000010001111000000 //If r3 != r12, then jump to offset 2
00001010100000000000001000000010 //Compute r2 << 0 and write result to r2
00001001100000000001110000001100 //Compute r12 + 1 and write result to r12
00000001100000000000001010101010 //Compute r2 + r10 and write result to r10
01110000000000000100000000000011 //Set r3 to 4
00110000000000000010110000110000 //If r12 >= r3, then jump to offset 2
00010000000000000000000000000000 //Return from interrupt
01110000000000000000000000000100 //Set r4 to 0x0000
01110000000001000000000100000100 //Set highest 16 bits of r4 to 0x40
00000001100000000000101101000100 //Compute r11 + r4 and write result to r4
11010000000000000000010010100000 //Write value in r10 to address in r4 with offset 0
00001001100000000001101100001011 //Compute r11 + 1 and write result to r11
01110000000000000000000000000001 //Set r1 to 0
01110000000000000000000000000010 //Set r2 to 0
01110000000000000000000000000011 //Set r3 to 0
01110000000000000000000000000100 //Set r4 to 0
01110000000000000000000000000101 //Set r5 to 0
01110000000000000000000000000110 //Set r6 to 0
01110000000000000000000000000111 //Set r7 to 0
01110000000000000000000000001000 //Set r8 to 0
01110000000000000000000000001001 //Set r9 to 0
01110000000000000000000000001010 //Set r10 to 0
01110000000000000000000000001100 //Set r12 to 0
01100000000000000010101111100000 //If r11 == r14, then jump to offset 2
00010000000000000000000000000000 //Return from interrupt
01110010011000101110000000000001 //Set r1 to 0x262E
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
01110000000001100100000000000011 //Set r3 to 100
11010000000000000000000100110000 //Write value in r3 to address in r1 with offset 0
01110010011000100110000000000001 //Set r1 to 0x2626
01110000000011000000000100000001 //Set highest 16 bits of r1 to 0xC0
01110000000000000001000000000010 //Set r2 to 1
11010000000000000000000100100000 //Write value in r2 to address in r1 with offset 0
11010000000000000001000100100000 //Write value in r2 to address in r1 with offset 1
00010000000000000000000000000000 //Return from interrupt
00010000000000000000000000000000 //Return from interrupt
```

</details>