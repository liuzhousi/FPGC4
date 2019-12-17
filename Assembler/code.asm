Main:
    load 0 r4

    load 0x2626 r1
    loadhi 0xC0 r1      ; r1 = Timer1 value register

    load 1 r2;
    load 1 r3;

    write 0 r1 r2       ; write timer1 value
    write 1 r1 r3       ; start timer1


    halt    


Int1:
    load 0x2626 r1
    loadhi 0xC0 r1      ; r1 = Timer1 value register

    load 1 r2
    load 1 r3

    write 0 r1 r2       ; write timer1 value
    write 1 r1 r3       ; start timer1

    add r4 1 r4  

    write 6 r1 r4       ; 0xC0262C TonePlayer1

    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti