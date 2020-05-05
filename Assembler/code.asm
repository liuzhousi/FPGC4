Main: 

    load32 0xC02626 r1 ; value address
    load 7 r2
    write 0 r1 r2

    write 1 r1 r0   ; trigger
    halt


Int1:
    reti

Int2:
    readintid r2
    add r2 0 r2
    nop
    nop
    reti

Int3:
    reti

Int4:
    reti                    ; return from interrupt
