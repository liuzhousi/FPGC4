; bootloader code
; copy SPI to SDRAM and jump to sdram
Main:
    loadhi 0x80 r1          ;r1 = address 0 of SPI: 0x800000
    load 0 r2               ;r2 = address 0 of SDRAM: 0x00

    ; loop variables
    load 0 r3               ; r3 = loopvar
    load 32 r4              ; r4 = loopmax
    or r2 r0 r5             ; r5 = SDRAM addr with offset
    or r1 r0 r6             ; r6 = ascii addr with offset

    ; copy loop
    CopyLoop:
        copy 0 r6 r5            ; copy SPI to SDRAM
        ;read 0 r6 r7           ; read data from SPI
        ;write 0 r5 r7          ; write data to SDRAM
        add r5 1 r5             ; incr SDRAM address
        add r6 1 r6             ; incr SPI address 
        add r3 1 r3             ; incr counter

        beq r3 r4 2             ; keep looping until all data is copied
        jump CopyLoop
        jump 0                  ; jump to sdram

    halt
   

Int1:
    halt

Int2:
    halt

Int3:
    halt

Int4:
    halt