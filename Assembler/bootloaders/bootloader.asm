; New bootloader code with UART option, now defaults to UART
; copies SPI to SDRAM, or copies UART bootloader from ROM to SDRAM, and finally jumps to SDRAM after clearing all registers
; lines with a . in the comments indicate a change over the previous version, where the UART bootloader was stored in SPI flash instead

Main:
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

Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti