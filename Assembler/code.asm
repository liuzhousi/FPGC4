; First FPGC4 game: a platformer

; for debugging to pc
`include lib/UART.asm
; for basic functions
`include lib/STD.asm
; for graphics operations
`include lib/GFX.asm

; DATA INCLUDES
`include data_lv1.asm


Main:

    savpc r15
    push r15
    jump GFX_initVram


    ; load pattern table
    addr2reg ASCIITABLE r1 
    savpc r15
    push r15
    jump GFX_copyPatternTable

    ; load palette table
    addr2reg PALETTETABLE r1 
    savpc r15
    push r15
    jump GFX_copyPaletteTable
    
    ; copy level 1
    addr2reg LEVEL_1_DATA r1
    savpc r15
    push r15
    jump CopyLevelToBG



    ; Sprite movement test
    load32 0xC02632 r1

    load 64 r2
    write 0 r1 r2
    load 196 r2
    write 1 r1 r2
    load 21 r2
    write 2 r1 r2
    load 0 r2
    shiftl r2 4 r2
    write 3 r1 r2
    

    halt    


; level to copy in reg1
CopyLevelToBG:

    ; TODO HERE: READ X TILE OFFSET AND APPLY
    add r1 0 r1

    load 26 r8                      ; lines in level
    load 0 r9                       ; line copy loop variable

    ; vram address
    load32 0xC00420 r2              ; r2 = vram addr 1056+4096 0xC01420          

    add r2 256 r2                 ; start at 4th line

    CopyLevelToBG_Line:
        ; loop variables
        load 0 r3                       ; r3 = loopvar
        load 40 r4                      ; r4 = loopmax
        or r2 r0 r5                     ; r5 = vram addr with offset
        or r1 r0 r6                     ; r6 = level addr with offset
        load 0 r7                       ; r7 = read tile data
        load 0 r10                      ; r10 = tile id to compare against
        load 0 r11                      ; r11 = palette value to write

        ; copy loop
        Copyleveltestloop:
            read 0 r6 r7                ; read level tile
            write 0 r5 r7               ; write tile to vram
            
            ; write palette based on tile id

            ; background
            load 5 r10
            bne r7 r10 4
                load 2 r11              ; palette to use for this tile
                write 2048 r5 r11       ; write palette index to vram
                jump Copyleveltestloop_EndPalette   ; skip to end

            ; upward spikes
            load 32 r10
            bne r7 r10 4
                load 3 r11              ; palette to use for this tile
                write 2048 r5 r11       ; write palette index to vram
                jump Copyleveltestloop_EndPalette   ; skip to end

            ; downward spikes
            load 40 r10
            bne r7 r10 4
                load 3 r11              ; palette to use for this tile
                write 2048 r5 r11       ; write palette index to vram
                jump Copyleveltestloop_EndPalette   ; skip to end

            ; arrow shooters
            load 8 r10
            bne r7 r10 4
                load 4 r11              ; palette to use for this tile
                write 2048 r5 r11       ; write palette index to vram
                jump Copyleveltestloop_EndPalette   ; skip to end


            load 1 r11              ; default
            write 2048 r5 r11       ; write palette index to vram
            Copyleveltestloop_EndPalette:

            add r5 1 r5             ; incr vram address
            add r6 1 r6             ; incr level address 
            add r3 1 r3             ; incr counter
            beq r3 r4 2             ; keep looping until all data is copied
            jump Copyleveltestloop




    add r1 LEVEL_1_WIDTH r1     ; move to next level line
    add r2 64 r2                ; move to next bg line
    add r9 1 r9                 ; increase loopvar

    beq r8 r9 2                 ; copy next line untill all lines are copied
        jump CopyLevelToBG_Line


    ; return
    pop r15
    jumpr 3 r15








WINDOWTEXT:
.ds "Graphics printing test :O"

BACKGROUNDTILES:
.db 176 176 177 177 178 178





Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti



PALETTETABLE:
.dw 0b00000000111111110000000011111111
.dw 0b01000100101011010110100011010101  ; Default/Ground
.dw 0b00100100000000000100010000000000  ; Background cave
.dw 0b00100100101110101001000111111111  ; Spikes
.dw 0b00100100110011010100100100000000  ; Arrow shooters
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000


ASCIITABLE:
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; empty
.dw 0b00111010101010111110010101010110
.dw 0b11010101010101011001010101000000
.dw 0b10010000000000001001000000000000
.dw 0b10010000000000001001000000000000 ; tile  0
.dw 0b11101010101010101001010101010101
.dw 0b10010101010101010100000101000100
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  1
.dw 0b11101010101011001001010101011011
.dw 0b10010101010101110000000000010110
.dw 0b00000000000001100000000000000110
.dw 0b00000000000001100000000000000110 ; tile  2
.dw 0b00111010101011001110010101011011
.dw 0b11010101010101111001010000010110
.dw 0b10010000000001101001000000000110
.dw 0b10010000000001101001000000000110 ; tile  3
.dw 0b00000000000000000001010000000000
.dw 0b00010100000000000000000000000100
.dw 0b00000000000001000000000000000000
.dw 0b00000001000000000000000000000000 ; tile  4
.dw 0b00111000001110000011100000111000
.dw 0b11111110111111101111111011111110
.dw 0b00010100000101010001010000010101
.dw 0b00010100000101000001010000010100 ; tile  5
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000011000000000001
.dw 0b11111010101001000011000000000001
.dw 0b00000000000000000000000000000000 ; tile  6
.dw 0b00000000000000010000000000001001
.dw 0b00000000000010100000000000000000
.dw 0b00000000000000000000000000001010
.dw 0b00000000000010010000000000000001 ; tile  7
.dw 0b11100000000000001001010000000000
.dw 0b10010100000000001001010000000000
.dw 0b11100000000000001001000000000000
.dw 0b10010000000000001001000000000000 ; tile  8
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  9
.dw 0b00000000000010110000000000010110
.dw 0b00000000000101100000000000010110
.dw 0b00000000000010110000000000000110
.dw 0b00000000000001100000000000000110 ; tile  10
.dw 0b11100000000010111001010000010110
.dw 0b10010100000101101001000000010110
.dw 0b11100000000010111001000000000110
.dw 0b10010000000001101001000000000110 ; tile  11
.dw 0b00111010101011001110010101011011
.dw 0b11010101010101111001000000000110
.dw 0b10010000000001101001000000000110
.dw 0b10010101010101101110101010101011 ; tile  12
.dw 0b00010100000101000001010000010100
.dw 0b00010100000101000001010000010100
.dw 0b00010100000101000001010000010100
.dw 0b00010100000101000001010000010100 ; tile  13
.dw 0b00000000000000000000000000000011
.dw 0b00001100000000100000001111000010
.dw 0b00000010111100100000000010111101
.dw 0b00000000001001011111111111010110 ; tile  14
.dw 0b11000000000000001100000000000000
.dw 0b11000000001100001100001011000000
.dw 0b11001011110000000110111100000000
.dw 0b01011100000000001001011010101100 ; tile  15
.dw 0b11100000000000001001010000000000
.dw 0b10010100000000001001010000000000
.dw 0b10010000000000001001000000010000
.dw 0b10110101010101011110101010101011 ; tile  16
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000010100000000
.dw 0b10010101010101011110101010101011 ; tile  17
.dw 0b00000000000010110000000000010110
.dw 0b00000000000101100000000000010110
.dw 0b00000000000001100000010000000110
.dw 0b01010101010111101110101010101011 ; tile  18
.dw 0b11100000000010111001010000010110
.dw 0b10010000000001101001010000000110
.dw 0b10010000000001101001000000000110
.dw 0b10110101010111101110101010101011 ; tile  19
.dw 0b00000000100000000000001000000000
.dw 0b00000010100000000000001000000000
.dw 0b00000010100000000000100001100000
.dw 0b00001000011000000000001010000000 ; tile  20
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000100001001000001 ; tile  21
.dw 0b00111010100101100000000000110101
.dw 0b00000000111110010000001111100011
.dw 0b00000011100000110000110000000011
.dw 0b00000000000000110000000000000011 ; tile  22
.dw 0b10010111111111110101100000000000
.dw 0b01111110000000001000111110000000
.dw 0b10000011110000001000000000110000
.dw 0b11000000000000000000000000000000 ; tile  23
.dw 0b00111010101010111110010101010101
.dw 0b11010101010001011001010000000000
.dw 0b10010000000000001001000000000000
.dw 0b10110101010101011110101010101011 ; tile  24
.dw 0b11101010101010101001010101010110
.dw 0b10010100000101010000000000000000
.dw 0b00000000000000000100000000000000
.dw 0b10010101010101011110101010101011 ; tile  25
.dw 0b11101010101011001001010101011011
.dw 0b10010101000101110000000000010110
.dw 0b00000000000001100000000000010110
.dw 0b01101001010111101110101010101011 ; tile  26
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000010000000000000101 ; tile  27
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b01010000000000001001000000000000 ; tile  28
.dw 0b00011111111101000011111010111100
.dw 0b00111010101011000010100101101000
.dw 0b00101001011010000011101010101100
.dw 0b00111110101111000011111010111100 ; tile  29
.dw 0b00111010101011000010100101101000
.dw 0b00100101010110000001010101010100
.dw 0b00010101010101000001011111010100
.dw 0b00011101011101000001110101110100 ; tile  30
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000011000000110000
.dw 0b00110000001100001111100011111000
.dw 0b11111000111110001110010011100100 ; tile  31
.dw 0b00111010101010111110000101010101
.dw 0b11000101010001011001010000000000
.dw 0b10000000000000000001000000000000
.dw 0b00000000000000000000000000000000 ; tile  32
.dw 0b11100010101010101001000101010110
.dw 0b10010100000101010000000000000000
.dw 0b00000000000000000100000000000000
.dw 0b00000000000000000000000000000000 ; tile  33
.dw 0b11101010101011001000010101011011
.dw 0b10010101000101110000000000010110
.dw 0b00000000000001100000000000000010
.dw 0b00000000000000000000000000000000 ; tile  34
.dw 0b00000000000101100000000000000101
.dw 0b00000000000000010000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  35
.dw 0b11010000000000001001000000000000
.dw 0b01000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  36
.dw 0b00111110101111000011111010111100
.dw 0b00111010101011000010100101101000
.dw 0b00101001011010000011101010101100
.dw 0b00111110101111000001111010110100 ; tile  37
.dw 0b00011111111101000001111111110100
.dw 0b00011111111101000001010101010100
.dw 0b00010101010101000010010101011000
.dw 0b00101001011010000011100101101100 ; tile  38
.dw 0b00111001001110010011111000111110
.dw 0b00111110001111100000110000001100
.dw 0b00001100000011000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  39
.dw 0b00111010101010101010010101010101
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  40
.dw 0b11101010101010101001010101010110
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  41
.dw 0b11101010101011001001010101010110
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  42
.dw 0b00111010101011001010010101010110
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  43
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  44
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  45
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  46
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000 ; tile  47
