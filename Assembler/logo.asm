; Attempt at minimal code to write logo to screen using window plane
; for bootloader if success
; currently does not clean vram first

Main:
    ; set palette table
    load32 0xC00400 r1      ; pallette address
    load 0xFF r2            ; white for 11 bytes, others black
    write 0 r1 r2

    ; copy pattern table
    load32 0xC00000 r3      ; r3 = data dest
    addr2reg LOGOTABLE r2   ; r2 = data source

    add r3 253 r1           ; r1 = loop end (if r3 matches)

    CopyPatternLoop:
        copy 0 r2 r3        ; copy data to vram
        add r2 1 r2         ; increase source address
        add r3 1 r3         ; increase dest address

        beq r3 r1 2         ; keep looping until all 252 words are copied
        jump CopyPatternLoop


    ; copy window tile table
    load32 0xC015E4 r3      ; r3 = data dest: window tile address 0xC01420 + position offset
    addr2reg TILETABLE r2   ; r2 = data source

    load 0 r4               ; r4 = loop counter
    load 96 r1              ; r1 = loop end
    load 16 r5              ; r5 = next line counter
    load 32 r8              ; r8 = shift variable


    CopyTileLoop:
        sub r8 8 r8         ; remove 8 from shift variable
        read 0 r2 r10       ; read data
        shiftr r10 r8 r10   ; shift data to right
        write 0 r3 r10      ; write shifted data to vram
        bne r0 r8 3         ; if we shifted the last byte
            add r2 1 r2         ; increase source address
            load 32 r8          ; set shift variable back
        add r3 1 r3         ; increase dest address
        sub r5 1 r5         ; reduce line counter
        add r4 1 r4         ; increase counter

        bne r5 r0 3
            load 16 r5
            add r3 24 r3

        beq r4 r1 2         ; keep looping until all tiles are copied
        jump CopyTileLoop

    halt


Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti                    ; return from interrupt

TILETABLE:
.db 0  1  2  3  4  5  0  0  0  0  0  0  0  0  0  0
.db 6  7  8  9  10 11 12 0  0  0  0  0  0  0  0  0
.db 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28
.db 29 30 31 32 33 34 35 36 37 38 39 40 41 42 43 44
.db 45 46 47 48 49 50 51 0  0  52 53 54 55 56 0  57
.db 58 59 60 61 62 63 0  0  0  0  0  0  0  0  0  0

LOGOTABLE: ; 252 words long
.dw 0 0 0 0 ; tile 0, background, so always empty
.dw 0b00000000000000000000000000000011
.dw 0b00000000000000110000000000000000
.dw 0b00000000110000000000001111110000
.dw 0b00000000111111000000000000111111 ; tile  1
.dw 0b00000000000000001100000000000000
.dw 0b11110000000000001111110000000000
.dw 0b00111111000011110000110000111111
.dw 0b00000000111111000000001111111100 ; tile  2
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000011
.dw 0b11111111000011111111111111000011
.dw 0b00000011111100000000000011111100 ; tile  3
.dw 0b00000000000000000011110000000000
.dw 0b11111100000000001111000000000000
.dw 0b11000000001111000000000011111100
.dw 0b00000011111100000000111111000000 ; tile  4
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000011000000000000 ; tile  5
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000011110000
.dw 0b00000000111111000000000000111111
.dw 0b00110000000011111111110000000011 ; tile  6
.dw 0b11110000000011111111110000000000
.dw 0b00111111000000000000111111000011
.dw 0b00000011000011110000000000111111
.dw 0b11000000111111001100001111110000 ; tile  7
.dw 0b00001111110011110011111100000011
.dw 0b11111100000000001111110000000000
.dw 0b11001111000000000000001111000000
.dw 0b00000000111100000000000000111100 ; tile  8
.dw 0b00000000001111111100000000001111
.dw 0b11110000000000110011110000000000
.dw 0b00001111000000000000001111000000
.dw 0b00000000111100000000000000111100 ; tile  9
.dw 0b00001111000000001100000000000011
.dw 0b11110000000011111111110000111111
.dw 0b00111111000011000000111111000000
.dw 0b00000011111100000000000011111100 ; tile  10
.dw 0b11111100000000001111000000000000
.dw 0b11000000000000000000000011110000
.dw 0b00000011111100000000111111000000
.dw 0b00111111000000000011110000000011 ; tile  00
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11000000000000001111000000000000 ; tile  12
.dw 0b00111111000000000000111111000000
.dw 0b00000011111100000000000011000011
.dw 0b00000000000011110000000000111111
.dw 0b00000000111111000000000011110000 ; tile  13
.dw 0b00001111110000000011111100000000
.dw 0b11111100000000001111000000000000
.dw 0b11000000001111110000000000110011
.dw 0b00000000111111110000001111000000 ; tile  14
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111 ; tile  15
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111111100000000000000
.dw 0b11000000000000001100000000000000
.dw 0b11111111111111001111111111111100 ; tile  16
.dw 0b11111100001111111111110000001111
.dw 0b11111100000000110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  17
.dw 0b00000000000011111100000000111111
.dw 0b11110000111111001111110000110000
.dw 0b00111111000000000000111111000000
.dw 0b00111111111100001111000011110000 ; tile  18
.dw 0b11000011111111110000001111111111
.dw 0b00000011111111110000001111111111
.dw 0b00000011111111110000001111111111
.dw 0b00000011111111110000001111111111 ; tile  19
.dw 0b11111111111111001111111111111100
.dw 0b11111111111111000000000000111111
.dw 0b00000000001111110000000000111111
.dw 0b00000000001111110000000000111111 ; tile  20
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000001111000000001111
.dw 0b11110000000011111111000000001111
.dw 0b11110000000011111111000000001111 ; tile  21
.dw 0b00111111111111110011111111111111
.dw 0b00111111111111111111110000000000
.dw 0b11111100000000001111110000000000
.dw 0b11111100000000001111110000000000 ; tile  22
.dw 0b11111111110000001111111111000000
.dw 0b11111111110000000000001111111111
.dw 0b00000011111111110000001111111111
.dw 0b00000000000000000000000000000000 ; tile  23
.dw 0b00000000000000110000000000000011
.dw 0b00000000000000110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111 ; tile  24
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111111100000000000000
.dw 0b11000000000000001100000000000000
.dw 0b11000000000000001100000000000000 ; tile  25
.dw 0b11111100000000001111110000000000
.dw 0b11111100000000000011111111110000
.dw 0b00111111111100000011111111110000
.dw 0b00000000000000000000000000000000 ; tile  26
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000001111
.dw 0b00000000000011110000000011111111
.dw 0b00000000111111000000111111111100 ; tile  27
.dw 0b00111111110000000011111111000000
.dw 0b00111111110000001111111111000000
.dw 0b11111111110000001111111111000000
.dw 0b00111111110000000011111111000000 ; tile  28
.dw 0b00000000111100000000000011110000
.dw 0b00000000111111000000000000111111
.dw 0b00000000000011110000000011000011
.dw 0b00000011111100000000111111000000 ; tile  29
.dw 0b00001111000000000011110000001111
.dw 0b11110000000011001100000000001111
.dw 0b11000000001111001111000011110000
.dw 0b11111111110000000011111100000000 ; tile  30
.dw 0b00000000111111111100000011111111
.dw 0b11000000111111111100000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111 ; tile  31
.dw 0b11111111111111001100000000000000
.dw 0b11000000000000001100000000000000
.dw 0b11000000000011111100000000001100
.dw 0b11000000000011111111000000000000 ; tile  32
.dw 0b00000000000000110000000011111111
.dw 0b00000000110011000000000011111100
.dw 0b11000000000000001100000000000000
.dw 0b11000000000000111111000000001111 ; tile  33
.dw 0b11000000111100000000000011110000
.dw 0b00000011111100000000111111000000
.dw 0b00111111000000001111110000110000
.dw 0b11110000111111001100000000111111 ; tile  34
.dw 0b00000011111111110000001111111111
.dw 0b00000011111111110000001111111111
.dw 0b00000011111111110000001111111111
.dw 0b00000011111111110000001111111111 ; tile  35
.dw 0b00000000001111111111111111111100
.dw 0b11111111111111001111111111111100
.dw 0b11111111111111000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  36
.dw 0b11110000000011110000000000001111
.dw 0b00000000000011110000000000001111
.dw 0b00000000000011110000000000001111
.dw 0b00000000000011110000000000001111 ; tile  37
.dw 0b11111100000000001111110000000000
.dw 0b11111100000000001111110000000000
.dw 0b11111100000000001111110000000000
.dw 0b11111100000000001111110000000000 ; tile  38
.dw 0b00000000000000001111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111110000001111111111
.dw 0b00000011111111110000001111111111 ; tile  39
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111 ; tile  40
.dw 0b11000000000000001100000000000000
.dw 0b11000000000000001100000000000000
.dw 0b11000000000000001100000000000000
.dw 0b11000000000000001100000000000000 ; tile  41
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000011111111110000
.dw 0b00111111111100000011111111110000 ; tile  42
.dw 0b00001111110000001111111111000000
.dw 0b11111100000000001111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b00000000000000000000000000000000 ; tile  43
.dw 0b00111111110000000011111111000000
.dw 0b00111111110000001111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b00111111110000000011111111000000 ; tile  44
.dw 0b00111111000000001111110000000011
.dw 0b00110000000011110000000000111111
.dw 0b00000000111111000000000011110000
.dw 0b00000000000000000000000000000000 ; tile  45
.dw 0b00001111110000001100001111110000
.dw 0b11000000111111000000000000111111
.dw 0b00000011000011110000111111000011
.dw 0b00111111000000001111110000000000 ; tile  46
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000000001111
.dw 0b11000000000011111111000000111100
.dw 0b11111100111100000011111111000000 ; tile  47
.dw 0b11111100000000001100111100000000
.dw 0b11000011110000000000000011110000
.dw 0b00000000001111000000000000001111
.dw 0b00000000000000110000000000001111 ; tile  48
.dw 0b00111100001111110000111111111100
.dw 0b00000011111100000000111111000000
.dw 0b00111111000011001111110000111111
.dw 0b11110000000011111100000000000011 ; tile  49
.dw 0b00000000000011110011110000000011
.dw 0b00111111000000000000111111000000
.dw 0b00000011111100000000000011110000
.dw 0b11000000000000001111000000000000 ; tile  50
.dw 0b11000011111111111111001111111111
.dw 0b11000011111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  51
.dw 0b00111111111111110011111111111111
.dw 0b00111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  52
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  53
.dw 0b00000000000000110000000000000011
.dw 0b00000000000000110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  54
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  55
.dw 0b11111100000000001111110000000000
.dw 0b11111100000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  56
.dw 0b00111111110000000011111111000000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  57
.dw 0b00000000000000110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  58
.dw 0b11110000000011111100000000111111
.dw 0b00000000111111000000001111110000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000110000000000000011 ; tile  59
.dw 0b00001111110000000000001111110000
.dw 0b00000000111111000000110000111111
.dw 0b00111111000011111111110000000000
.dw 0b11110000000000001100000000000000 ; tile  60
.dw 0b00000000001111110000000011111100
.dw 0b00000011111100001111111111000011
.dw 0b11111111000011110000000000000011
.dw 0b00000000000000000000000000000000 ; tile  61
.dw 0b00001111000000000000111111000000
.dw 0b00000011111100000000000011111100
.dw 0b11000000001111001111000000000000
.dw 0b11111100000000000011110000000000 ; tile  62
.dw 0b11111100000000000011000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  63