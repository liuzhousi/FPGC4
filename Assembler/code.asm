; Graphics, sound and UART printing test ROM

; Graphics library test
; Should eventually become a real library when library support is added in assembler

define GFX_PATTERN_TABLE_SIZE       = 1024      ; size of pattern table
define GFX_PALETTE_TABLE_SIZE       = 32        ; size of palette table
define GFX_WINDOW_TILES             = 1920      ; number of tiles in window plane
define GFX_BG_TILES                 = 2048      ; number of tiles in bg plane

define MUSIC_LEN                    = 12        ; number of notes

Main:

    ;CRAPPY MUSIC PLAYER TEST CODE
    load 0x0000 r2
    loadhi 0x08 r2      ; r2 =  0x80000 | music index
                        ;       0x80001 | max music index
    load MUSIC_LEN r1
    write 1 r2 r1
    write 0 r2 r0
    write 2 r2 r0
    write 3 r2 r0

    load 0x2626 r1
    loadhi 0xC0 r1      ; r1 = Timer1 value register

    addr2reg MUSICLENS r2
    read 0 r2 r2

    addr2reg MUSICLOWLENS r10
    read 0 r10 r10


    load 1 r3

    write 0 r1 r2       ; write timer1 value
    write 1 r1 r3       ; start timer1

    write 2 r1 r10      ; write timer2 value
    write 3 r1 r3       ; start timer3

    addr2reg MUSICNOTES r4
    read 0 r4 r4

    addr2reg MUSICLOWNOTES r11
    read 0 r11 r11

    load 0x0000 r2
    loadhi 0x08 r2      ; r2 =  0x80000 | music index
                        ;       0x80001 | max music index

    read 0 r2 r3
    add r3 1 r3
    write 0 r2 r3
    write 2 r2 r3
    ;END CRAPPY MUSIC TEST INIT CODE



    savpc r15
    push r15
    jump GFXinitVram

    ; print some data to Window
    addr2reg WINDOWTEXT r1   ; data to copy
    load 25 r2              ; length of data
    load 26 r3               ; offset from start
    load 1 r4               ; palette idx

    savpc r15
    push r15
    jump GFXprintWindowColored   

    ; print some data to BG
    addr2reg BACKGROUNDTILES r1   ; data to copy
    load 6 r2               ; length of data
    load 16 r3              ; offset from start
    load 1 r4               ; palette idx

    savpc r15
    push r15
    jump GFXprintBGColored  
    
    ; SNES controller address
    load 0x2622 r1
    loadhi 0xC0 r1      ; r1 = Controller address 0xC02622

    jump SNESloop

    halt    

WINDOWTEXT:
.ds "Graphics printing test :P"

BACKGROUNDTILES:
.db 176 176 177 177 178 178

MUSICNOTES:
; music note data
.dw 0x0 0x2f39 0x0 0x2f39 0x0 0x2f39 0x0 0x2f35 0x0 0x2f39 0x0 0x30343c 0x0 0x30 0x0 0x2d35 0x0 0x2930 0x0 
.dw 0x242d 0x0 0x2932 0x0 0x2b34 0x0 0x2a33 0x0 0x2932 0x0 0x2930 0x0 0x3039 0x0 0x343c 0x0 0x353e 0x0 0x323a 0x0 
.dw 0x343c 0x0 0x3239 0x0 0x2d35 0x0 0x2e37 0x0 0x2b34 0x0 0x2d35 0x0 0x2930 0x0 0x242d 0x0 0x2932 0x0 0x2b34 0x0 
.dw 0x2a33 0x0 0x2932 0x0 0x2930 0x0 0x3039 0x0 0x343c 0x0 0x353e 0x0 0x323a 0x0 0x343c 0x0 0x3239 0x0 0x2d35 0x0 
.dw 0x2e37 0x0 0x2b34 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 0x2d31 0x0 0x2e32 0x0 0x3035 0x0 
.dw 0x2932 0x0 0x2d35 0x0 0x2e37 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 0x3a3c41 0x0 0x3a3c41 0x0 
.dw 0x3a3c41 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 0x2d31 0x0 0x2e32 0x0 0x3035 0x0 0x2932 0x0 
.dw 0x2d35 0x0 0x2e37 0x0 0x3138 0x0 0x2e37 0x0 0x2d35 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 
.dw 0x2d31 0x0 0x2e32 0x0 0x3035 0x0 0x2932 0x0 0x2d35 0x0 0x2e37 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 
.dw 0x3539 0x0 0x3a3c41 0x0 0x3a3c41 0x0 0x3a3c41 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 0x2d31 0x0 
.dw 0x2e32 0x0 0x3035 0x0 0x2932 0x0 0x2d35 0x0 0x2e37 0x0 0x3138 0x0 0x2e37 0x0 0x2d35 0x0 0x3135 0x0 0x3135 0x0 
.dw 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x2d35 0x0 0x2d32 0x0 0x2930 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 
.dw 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x2d35 0x0 
.dw 0x2d32 0x0 0x2930 0x0 0x2f39 0x0 0x2f39 0x0 0x2f39 0x0 0x2f35 0x0 0x2f39 0x0 0x30343c 0x0 0x30 0x0 0x2d35 0x0 
.dw 0x2930 0x0 0x242d 0x0 0x2932 0x0 0x2b34 0x0 0x2a33 0x0 0x2932 0x0 0x2930 0x0 0x3039 0x0 0x343c 0x0 0x353e 0x0 
.dw 0x323a 0x0 0x343c 0x0 0x3239 0x0 0x2d35 0x0 0x2e37 0x0 0x2b34 0x0 0x2d35 0x0 0x2930 0x0 0x242d 0x0 0x2932 0x0 
.dw 0x2b34 0x0 0x2a33 0x0 0x2932 0x0 0x2930 0x0 0x3039 0x0 0x343c 0x0 0x353e 0x0 0x323a 0x0 0x343c 0x0 0x3239 0x0 
.dw 0x2d35 0x0 0x2e37 0x0 0x2b34 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 
.dw 0x2e32 0x0 0x3034 0x0 0x3a3e 0x0 0x3a3e 0x0 0x3a3e 0x0 0x393c 0x0 0x373a 0x0 0x3539 0x0 0x3235 0x0 0x2e32 0x0 
.dw 0x2d30 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 
.dw 0x373a 0x0 0x373a 0x0 0x373a 0x0 0x3539 0x0 0x3437 0x0 0x3035 0x0 0x2d 0x0 0x2d 0x0 0x29 0x0 0x3539 0x0 
.dw 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x3a3e 0x0 0x3a3e 0x0 
.dw 0x3a3e 0x0 0x393c 0x0 0x373a 0x0 0x3539 0x0 0x3235 0x0 0x2e32 0x0 0x2d30 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 
.dw 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x373a 0x0 0x373a 0x0 0x373a 0x0 0x3539 0x0 
.dw 0x3437 0x0 0x3035 0x0 0x2d 0x0 0x2d 0x0 0x29 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 
.dw 0x3039 0x0 0x2d35 0x0 0x2d32 0x0 0x2930 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 
.dw 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x2d35 0x0 0x2d32 0x0 0x2930 0x0 0x2f39 0x0 
.dw 0x2f39 0x0 0x2f39 0x0 0x2f35 0x0 0x2f39 0x0 0x30343c 0x0 0x30 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 
.dw 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x3a3e 0x0 0x3a3e 0x0 0x3a3e 0x0 0x393c 0x0 0x373a 0x0 
.dw 0x3539 0x0 0x3235 0x0 0x2e32 0x0 0x2d30 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 
.dw 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x373a 0x0 0x373a 0x0 0x373a 0x0 0x3539 0x0 0x3437 0x0 0x3035 0x0 0x2d 0x0 
.dw 0x2d 0x0 0x29 0x0 0x2d35 0x0 0x2930 0x0 0x242d 0x0 0x2932 0x0 0x2b34 0x0 0x2a33 0x0 0x2932 0x0 0x2930 0x0 
.dw 0x3039 0x0 0x343c 0x0 0x353e 0x0 0x323a 0x0 0x343c 0x0 0x3239 0x0 0x2d35 0x0 0x2e37 0x0 0x2b34 0x0 0x2d35 0x0 
.dw 0x2930 0x0 0x242d 0x0 0x2932 0x0 0x2b34 0x0 0x2a33 0x0 0x2932 0x0 0x2930 0x0 0x3039 0x0 0x343c 0x0 0x353e 0x0 
.dw 0x323a 0x0 0x343c 0x0 0x3239 0x0 0x2d35 0x0 0x2e37 0x0 0x2b34 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 
.dw 0x3539 0x0 0x2d31 0x0 0x2e32 0x0 0x3035 0x0 0x2932 0x0 0x2d35 0x0 0x2e37 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 
.dw 0x3438 0x0 0x3539 0x0 0x3a3c41 0x0 0x3a3c41 0x0 0x3a3c41 0x0 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 
.dw 0x2d31 0x0 0x2e32 0x0 0x3035 0x0 0x2932 0x0 0x2d35 0x0 0x2e37 0x0 0x3138 0x0 0x2e37 0x0 0x2d35 0x0 0x393c 0x0 
.dw 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 0x2d31 0x0 0x2e32 0x0 0x3035 0x0 0x2932 0x0 0x2d35 0x0 0x2e37 0x0 
.dw 0x393c 0x0 0x383b 0x0 0x373a 0x0 0x3438 0x0 0x3539 0x0 0x3a3c41 0x0 0x3a3c41 0x0 0x3a3c41 0x0 0x393c 0x0 0x383b 0x0 
.dw 0x373a 0x0 0x3438 0x0 0x3539 0x0 0x2d31 0x0 0x2e32 0x0 0x3035 0x0 0x2932 0x0 0x2d35 0x0 0x2e37 0x0 0x3138 0x0 
.dw 0x2e37 0x0 0x2d35 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x2d35 0x0 0x2d32 0x0 
.dw 0x2930 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 
.dw 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x2d35 0x0 0x2d32 0x0 0x2930 0x0 0x2f39 0x0 0x2f39 0x0 0x2f39 0x0 0x2f35 0x0 
.dw 0x2f39 0x0 0x30343c 0x0 0x30 0x0 0x2d35 0x0 0x2930 0x0 0x242d 0x0 0x2932 0x0 0x2b34 0x0 0x2a33 0x0 0x2932 0x0 
.dw 0x2930 0x0 0x3039 0x0 0x343c 0x0 0x353e 0x0 0x323a 0x0 0x343c 0x0 0x3239 0x0 0x2d35 0x0 0x2e37 0x0 0x2b34 0x0 
.dw 0x2d35 0x0 0x2930 0x0 0x242d 0x0 0x2932 0x0 0x2b34 0x0 0x2a33 0x0 0x2932 0x0 0x2930 0x0 0x3039 0x0 0x343c 0x0 
.dw 0x353e 0x0 0x323a 0x0 0x343c 0x0 0x3239 0x0 0x2d35 0x0 0x2e37 0x0 0x2b34 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 
.dw 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x3a3e 0x0 0x3a3e 0x0 0x3a3e 0x0 0x393c 0x0 
.dw 0x373a 0x0 0x3539 0x0 0x3235 0x0 0x2e32 0x0 0x2d30 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 
.dw 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x373a 0x0 0x373a 0x0 0x373a 0x0 0x3539 0x0 0x3437 0x0 0x3035 0x0 
.dw 0x2d 0x0 0x2d 0x0 0x29 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 
.dw 0x2e32 0x0 0x3034 0x0 0x3a3e 0x0 0x3a3e 0x0 0x3a3e 0x0 0x393c 0x0 0x373a 0x0 0x3539 0x0 0x3235 0x0 0x2e32 0x0 
.dw 0x2d30 0x0 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 
.dw 0x373a 0x0 0x373a 0x0 0x373a 0x0 0x3539 0x0 0x3437 0x0 0x3035 0x0 0x2d 0x0 0x2d 0x0 0x29 0x0 0x3135 0x0 
.dw 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x2d35 0x0 0x2d32 0x0 0x2930 0x0 0x3135 0x0 0x3135 0x0 
.dw 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3135 0x0 0x3337 0x0 0x3039 0x0 
.dw 0x2d35 0x0 0x2d32 0x0 0x2930 0x0 0x2f39 0x0 0x2f39 0x0 0x2f39 0x0 0x2f35 0x0 0x2f39 0x0 0x30343c 0x0 0x30 0x0 
.dw 0x3539 0x0 0x3235 0x0 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x3a3e 0x0 
.dw 0x3a3e 0x0 0x3a3e 0x0 0x393c 0x0 0x373a 0x0 0x3539 0x0 0x3235 0x0 0x2e32 0x0 0x2d30 0x0 0x3539 0x0 0x3235 0x0 
.dw 0x2d30 0x0 0x2d31 0x0 0x2e32 0x0 0x353a 0x0 0x353a 0x0 0x2e32 0x0 0x3034 0x0 0x373a 0x0 0x373a 0x0 0x373a 0x0 
.dw 0x3539 0x0 0x3437 0x0 0x3035 0x0 0x2d 0x0 0x2d 0x0 

MUSICLENS:
; music duration data
.dw 1 149 1 146 145 145 150 146 1 144 145 150 436 150 436 150 291 145 297 
.dw 145 296 146 145 145 150 146 1 144 145 100 97 97 98 94 97 150 146 145 1 
.dw 145 150 146 145 145 1 150 1 146 290 150 291 145 297 144 296 146 145 145 150 
.dw 146 1 144 145 100 97 97 98 94 97 150 146 144 1 145 150 146 145 145 1 
.dw 150 1 146 587 144 1 145 1 150 1 146 145 145 150 146 1 144 1 145 150 
.dw 146 1 144 1 145 297 144 1 145 1 150 1 146 145 145 150 146 145 145 1 
.dw 150 733 144 1 145 1 150 1 146 145 145 150 146 1 144 1 145 150 146 1 
.dw 144 1 145 297 144 296 146 290 150 1321 144 1 145 1 150 1 146 145 145 150 
.dw 146 1 144 1 145 150 146 1 144 1 145 297 144 1 145 1 150 1 146 145 
.dw 145 150 146 145 145 1 150 733 144 1 145 1 150 1 146 145 145 150 146 1 
.dw 144 1 145 150 146 1 144 1 145 297 144 296 146 290 150 1024 150 1 146 145 
.dw 145 150 146 1 144 145 150 1 146 145 145 1 150 436 150 1 146 145 145 150 
.dw 146 1 145 1 145 1175 150 1 146 145 145 150 146 1 145 145 150 1 146 145 
.dw 145 1 150 436 150 1 146 145 145 150 146 1 145 145 150 436 150 436 150 291 
.dw 145 297 145 296 146 145 145 150 146 1 145 145 100 97 97 98 94 97 150 146 
.dw 145 1 145 150 146 145 145 1 150 1 146 290 150 291 145 297 145 296 146 145 
.dw 145 150 146 1 145 145 100 97 97 98 94 97 150 146 145 1 145 150 146 145 
.dw 145 1 150 1 146 290 150 1 146 145 145 297 145 145 150 1 146 145 145 1 
.dw 150 436 100 97 97 98 94 97 100 97 97 98 94 97 150 1 146 145 145 1 
.dw 150 436 150 1 146 145 145 297 145 145 150 1 146 145 145 1 150 436 150 1 
.dw 146 145 145 1 100 97 97 98 94 97 150 1 146 145 145 1 150 436 150 1 
.dw 146 145 145 297 145 145 150 1 146 145 145 1 150 436 100 97 97 98 94 97 
.dw 100 97 97 98 94 97 150 1 146 145 145 1 150 436 150 1 146 145 145 297 
.dw 144 145 150 1 146 145 145 1 150 436 150 1 146 145 145 1 100 97 97 98 
.dw 94 97 150 1 146 145 145 1 150 436 150 1 146 145 145 150 146 1 144 145 
.dw 150 1 146 145 145 1 150 436 150 1 146 145 145 150 146 1 144 1 145 1175 
.dw 150 1 146 145 145 150 146 1 144 145 150 1 146 145 145 1 150 436 150 1 
.dw 146 145 145 150 146 1 144 145 150 436 150 436 150 1 146 145 145 297 144 145 
.dw 150 1 146 145 145 1 150 436 100 97 97 98 94 97 100 97 97 98 94 97 
.dw 150 1 146 145 145 1 150 436 150 1 146 145 145 297 144 145 150 1 146 145 
.dw 145 1 150 436 150 1 146 145 145 1 100 97 97 98 94 97 150 1 146 145 
.dw 145 1 150 436 150 291 145 297 144 296 146 145 145 150 146 1 144 145 100 97 
.dw 97 98 94 97 150 146 144 1 145 150 146 145 145 1 150 1 146 290 150 291 
.dw 145 297 144 296 146 145 145 150 146 1 144 145 100 97 97 98 94 97 150 146 
.dw 144 1 145 150 146 145 145 1 150 1 146 587 144 1 145 1 150 1 146 145 
.dw 145 150 146 1 144 1 145 150 146 1 144 1 145 297 144 1 145 1 150 1 
.dw 146 145 145 150 146 145 145 1 150 733 144 1 145 1 150 1 146 145 145 150 
.dw 146 1 144 1 145 150 146 1 144 1 145 297 144 296 146 290 150 1321 144 1 
.dw 145 1 150 1 146 145 145 150 146 1 144 1 145 150 146 1 144 1 145 297 
.dw 144 1 145 1 150 1 146 145 145 150 146 145 145 1 150 733 144 1 145 1 
.dw 150 1 146 145 145 150 146 1 144 1 145 150 146 1 144 1 145 297 144 296 
.dw 146 290 150 1024 150 1 146 145 145 150 146 1 144 145 150 1 146 145 145 1 
.dw 150 436 150 1 146 145 145 150 146 1 144 1 145 1175 150 1 146 145 145 150 
.dw 146 1 144 145 150 1 146 145 145 1 150 436 150 1 146 145 145 150 146 1 
.dw 144 145 150 436 150 436 150 291 145 297 144 296 146 145 145 150 146 1 144 145 
.dw 100 97 97 98 94 97 150 146 144 1 145 150 146 145 145 1 150 1 146 290 
.dw 150 291 145 297 145 296 146 145 145 150 146 1 145 145 100 97 97 98 94 97 
.dw 150 146 145 1 145 150 146 145 145 1 150 1 146 290 150 1 146 145 145 297 
.dw 145 145 150 1 146 145 145 1 150 436 100 97 97 98 94 97 100 97 97 98 
.dw 94 97 150 1 146 145 145 1 150 436 150 1 146 145 145 297 145 145 150 1 
.dw 146 145 145 1 150 436 150 1 146 145 145 1 100 97 97 98 94 97 150 1 
.dw 146 145 145 1 150 436 150 1 146 145 145 297 145 145 150 1 146 145 145 1 
.dw 150 436 100 97 97 98 94 97 100 97 97 98 94 97 150 1 146 145 145 1 
.dw 150 436 150 1 146 145 145 297 145 145 150 1 146 145 145 1 150 436 150 1 
.dw 146 145 145 1 100 97 97 98 94 97 150 1 146 145 145 1 150 436 150 1 
.dw 146 145 145 150 146 1 145 145 150 1 146 145 145 1 150 436 150 1 146 145 
.dw 145 150 146 1 145 1 145 1175 150 1 146 145 145 150 146 1 145 145 150 1 
.dw 146 145 145 1 150 436 150 1 146 145 145 150 146 1 145 145 150 436 150 436 
.dw 150 1 146 145 145 297 145 145 150 1 146 145 145 1 150 436 100 97 97 98 
.dw 94 97 100 97 97 98 94 97 150 1 146 145 145 1 150 436 150 1 146 145 
.dw 145 297 145 145 150 1 146 145 145 1 150 436 150 1 146 145 145 1 100 97 
.dw 97 98 94 97 150 1 146 145 145 1 

MUSICLOWNOTES:
; music note data
.dw 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x24 0x0 0x24 0x0 0x21 0x0 0x1d 0x0 
.dw 0x22 0x0 0x24 0x0 0x23 0x0 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 0x2e 0x0 0x2b 0x0 0x2d 0x0 
.dw 0x29 0x0 0x26 0x0 0x28 0x0 0x24 0x0 0x24 0x0 0x21 0x0 0x1d 0x0 0x22 0x0 0x24 0x0 0x23 0x0 
.dw 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 0x2e 0x0 0x2b 0x0 0x2d 0x0 0x29 0x0 0x26 0x0 0x28 0x0 
.dw 0x24 0x0 0x1d 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1d 0x0 0x21 0x0 
.dw 0x24 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 
.dw 0x1d 0x0 0x25 0x0 0x27 0x0 0x29 0x0 0x24 0x0 0x24 0x0 0x1d 0x0 0x1d 0x0 0x24 0x0 0x29 0x0 
.dw 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1d 0x0 0x21 0x0 0x24 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 
.dw 0x24 0x0 0x29 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1d 0x0 0x25 0x0 0x27 0x0 0x29 0x0 
.dw 0x24 0x0 0x24 0x0 0x1d 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 0x19 0x0 
.dw 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 
.dw 0x18 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x24 0x0 0x24 0x0 0x21 0x0 0x1d 0x0 
.dw 0x22 0x0 0x24 0x0 0x23 0x0 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 0x2e 0x0 0x2b 0x0 0x2d 0x0 
.dw 0x29 0x0 0x26 0x0 0x28 0x0 0x24 0x0 0x24 0x0 0x21 0x0 0x1d 0x0 0x22 0x0 0x24 0x0 0x23 0x0 
.dw 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 0x2e 0x0 0x2b 0x0 0x2d 0x0 0x29 0x0 0x26 0x0 0x28 0x0 
.dw 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 
.dw 0x1f 0x0 0x22 0x0 0x24 0x0 0x28 0x0 0x24 0x0 0x24 0x0 0x29 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 
.dw 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x24 0x0 0x24 0x0 
.dw 0x24 0x0 0x26 0x0 0x28 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 
.dw 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1f 0x0 0x22 0x0 0x24 0x0 0x28 0x0 0x24 0x0 
.dw 0x24 0x0 0x29 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 
.dw 0x29 0x0 0x29 0x0 0x22 0x0 0x24 0x0 0x24 0x0 0x24 0x0 0x26 0x0 0x28 0x0 0x29 0x0 0x24 0x0 
.dw 0x1d 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 0x19 0x0 0x20 0x0 0x25 0x0 
.dw 0x24 0x0 0x1d 0x0 0x18 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 0x1f 0x0 
.dw 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 
.dw 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1f 0x0 0x22 0x0 0x24 0x0 0x28 0x0 0x24 0x0 0x24 0x0 
.dw 0x29 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 0x29 0x0 
.dw 0x29 0x0 0x22 0x0 0x24 0x0 0x24 0x0 0x24 0x0 0x26 0x0 0x28 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 
.dw 0x24 0x0 0x21 0x0 0x1d 0x0 0x22 0x0 0x24 0x0 0x23 0x0 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 
.dw 0x2e 0x0 0x2b 0x0 0x2d 0x0 0x29 0x0 0x26 0x0 0x28 0x0 0x24 0x0 0x24 0x0 0x21 0x0 0x1d 0x0 
.dw 0x22 0x0 0x24 0x0 0x23 0x0 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 0x2e 0x0 0x2b 0x0 0x2d 0x0 
.dw 0x29 0x0 0x26 0x0 0x28 0x0 0x24 0x0 0x1d 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x29 0x0 0x29 0x0 
.dw 0x22 0x0 0x1d 0x0 0x21 0x0 0x24 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x24 0x0 0x29 0x0 0x22 0x0 
.dw 0x29 0x0 0x29 0x0 0x22 0x0 0x1d 0x0 0x25 0x0 0x27 0x0 0x29 0x0 0x24 0x0 0x24 0x0 0x1d 0x0 
.dw 0x1d 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1d 0x0 0x21 0x0 0x24 0x0 
.dw 0x29 0x0 0x24 0x0 0x1d 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1d 0x0 
.dw 0x25 0x0 0x27 0x0 0x29 0x0 0x24 0x0 0x24 0x0 0x1d 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 
.dw 0x1d 0x0 0x18 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 0x19 0x0 0x20 0x0 
.dw 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x24 0x0 
.dw 0x24 0x0 0x21 0x0 0x1d 0x0 0x22 0x0 0x24 0x0 0x23 0x0 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 
.dw 0x2e 0x0 0x2b 0x0 0x2d 0x0 0x29 0x0 0x26 0x0 0x28 0x0 0x24 0x0 0x24 0x0 0x21 0x0 0x1d 0x0 
.dw 0x22 0x0 0x24 0x0 0x23 0x0 0x22 0x0 0x21 0x0 0x29 0x0 0x2d 0x0 0x2e 0x0 0x2b 0x0 0x2d 0x0 
.dw 0x29 0x0 0x26 0x0 0x28 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 
.dw 0x29 0x0 0x29 0x0 0x22 0x0 0x1f 0x0 0x22 0x0 0x24 0x0 0x28 0x0 0x24 0x0 0x24 0x0 0x29 0x0 
.dw 0x29 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 
.dw 0x22 0x0 0x24 0x0 0x24 0x0 0x24 0x0 0x26 0x0 0x28 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x1d 0x0 
.dw 0x23 0x0 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1f 0x0 0x22 0x0 
.dw 0x24 0x0 0x28 0x0 0x24 0x0 0x24 0x0 0x29 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 
.dw 0x29 0x0 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x24 0x0 0x24 0x0 0x24 0x0 0x26 0x0 
.dw 0x28 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 
.dw 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 0x1d 0x0 0x18 0x0 0x19 0x0 0x20 0x0 0x25 0x0 0x24 0x0 
.dw 0x1d 0x0 0x18 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x1f 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 
.dw 0x24 0x0 0x29 0x0 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x1f 0x0 0x22 0x0 0x24 0x0 
.dw 0x28 0x0 0x24 0x0 0x24 0x0 0x29 0x0 0x29 0x0 0x24 0x0 0x1d 0x0 0x23 0x0 0x24 0x0 0x29 0x0 
.dw 0x22 0x0 0x22 0x0 0x29 0x0 0x29 0x0 0x22 0x0 0x24 0x0 0x24 0x0 0x24 0x0 0x26 0x0 0x28 0x0 
.dw 0x29 0x0 0x24 0x0 

MUSICLOWLENS:
; music duration data
.dw 1 149 1 146 145 145 150 146 1 144 732 150 436 150 291 145 297 145 296 
.dw 146 145 145 150 146 1 144 145 100 97 97 98 94 97 150 146 145 1 145 150 
.dw 146 145 145 1 150 1 146 290 150 291 145 297 144 296 146 145 145 150 146 1 
.dw 144 145 100 97 97 98 94 97 150 146 144 1 145 150 146 145 145 1 150 1 
.dw 146 290 150 291 145 297 144 145 150 291 145 1 150 146 144 145 150 291 145 297 
.dw 144 1 145 884 144 145 150 291 145 297 144 145 150 291 145 1 150 146 144 145 
.dw 150 146 144 296 146 290 150 291 145 1 150 146 144 145 150 291 145 297 144 145 
.dw 150 291 145 1 150 146 144 145 150 291 145 297 144 1 145 884 144 145 150 291 
.dw 145 297 144 145 150 291 145 1 150 146 144 145 150 146 144 296 146 290 150 291 
.dw 145 1 150 146 144 145 150 291 145 297 144 145 150 291 145 297 145 145 150 291 
.dw 145 297 145 145 150 291 145 297 145 145 150 291 145 297 145 145 150 291 145 297 
.dw 145 145 150 1 146 145 145 150 146 1 145 732 150 436 150 291 145 297 145 296 
.dw 146 145 145 150 146 1 145 145 100 97 97 98 94 97 150 146 145 1 145 150 
.dw 146 145 145 1 150 1 146 290 150 291 145 297 145 296 146 145 145 150 146 1 
.dw 145 145 100 97 97 98 94 97 150 146 145 1 145 150 146 145 145 1 150 1 
.dw 146 290 150 291 145 1 150 146 145 145 150 146 145 145 150 1 146 1 145 145 
.dw 150 291 145 1 150 146 145 145 150 146 145 145 150 1 146 1 145 145 150 291 
.dw 145 1 150 146 145 145 150 146 145 145 150 1 146 1 145 145 150 291 145 1 
.dw 100 97 97 98 94 97 150 146 145 145 150 436 150 291 145 1 150 146 145 145 
.dw 150 146 145 145 150 1 146 1 145 145 150 291 145 1 150 146 145 145 150 146 
.dw 145 145 150 1 146 1 145 145 150 291 145 1 150 146 144 145 150 146 144 145 
.dw 150 1 146 1 144 145 150 291 145 1 100 97 97 98 94 97 150 146 144 145 
.dw 150 436 150 291 145 297 144 145 150 291 145 297 144 145 150 291 145 297 144 145 
.dw 150 291 145 297 144 145 150 291 145 297 144 145 150 291 145 297 144 145 150 1 
.dw 146 145 145 150 146 1 144 732 150 436 150 291 145 1 150 146 144 145 150 146 
.dw 144 145 150 1 146 1 144 145 150 291 145 1 150 146 144 145 150 146 144 145 
.dw 150 1 146 1 144 145 150 291 145 1 150 146 144 145 150 146 144 145 150 1 
.dw 146 1 144 145 150 291 145 1 100 97 97 98 94 97 150 146 144 145 150 436 
.dw 150 291 145 297 144 296 146 145 145 150 146 1 144 145 100 97 97 98 94 97 
.dw 150 146 144 1 145 150 146 145 145 1 150 1 146 290 150 291 145 297 144 296 
.dw 146 145 145 150 146 1 144 145 100 97 97 98 94 97 150 146 144 1 145 150 
.dw 146 145 145 1 150 1 146 290 150 291 145 297 144 145 150 291 145 1 150 146 
.dw 144 145 150 291 145 297 144 1 145 884 144 145 150 291 145 297 144 145 150 291 
.dw 145 1 150 146 144 145 150 146 144 296 146 290 150 291 145 1 150 146 144 145 
.dw 150 291 145 297 144 145 150 291 145 1 150 146 144 145 150 291 145 297 144 1 
.dw 145 884 144 145 150 291 145 297 144 145 150 291 145 1 150 146 144 145 150 146 
.dw 144 296 146 290 150 291 145 1 150 146 144 145 150 291 145 297 144 145 150 291 
.dw 145 297 144 145 150 291 145 297 144 145 150 291 145 297 144 145 150 291 145 297 
.dw 144 145 150 291 145 297 144 145 150 1 146 145 145 150 146 1 144 732 150 436 
.dw 150 291 145 297 144 296 146 145 145 150 146 1 144 145 100 97 97 98 94 97 
.dw 150 146 144 1 145 150 146 145 145 1 150 1 146 290 150 291 145 297 145 296 
.dw 146 145 145 150 146 1 145 145 100 97 97 98 94 97 150 146 145 1 145 150 
.dw 146 145 145 1 150 1 146 290 150 291 145 1 150 146 145 145 150 146 145 145 
.dw 150 1 146 1 145 145 150 291 145 1 150 146 145 145 150 146 145 145 150 1 
.dw 146 1 145 145 150 291 145 1 150 146 145 145 150 146 145 145 150 1 146 1 
.dw 145 145 150 291 145 1 100 97 97 98 94 97 150 146 145 145 150 436 150 291 
.dw 145 1 150 146 145 145 150 146 145 145 150 1 146 1 145 145 150 291 145 1 
.dw 150 146 145 145 150 146 145 145 150 1 146 1 145 145 150 291 145 1 150 146 
.dw 145 145 150 146 145 145 150 1 146 1 145 145 150 291 145 1 100 97 97 98 
.dw 94 97 150 146 145 145 150 436 150 291 145 297 145 145 150 291 145 297 145 145 
.dw 150 291 145 297 145 145 150 291 145 297 145 145 150 291 145 297 145 145 150 291 
.dw 145 297 145 145 150 1 146 145 145 150 146 1 145 732 150 436 150 291 145 1 
.dw 150 146 145 145 150 146 145 145 150 1 146 1 145 145 150 291 145 1 150 146 
.dw 145 145 150 146 145 145 150 1 146 1 145 145 150 291 145 1 150 146 145 145 
.dw 150 146 145 145 150 1 146 1 145 145 150 291 145 1 100 97 97 98 94 97 
.dw 150 146 145 145 

SNESloop:
    
    read 0 r1 r3
    write 0 r2 r3

    jump SNESloop


; Prints to screen in window plane, with color, data is accessed in bytes
; Reads each word from left to right
; INPUT:
;   r1 = address of data to print
;   r2 = length of data
;   r3 = position on screen
;   r4 = palette index
GFXprintWindowColored:
    ; backup registers
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10

    ; vram address
    load 0x1420 r10
    loadhi 0xC0 r10                 ; r10 = vram addr 1056+4096 0xC01420

    ; loop variables
    load 0 r5                       ; r5 = loopvar
    or r10 r0 r6                    ; r6 = vram addr with offset
    or r1 r0 r7                     ; r7 = data addr with offset
    load 32 r8                      ; r8 = shift variable

    add r3 r6 r6                    ; apply offset from r3

    ; copy loop
    GFXprintWindowColoredLoop:
        sub r8 8 r8             ; remove 8 from shift variable
        read 0 r7 r9            ; read 32 bits
        shiftr r9 r8 r9         ; shift to right
        write 0 r6 r9           ; write char to vram
        write 2048 r6 r4        ; write palette index to vram
        add r6 1 r6             ; incr vram address

        bne r0 r8 3             ; if we shifted the last byte
            add r7 1 r7             ; incr data address 
            load 32 r8              ; set shift variable back to 24

        add r5 1 r5             ; incr counter
        bge r5 r2 2             ; keep looping until all data is copied
        jump GFXprintWindowColoredLoop

    ; restore registers
    pop r10
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5

    ; return
    pop r15
    jumpr 3 r15


; Prints to screen in window plane, data is accessed in bytes
; Reads each word from left to right
; INPUT:
;   r1 = address of data to print
;   r2 = length of data
;   r3 = position on screen
GFXprintWindow:
    ; backup registers
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9

    ; vram address
    load 0x1420 r4
    loadhi 0xC0 r4                 ; r10 = vram addr 1056+4096 0xC01420

    ; loop variables
    load 0 r5                       ; r5 = loopvar
    or r4 r0 r6                     ; r6 = vram addr with offset
    or r1 r0 r7                     ; r7 = data addr with offset
    load 32 r8                      ; r8 = shift variable

    add r3 r6 r6                    ; apply offset from r3

    ; copy loop
    GFXprintWindowLoop:
        sub r8 8 r8             ; remove 8 from shift variable
        read 0 r7 r9            ; read 32 bits
        shiftr r9 r8 r9         ; shift to right
        write 0 r6 r9           ; write char to vram
        add r6 1 r6             ; incr vram address

        bne r0 r8 3             ; if we shifted the last byte
            add r7 1 r7             ; incr data address 
            load 32 r8              ; set shift variable back to 24

        add r5 1 r5             ; incr counter
        bge r5 r2 2             ; keep looping until all data is copied
        jump GFXprintWindowLoop

    ; restore registers
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4

    ; return
    pop r15
    jumpr 3 r15
   

; Prints to screen in BG plane, with color, data is accessed in bytes
; Reads each word from left to right
; INPUT:
;   r1 = address of data to print
;   r2 = length of data
;   r3 = position on screen
;   r4 = palette index
GFXprintBGColored:
    ; backup registers
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10

    ; vram address
    load 0x0420 r10
    loadhi 0xC0 r10                 ; r10 = vram addr 1056 0xC00420

    ; loop variables
    load 0 r5                       ; r5 = loopvar
    or r10 r0 r6                    ; r6 = vram addr with offset
    or r1 r0 r7                     ; r7 = data addr with offset
    load 32 r8                      ; r8 = shift variable

    add r3 r6 r6                    ; apply offset from r3

    ; copy loop
    GFXprintBGColoredLoop:
        sub r8 8 r8             ; remove 8 from shift variable
        read 0 r7 r9            ; read 32 bits
        shiftr r9 r8 r9         ; shift to right
        write 0 r6 r9           ; write char to vram
        write 2048 r6 r4        ; write palette index to vram
        add r6 1 r6             ; incr vram address

        bne r0 r8 3             ; if we shifted the last byte
            add r7 1 r7             ; incr data address 
            load 32 r8              ; set shift variable back to 24

        add r5 1 r5             ; incr counter
        bge r5 r2 2             ; keep looping until all data is copied
        jump GFXprintBGColoredLoop

    ; restore registers
    pop r10
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5

    ; return
    pop r15
    jumpr 3 r15


; Prints to screen in window plane, data is accessed in bytes
; Reads each word from left to right
; INPUT:
;   r1 = address of data to print
;   r2 = length of data
;   r3 = position on screen
GFXprintBG:
    ; backup registers
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9

    ; vram address
    load 0x0420 r4
    loadhi 0xC0 r4                 ; r10 = vram addr 1056 0xC00420

    ; loop variables
    load 0 r5                       ; r5 = loopvar
    or r4 r0 r6                     ; r6 = vram addr with offset
    or r1 r0 r7                     ; r7 = data addr with offset
    load 32 r8                      ; r8 = shift variable

    add r3 r6 r6                    ; apply offset from r3

    ; copy loop
    GFXprintBGLoop:
        sub r8 8 r8             ; remove 8 from shift variable
        read 0 r7 r9            ; read 32 bits
        shiftr r9 r8 r9         ; shift to right
        write 0 r6 r9           ; write char to vram
        add r6 1 r6             ; incr vram address

        bne r0 r8 3             ; if we shifted the last byte
            add r7 1 r7             ; incr data address 
            load 32 r8              ; set shift variable back to 24

        add r5 1 r5             ; incr counter
        bge r5 r2 2             ; keep looping until all data is copied
        jump GFXprintBGLoop

    ; restore registers
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4

    ; return
    pop r15
    jumpr 3 r15


; Initialize VRAM by copying pattern table and palette table
; also clears BG tile and BG palette table
GFXinitVram:
    ; ascii address
    addr2reg ASCIITABLE r1 

    savpc r15
    push r15
    jump GFXcopyPatternTable

    ; palette address
    addr2reg PALETTETABLE r1 

    savpc r15
    push r15
    jump GFXcopyPaletteTable

    savpc r15
    push r15
    jump GFXclearBGtileTable

    savpc r15
    push r15
    jump GFXclearBGpaletteTable

    savpc r15
    push r15
    jump GFXclearWindowtileTable

    savpc r15
    push r15
    jump GFXclearWindowpaletteTable

    ; return
    pop r15
    jumpr 3 r15
  

; Loads entire pattern table
; INPUT:
;   r1 = address of pattern table to copy
GFXcopyPatternTable:
    ; backup registers
    push r2
    push r3
    push r4
    push r5
    push r6

    ; vram address
    load 0x0000 r2
    loadhi 0xC0 r2                  ; r2 = vram addr 0 0xC00000

    ; loop variables
    load 0 r3                       ; r3 = loopvar
    load GFX_PATTERN_TABLE_SIZE r4  ; r4 = loopmax
    or r2 r0 r5                     ; r5 = vram addr with offset
    or r1 r0 r6                     ; r6 = ascii addr with offset

    ; copy loop
    GFXinitPatternTableLoop:
        copy 0 r6 r5            ; copy ascii to vram
        add r5 1 r5             ; incr vram address
        add r6 1 r6             ; incr ascii address 
        add r3 1 r3             ; incr counter
        beq r3 r4 2             ; keep looping until all data is copied
        jump GFXinitPatternTableLoop

    ; restore registers
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2

    ; return
    pop r15
    jumpr 3 r15


; Loads entire palette table
; INPUT:
;   r1 = address of palette table to copy
GFXcopyPaletteTable:
    ; backup registers
    push r2
    push r3
    push r4
    push r5
    push r6

    ; vram address
    load 0x0400 r2
    loadhi 0xC0 r2                  ; r2 = vram addr 1024 0xC00400

    ; loop variables
    load 0 r3                       ; r3 = loopvar
    load GFX_PALETTE_TABLE_SIZE r4  ; r4 = loopmax
    or r2 r0 r5                     ; r5 = vram addr with offset
    or r1 r0 r6                     ; r6 = palette addr with offset

    ; copy loop
    GFXinitPaletteTableLoop:
        copy 0 r6 r5            ; copy palette to vram
        add r5 1 r5             ; incr vram address
        add r6 1 r6             ; incr palette address 
        add r3 1 r3             ; incr counter
        beq r3 r4 2             ; keep looping until all data is copied
        jump GFXinitPaletteTableLoop

    ; restore registers
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2

    ; return
    pop r15
    jumpr 3 r15


; Clear BG tile table
GFXclearBGtileTable:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5

    ; vram address
    load 0x0420 r1
    loadhi 0xC0 r1          ; r1 = vram addr 1056 0xC00420

    ; loop variables
    load 0 r3               ; r3 = loopvar
    load GFX_BG_TILES r4    ; r4 = loopmax
    or r1 r0 r5             ; r5 = vram addr with offset

    ; copy loop
    GFXclearBGtileTableLoop:
        write 0 r5 r0           ; clear tile
        add r5 1 r5             ; incr vram address
        add r3 1 r3             ; incr counter
        beq r3 r4 2             ; keep looping until all tiles are cleared
        jump GFXclearBGtileTableLoop

    ; restore registers
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15
  

; Clear BG palette table
GFXclearBGpaletteTable:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5

    ; vram address
    load 0x0C20 r1
    loadhi 0xC0 r1          ; r1 = vram addr 1056+2048 0xC00C20

    ; loop variables
    load 0 r3               ; r3 = loopvar
    load GFX_BG_TILES r4    ; r4 = loopmax
    or r1 r0 r5             ; r5 = vram addr with offset

    ; copy loop
    GFXclearBGpaletteTableLoop:
        write 0 r5 r0           ; clear tile
        add r5 1 r5             ; incr vram address
        add r3 1 r3             ; incr counter
        beq r3 r4 2             ; keep looping until all tiles are cleared
        jump GFXclearBGpaletteTableLoop

    ; restore registers
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


; Clear Window tile table
GFXclearWindowtileTable:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5

    ; vram address
    load 0x1420 r1
    loadhi 0xC0 r1          ; r1 = vram addr 1056+2048 0xC01420

    ; loop variables
    load 0 r3               ; r3 = loopvar
    load GFX_WINDOW_TILES r4    ; r4 = loopmax
    or r1 r0 r5             ; r5 = vram addr with offset

    ; copy loop
    GFXclearWindowtileTableLoop:
        write 0 r5 r0           ; clear tile
        add r5 1 r5             ; incr vram address
        add r3 1 r3             ; incr counter
        beq r3 r4 2             ; keep looping until all tiles are cleared
        jump GFXclearWindowtileTableLoop

    ; restore registers
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15
  

; Clear Window palette table
GFXclearWindowpaletteTable:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5

    ; vram address
    load 0x0C20 r1
    loadhi 0xC0 r1          ; r1 = vram addr 1056+2048 0xC00C20

    ; loop variables
    load 0 r3               ; r3 = loopvar
    load GFX_WINDOW_TILES r4    ; r4 = loopmax
    or r1 r0 r5             ; r5 = vram addr with offset

    ; copy loop
    GFXclearWindowpaletteTableLoop:
        write 0 r5 r0           ; clear tile
        add r5 1 r5             ; incr vram address
        add r3 1 r3             ; incr counter
        beq r3 r4 2             ; keep looping until all tiles are cleared
        jump GFXclearWindowpaletteTableLoop

    ; restore registers
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


Int1:
    ; CRAPPY MUSIC INTERRUPT CODE TONE1PLAYER
    push r1
    push r2
    push r3
    push r4
    push r5

    load 0x0000 r2
    loadhi 0x08 r2      ; r2 =  0x80000 | music index
                        ;       0x80001 | max music index
    read 0 r2 r5 

    load 0x2626 r1
    loadhi 0xC0 r1      ; r1 = Timer1 value register

    addr2reg MUSICLENS r3
    add r3 r5 r3
    read 0 r3 r3        ; get len data

    load 1 r4

    write 0 r1 r3       ; write timer1 value
    write 1 r1 r4       ; start timer1

    addr2reg MUSICNOTES r4
    add r4 r5 r4
    read 0 r4 r4        ; get note

    write 6 r1 r4       ; 0xC0262C TonePlayer1

    load 0x0000 r2
    loadhi 0x08 r2      ; r2 =  0x80000 | music index
                        ;       0x80001 | max music index

    read 0 r2 r3
    add r3 1 r3
    write 0 r2 r3

    ; restore registers
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    reti

Int2:
    ; CRAPPY MUSIC INTERRUPT CODE TONE2PLAYER
    push r1
    push r2
    push r3
    push r4
    push r5

    load 0x0002 r2
    loadhi 0x08 r2      ; r2 =  0x80002 | music index
                        ;       0x80001 | max music index
    read 0 r2 r5 

    load 0x2626 r1
    loadhi 0xC0 r1      ; r1 = Timer1 value register

    addr2reg MUSICLOWLENS r3
    add r3 r5 r3
    read 0 r3 r3        ; get len data

    load 1 r4

    write 2 r1 r3       ; write timer2 value
    write 3 r1 r4       ; start timer2

    addr2reg MUSICLOWNOTES r4
    add r4 r5 r4
    read 0 r4 r4        ; get note

    write 7 r1 r4       ; 0xC0262C TonePlayer2

    load 0x0002 r2
    loadhi 0x08 r2      ; r2 =  0x80002 | music index
                        ;       0x80001 | max music index

    read 0 r2 r3
    add r3 1 r3
    write 0 r2 r3

    ; restore registers
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    reti

Int3:
    push r1
    push r2
    push r3
    push r4
    push r5

    load 0x262E r1
    loadhi 0xC0 r1

    read 1 r1 r2

    ; vram address
    load 0x1420 r1
    loadhi 0xC0 r1          ; r1 = vram addr 1056+2048 0xC01420

    load 0x0003 r3
    loadhi 0x08 r3      ; r2 =  0x80003 | counter

    read 0 r3 r4

    add r4 r1 r1
    write 0 r1 r2

    add r4 1 r4
    write 0 r3 r4


    ; restore registers
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1
    reti

Int4:
    push r1
    push r2
    push r3
    push r4
    push r5

    ; x fine address 0xC02421
    load 0x2421 r1
    loadhi 0xC0 r1

    ; x offset address 0xC02420
    load 0x2420 r2
    loadhi 0xC0 r2

    read 0 r1 r3 ; fine value
    read 0 r2 r4 ; offset value

    ; check if we have to increase tile offset
    and r3 0b111 r5
    sub r5 0b111 r5
    bne r5 r0 3
        add r4 1 r4
        write 0 r2 r4


    add r3 1 r3
    write 0 r1 r3

    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    reti


PALETTETABLE:
.dw 0b00000000000000001111111111111111 ; black, black,  white,  white
.dw 0b00000011000000000000000000011101 ; blue, black, black, greenblueish
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
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000


ASCIITABLE:
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111111111001100000000000011
.dw 0b11001100001100111100000000000011
.dw 0b11001111111100111100001111000011
.dw 0b11000000000000110011111111111100
.dw 0b00111111111111001111111111111111
.dw 0b11110011110011111111111111111111
.dw 0b11110000000011111111110000111111
.dw 0b11111111111111110011111111111100
.dw 0b00111100111100001111111111111100
.dw 0b11111111111111001111111111111100
.dw 0b00111111111100000000111111000000
.dw 0b00000011000000000000000000000000
.dw 0b00000011000000000000111111000000
.dw 0b00111111111100001111111111111100
.dw 0b00111111111100000000111111000000
.dw 0b00000011000000000000000000000000
.dw 0b00001111110000000011111111110000
.dw 0b00001111110000001111111111111100
.dw 0b11111111111111001111001100111100
.dw 0b00000011000000000000111111000000
.dw 0b00000011000000000000001100000000
.dw 0b00001111110000000011111111110000
.dw 0b11111111111111000011111111110000
.dw 0b00000011000000000000111111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011110000000000111111110000
.dw 0b00001111111100000000001111000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111111111111111111111
.dw 0b11111100001111111111000000001111
.dw 0b11110000000011111111110000111111
.dw 0b11111111111111111111111111111111
.dw 0b00000000000000000000111111110000
.dw 0b00111100001111000011000000001100
.dw 0b00110000000011000011110000111100
.dw 0b00001111111100000000000000000000
.dw 0b11111111111111111111000000001111
.dw 0b11000011110000111100111111110011
.dw 0b11001111111100111100001111000011
.dw 0b11110000000011111111111111111111
.dw 0b00000000111111110000000000111111
.dw 0b00000000111111110011111111110011
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000011111111000000
.dw 0b00001111111100000011110000111100
.dw 0b00111100001111000011110000111100
.dw 0b00001111111100000000001111000000
.dw 0b00111111111111000000001111000000
.dw 0b00001111111111110000111100001111
.dw 0b00001111111111110000111100000000
.dw 0b00001111000000000011111100000000
.dw 0b11111111000000001111110000000000
.dw 0b00111111111111110011110000001111
.dw 0b00111111111111110011110000001111
.dw 0b00111100000011110011110000111111
.dw 0b11111100001111001111000000000000
.dw 0b00000011110000001111001111001111
.dw 0b00001111111100001111110000111111
.dw 0b11111100001111110000111111110000
.dw 0b11110011110011110000001111000000
.dw 0b11000000000000001111110000000000
.dw 0b11111111110000001111111111111100
.dw 0b11111111110000001111110000000000
.dw 0b11000000000000000000000000000000
.dw 0b00000000000011000000000011111100
.dw 0b00001111111111001111111111111100
.dw 0b00001111111111000000000011111100
.dw 0b00000000000011000000000000000000
.dw 0b00000011110000000000111111110000
.dw 0b00111111111111000000001111000000
.dw 0b00000011110000000011111111111100
.dw 0b00001111111100000000001111000000
.dw 0b00111100001111000011110000111100
.dw 0b00111100001111000011110000111100
.dw 0b00111100001111000000000000000000
.dw 0b00111100001111000000000000000000
.dw 0b00111111111111111111001111001111
.dw 0b11110011110011110011111111001111
.dw 0b00000011110011110000001111001111
.dw 0b00000011110011110000000000000000
.dw 0b00001111111111000011110000001111
.dw 0b00001111110000000011110011110000
.dw 0b00111100111100000000111111000000
.dw 0b11110000111100000011111111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111111111000011111111111100
.dw 0b00111111111111000000000000000000
.dw 0b00000011110000000000111111110000
.dw 0b00111111111111000000001111000000
.dw 0b00111111111111000000111111110000
.dw 0b00000011110000001111111111111111
.dw 0b00000011110000000000111111110000
.dw 0b00111111111111000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00111111111111000000111111110000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000000000001111000000
.dw 0b00000000111100001111111111111100
.dw 0b00000000111100000000001111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00111100000000001111111111111100
.dw 0b00111100000000000000111100000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110000000000001111000000000000
.dw 0b11110000000000001111111111111100
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000110000110000
.dw 0b00111100001111001111111111111111
.dw 0b00111100001111000000110000110000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000001111000000
.dw 0b00001111111100000011111111111100
.dw 0b11111111111111111111111111111111
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000001111111111111111
.dw 0b11111111111111110011111111111100
.dw 0b00001111111100000000001111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00001111000000000011111111000000
.dw 0b00111111110000000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b00001111000000000000000000000000
.dw 0b00111100111100000011110011110000
.dw 0b00111100111100000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111100111100000011110011110000
.dw 0b11111111111111000011110011110000
.dw 0b11111111111111000011110011110000
.dw 0b00111100111100000000000000000000
.dw 0b00001111000000000011111111110000
.dw 0b11110000000000000011111111000000
.dw 0b00000000111100001111111111000000
.dw 0b00001111000000000000000000000000
.dw 0b00000000000000001111000000111100
.dw 0b11110000111100000000001111000000
.dw 0b00001111000000000011110000111100
.dw 0b11110000001111000000000000000000
.dw 0b00001111110000000011110011110000
.dw 0b00001111110000000011111100111100
.dw 0b11110011111100001111000011110000
.dw 0b00111111001111000000000000000000
.dw 0b00111100000000000011110000000000
.dw 0b11110000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011110000000000111100000000
.dw 0b00111100000000000011110000000000
.dw 0b00111100000000000000111100000000
.dw 0b00000011110000000000000000000000
.dw 0b00111100000000000000111100000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000111100000000
.dw 0b00111100000000000000000000000000
.dw 0b00000000000000000011110000111100
.dw 0b00001111111100001111111111111111
.dw 0b00001111111100000011110000111100
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000001111111111110000
.dw 0b00001111000000000000111100000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000000011110000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000001111111111110000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b00000000001111000000000011110000
.dw 0b00000011110000000000111100000000
.dw 0b00111100000000001111000000000000
.dw 0b11000000000000000000000000000000
.dw 0b00111111111100001111000000111100
.dw 0b11110000111111001111001111111100
.dw 0b11111111001111001111110000111100
.dw 0b00111111111100000000000000000000
.dw 0b00001111000000000011111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b11111111111100000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b00000000111100000000111111000000
.dw 0b00111100000000001111000011110000
.dw 0b11111111111100000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b00000000111100000000111111000000
.dw 0b00000000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000011111100000000111111110000
.dw 0b00111100111100001111000011110000
.dw 0b11111111111111000000000011110000
.dw 0b00000011111111000000000000000000
.dw 0b11111111111100001111000000000000
.dw 0b11111111110000000000000011110000
.dw 0b00000000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00001111110000000011110000000000
.dw 0b11110000000000001111111111000000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b11111111111100001111000011110000
.dw 0b00000000111100000000001111000000
.dw 0b00001111000000000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000111100000011111111000000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000111100000011111111110000
.dw 0b00000000111100000000001111000000
.dw 0b00111111000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000000011110000000000
.dw 0b00000011110000000000111100000000
.dw 0b00111100000000001111000000000000
.dw 0b00111100000000000000111100000000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111100000000000000000000
.dw 0b00000000000000001111111111110000
.dw 0b00000000000000000000000000000000
.dw 0b00111100000000000000111100000000
.dw 0b00000011110000000000000011110000
.dw 0b00000011110000000000111100000000
.dw 0b00111100000000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b00000000111100000000001111000000
.dw 0b00001111000000000000000000000000
.dw 0b00001111000000000000000000000000
.dw 0b00111111111100001111000000111100
.dw 0b11110011111111001111001111111100
.dw 0b11110011111111001111000000000000
.dw 0b00111111110000000000000000000000
.dw 0b00001111000000000011111111000000
.dw 0b11110000111100001111000011110000
.dw 0b11111111111100001111000011110000
.dw 0b11110000111100000000000000000000
.dw 0b11111111111100000011110000111100
.dw 0b00111100001111000011111111110000
.dw 0b00111100001111000011110000111100
.dw 0b11111111111100000000000000000000
.dw 0b00001111111100000011110000111100
.dw 0b11110000000000001111000000000000
.dw 0b11110000000000000011110000111100
.dw 0b00001111111100000000000000000000
.dw 0b11111111110000000011110011110000
.dw 0b00111100001111000011110000111100
.dw 0b00111100001111000011110011110000
.dw 0b11111111110000000000000000000000
.dw 0b11111111111111000011110000001100
.dw 0b00111100110000000011111111000000
.dw 0b00111100110000000011110000001100
.dw 0b11111111111111000000000000000000
.dw 0b11111111111111000011110000001100
.dw 0b00111100110000000011111111000000
.dw 0b00111100110000000011110000000000
.dw 0b11111111000000000000000000000000
.dw 0b00001111111100000011110000111100
.dw 0b11110000000000001111000000000000
.dw 0b11110000111111000011110000111100
.dw 0b00001111111111000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100001111111111110000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000000000000000000
.dw 0b00111111110000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b00000011111111000000000011110000
.dw 0b00000000111100000000000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b11111100001111000011110000111100
.dw 0b00111100111100000011111111000000
.dw 0b00111100111100000011110000111100
.dw 0b11111100001111000000000000000000
.dw 0b11111111000000000011110000000000
.dw 0b00111100000000000011110000000000
.dw 0b00111100000011000011110000111100
.dw 0b11111111111111000000000000000000
.dw 0b11110000001111001111110011111100
.dw 0b11111111111111001111111111111100
.dw 0b11110011001111001111000000111100
.dw 0b11110000001111000000000000000000
.dw 0b11110000001111001111110000111100
.dw 0b11111111001111001111001111111100
.dw 0b11110000111111001111000000111100
.dw 0b11110000001111000000000000000000
.dw 0b00001111110000000011110011110000
.dw 0b11110000001111001111000000111100
.dw 0b11110000001111000011110011110000
.dw 0b00001111110000000000000000000000
.dw 0b11111111111100000011110000111100
.dw 0b00111100001111000011111111110000
.dw 0b00111100000000000011110000000000
.dw 0b11111111000000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b11110011111100000011111111000000
.dw 0b00000011111100000000000000000000
.dw 0b11111111111100000011110000111100
.dw 0b00111100001111000011111111110000
.dw 0b00111100111100000011110000111100
.dw 0b11111100001111000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b00111100000000000000111100000000
.dw 0b00000011110000001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b11111111111100001100111100110000
.dw 0b00001111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b11111111111100000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000011111111000000
.dw 0b00001111000000000000000000000000
.dw 0b11110000001111001111000000111100
.dw 0b11110000001111001111001100111100
.dw 0b11111111111111001111110011111100
.dw 0b11110000001111000000000000000000
.dw 0b11110000001111001111000000111100
.dw 0b00111100111100000000111111000000
.dw 0b00001111110000000011110011110000
.dw 0b11110000001111000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000011111111000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b11111111111111001111000000111100
.dw 0b11000000111100000000001111000000
.dw 0b00001111000011000011110000111100
.dw 0b11111111111111000000000000000000
.dw 0b00111111110000000011110000000000
.dw 0b00111100000000000011110000000000
.dw 0b00111100000000000011110000000000
.dw 0b00111111110000000000000000000000
.dw 0b11110000000000000011110000000000
.dw 0b00001111000000000000001111000000
.dw 0b00000000111100000000000000111100
.dw 0b00000000000011000000000000000000
.dw 0b00111111110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00111111110000000000000000000000
.dw 0b00000011000000000000111111000000
.dw 0b00111100111100001111000000111100
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000001111111111111111
.dw 0b00001111000000000000111100000000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111110000000000000011110000
.dw 0b00111111111100001111000011110000
.dw 0b00111111001111000000000000000000
.dw 0b11111100000000000011110000000000
.dw 0b00111100000000000011111111110000
.dw 0b00111100001111000011110000111100
.dw 0b11110011111100000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000000000001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000011111100000000000011110000
.dw 0b00000000111100000011111111110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111001111000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11111111111100001111000000000000
.dw 0b00111111110000000000000000000000
.dw 0b00001111110000000011110011110000
.dw 0b00111100000000001111111100000000
.dw 0b00111100000000000011110000000000
.dw 0b11111111000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111001111001111000011110000
.dw 0b11110000111100000011111111110000
.dw 0b00000000111100001111111111000000
.dw 0b11111100000000000011110000000000
.dw 0b00111100111100000011111100111100
.dw 0b00111100001111000011110000111100
.dw 0b11111100001111000000000000000000
.dw 0b00001111000000000000000000000000
.dw 0b00111111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b00000000111100000000000000000000
.dw 0b00000000111100000000000011110000
.dw 0b00000000111100001111000011110000
.dw 0b11110000111100000011111111000000
.dw 0b11111100000000000011110000000000
.dw 0b00111100001111000011110011110000
.dw 0b00111111110000000011110011110000
.dw 0b11111100001111000000000000000000
.dw 0b00111111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110000111100001111111111111100
.dw 0b11111111111111001111001100111100
.dw 0b11110000001111000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111110000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110011111100000011110000111100
.dw 0b00111100001111000011111111110000
.dw 0b00111100000000001111111100000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111001111001111000011110000
.dw 0b11110000111100000011111111110000
.dw 0b00000000111100000000001111111100
.dw 0b00000000000000000000000000000000
.dw 0b11110011111100000011111100111100
.dw 0b00111100001111000011110000000000
.dw 0b11111111000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111111100001111000000000000
.dw 0b00111111110000000000000011110000
.dw 0b11111111110000000000000000000000
.dw 0b00000011000000000000111100000000
.dw 0b00111111111100000000111100000000
.dw 0b00001111000000000000111100110000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111001111000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000011111111000000
.dw 0b00001111000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110000001111001111001100111100
.dw 0b11111111111111001111111111111100
.dw 0b00111100111100000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110000001111000011110011110000
.dw 0b00001111110000000011110011110000
.dw 0b11110000001111000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000011111111110000
.dw 0b00000000111100001111111111000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111100001100001111000000
.dw 0b00001111000000000011110000110000
.dw 0b11111111111100000000000000000000
.dw 0b00000011111100000000111100000000
.dw 0b00001111000000001111110000000000
.dw 0b00001111000000000000111100000000
.dw 0b00000011111100000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000000000000000
.dw 0b11111100000000000000111100000000
.dw 0b00001111000000000000001111110000
.dw 0b00001111000000000000111100000000
.dw 0b11111100000000000000000000000000
.dw 0b00111111001111001111001111110000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000001100000000
.dw 0b00001111110000000011110011110000
.dw 0b11110000001111001111000000111100
.dw 0b11111111111111000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000000000001111000011110000
.dw 0b00111111110000000000001111000000
.dw 0b00000000111100000011111111000000
.dw 0b00000000000000001111000011110000
.dw 0b00000000000000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b00000011111100000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11111111111100001111000000000000
.dw 0b00111111110000000000000000000000
.dw 0b00111111111111001111000000001111
.dw 0b00001111111100000000000000111100
.dw 0b00001111111111000011110000111100
.dw 0b00001111111111110000000000000000
.dw 0b11110000111100000000000000000000
.dw 0b00111111110000000000000011110000
.dw 0b00111111111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b11111100000000000000000000000000
.dw 0b00111111110000000000000011110000
.dw 0b00111111111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000011110000
.dw 0b00111111111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111110000001111000000000000
.dw 0b11110000000000000011111111000000
.dw 0b00000000111100000000111111000000
.dw 0b00111111111111001111000000001111
.dw 0b00001111111100000011110000111100
.dw 0b00111111111111000011110000000000
.dw 0b00001111111100000000000000000000
.dw 0b11110000111100000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11111111111100001111000000000000
.dw 0b00111111110000000000000000000000
.dw 0b11111100000000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11111111111100001111000000000000
.dw 0b00111111110000000000000000000000
.dw 0b11110000111100000000000000000000
.dw 0b00111111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b00111111111100001111000000111100
.dw 0b00001111110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00001111111100000000000000000000
.dw 0b11111100000000000000000000000000
.dw 0b00111111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b11110000001111000000111111000000
.dw 0b00111100111100001111000000111100
.dw 0b11111111111111001111000000111100
.dw 0b11110000001111000000000000000000
.dw 0b00001111000000000000111100000000
.dw 0b00000000000000000011111111000000
.dw 0b11110000111100001111111111110000
.dw 0b11110000111100000000000000000000
.dw 0b00000011111100000000000000000000
.dw 0b11111111111100000011110000000000
.dw 0b00111111110000000011110000000000
.dw 0b11111111111100000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111111111110000000011110000
.dw 0b00111111111111111111000011110000
.dw 0b00111111111111110000000000000000
.dw 0b00001111111111000011110011110000
.dw 0b11110000111100001111111111111100
.dw 0b11110000111100001111000011110000
.dw 0b11110000111111000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b00000000000000000011111111000000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000001111000011110000
.dw 0b00000000000000000011111111000000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000001111110000000000
.dw 0b00000000000000000011111111000000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b00000000000000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b00000000000000001111110000000000
.dw 0b00000000000000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b00000000000000001111000011110000
.dw 0b00000000000000001111000011110000
.dw 0b11110000111100000011111111110000
.dw 0b00000000111100001111111111000000
.dw 0b11110000000011110000001111000000
.dw 0b00001111111100000011110000111100
.dw 0b00111100001111000000111111110000
.dw 0b00000011110000000000000000000000
.dw 0b11110000111100000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b00111111111111001111000000000000
.dw 0b11110000000000000011111111111100
.dw 0b00000011110000000000001111000000
.dw 0b00001111110000000011110011110000
.dw 0b00111100001100001111111100000000
.dw 0b00111100000000001111110000111100
.dw 0b11111111111100000000000000000000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000001111111111110000
.dw 0b00001111000000001111111111110000
.dw 0b00001111000000000000111100000000
.dw 0b11111111110000001111000011110000
.dw 0b11110000111100001111111111001100
.dw 0b11110000001111001111000011111111
.dw 0b11110000001111001111000000111111
.dw 0b00000000111111000000001111001111
.dw 0b00000011110000000000111111110000
.dw 0b00000011110000000000001111000000
.dw 0b11110011110000000011111100000000
.dw 0b00000011111100000000000000000000
.dw 0b00111111110000000000000011110000
.dw 0b00111111111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b00001111110000000000000000000000
.dw 0b00111111000000000000111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000001111110000
.dw 0b00000000000000000011111111000000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000001111110000
.dw 0b00000000000000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111111111000000000000000000
.dw 0b00000000000000001111111111000000
.dw 0b00000000000000001111111111000000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000000000000000000
.dw 0b11111111111100000000000000000000
.dw 0b11110000111100001111110011110000
.dw 0b11111111111100001111001111110000
.dw 0b11110000111100000000000000000000
.dw 0b00001111111100000011110011110000
.dw 0b00111100111100000000111111111100
.dw 0b00000000000000000011111111111100
.dw 0b00000000000000000000000000000000
.dw 0b00001111110000000011110011110000
.dw 0b00111100111100000000111111000000
.dw 0b00000000000000000011111111110000
.dw 0b00000000000000000000000000000000
.dw 0b00001111000000000000000000000000
.dw 0b00001111000000000011110000000000
.dw 0b11110000000000001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000001111111111110000
.dw 0b11110000000000001111000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000001111111111110000
.dw 0b00000000111100000000000011110000
.dw 0b00000000000000000000000000000000
.dw 0b11110000000011111111000000111100
.dw 0b11110000111100001111001111111100
.dw 0b00001111000011110011110000111100
.dw 0b11110000111100000000000011111111
.dw 0b11110000000011111111000000111100
.dw 0b11110000111100001111001111001111
.dw 0b00001111001111110011110011111111
.dw 0b11110000111111110000000000001111
.dw 0b00000011110000000000001111000000
.dw 0b00000000000000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000000000111100001111
.dw 0b00111100001111001111000011110000
.dw 0b00111100001111000000111100001111
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000001111000011110000
.dw 0b00111100001111000000111100001111
.dw 0b00111100001111001111000011110000
.dw 0b00000000000000000000000000000000
.dw 0b00001100000011001100000011000000
.dw 0b00001100000011001100000011000000
.dw 0b00001100000011001100000011000000
.dw 0b00001100000011001100000011000000
.dw 0b00110011001100111100110011001100
.dw 0b00110011001100111100110011001100
.dw 0b00110011001100111100110011001100
.dw 0b00110011001100111100110011001100
.dw 0b11110011110011110011111100111111
.dw 0b11110011110011111111110011111100
.dw 0b11110011110011110011111100111111
.dw 0b11110011110011111111110011111100
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b11111111110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b11111111110000000000001111000000
.dw 0b11111111110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b11111111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00000000000000000000000000000000
.dw 0b11111111110000000000001111000000
.dw 0b11111111110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00001111001111000000111100111100
.dw 0b11111111001111000000000000111100
.dw 0b11111111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111000000000000111100
.dw 0b11111111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b11111111001111000000000000111100
.dw 0b11111111111111000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b11111111111111000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b11111111110000000000001111000000
.dw 0b11111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b11111111111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011111111110000001111000000
.dw 0b00000011111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111110000111100000000
.dw 0b00001111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00001111111111110000111100000000
.dw 0b00001111001111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b11111111001111110000000000000000
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111110000000000000000
.dw 0b11111111001111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111110000111100000000
.dw 0b00001111001111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111110000000000000000
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00001111001111000000111100111100
.dw 0b11111111001111110000000000000000
.dw 0b11111111001111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00000011110000000000001111000000
.dw 0b11111111111111110000000000000000
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b11111111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111110000000000000000
.dw 0b11111111111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011111111110000001111000000
.dw 0b00000011111111110000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011111111110000001111000000
.dw 0b00000011111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00001111111111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b11111111111111110000111100111100
.dw 0b00001111001111000000111100111100
.dw 0b00000011110000000000001111000000
.dw 0b11111111111111110000001111000000
.dw 0b11111111111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b11111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011111111110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b11111111000000001111111100000000
.dw 0b11111111000000001111111100000000
.dw 0b11111111000000001111111100000000
.dw 0b11111111000000001111111100000000
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b00000000111111110000000011111111
.dw 0b11111111111111111111111111111111
.dw 0b11111111111111111111111111111111
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111001111001111001111110000
.dw 0b11110000110000001111001111110000
.dw 0b00111111001111000000000000000000
.dw 0b00000000000000000011111111000000
.dw 0b11110000111100001111111111000000
.dw 0b11110000111100001111111111000000
.dw 0b11110000000000001111000000000000
.dw 0b00000000000000001111111111110000
.dw 0b11110000111100001111000000000000
.dw 0b11110000000000001111000000000000
.dw 0b11110000000000000000000000000000
.dw 0b00000000000000001111111111111100
.dw 0b00111100111100000011110011110000
.dw 0b00111100111100000011110011110000
.dw 0b00111100111100000000000000000000
.dw 0b11111111111100001111000011110000
.dw 0b00111100000000000000111100000000
.dw 0b00111100000000001111000011110000
.dw 0b11111111111100000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111111111001111001111000000
.dw 0b11110011110000001111001111000000
.dw 0b00111111000000000000000000000000
.dw 0b00000000000000000011110000111100
.dw 0b00111100001111000011110000111100
.dw 0b00111100001111000011111111110000
.dw 0b00111100000000001111000000000000
.dw 0b00000000000000000011111100111100
.dw 0b11110011111100000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000000000000000
.dw 0b11111111111100000000111100000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000111100000011111111000000
.dw 0b00001111000000001111111111110000
.dw 0b00001111110000000011110011110000
.dw 0b11110000001111001111111111111100
.dw 0b11110000001111000011110011110000
.dw 0b00001111110000000000000000000000
.dw 0b00001111110000000011110011110000
.dw 0b11110000001111001111000000111100
.dw 0b00111100111100000011110011110000
.dw 0b11111100111111000000000000000000
.dw 0b00000011111100000000111100000000
.dw 0b00000011110000000011111111110000
.dw 0b11110000111100001111000011110000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111111111001111001111001111
.dw 0b11110011110011110011111111111100
.dw 0b00000000000000000000000000000000
.dw 0b00000000001111000000000011110000
.dw 0b00111111111111001111001111001111
.dw 0b11110011110011110011111111111100
.dw 0b00111100000000001111000000000000
.dw 0b00001111110000000011110000000000
.dw 0b11110000000000001111111111000000
.dw 0b11110000000000000011110000000000
.dw 0b00001111110000000000000000000000
.dw 0b00111111110000001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100001111000011110000
.dw 0b11110000111100000000000000000000
.dw 0b00000000000000001111111111110000
.dw 0b00000000000000001111111111110000
.dw 0b00000000000000001111111111110000
.dw 0b00000000000000000000000000000000
.dw 0b00001111000000000000111100000000
.dw 0b11111111111100000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b11111111111100000000000000000000
.dw 0b00111100000000000000111100000000
.dw 0b00000011110000000000111100000000
.dw 0b00111100000000000000000000000000
.dw 0b11111111111100000000000000000000
.dw 0b00000011110000000000111100000000
.dw 0b00111100000000000000111100000000
.dw 0b00000011110000000000000000000000
.dw 0b11111111111100000000000000000000
.dw 0b00000000111111000000001111001111
.dw 0b00000011110011110000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000000000001111000000
.dw 0b00000011110000001111001111000000
.dw 0b11110011110000000011111100000000
.dw 0b00001111000000000000111100000000
.dw 0b00000000000000001111111111110000
.dw 0b00000000000000000000111100000000
.dw 0b00001111000000000000000000000000
.dw 0b00000000000000000011111100111100
.dw 0b11110011111100000000000000000000
.dw 0b00111111001111001111001111110000
.dw 0b00000000000000000000000000000000
.dw 0b00001111110000000011110011110000
.dw 0b00111100111100000000111111000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000001111000000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000011110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000111111110000000011110000
.dw 0b00000000111100000000000011110000
.dw 0b11111100111100000011110011110000
.dw 0b00001111111100000000001111110000
.dw 0b00111111110000000011110011110000
.dw 0b00111100111100000011110011110000
.dw 0b00111100111100000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00111111000000000000001111000000
.dw 0b00001111000000000011110000000000
.dw 0b00111111110000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00001111111100000000111111110000
.dw 0b00001111111100000000111111110000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000
.dw 0b00000000000000000000000000000000