; bootloader code
; copy SPI to SDRAM and jump to sdram
Main:
    load 0x0410 r1
    loadhi 0x00C0 r1
    ;C00410
    load 98 r2
    load 97 r3
    load 114 r4
    load 116 r5

    write 0 r1 r2
    write 1 r1 r3
    write 2 r1 r4
    write 3 r1 r5
    halt
   

Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti