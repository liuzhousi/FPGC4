; New bootloader code with UART option
; copy SPI to SDRAM and jump to sdram

Main:
    load 0x2630 r1
    loadhi 0xC0 r1          ; r1 = GPIO address: 0xC02630
    read 0 r1 r2            ; r2 = GPIO values
    load 0b00000001 r3      ; r3 = bitmask for GPI[0]
    and r2 r3 r3            ; r3 = GPI[0]

    ; if GPI[0] is low (button has pullup), then jump to UART optimized copy function
    bne r0 r3 2
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

Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti