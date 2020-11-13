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

Label_endp_mode:
	.dw 128
Label___strlit1:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 48 0
Label___strlit11:
	.dw 10 0
Label___strlit38:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 50 0
Label___strlit41:
	.dw 67 73 78 58 32 0
Label___strlit73:
	.dw 45 45 80 65 82 83 69 68 32 68 65 84 65 45 45 0
Label___strlit86:
	.dw 45 45 45 45 45 45 83 108 97 118 101 32 97 100 100 114 32 115 101 116 45 45 45 45 45 45 0
Label___strlit101:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 49 0
Label___strlit106:
	.dw 67 97 98 108 101 32 78 117 109 98 101 114 58 32 0
Label___strlit114:
	.dw 67 104 101 99 107 105 110 103 32 100 101 118 105 99 101 32 99 111 110 110 101 99 116 105 111 110 32 115 116 97 116 117 115 0
Label___strlit120:
	.dw 68 101 118 105 99 101 32 99 111 110 110 101 99 116 101 100 0
Label___strlit137:
	.dw 45 45 45 45 45 45 72 111 115 116 32 97 100 100 114 32 115 101 116 45 45 45 45 45 45 0
Label___strlit152:
	.dw 78 111 116 101 73 68 58 32 0
Label___strlit166:
	.dw 86 101 108 111 99 105 116 121 58 32 0
Label___strlit203:
	.dw 114 101 115 101 116 32 100 111 110 101 0
Label___strlit226:
	.dw 67 104 97 110 110 101 108 58 32 0
Label___strlit243:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 49 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit250:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 48 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit255:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 50 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit287:
	.dw 67 104 101 99 107 105 110 103 32 100 101 118 105 99 101 32 99 111 110 110 101 99 116 105 111 110 32 115 116 97 116 117 115 0
Label___strlit288:
	.dw 45 45 45 45 45 45 82 101 97 100 121 32 116 111 32 114 101 99 101 105 118 101 45 45 45 45 45 45 0
Label___strlit290:
	.dw 10 0
Label___strlit291:
	.dw 68 101 118 105 99 101 32 99 111 110 110 101 99 116 101 100 0
Label___strlit297:
	.dw 69 118 101 110 116 58 32 0
Label___strlit308:
	.dw 45 45 82 65 87 32 68 65 84 65 45 45 0

Label_div:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; LOADARG
	; EQUALCMP
	load32 1 r1
	or r0 r4 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label43
	load32 0 r1
Label___shivyc_label43:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label1
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label1:
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label2:
	; GREATEROREQCMP
	load32 1 r2
	or r0 r5 r12
	or r0 r4 r13
	bgt r13 r12 2
	jump Label___shivyc_label44
	load32 0 r2
Label___shivyc_label44:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label3
	; SUBTR
	or r0 r5 r12
	or r0 r4 r13
	sub r12 r13 r12
	or r0 r12 r5
	; SET
	; ADD
	or r0 r1 r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	; JUMP
	jump Label___shivyc_label2
	; LABEL
Label___shivyc_label3:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_mod:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; LOADARG
	; EQUALCMP
	load32 1 r1
	or r0 r4 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label45
	load32 0 r1
Label___shivyc_label45:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label4
	; RETURN
	or r0 r5 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label4:
	; LABEL
Label___shivyc_label5:
	; GREATEROREQCMP
	load32 1 r1
	or r0 r5 r12
	or r0 r4 r13
	bgt r13 r12 2
	jump Label___shivyc_label46
	load32 0 r1
Label___shivyc_label46:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label6
	; SUBTR
	or r0 r5 r12
	or r0 r4 r13
	sub r12 r13 r12
	or r0 r12 r5
	; SET
	; JUMP
	jump Label___shivyc_label5
	; LABEL
Label___shivyc_label6:
	; RETURN
	or r0 r5 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_memcpy:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; LOADARG
	; LOADARG
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label7:
	; LESSCMP
	load32 1 r1
	or r0 r2 r12
	or r0 r3 r13
	bge r12 r13 2
	jump Label___shivyc_label47
	load32 0 r1
Label___shivyc_label47:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label9
	; SET
	or r0 r2 r1
	; MULT
	or r0 r1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	or r0 r4 r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; READAT
	or r0 r1 r1
	read 0 r1 r8
	; SET
	or r0 r2 r1
	; MULT
	or r0 r1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	or r0 r5 r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SETAT
	or r0 r1 r1
	write 0 r1 r8
	; LABEL
Label___shivyc_label8:
	; SET
	or r0 r2 r1
	; ADD
	or r0 r2 r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r2
	; SET
	; JUMP
	jump Label___shivyc_label7
	; LABEL
Label___shivyc_label9:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_uprintc:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; SET
	load32 12592686 r1
	; SET
	; SETAT
	or r0 r1 r1
	write 0 r1 r5
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_uprint:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; SET
	load32 12592686 r3
	; READAT
	or r0 r5 r1
	read 0 r1 r2
	; SET
	; LABEL
Label___shivyc_label10:
	; SET
	or r0 r2 r1
	; NOTEQUALCMP
	load32 1 r4
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label48
	load32 0 r4
Label___shivyc_label48:
	; JUMPZERO
	or r0 r4 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label11
	; SET
	; SETAT
	or r0 r3 r1
	write 0 r1 r2
	; SET
	or r0 r5 r1
	; ADD
	or r0 r5 r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r5
	; SET
	; READAT
	or r0 r5 r1
	read 0 r1 r2
	; SET
	; JUMP
	jump Label___shivyc_label10
	; LABEL
Label___shivyc_label11:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_uprintln:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; ADDROF
	addr2reg Label_uprint r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit290 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_itoar:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 4 rsp
	; LOADARG
	write -1 rbp r5
	; LOADARG
	write -2 rbp r4
	; ADDROF
	addr2reg Label_mod r1
	; CALL
	read -1 rbp r5
	load32 10 r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -3 rbp r1
	; SET
	load32 0 r12
	write -4 rbp r12
	; ADDROF
	addr2reg Label_div r1
	; CALL
	read -1 rbp r5
	load32 10 r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -1 rbp r1
	; GREATERCMP
	load32 1 r1
	read -1 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label49
	load32 0 r1
Label___shivyc_label49:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label12
	; ADDROF
	addr2reg Label_itoar r1
	; CALL
	read -1 rbp r5
	read -2 rbp r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADD
	read -4 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	write -4 rbp r1
	; LABEL
Label___shivyc_label12:
	; ADD
	read -3 rbp r12
	load32 48 r13
	add r12 r13 r12
	or r0 r12 r2
	; SET
	read -4 rbp r1
	; ADD
	read -4 rbp r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r3
	; SET
	write -4 rbp r3
	; SET
	; MULT
	or r0 r1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	read -2 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	; SETAT
	or r0 r1 r1
	write 0 r1 r2
	; RETURN
	read -4 rbp r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_itoa:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 5 rsp
	; LOADARG
	; LOADARG
	write -5 rbp r4
	; ADDROF
	addr2reg Label_itoar r1
	; CALL
	read -5 rbp r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; SET
	; MULT
	or r0 r1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	read -5 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SETAT
	or r0 r1 r1
	load32 0 r12
	write 0 r1 r12
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_itoahr:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 9 rsp
	; LOADARG
	write -6 rbp r5
	; LOADARG
	write -7 rbp r4
	; ADDROF
	addr2reg Label_mod r1
	; CALL
	read -6 rbp r5
	load32 16 r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -8 rbp r1
	; SET
	load32 0 r12
	write -9 rbp r12
	; ADDROF
	addr2reg Label_div r1
	; CALL
	read -6 rbp r5
	load32 16 r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -6 rbp r1
	; GREATERCMP
	load32 1 r1
	read -6 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label50
	load32 0 r1
Label___shivyc_label50:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label13
	; ADDROF
	addr2reg Label_itoahr r1
	; CALL
	read -6 rbp r5
	read -7 rbp r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADD
	read -9 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	write -9 rbp r1
	; LABEL
Label___shivyc_label13:
	; GREATERCMP
	load32 1 r1
	read -8 rbp r12
	load32 9 r13
	bge r13 r12 2
	jump Label___shivyc_label51
	load32 0 r1
Label___shivyc_label51:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label14
	; ADD
	read -8 rbp r12
	load32 65 r13
	add r12 r13 r12
	or r0 r12 r2
	; SUBTR
	or r0 r2 r12
	load32 10 r13
	sub r12 r13 r12
	or r0 r12 r2
	; SET
	; JUMP
	jump Label___shivyc_label15
	; LABEL
Label___shivyc_label14:
	; ADD
	read -8 rbp r12
	load32 48 r13
	add r12 r13 r12
	or r0 r12 r2
	; SET
	; LABEL
Label___shivyc_label15:
	; SET
	read -9 rbp r1
	; ADD
	read -9 rbp r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r3
	; SET
	write -9 rbp r3
	; SET
	; MULT
	or r0 r1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	read -7 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SETAT
	or r0 r1 r1
	write 0 r1 r2
	; RETURN
	read -9 rbp r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_itoah:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 10 rsp
	; LOADARG
	; LOADARG
	write -10 rbp r4
	; MULT
	load32 0 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	read -10 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SETAT
	or r0 r1 r1
	load32 48 r12
	write 0 r1 r12
	; MULT
	load32 1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	read -10 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SETAT
	or r0 r1 r1
	load32 120 r12
	write 0 r1 r12
	; MULT
	load32 2 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	read -10 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	write -10 rbp r1
	; ADDROF
	addr2reg Label_itoahr r1
	; CALL
	read -10 rbp r4
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; SET
	; MULT
	or r0 r1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	read -10 rbp r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SETAT
	or r0 r1 r1
	load32 0 r12
	write 0 r1 r12
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_delay:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; SET
	load32 4980736 r3
	; SETAT
	or r0 r3 r1
	load32 0 r12
	write 0 r1 r12
	; SET
	load32 12592678 r1
	; SETAT
	or r0 r1 r1
	write 0 r1 r5
	; SET
	load32 12592679 r1
	; SETAT
	or r0 r1 r1
	load32 1 r12
	write 0 r1 r12
	; LABEL
Label___shivyc_label16:
	; READAT
	or r0 r3 r1
	read 0 r1 r2
	; EQUALCMP
	load32 1 r1
	or r0 r2 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label52
	load32 0 r1
Label___shivyc_label52:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label17
	; JUMP
	jump Label___shivyc_label16
	; LABEL
Label___shivyc_label17:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_AssemblyImports:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ASMCODE
	`include example/data_music_midi.asm
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_spiBeginTransfer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ASMCODE
	push r1
	push r2
	push r3
	load32 0xC02630 r3
	read 0 r3 r1
	load 0b1111111011111111 r2
	and r1 r2 r1
	write 0 r3 r1
	pop r3
	pop r2
	pop r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_spiEndTransfer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ASMCODE
	push r1
	push r2
	push r3
	load32 0xC02630 r3
	read 0 r3 r1
	load 0b100000000 r2
	or r1 r2 r1
	write 0 r3 r1
	pop r3
	pop r2
	pop r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_spiTransfer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; ASMCODE
	load32 0xC02631 r1
	write 0 r1 r5
	read 0 r1 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_WaitGetStatus:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 11 rsp
	; SET
	load32 1 r1
	; LABEL
Label___shivyc_label18:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label19
	; SET
	load32 12592676 r1
	; READAT
	or r0 r1 r2
	read 0 r2 r1
	; SET
	; JUMP
	jump Label___shivyc_label18
	; LABEL
Label___shivyc_label19:
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 34 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -11 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	read -11 rbp r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_noWaitGetStatus:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 12 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 34 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -12 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	read -12 rbp r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_setUSBmode:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 14 rsp
	; LOADARG
	write -13 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 21 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -13 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -14 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	read -14 rbp r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_init:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 24 rsp
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 60 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 5 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 100 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label20
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit203 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label20:
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label21
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit1 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label21:
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	load32 5 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	or r0 r1 r5
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label22
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 24 r4 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 24 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit250 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label22:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_setUSBspeed:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 24 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 11 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 23 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 216 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 20 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_connectDevice:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 34 rsp
	; SET
	load32 0 r5
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label23
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit114 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label23:
	; LABEL
Label___shivyc_label24:
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; NOTEQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label53
	load32 0 r2
Label___shivyc_label53:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label25
	; JUMP
	jump Label___shivyc_label24
	; LABEL
Label___shivyc_label25:
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label26
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit291 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label26:
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label27
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit101 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label27:
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	load32 7 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	or r0 r1 r5
	; SET
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label28
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 34 r4 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 34 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit243 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label28:
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label29
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit38 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label29:
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	load32 6 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	or r0 r1 r5
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label30
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 34 r4 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 34 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit255 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label30:
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label31
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit287 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label31:
	; LABEL
Label___shivyc_label32:
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; NOTEQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label54
	load32 0 r2
Label___shivyc_label54:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label33
	; JUMP
	jump Label___shivyc_label32
	; LABEL
Label___shivyc_label33:
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label34
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit120 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label34:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_toggle_recv:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 34 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 28 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	addr2reg Label_endp_mode r7
	read 0 r7 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; XOR
	addr2reg Label_endp_mode r7
	read 0 r7 r12
	load32 64 r13
	xor r12 r13 r12
	or r0 r12 r1
	; SET
	addr2reg Label_endp_mode r7
	write 0 r7 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_issue_token:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 35 rsp
	; LOADARG
	write -35 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 79 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -35 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_RD_USB_DATA:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 55 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 40 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -52 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -54 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -50 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -47 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 12592946 r1
	; SETAT
	or r0 r1 r2
	read -54 rbp r12
	write 0 r2 r12
	; SETAT
	or r0 r1 r2
	read -50 rbp r12
	write 0 r2 r12
	; SETAT
	or r0 r1 r1
	read -47 rbp r12
	write 0 r1 r12
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label35
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit308 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -52 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -54 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -50 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -47 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; AND
	read -52 rbp r12
	load32 240 r13
	and r12 r13 r12
	or r0 r12 r1
	; SET
	write -46 rbp r1
	; AND
	read -52 rbp r12
	load32 15 r13
	and r12 r13 r12
	or r0 r12 r1
	; SET
	write -48 rbp r1
	; AND
	read -54 rbp r12
	load32 15 r13
	and r12 r13 r12
	or r0 r12 r1
	; SET
	write -49 rbp r1
	; AND
	read -54 rbp r12
	load32 240 r13
	and r12 r13 r12
	or r0 r12 r1
	; SET
	write -51 rbp r1
	; SET
	read -50 rbp r12
	write -53 rbp r12
	; SET
	read -47 rbp r12
	write -55 rbp r12
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit73 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit106 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -46 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit41 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -48 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit226 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -49 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit297 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -51 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit152 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -53 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit166 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 45 r4 ;lea
	; CALL
	read -55 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 45 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit11 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label35:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_set_addr:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 56 rsp
	; LOADARG
	write -56 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 69 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -56 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 20 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label36
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit137 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label36:
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 19 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -56 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 20 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label37
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit86 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label37:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_set_config:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 57 rsp
	; LOADARG
	write -57 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	load32 73 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -57 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 20 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_startMidiPlayer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 45 rsp
	; ASMCODE
	load32 0x80000 r2
	load 1 r1
	write 0 r2 r0
	write 1 r2 r1
	load32 0xC02628 r1
	load 1 r3
	write 0 r1 r3
	write 1 r1 r3
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_main:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 45 rsp
	; ADDROF
	addr2reg Label_startMidiPlayer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_CH376_init r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_connectDevice r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 10 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_set_addr r1
	; CALL
	load32 5 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 10 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_set_config r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 10 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMPZERO
	load32 0 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label38
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit288 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label38:
	; LABEL
Label___shivyc_label39:
	; JUMPZERO
	load32 1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label40
	; ADDROF
	addr2reg Label_toggle_recv r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_issue_token r1
	; CALL
	load32 89 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label41:
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; NOTEQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label55
	load32 0 r2
Label___shivyc_label55:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label42
	; JUMP
	jump Label___shivyc_label41
	; LABEL
Label___shivyc_label42:
	; ADDROF
	addr2reg Label_RD_USB_DATA r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMP
	jump Label___shivyc_label39
	; LABEL
Label___shivyc_label40:
	; RETURN
	load32 48 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_int1:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 45 rsp
	; SET
	load32 4980736 r1
	; SETAT
	or r0 r1 r1
	load32 1 r12
	write 0 r1 r12
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_int2:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 45 rsp
	; ASMCODE
	push r1
	push r2
	push r3
	push r4
	push r5
	push r8
	push r10
	push r11
	push r12
	load32 0x80000 r2
	read 1 r2 r5
	load32 0xC02628 r1
	addr2reg MUSICLENS r3
	add r3 r5 r3
	read 0 r3 r3
	load 1 r4
	write 0 r1 r3
	write 1 r1 r4
	add r5 1 r5
	write 1 r2 r5
	read 0 r2 r5
	addr2reg MUSICNOTES r4
	add r4 r5 r4
	read 0 r4 r10
	read 1 r4 r11
	read 2 r4 r12
	load32 0xC02732 r8
	write 0 r8 r10
	write 0 r8 r11
	write 0 r8 r12
	add r5 3 r5
	write 0 r2 r5
	pop r12
	pop r11
	pop r10
	pop r8
	pop r5
	pop r4
	pop r3
	pop r2
	pop r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_int3:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 45 rsp
	; SET
	load32 12592686 r1
	; SETAT
	or r0 r1 r1
	load32 45 r12
	write 0 r1 r12
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_int4:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 45 rsp
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
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

