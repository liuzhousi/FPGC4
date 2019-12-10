; bootloader code
; copy SPI to SDRAM and jump to sdram
Main:
    loadhi 0x80 r1          ; r1 = address 0 of SPI: 0x800000
    load 0 r2               ; r2 = address 0 of SDRAM: 0x00, and loop var
    read 5 r1 r3            ; r3 = last address to copy +1, which is in line 6 of SPI code

    CopyLoop:
        copy 0 r1 r2            ; copy SPI to SDRAM

        add r1 1 r1             ; incr SPI address 
        add r2 1 r2             ; incr SDRAM address

        beq r2 r3 2             ; copy is done when SDRAM address == number of lines to copy
        jump CopyLoop           ; copy is not done yet, copy next address
        jump 0                  ; copy is done, jump to sdram

    halt                        ; should not get here, halt if we do
   

Int1:
    halt

Int2:
    halt

Int3:
    halt

Int4:
    halt