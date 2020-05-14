# Bootloader code
The bootloader is the first thing that is executed by the CPU. The bootloader is used to copy data from the slow SPI flash to the faster SDRAM, and to jump to address 0 on the SDRAM. Since the bootloader has room for 512 instructions, I will probably add a boot screen with logo.
There are two modes for the bootloader:
- If GPI[0] is high (which should be by default, because of a pull-up resistor), then the bootloader will only copy the first 16 addresses, and the last 512 addresses. This is because the code of the UARTbootloader has to run at the end of the 16'th MiB of the SPI flash to prevent that the bootloader overwrites its own code (since it is ran from SDRAM). If all 16MiB is copied, then the copying would take about ten seconds, which is way to long. By only copying the start and end, the UARTbootloader still works, and is copied almost instantly.
- If GPI[0] is low, then the bootloader will copy X addresses, where X is the number in (32 bit) address 5 of the SPI flash.

I chose to make the UART mode the default mode, since this mode is currently used >99% of the time. This will likely change when I have developed an OS.
Furthermore, all registers are reset before jumping to address 0, because the UARTbootloader has to halt in the first instruction and therefore has to assume all registers are empty. The code could be space optimized by jumping to one of the two clear registers code, if needed.

<details>
<summary>The assembly code of the bootloader</summary>

``` asm
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

    load 0 r1
    loadhi 0x80 r1          ; r1 = address 0 of SPI: 0x800000
    load 0 r2               ; r2 = address 0 of SDRAM: 0x00, and loop var
    read 5 r1 r3            ; r3 = last address to copy +1, which is in line 6 of SPI code
    load 16 r4              ; r4 = number of words to copy at the start

    CopyStartLoop:
        copy 0 r1 r2            ; copy SPI to SDRAM

        add r1 1 r1             ; incr SPI address 
        add r2 1 r2             ; incr SDRAM address

        beq r2 r4 2             ; copy is done when SDRAM address == number of words to copy at the start
        jump CopyStartLoop      ; copy is not done yet, copy next address


    load 0 r1
    loadhi 0x80 r1          ; r1 = address 0 of SPI: 0x800000
    load 0 r2               ; r2 = address 0 of SDRAM: 0x00, and loop var
    read 5 r1 r3            ; r3 = last address to copy +1, which is in line 6 of SPI code
    sub r3 512 r4           ; r4 = starting address, 512 addresses before last address
    add r4 r1 r1            ; apply starting address offset to SPI address
    add r4 r2 r2            ; apply starting address offset to SDRAM address

    CopyEndLoop:
        copy 0 r1 r2            ; copy SPI to SDRAM

        add r1 1 r1             ; incr SPI address 
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
01110010011000110000000000000001 //Set r1 to 0x2630   (this is address 0xC02422)
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
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
01110000000000010000000000000100 //Set r4 to 16
11000000000000000000000100100000 //Copy from address in r1 to address in r2 with offset 0
00001001100000000001000100000001 //Compute r1 + 1 and write result to r1
00001001100000000001001000000010 //Compute r2 + 1 and write result to r2
01100000000000000010001001000000 //If r2 == r4, then jump to offset 2
10010001100000000100100010010000 //Jump to copy instruction in line 39 (0xC02422 + 39 - 1)
01110000000000000000000000000001 //Set r1 to 0
01110000000010000000000100000001 //Set highest 16 bits of r1 to 0x80
01110000000000000000000000000010 //Set r2 to 0
11100000000000000101000100000011 //Read at address in r1 with offset 5 to r3
00001010001000000000001100000100 //Compute r3 - 512 and write result to r4
00000001100000000000010000010001 //Compute r4 + r1 and write result to r1
00000001100000000000010000100010 //Compute r4 + r2 and write result to r2
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
```

</details>