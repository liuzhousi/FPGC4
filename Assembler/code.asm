   ; all required addresses
    ;load 0x2631 r1
    ;loadhi 0xC0 r1      ; r1 = 0xC02631 | SPI address

    ;load 0x262E r2
    ;loadhi 0xC0 r2      ; r2 = 0xC0262E | UART tx

    ;spi_write and spi_read are just a single write and read operation,
    ; and therefore do not need seperate functions

define CMD_GET_IC_VER           =   0x01
define CMD_SET_BAUDRATE         =   0x02
define CMD_ENTER_SLEEP          =   0x03
define CMD_SET_USB_SPEED        =   0x04
define CMD_RESET_ALL            =   0x05
define CMD_CHECK_EXIST          =   0x06
define CMD_SET_SD0_INT          =   0x0b
define CMD_SET_RETRY            =   0x0b
define CMD_GET_FILE_SIZE        =   0x0c
define CMD_SET_USB_ADDRESS      =   0x13
define CMD_SET_USB_MODE         =   0x15
define MODE_HOST_0              =   0x05
define MODE_HOST_1              =   0x07
define MODE_HOST_2              =   0x06
define CMD_GET_STATUS           =   0x22
define CMD_RD_USB_DATA0         =   0x27
define CMD_WR_USB_DATA          =   0x2c
define CMD_WR_REQ_DATA          =   0x2d
define CMD_WR_OFS_DATA          =   0x2e
define CMD_SET_FILE_NAME        =   0x2f
define CMD_DISK_CONNECT         =   0x30
define CMD_DISK_MOUNT           =   0x31
define CMD_FILE_OPEN            =   0x32
define CMD_FILE_ENUM_GO         =   0x33
define CMD_FILE_CREATE          =   0x34
define CMD_FILE_ERASE           =   0x35
define CMD_FILE_CLOSE           =   0x36
define CMD_DIR_INFO_READ        =   0x37
define CMD_DIR_INFO_SAVE        =   0x38
define CMD_BYTE_LOCATE          =   0x39
define CMD_BYTE_READ            =   0x3a
define CMD_BYTE_RD_GO           =   0x3b
define CMD_BYTE_WRITE           =   0x3c
define CMD_BYTE_WR_GO           =   0x3d
define CMD_DISK_CAPACITY        =   0x3e
define CMD_DISK_QUERY           =   0x3f
define CMD_DIR_CREATE           =   0x40
define CMD_SET_ADDRESS          =   0x45
define CMD_GET_DESCR            =   0x46
define CMD_SET_CONFIG           =   0x49
define CMD_AUTO_CONFIG          =   0x4D
define CMD_ISSUE_TKN_X          =   0x4E
define ANSW_RET_SUCCESS         =   0x51
define ANSW_USB_INT_SUCCESS     =   0x14
define ANSW_USB_INT_CONNECT     =   0x15
define ANSW_USB_INT_DISCONNECT  =   0x16
define ANSW_USB_INT_USB_READY   =   0x18
define ANSW_USB_INT_DISK_READ   =   0x1d
define ANSW_USB_INT_DISK_WRITE  =   0x1e
define ANSW_RET_ABORT           =   0x5F
define ANSW_USB_INT_DISK_ERR    =   0x1f
define ANSW_USB_INT_BUF_OVER    =   0x17
define ANSW_ERR_OPEN_DIR        =   0x41
define ANSW_ERR_MISS_FILE       =   0x42
define ANSW_ERR_FOUND_NAME      =   0x43
define ANSW_ERR_DISK_DISCON     =   0x82
define ANSW_ERR_LARGE_SECTOR    =   0x84
define ANSW_ERR_TYPE_ERROR      =   0x92
define ANSW_ERR_BPB_ERROR       =   0xa1
define ANSW_ERR_DISK_FULL       =   0xb1
define ANSW_ERR_FDT_OVER        =   0xb2
define ANSW_ERR_FILE_CLOSE      =   0xb4
define ERR_LONGFILENAME         =   0x01
define ATTR_READ_ONLY           =   0x01
define ATTR_HIDDEN              =   0x02
define ATTR_SYSTEM              =   0x04
define ATTR_VOLUME_ID           =   0x08
define ATTR_DIRECTORY           =   0x10 
define ATTR_ARCHIVE             =   0x20

Main:
    savpc r15
    push r15
    jump CH376_init

    halt

 
; initialize CH376 module
CH376_init:
    ; backup regs
    push r1
    push r2
    push r3

    ; initialize cs as high by using SPI_endTransfer
    savpc r15
    push r15
    jump SPI_endTransfer

    addr2reg CH376_String_Init r1
    load 4 r2
    savpc r15
    push r15
    jump UART_print_text

    ; reset
    savpc r15
    push r15
    jump CH376_Reset

    ; set usb mode
    savpc r15
    push r15
    jump CH376_Set_USB_Mode

    ; set mode host 0
    savpc r15
    push r15
    jump CH376_Set_Mode_Host_0

    ; restore regs
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15
    

CH376_String_Init:
.ds "Init"

CH376_String_Reset_done:
.ds "Reset done"

CH376_String_USB_mode_set:
.ds "Set USB mode"

CH376_String_Mode_Host_0_set:
.ds "Set host mode 0"


; Send CMD_RESET_ALL and wait
CH376_Reset:
    ; backup regs
    push r1
    push r2

    savpc r15
    push r15
    jump SPI_beginTransfer

    load 0x2631 r1
    loadhi 0xC0 r1          ; r1 = 0xC02631 | SPI address
    load CMD_RESET_ALL r2
    write 0 r1 r2

    savpc r15
    push r15
    jump SPI_endTransfer

    savpc r15
    push r15
    jump CH376_Delay_100ms

    addr2reg CH376_String_Reset_done r1
    load 10 r2
    savpc r15
    push r15
    jump UART_print_text

    ; restore regs
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


; Set USB mode and wait a 40us
CH376_Set_USB_Mode:
    ; backup regs
    push r1
    push r2

    savpc r15
    push r15
    jump SPI_beginTransfer

    load 0x2631 r1
    loadhi 0xC0 r1          ; r1 = 0xC02631 | SPI address
    load CMD_SET_USB_MODE r2
    write 0 r1 r2

    savpc r15
    push r15
    jump SPI_endTransfer

    savpc r15
    push r15
    jump CH376_Delay_40us

    addr2reg CH376_String_USB_mode_set r1
    load 12 r2
    savpc r15
    push r15
    jump UART_print_text

    ; restore regs
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


; Set mode host 0, wait 40us and read status
CH376_Set_Mode_Host_0:
    ; backup regs
    push r1
    push r2
    push r3

    savpc r15
    push r15
    jump SPI_beginTransfer

    load 0x2631 r1
    loadhi 0xC0 r1          ; r1 = 0xC02631 | SPI address
    load MODE_HOST_0 r2
    write 0 r1 r2

    savpc r15
    push r15
    jump SPI_endTransfer

    ; delay 40us
    savpc r15
    push r15
    jump CH376_Delay_40us

    ; print to uart
    addr2reg CH376_String_Mode_Host_0_set r1
    load 15 r2
    savpc r15
    push r15
    jump UART_print_text

    ; read from SPI
    savpc r15
    push r15
    jump SPI_beginTransfer

    load 0x2631 r1
    loadhi 0xC0 r1          ; r1 = 0xC02631 | SPI address
    write 0 r1 r0
    read 0 r1 r2

    savpc r15
    push r15
    jump SPI_endTransfer


    ; print received char over uart
    load 0x262E r3
    loadhi 0xC0 r3          ; r3 = 0xC0262E | UART tx
    write 0 r3 r2

    ; restore regs
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


; Delay 100ms
; ~.5us per instruction
; 200.000 instructions to wait 100ms
CH376_Delay_100ms:
    ; backup regs
    push r1
    push r2

    load 0x046A r1
    loadhi 0x1  r1              ; r1 = loop max, 200.000/3 = 66.666
    load 0 r2                   ; r2 = loopvar

    ; delay loop
    CH376_Delay_100ms_loop:
        add r2 1 r2             ; incr counter
        bge r2 r1 2             ; keep looping until all iteration done
        jump CH376_Delay_100ms_loop


    ; restore regs
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


; Delay 40us
; ~.5us per instruction
; 80 instructions to wait 40us
CH376_Delay_40us:
    ; backup regs
    push r1
    push r2

    load 27 r1                  ; r1 = loop max, 80/3 = 27
    load 0 r2                   ; r2 = loopvar

    ; delay loop
    CH376_Delay_40us_loop:
        add r2 1 r2             ; incr counter
        bge r2 r1 2             ; keep looping until all iteration done
        jump CH376_Delay_40us_loop


    ; restore regs
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


; Prints text over UART
; INPUT:
;   r1: address of first byte
;   r2: length of data to print
UART_print_text:
    ; backup regs
    push r1
    push r2
    push r3
    push r5
    push r8
    push r9

    load 0x262E r3
    loadhi 0xC0 r3              ; r3 = 0xC0262E | UART tx

    ; loop variables
    load 0 r5                   ; r5 = loopvar
    load 32 r8                  ; r8 = shift variable

    ; copy loop
    UART_print_text_loop:
        sub r8 8 r8             ; remove 8 from shift variable
        read 0 r1 r9            ; read 32 bits
        shiftr r9 r8 r9         ; shift to right
        write 0 r3 r9           ; write char to UART tx

        bne r0 r8 3             ; if we shifted the last byte
            add r1 1 r1             ; incr data address 
            load 32 r8              ; set shift variable back to 24

        add r5 1 r5             ; incr counter
        bge r5 r2 2             ; keep looping until all data is copied
        jump UART_print_text_loop

    ; print \n (0x0A)
    load 0xA r2
    write 0 r3 r2

    ; restore regs
    pop r9
    pop r8
    pop r5
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15



; Sets GPO[0] (cs) low
SPI_beginTransfer:
    ; backup regs
    push r1
    push r2
    push r3

    load 0x2630 r3
    loadhi 0xC0 r3              ; r3 = 0xC02630 | GPIO

    read 0 r3 r1                ; r1 = GPIO values
    load 0b1111111011111111 r2  ; r2 = bitmask
    and r1 r2 r1                ; set GPO[0] low
    write 0 r3 r1               ; write GPIO

    ; restore regs
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


; Sets GPO[0] (cs) high
SPI_endTransfer:
    ; backup regs
    push r1
    push r2
    push r3

    load 0x2630 r3
    loadhi 0xC0 r3              ; r3 = 0xC02630 | GPIO

    read 0 r3 r1                ; r1 = GPIO values
    load 0b100000000 r2         ; r2 = bitmask
    or r1 r2 r1                 ; set GPO[0] high
    write 0 r3 r1               ; write GPIO

    ; restore regs
    pop r3
    pop r2
    pop r1

    ; return
    pop r15
    jumpr 3 r15


Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti
