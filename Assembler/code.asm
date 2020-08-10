; Setup stack and return function before jumping to Main of C program
Main:
    load32 0x700000 rsp     ; initialize stack address
    addr2reg Return_UART r1 ; get address of return function
    sub r1 4 r1             ; remove 4 from address, since function return has offset 4
    write 0 rsp r1          ; write return address on stack
    jump Label_main         ; jump to main of C program
                            ; should return to the address we just put on the stack
    halt                    ; should not get here

; Function that is called after Main of C program has returned
; Return value should be in R1
; Send it over UART and halt afterwards
Return_UART:
    load32 0xC0262E r2          ; r2 = 0xC0262E | UART tx
    write 0 r2 r1               ; write r1 over UART
    halt                        ; halt

; COMPILED C CODE HERE

Label___strlit30:
	.dw 45 45 45 69 78 68 32 82 69 81 85 69 83 84 45 45 45 0
Label___strlit40:
	.dw 60 100 105 118 32 97 108 105 103 110 61 34 99 101 110 116 101 114 34 62 60 70 79 78 84 32 99 111 108 111 114 61 34 35 102 102 102 102 102 102 34 32 115 105 122 101 61 34 57 57 34 62 60 77 65 82 81 85 69 69 32 98 103 99 111 108 111 114 61 34 35 48 48 48 48 56 48 34 32 100 105 114 101 99 116 105 111 110 61 34 108 101 102 116 34 32 108 111 111 112 61 34 50 48 34 32 119 105 100 116 104 61 34 55 53 37 34 62 60 83 84 82 79 78 71 62 68 101 122 101 32 115 105 116 101 32 119 111 114 100 116 32 103 101 104 111 115 116 32 111 112 32 101 101 110 32 70 80 71 67 52 60 47 83 84 82 79 78 71 62 60 47 77 65 82 81 85 69 69 62 60 47 70 79 78 84 62 60 47 68 73 86 62 0
Label___strlit78:
	.dw 83 111 99 107 101 116 32 99 108 111 115 101 100 0
Label___strlit81:
	.dw 82 101 115 101 116 116 105 110 103 32 115 111 99 107 101 116 0
Label___strlit173:
	.dw 10 0
Label___strlit186:
	.dw 111 112 101 110 101 100 32 115 111 99 107 101 116 0
Label___strlit261:
	.dw 45 45 45 83 84 65 82 84 32 82 69 81 85 69 83 84 45 45 45 0
Label___strlit269:
	.dw 71 111 116 32 99 111 110 110 101 99 116 105 111 110 0
Label___strlit289:
	.dw 73 110 105 116 32 100 111 110 101 0

Label_div:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; LOADARG
	; EQUALCMP
	or r0 1 r1
	or r0 r4 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label39
	or r0 0 r1
Label___shivyc_label39:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label1
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label1:
	or r0 r0 r0
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label2:
	or r0 r0 r0
	; GREATEROREQCMP
	or r0 1 r2
	or r0 r5 r12
	or r0 r4 r13
	bgt r13 r12 2
	jump Label___shivyc_label40
	or r0 0 r2
Label___shivyc_label40:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label3
	; SUBTR
	or r0 r4 r12
	sub r5 r12 r5
	; SET
	; ADD
	load32 1 r12
	add r1 r12 r1
	; SET
	; JUMP
	jump Label___shivyc_label2
	; LABEL
Label___shivyc_label3:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_mod:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; LOADARG
	; EQUALCMP
	or r0 1 r1
	or r0 r4 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label41
	or r0 0 r1
Label___shivyc_label41:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label4
	; RETURN
	or r0 r5 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label4:
	or r0 r0 r0
	; LABEL
Label___shivyc_label5:
	or r0 r0 r0
	; GREATEROREQCMP
	or r0 1 r1
	or r0 r5 r12
	or r0 r4 r13
	bgt r13 r12 2
	jump Label___shivyc_label42
	or r0 0 r1
Label___shivyc_label42:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label6
	; SUBTR
	or r0 r4 r12
	sub r5 r12 r5
	; SET
	; JUMP
	jump Label___shivyc_label5
	; LABEL
Label___shivyc_label6:
	or r0 r0 r0
	; RETURN
	or r0 r5 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_uprintc:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; SET
	load32 12592686 r1
	; SET
	; SETAT
	write 0 r1 r5
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_uprint:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; SET
	load32 12592686 r3
	; READAT
	read 0 r5 r2
	; SET
	; LABEL
Label___shivyc_label7:
	or r0 r0 r0
	; SET
	or r0 r2 r1
	; NOTEQUALCMP
	or r0 1 r4
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label43
	or r0 0 r4
Label___shivyc_label43:
	; JUMPZERO
	sub r4 0 r12
	bne r0 r12 2
	jump Label___shivyc_label8
	; SET
	; SETAT
	write 0 r3 r2
	; SET
	or r0 r5 r1
	; ADD
	load32 1 r12
	add r5 r12 r5
	; SET
	; READAT
	read 0 r5 r2
	; SET
	; JUMP
	jump Label___shivyc_label7
	; LABEL
Label___shivyc_label8:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_uprintln:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; ADDROF
	addr2reg Label_uprint r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit173 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_itoar:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 20 rsp
	; LOADARG
	write -4 rbp r5
	; LOADARG
	write -12 rbp r4
	; ADDROF
	addr2reg Label_mod r1
	; CALL
	read -4 rbp r12
	or r0 r12 r5
	or r0 10 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -16 rbp r1
	; SET
	load32 0 r12
	write -20 rbp r12
	; ADDROF
	addr2reg Label_div r1
	; CALL
	read -4 rbp r12
	or r0 r12 r5
	or r0 10 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -4 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -4 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label44
	or r0 0 r1
Label___shivyc_label44:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label9
	; ADDROF
	addr2reg Label_itoar r1
	; CALL
	read -4 rbp r12
	or r0 r12 r5
	read -12 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -20 rbp r12
	add r1 r12 r1
	; SET
	write -20 rbp r1
	; LABEL
Label___shivyc_label9:
	or r0 r0 r0
	; ADD
	read -16 rbp r2
	add r2 48 r2
	; SET
	read -20 rbp r1
	; ADD
	read -20 rbp r3
	add r3 1 r3
	; SET
	write -20 rbp r3
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -12 rbp r12
	add r1 r12 r1
	; SET
	; SETAT
	write 0 r1 r2
	; RETURN
	read -20 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_itoa:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 28 rsp
	; LOADARG
	; LOADARG
	write -28 rbp r4
	; ADDROF
	addr2reg Label_itoar r1
	; CALL
	read -28 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -28 rbp r12
	add r1 r12 r1
	; SETAT
	load32 0 r12
	write 0 r1 r12
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_itoahr:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 48 rsp
	; LOADARG
	write -32 rbp r5
	; LOADARG
	write -40 rbp r4
	; ADDROF
	addr2reg Label_mod r1
	; CALL
	read -32 rbp r12
	or r0 r12 r5
	or r0 16 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -44 rbp r1
	; SET
	load32 0 r12
	write -48 rbp r12
	; ADDROF
	addr2reg Label_div r1
	; CALL
	read -32 rbp r12
	or r0 r12 r5
	or r0 16 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -32 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -32 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label45
	or r0 0 r1
Label___shivyc_label45:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label10
	; ADDROF
	addr2reg Label_itoahr r1
	; CALL
	read -32 rbp r12
	or r0 r12 r5
	read -40 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -48 rbp r12
	add r1 r12 r1
	; SET
	write -48 rbp r1
	; LABEL
Label___shivyc_label10:
	or r0 r0 r0
	; GREATERCMP
	or r0 1 r1
	read -44 rbp r12
	load32 9 r13
	bge r13 r12 2
	jump Label___shivyc_label46
	or r0 0 r1
Label___shivyc_label46:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label11
	; ADD
	read -44 rbp r2
	add r2 65 r2
	; SUBTR
	load32 10 r12
	sub r2 r12 r2
	; SET
	; JUMP
	jump Label___shivyc_label12
	; LABEL
Label___shivyc_label11:
	or r0 r0 r0
	; ADD
	read -44 rbp r2
	add r2 48 r2
	; SET
	; LABEL
Label___shivyc_label12:
	or r0 r0 r0
	; SET
	read -48 rbp r1
	; ADD
	read -48 rbp r3
	add r3 1 r3
	; SET
	write -48 rbp r3
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -40 rbp r12
	add r1 r12 r1
	; SETAT
	write 0 r1 r2
	; RETURN
	read -48 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_itoah:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 56 rsp
	; LOADARG
	; LOADARG
	write -56 rbp r4
	; MULT
	or r0 0 r1
	mult r1 1 r1
	; ADD
	read -56 rbp r12
	add r1 r12 r1
	; SETAT
	load32 48 r12
	write 0 r1 r12
	; MULT
	or r0 1 r1
	mult r1 1 r1
	; ADD
	read -56 rbp r12
	add r1 r12 r1
	; SETAT
	load32 120 r12
	write 0 r1 r12
	; MULT
	or r0 2 r1
	mult r1 1 r1
	; ADD
	read -56 rbp r12
	add r1 r12 r1
	; SET
	write -56 rbp r1
	; ADDROF
	addr2reg Label_itoahr r1
	; CALL
	read -56 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -56 rbp r12
	add r1 r12 r1
	; SETAT
	load32 0 r12
	write 0 r1 r12
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_delay:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; SET
	load32 4980736 r3
	; SETAT
	load32 0 r12
	write 0 r3 r12
	; SET
	load32 12592678 r1
	; SETAT
	write 0 r1 r5
	; SET
	load32 12592679 r1
	; SETAT
	load32 1 r12
	write 0 r1 r12
	; LABEL
Label___shivyc_label13:
	or r0 r0 r0
	; READAT
	read 0 r3 r2
	; EQUALCMP
	or r0 1 r1
	or r0 r2 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label47
	or r0 0 r1
Label___shivyc_label47:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label14
	; JUMP
	jump Label___shivyc_label13
	; LABEL
Label___shivyc_label14:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_WizSpiBeginTransfer:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ASMCODE
	push r1
	push r2
	push r3
	load32 0xC02630 r3
	read 0 r3 r1
	load 0b1111110111111111 r2
	and r1 r2 r1
	write 0 r3 r1
	pop r3
	pop r2
	pop r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_WizSpiEndTransfer:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ASMCODE
	push r1
	push r2
	push r3
	load32 0xC02630 r3
	read 0 r3 r1
	load 0b1000000000 r2
	or r1 r2 r1
	write 0 r3 r1
	pop r3
	pop r2
	pop r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_WizSpiTransfer:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; ASMCODE
	load32 0xC02734 r1
	write 0 r1 r5
	read 0 r1 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizWrite:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 80 rsp
	; LOADARG
	write -72 rbp r5
	; LOADARG
	write -76 rbp r4
	; LOADARG
	write -64 rbp r3
	; LOADARG
	write -68 rbp r2
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -72 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -72 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -76 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -80 rbp r12
	; LABEL
Label___shivyc_label15:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -80 rbp r2
	or r0 r2 r12
	read -68 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label48
	or r0 0 r1
Label___shivyc_label48:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label17
	; ADDROF
	addr2reg Label_WizSpiTransfer r2
	; SET
	read -80 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -64 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r2
	; LABEL
Label___shivyc_label16:
	or r0 r0 r0
	; SET
	read -80 rbp r1
	; ADD
	read -80 rbp r1
	add r1 1 r1
	; SET
	write -80 rbp r1
	; JUMP
	jump Label___shivyc_label15
	; LABEL
Label___shivyc_label17:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizWriteSingle:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 92 rsp
	; LOADARG
	write -84 rbp r5
	; LOADARG
	write -88 rbp r4
	; LOADARG
	write -92 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -84 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -84 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -88 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -92 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -92 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizWriteDouble:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 104 rsp
	; LOADARG
	write -96 rbp r5
	; LOADARG
	write -100 rbp r4
	; LOADARG
	write -104 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -96 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -96 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -100 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -104 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -104 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizRead:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 128 rsp
	; LOADARG
	write -120 rbp r5
	; LOADARG
	write -124 rbp r4
	; LOADARG
	write -112 rbp r3
	; LOADARG
	write -116 rbp r2
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -120 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -120 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -124 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -128 rbp r12
	; LABEL
Label___shivyc_label18:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -128 rbp r2
	or r0 r2 r12
	read -116 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label49
	or r0 0 r1
Label___shivyc_label49:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label20
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -128 rbp r2
	; MULT
	load32 1 r12
	mult r2 r12 r2
	; ADD
	read -112 rbp r12
	add r2 r12 r2
	; SET
	; SETAT
	write 0 r2 r1
	; LABEL
Label___shivyc_label19:
	or r0 r0 r0
	; SET
	read -128 rbp r1
	; ADD
	read -128 rbp r1
	add r1 1 r1
	; SET
	write -128 rbp r1
	; JUMP
	jump Label___shivyc_label18
	; LABEL
Label___shivyc_label20:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizReadSingle:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 140 rsp
	; LOADARG
	write -132 rbp r5
	; LOADARG
	write -136 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -132 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -132 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -136 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -140 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -140 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizReadDouble:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 152 rsp
	; LOADARG
	write -144 rbp r5
	; LOADARG
	write -148 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -144 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -144 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -148 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 8 r1
	; SET
	write -152 rbp r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -152 rbp r12
	add r1 r12 r1
	; SET
	write -152 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -152 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizCmd:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 156 rsp
	; LOADARG
	write -156 rbp r5
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -156 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label21:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizReadSingle r1
	; CALL
	or r0 1 r5
	or r0 8 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label22
	; JUMP
	jump Label___shivyc_label21
	; LABEL
Label___shivyc_label22:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizSetSockReg8:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 164 rsp
	; LOADARG
	write -160 rbp r5
	; LOADARG
	write -164 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -160 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -164 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizGetSockReg8:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; ADDROF
	addr2reg Label_wizReadSingle r1
	; CALL
	or r0 8 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizSetSockReg16:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 172 rsp
	; LOADARG
	write -168 rbp r5
	; LOADARG
	write -172 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -168 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -172 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -172 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizGetSockReg16:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; ADDROF
	addr2reg Label_wizReadDouble r1
	; CALL
	or r0 8 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizWriteResponse:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 196 rsp
	; LOADARG
	write -180 rbp r5
	; LOADARG
	write -184 rbp r4
	; LESSOREQCMP
	or r0 1 r1
	read -184 rbp r12
	load32 0 r13
	bgt r12 r13 2
	jump Label___shivyc_label50
	or r0 0 r1
Label___shivyc_label50:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label23
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label23:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	or r0 32 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -188 rbp r1
	; SET
	load32 0 r12
	write -192 rbp r12
	; LABEL
Label___shivyc_label24:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -188 rbp r2
	or r0 r2 r12
	read -184 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label51
	or r0 0 r1
Label___shivyc_label51:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label25
	; SET
	read -192 rbp r1
	; ADD
	read -192 rbp r1
	add r1 1 r1
	; SET
	write -192 rbp r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	or r0 32 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -188 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -192 rbp r12
	load32 1000 r13
	bge r13 r12 2
	jump Label___shivyc_label52
	or r0 0 r1
Label___shivyc_label52:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label26
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 8 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label26:
	or r0 r0 r0
	; JUMP
	jump Label___shivyc_label24
	; LABEL
Label___shivyc_label25:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	or r0 36 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -196 rbp r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; CALL
	read -196 rbp r12
	or r0 r12 r5
	or r0 20 r4
	read -180 rbp r12
	or r0 r12 r3
	read -184 rbp r12
	or r0 r12 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -196 rbp r4
	read -184 rbp r12
	add r4 r12 r4
	; SET
	; ADDROF
	addr2reg Label_wizSetSockReg16 r1
	; CALL
	or r0 36 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 32 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizReadRecvData:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 208 rsp
	; LOADARG
	write -204 rbp r5
	; LOADARG
	write -208 rbp r4
	; EQUALCMP
	or r0 1 r1
	read -208 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label53
	or r0 0 r1
Label___shivyc_label53:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label27
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label27:
	or r0 r0 r0
	; GREATERCMP
	or r0 1 r1
	read -208 rbp r12
	load32 512 r13
	bge r13 r12 2
	jump Label___shivyc_label54
	or r0 0 r1
Label___shivyc_label54:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label28
	; SET
	load32 510 r12
	write -208 rbp r12
	; LABEL
Label___shivyc_label28:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	or r0 40 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	or r0 r1 r5
	; ADDROF
	addr2reg Label_wizRead r1
	; CALL
	or r0 24 r4
	read -204 rbp r12
	or r0 r12 r3
	read -208 rbp r12
	or r0 r12 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -208 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -204 rbp r12
	add r1 r12 r1
	; SETAT
	load32 0 r12
	write 0 r1 r12
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizFlush:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 212 rsp
	; LOADARG
	; LOADARG
	write -212 rbp r4
	; GREATERCMP
	or r0 1 r1
	read -212 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label55
	or r0 0 r1
Label___shivyc_label55:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label29
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	or r0 40 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; ADD
	read -212 rbp r12
	add r1 r12 r1
	; SET
	or r0 r1 r4
	; ADDROF
	addr2reg Label_wizSetSockReg16 r1
	; CALL
	or r0 40 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 64 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label29:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizSendResponse:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ADDROF
	addr2reg Label___strlit40 r5
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponse r1
	; CALL
	or r0 192 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizHandleSession:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 728 rsp
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	or r0 38 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -728 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -728 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label56
	or r0 0 r1
Label___shivyc_label56:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label30
	; SETREL
	load32 0 r12
	write -724 rbp r12
	; ADDROF
	addr2reg Label_wizReadRecvData r1
	; ADDRREL
	sub rbp 724 r5 ;lea
	; CALL
	read -728 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit261 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 724 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit30 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWriteResponse r1
	; ADDRREL
	sub rbp 724 r5 ;lea
	; CALL
	read -728 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label30:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 8 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wiz_Init:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 746 rsp
	; SET
	load32 192 r1
	; SETREL
	write -732 rbp r1
	; SET
	load32 168 r1
	; SETREL
	write -731 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -730 rbp r1
	; SET
	load32 213 r1
	; SETREL
	write -729 rbp r1
	; SET
	load32 192 r1
	; SETREL
	write -736 rbp r1
	; SET
	load32 168 r1
	; SETREL
	write -735 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -734 rbp r1
	; SET
	load32 1 r1
	; SETREL
	write -733 rbp r1
	; SET
	load32 222 r1
	; SETREL
	write -742 rbp r1
	; SET
	load32 173 r1
	; SETREL
	write -741 rbp r1
	; SET
	load32 190 r1
	; SETREL
	write -740 rbp r1
	; SET
	load32 239 r1
	; SETREL
	write -739 rbp r1
	; SET
	load32 36 r1
	; SETREL
	write -738 rbp r1
	; SET
	load32 100 r1
	; SETREL
	write -737 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -746 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -745 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -744 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -743 rbp r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 732 r3 ;lea
	; CALL
	or r0 15 r5
	or r0 4 r4
	or r0 4 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 736 r3 ;lea
	; CALL
	or r0 1 r5
	or r0 4 r4
	or r0 4 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 742 r3 ;lea
	; CALL
	or r0 9 r5
	or r0 4 r4
	or r0 6 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 746 r3 ;lea
	; CALL
	or r0 5 r5
	or r0 4 r4
	or r0 4 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit289 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizInitSocketTCP:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 746 rsp
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 16 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizSetSockReg8 r1
	; CALL
	or r0 2 r5
	or r0 255 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizSetSockReg8 r1
	; CALL
	or r0 0 r5
	or r0 1 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizSetSockReg16 r1
	; CALL
	or r0 4 r5
	or r0 80 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 2 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit186 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_main:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 750 rsp
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 100 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wiz_Init r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label31:
	or r0 r0 r0
	; JUMPZERO
	or r0 1 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label32
	; ADDROF
	addr2reg Label_wizGetSockReg8 r1
	; CALL
	or r0 3 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -750 rbp r1
	; EQUALCMP
	or r0 1 r1
	read -750 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label57
	or r0 0 r1
Label___shivyc_label57:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label33
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit78 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label34
	; LABEL
Label___shivyc_label33:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	read -750 rbp r12
	load32 23 r13
	bne r13 r12 2
	jump Label___shivyc_label58
	or r0 0 r1
Label___shivyc_label58:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label35
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit269 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizHandleSession r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label36
	; LABEL
Label___shivyc_label35:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	read -750 rbp r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label59
	or r0 0 r1
Label___shivyc_label59:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label37
	; JUMP
	jump Label___shivyc_label38
	; LABEL
Label___shivyc_label37:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit81 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label38:
	or r0 r0 r0
	; LABEL
Label___shivyc_label36:
	or r0 r0 r0
	; LABEL
Label___shivyc_label34:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label31
	; LABEL
Label___shivyc_label32:
	or r0 r0 r0
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_int1:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 746 rsp
	; SET
	load32 4980736 r1
	; SETAT
	load32 1 r12
	write 0 r1 r12
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_int2:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 746 rsp
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_int3:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 746 rsp
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_int4:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 746 rsp
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
; END OF COMPILED C CODE

; Interrupt handlers
; Has some administration before jumping to Label_int[ID]
; To prevent interfering with stack of program, they have their own stack
; at 0x7B0000, where program stack does not reach
; Also, all registers have to be backed up and restored to hardware stack
; A return function has to be put on the stack as wel that the C code interrupt handler
; will jump to when it is done


Int1:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push rbp
    push rsp

    load32 0x7B0000 rsp     ; initialize stack address
    addr2reg Return_Interrupt r1 ; get address of return function
    sub r1 4 r1             ; remove 4 from address, since function return has offset 4
    write 0 rsp r1          ; write return address on stack
    jump Label_int1         ; jump to interrupt handler of C program
                            ; should return to the address we just put on the stack
    halt                    ; should not get here


Int2:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push rbp
    push rsp

    load32 0x7B0000 rsp     ; initialize stack address
    addr2reg Return_Interrupt r1 ; get address of return function
    sub r1 4 r1             ; remove 4 from address, since function return has offset 4
    write 0 rsp r1          ; write return address on stack
    jump Label_int2         ; jump to interrupt handler of C program
                            ; should return to the address we just put on the stack
    halt                    ; should not get here


Int3:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push rbp
    push rsp

    load32 0x7B0000 rsp     ; initialize stack address
    addr2reg Return_Interrupt r1 ; get address of return function
    sub r1 4 r1             ; remove 4 from address, since function return has offset 4
    write 0 rsp r1          ; write return address on stack
    jump Label_int3         ; jump to interrupt handler of C program
                            ; should return to the address we just put on the stack
    halt                    ; should not get here


Int4:
    ; backup registers
    push r1
    push r2
    push r3
    push r4
    push r5
    push r6
    push r7
    push r8
    push r9
    push r10
    push r11
    push r12
    push r13
    push rbp
    push rsp

    load32 0x7B0000 rsp     ; initialize stack address
    addr2reg Return_Interrupt r1 ; get address of return function
    sub r1 4 r1             ; remove 4 from address, since function return has offset 4
    write 0 rsp r1          ; write return address on stack
    jump Label_int4         ; jump to interrupt handler of C program
                            ; should return to the address we just put on the stack
    halt                    ; should not get here


; Function that is called after any interrupt handler from C has returned
; Restores all registers and issues RETI instruction to continue from original code
Return_Interrupt:
    ; restore registers
    pop rsp
    pop rbp
    pop r13
    pop r12
    pop r11
    pop r10
    pop r9
    pop r8
    pop r7
    pop r6
    pop r5
    pop r4
    pop r3
    pop r2
    pop r1

    reti        ; return from interrrupt

    halt        ; should not get here

