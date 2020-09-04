Main:

	load32 0xC02631 r1
	load 0b10100101 r2
	load 0b00110110 r3
	write 0 r1 r2
	write 0 r1 r3
	halt

Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti