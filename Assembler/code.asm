Main: 
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
