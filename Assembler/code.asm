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

Label_fileBuffer:
	.dw 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Label___strlit17:
	.dw 119 105 122 84 114 97 110 115 101 114 32 101 114 114 111 114 0
Label___strlit23:
	.dw 45 45 45 83 84 65 82 84 32 82 69 81 85 69 83 84 45 45 45 0
Label___strlit46:
	.dw 83 111 99 107 101 116 32 99 108 111 115 101 100 0
Label___strlit50:
	.dw 116 105 109 101 111 117 116 0
Label___strlit88:
	.dw 45 45 45 69 78 68 32 82 69 81 85 69 83 84 45 45 45 0
Label___strlit163:
	.dw 60 33 68 79 67 84 89 80 69 32 104 116 109 108 62 60 104 116 109 108 62 60 104 101 97 100 62 60 116 105 116 108 101 62 69 82 82 79 82 52 48 52 60 47 116 105 116 108 101 62 60 47 104 101 97 100 62 60 98 111 100 121 62 69 82 82 79 82 32 52 48 52 58 32 84 104 105 115 32 105 115 32 110 111 116 32 116 104 101 32 112 97 103 101 32 121 111 117 32 97 114 101 32 108 111 111 107 105 110 103 32 102 111 114 60 47 98 111 100 121 62 60 47 104 116 109 108 62 0
Label___strlit198:
	.dw 99 117 114 115 111 114 32 101 114 114 111 114 0
Label___strlit246:
	.dw 72 84 84 80 47 49 46 49 32 50 48 48 32 79 75 10 83 101 114 118 101 114 58 32 70 80 71 67 52 47 49 46 48 10 10 0
Label___strlit262:
	.dw 111 112 101 110 101 100 32 115 111 99 107 101 116 0
Label___strlit322:
	.dw 82 101 115 101 116 116 105 110 103 32 115 111 99 107 101 116 0
Label___strlit334:
	.dw 72 84 84 80 47 49 46 49 32 52 48 52 32 78 111 116 32 70 111 117 110 100 10 83 101 114 118 101 114 58 32 70 80 71 67 52 47 49 46 48 10 67 111 110 116 101 110 116 45 84 121 112 101 58 32 116 101 120 116 47 104 116 109 108 10 10 0
Label___strlit344:
	.dw 44 32 73 67 32 118 101 114 115 105 111 110 0
Label___strlit360:
	.dw 99 111 110 110 101 99 116 105 111 110 32 99 108 111 115 101 100 0
Label___strlit394:
	.dw 47 52 48 52 46 72 84 77 0
Label___strlit421:
	.dw 10 0
Label___strlit461:
	.dw 72 84 84 80 47 49 46 49 32 51 48 49 32 77 111 118 101 100 32 80 101 114 109 97 110 101 110 116 108 121 10 76 111 99 97 116 105 111 110 58 32 47 73 78 68 69 88 46 72 84 77 10 0
Label___strlit563:
	.dw 73 110 105 116 32 100 111 110 101 0
Label___strlit567:
	.dw 45 45 45 83 84 65 82 84 32 80 65 84 72 78 65 77 69 45 45 45 0
Label___strlit600:
	.dw 114 101 97 100 32 101 114 114 111 114 0
Label___strlit611:
	.dw 69 114 114 111 114 32 119 104 105 108 101 32 119 114 105 116 105 110 103 32 100 97 116 97 0
Label___strlit712:
	.dw 71 111 116 32 99 111 110 110 101 99 116 105 111 110 0
Label___strlit718:
	.dw 69 114 114 111 114 32 119 104 105 108 101 32 114 101 97 100 105 110 103 32 100 97 116 97 0
Label___strlit730:
	.dw 45 45 45 69 78 68 32 80 65 84 72 78 65 77 69 45 45 45 0

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
	jump Label___shivyc_label157
	or r0 0 r1
Label___shivyc_label157:
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
	jump Label___shivyc_label158
	or r0 0 r2
Label___shivyc_label158:
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
	jump Label___shivyc_label159
	or r0 0 r1
Label___shivyc_label159:
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
	jump Label___shivyc_label160
	or r0 0 r1
Label___shivyc_label160:
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
Label_memcpy:
	sub rsp 4 rsp
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
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	or r0 r2 r12
	or r0 r3 r13
	bge r12 r13 2
	jump Label___shivyc_label161
	or r0 0 r1
Label___shivyc_label161:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label9
	; SET
	or r0 r2 r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	or r0 r4 r12
	add r1 r12 r1
	; READAT
	read 0 r1 r8
	; SET
	or r0 r2 r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	or r0 r5 r12
	add r1 r12 r1
	; SETAT
	write 0 r1 r8
	; LABEL
Label___shivyc_label8:
	or r0 r0 r0
	; SET
	or r0 r2 r1
	; ADD
	load32 1 r12
	add r2 r12 r2
	; SET
	; JUMP
	jump Label___shivyc_label7
	; LABEL
Label___shivyc_label9:
	or r0 r0 r0
	; RETURN
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
Label___shivyc_label10:
	or r0 r0 r0
	; SET
	or r0 r2 r1
	; NOTEQUALCMP
	or r0 1 r4
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label162
	or r0 0 r4
Label___shivyc_label162:
	; JUMPZERO
	sub r4 0 r12
	bne r0 r12 2
	jump Label___shivyc_label11
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
	jump Label___shivyc_label10
	; LABEL
Label___shivyc_label11:
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
	addr2reg Label___strlit421 r5
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
	jump Label___shivyc_label163
	or r0 0 r1
Label___shivyc_label163:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label12
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
Label___shivyc_label12:
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
	jump Label___shivyc_label164
	or r0 0 r1
Label___shivyc_label164:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label13
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
Label___shivyc_label13:
	or r0 r0 r0
	; GREATERCMP
	or r0 1 r1
	read -44 rbp r12
	load32 9 r13
	bge r13 r12 2
	jump Label___shivyc_label165
	or r0 0 r1
Label___shivyc_label165:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label14
	; ADD
	read -44 rbp r2
	add r2 65 r2
	; SUBTR
	load32 10 r12
	sub r2 r12 r2
	; SET
	; JUMP
	jump Label___shivyc_label15
	; LABEL
Label___shivyc_label14:
	or r0 r0 r0
	; ADD
	read -44 rbp r2
	add r2 48 r2
	; SET
	; LABEL
Label___shivyc_label15:
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
Label___shivyc_label16:
	or r0 r0 r0
	; READAT
	read 0 r3 r2
	; EQUALCMP
	or r0 1 r1
	or r0 r2 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label166
	or r0 0 r1
Label___shivyc_label166:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label17
	; JUMP
	jump Label___shivyc_label16
	; LABEL
Label___shivyc_label17:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_spiBeginTransfer:
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
	load 0b1111111011111111 r2
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
Label_CH376_spiEndTransfer:
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
	load 0b100000000 r2
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
Label_CH376_spiTransfer:
	sub rsp 4 rsp
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
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_WaitGetStatus:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 60 rsp
	; SET
	load32 1 r1
	; LABEL
Label___shivyc_label18:
	or r0 r0 r0
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label19
	; SET
	load32 12592676 r1
	; READAT
	read 0 r1 r1
	; SET
	; JUMP
	jump Label___shivyc_label18
	; LABEL
Label___shivyc_label19:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 34 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -60 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -60 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_noWaitGetStatus:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 64 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 34 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -64 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -64 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_sendString:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 72 rsp
	; LOADARG
	write -72 rbp r5
	; READAT
	read -72 rbp r1
	read 0 r1 r5
	; SET
	; LABEL
Label___shivyc_label20:
	or r0 r0 r0
	; SET
	or r0 r5 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label167
	or r0 0 r2
Label___shivyc_label167:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label21
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -72 rbp r1
	; ADD
	read -72 rbp r1
	add r1 1 r1
	; SET
	write -72 rbp r1
	; READAT
	read -72 rbp r1
	read 0 r1 r5
	; SET
	; JUMP
	jump Label___shivyc_label20
	; LABEL
Label___shivyc_label21:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_sendData:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 88 rsp
	; LOADARG
	write -80 rbp r5
	; LOADARG
	write -84 rbp r4
	; READAT
	read -80 rbp r1
	read 0 r1 r5
	; SET
	; SET
	load32 0 r12
	write -88 rbp r12
	; LABEL
Label___shivyc_label22:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -88 rbp r2
	or r0 r2 r12
	read -84 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label168
	or r0 0 r1
Label___shivyc_label168:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label24
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -80 rbp r1
	; ADD
	read -80 rbp r1
	add r1 1 r1
	; SET
	write -80 rbp r1
	; READAT
	read -80 rbp r1
	read 0 r1 r5
	; SET
	; LABEL
Label___shivyc_label23:
	or r0 r0 r0
	; SET
	read -88 rbp r1
	; ADD
	read -88 rbp r1
	add r1 1 r1
	; SET
	write -88 rbp r1
	; JUMP
	jump Label___shivyc_label22
	; LABEL
Label___shivyc_label24:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_printICver:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 102 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -102 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 98 r4 ;lea
	; CALL
	read -102 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 98 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit344 r5
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
Label_CH376_setUSBmode:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 110 rsp
	; LOADARG
	write -106 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 21 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -106 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -110 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -110 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_init:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 60 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 5 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
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
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 5 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 81 r13
	bne r13 r12 2
	jump Label___shivyc_label169
	or r0 0 r2
Label___shivyc_label169:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label25
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label26
	; LABEL
Label___shivyc_label25:
	or r0 r0 r0
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
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_connectDrive:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; LABEL
Label___shivyc_label27:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label170
	or r0 0 r2
Label___shivyc_label170:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label28
	; JUMP
	jump Label___shivyc_label27
	; LABEL
Label___shivyc_label28:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 7 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 81 r13
	beq r13 r12 2
	jump Label___shivyc_label171
	or r0 0 r2
Label___shivyc_label171:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label29
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label29:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 6 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 81 r13
	beq r13 r12 2
	jump Label___shivyc_label172
	or r0 0 r2
Label___shivyc_label172:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label30
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label30:
	or r0 r0 r0
	; LABEL
Label___shivyc_label31:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label173
	or r0 0 r2
Label___shivyc_label173:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label32
	; JUMP
	jump Label___shivyc_label31
	; LABEL
Label___shivyc_label32:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 48 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label174
	or r0 0 r2
Label___shivyc_label174:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label33
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label33:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 49 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label175
	or r0 0 r2
Label___shivyc_label175:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label34
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label34:
	or r0 r0 r0
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_getFileSize:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 114 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 104 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -114 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 8 r1
	; ADD
	read -114 rbp r12
	add r1 r12 r1
	; SET
	write -114 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 16 r1
	; ADD
	read -114 rbp r12
	add r1 r12 r1
	; SET
	write -114 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 24 r1
	; ADD
	read -114 rbp r12
	add r1 r12 r1
	; SET
	write -114 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -114 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_setCursor:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 118 rsp
	; LOADARG
	write -118 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 57 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -118 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -118 rbp r5
	shiftr r5 8 r5
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -118 rbp r5
	shiftr r5 16 r5
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -118 rbp r5
	shiftr r5 24 r5
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label176
	or r0 0 r2
Label___shivyc_label176:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label35
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label35:
	or r0 r0 r0
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_readFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 146 rsp
	; LOADARG
	write -126 rbp r5
	; LOADARG
	write -142 rbp r4
	; EQUALCMP
	or r0 1 r1
	read -142 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label177
	or r0 0 r1
Label___shivyc_label177:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label36
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label36:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 58 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -142 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -142 rbp r5
	shiftr r5 8 r5
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 29 r13
	beq r13 r12 2
	jump Label___shivyc_label178
	or r0 0 r2
Label___shivyc_label178:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label37
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label37:
	or r0 r0 r0
	; SET
	load32 0 r12
	write -130 rbp r12
	; SET
	load32 0 r12
	write -134 rbp r12
	; LABEL
Label___shivyc_label38:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	read -134 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label179
	or r0 0 r1
Label___shivyc_label179:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label39
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 39 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -138 rbp r1
	; SET
	load32 0 r12
	write -146 rbp r12
	; LABEL
Label___shivyc_label40:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -146 rbp r2
	or r0 r2 r12
	read -138 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label180
	or r0 0 r1
Label___shivyc_label180:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label42
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; SET
	; SET
	read -130 rbp r2
	; MULT
	load32 1 r12
	mult r2 r12 r2
	; ADD
	read -126 rbp r12
	add r2 r12 r2
	; SETAT
	write 0 r2 r1
	; ADD
	read -130 rbp r1
	add r1 1 r1
	; SET
	write -130 rbp r1
	; LABEL
Label___shivyc_label41:
	or r0 r0 r0
	; SET
	read -146 rbp r1
	; ADD
	read -146 rbp r1
	add r1 1 r1
	; SET
	write -146 rbp r1
	; JUMP
	jump Label___shivyc_label40
	; LABEL
Label___shivyc_label42:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 59 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label181
	or r0 0 r2
Label___shivyc_label181:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label43
	; SET
	load32 1 r12
	write -134 rbp r12
	; JUMP
	jump Label___shivyc_label44
	; LABEL
Label___shivyc_label43:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 29 r13
	bne r13 r12 2
	jump Label___shivyc_label182
	or r0 0 r2
Label___shivyc_label182:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label45
	; JUMP
	jump Label___shivyc_label46
	; LABEL
Label___shivyc_label45:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit718 r5
	; SET
	; CALL
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
Label___shivyc_label46:
	or r0 r0 r0
	; LABEL
Label___shivyc_label44:
	or r0 r0 r0
	; JUMP
	jump Label___shivyc_label38
	; LABEL
Label___shivyc_label39:
	or r0 r0 r0
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_writeFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 170 rsp
	; LOADARG
	write -154 rbp r5
	; LOADARG
	write -166 rbp r4
	; EQUALCMP
	or r0 1 r1
	read -166 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label183
	or r0 0 r1
Label___shivyc_label183:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label47
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label47:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 60 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -166 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -166 rbp r5
	shiftr r5 8 r5
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 30 r13
	beq r13 r12 2
	jump Label___shivyc_label184
	or r0 0 r2
Label___shivyc_label184:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label48
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label48:
	or r0 r0 r0
	; SET
	load32 0 r12
	write -158 rbp r12
	; SET
	load32 0 r12
	write -162 rbp r12
	; LABEL
Label___shivyc_label49:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	read -162 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label185
	or r0 0 r1
Label___shivyc_label185:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label50
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 45 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -170 rbp r1
	; ADDROF
	addr2reg Label_CH376_sendData r1
	; SET
	read -158 rbp r5
	; MULT
	load32 1 r12
	mult r5 r12 r5
	; ADD
	read -154 rbp r12
	add r5 r12 r5
	; CALL
	read -170 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -158 rbp r1
	read -170 rbp r12
	add r1 r12 r1
	; SET
	write -158 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 61 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label186
	or r0 0 r2
Label___shivyc_label186:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label51
	; SET
	load32 1 r12
	write -162 rbp r12
	; JUMP
	jump Label___shivyc_label52
	; LABEL
Label___shivyc_label51:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 30 r13
	bne r13 r12 2
	jump Label___shivyc_label187
	or r0 0 r2
Label___shivyc_label187:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label53
	; JUMP
	jump Label___shivyc_label54
	; LABEL
Label___shivyc_label53:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit611 r5
	; SET
	; CALL
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
Label___shivyc_label54:
	or r0 r0 r0
	; LABEL
Label___shivyc_label52:
	or r0 r0 r0
	; JUMP
	jump Label___shivyc_label49
	; LABEL
Label___shivyc_label50:
	or r0 r0 r0
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_openFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 50 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label188
	or r0 0 r2
Label___shivyc_label188:
	; SET
	load32 0 r3
	; JUMPNOTZERO
	sub r2 0 r12
	beq r0 r12 2
	jump Label___shivyc_label56
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 65 r13
	bne r13 r12 2
	jump Label___shivyc_label189
	or r0 0 r2
Label___shivyc_label189:
	; JUMPNOTZERO
	sub r2 0 r12
	beq r0 r12 2
	jump Label___shivyc_label56
	; JUMP
	jump Label___shivyc_label57
	; LABEL
Label___shivyc_label56:
	or r0 r0 r0
	; SET
	load32 1 r3
	; LABEL
Label___shivyc_label57:
	or r0 r0 r0
	; JUMPZERO
	sub r3 0 r12
	bne r0 r12 2
	jump Label___shivyc_label55
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label58
	; LABEL
Label___shivyc_label55:
	or r0 r0 r0
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label58:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_deleteFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 53 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label190
	or r0 0 r2
Label___shivyc_label190:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label59
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label60
	; LABEL
Label___shivyc_label59:
	or r0 r0 r0
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label60:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_closeFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 54 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label191
	or r0 0 r2
Label___shivyc_label191:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label61
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label62
	; LABEL
Label___shivyc_label61:
	or r0 r0 r0
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label62:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_createDir:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 64 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label192
	or r0 0 r2
Label___shivyc_label192:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label63
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label64
	; LABEL
Label___shivyc_label63:
	or r0 r0 r0
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label64:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_createFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 52 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label193
	or r0 0 r2
Label___shivyc_label193:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label65
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label65:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label67
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label67:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label66
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label66:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_closeFile r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label69
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label69:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label68
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label68:
	or r0 r0 r0
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_CH376_sendFileName:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 202 rsp
	; LOADARG
	write -194 rbp r5
	; SET
	load32 1 r12
	write -198 rbp r12
	; SETREL
	load32 47 r12
	write -186 rbp r12
	; SET
	load32 1 r12
	write -202 rbp r12
	; LABEL
Label___shivyc_label70:
	or r0 r0 r0
	; SET
	read -198 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -194 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label194
	or r0 0 r2
Label___shivyc_label194:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label71
	; SET
	read -198 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -194 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 47 r13
	bne r13 r12 2
	jump Label___shivyc_label195
	or r0 0 r2
Label___shivyc_label195:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label72
	; SET
	read -202 rbp r1
	; SETREL
	or r0 rbp r13
	load32 1 r12
	mult r12 r1 r12
	add r13 r12 r13
	load32 186 r12
	sub r13 r12 r13
	load32 0 r12
	write 0 r13 r12
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 47 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_sendString r1
	; ADDRREL
	sub rbp 186 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -202 rbp r12
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label74
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label74:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label73
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label73:
	or r0 r0 r0
	; JUMP
	jump Label___shivyc_label75
	; LABEL
Label___shivyc_label72:
	or r0 r0 r0
	; SET
	read -198 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -194 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r2
	; SET
	read -202 rbp r1
	; SETREL
	or r0 rbp r13
	load32 1 r12
	mult r12 r1 r12
	add r13 r12 r13
	load32 186 r12
	sub r13 r12 r13
	write 0 r13 r2
	; SET
	read -202 rbp r1
	; ADD
	read -202 rbp r1
	add r1 1 r1
	; SET
	write -202 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -202 rbp r12
	load32 13 r13
	bge r13 r12 2
	jump Label___shivyc_label196
	or r0 0 r1
Label___shivyc_label196:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label76
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label76:
	or r0 r0 r0
	; LABEL
Label___shivyc_label75:
	or r0 r0 r0
	; SET
	read -198 rbp r1
	; ADD
	read -198 rbp r1
	add r1 1 r1
	; SET
	write -198 rbp r1
	; JUMP
	jump Label___shivyc_label70
	; LABEL
Label___shivyc_label71:
	or r0 r0 r0
	; SET
	read -202 rbp r1
	; SETREL
	or r0 rbp r13
	load32 1 r12
	mult r12 r1 r12
	add r13 r12 r13
	load32 186 r12
	sub r13 r12 r13
	load32 0 r12
	write 0 r13 r12
	; EQUALCMP
	or r0 1 r1
	read -202 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label197
	or r0 0 r1
Label___shivyc_label197:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label77
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label77:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 47 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_sendString r1
	; ADDRREL
	sub rbp 186 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
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
Label_WizSpiBeginTransfer:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 186 rsp
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
	sub rsp 186 rsp
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
	sub rsp 186 rsp
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
	sub rsp 226 rsp
	; LOADARG
	write -218 rbp r5
	; LOADARG
	write -222 rbp r4
	; LOADARG
	write -210 rbp r3
	; LOADARG
	write -214 rbp r2
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -218 rbp r5
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
	read -218 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -222 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -226 rbp r12
	; LABEL
Label___shivyc_label78:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -226 rbp r2
	or r0 r2 r12
	read -214 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label198
	or r0 0 r1
Label___shivyc_label198:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label80
	; ADDROF
	addr2reg Label_WizSpiTransfer r2
	; SET
	read -226 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -210 rbp r12
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
Label___shivyc_label79:
	or r0 r0 r0
	; SET
	read -226 rbp r1
	; ADD
	read -226 rbp r1
	add r1 1 r1
	; SET
	write -226 rbp r1
	; JUMP
	jump Label___shivyc_label78
	; LABEL
Label___shivyc_label80:
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
	sub rsp 238 rsp
	; LOADARG
	write -230 rbp r5
	; LOADARG
	write -234 rbp r4
	; LOADARG
	write -238 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -230 rbp r5
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
	read -230 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -234 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -238 rbp r12
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
	read -238 rbp r12
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
	sub rsp 250 rsp
	; LOADARG
	write -242 rbp r5
	; LOADARG
	write -246 rbp r4
	; LOADARG
	write -250 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -242 rbp r5
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
	read -242 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -246 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -250 rbp r5
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
	read -250 rbp r12
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
	sub rsp 274 rsp
	; LOADARG
	write -266 rbp r5
	; LOADARG
	write -270 rbp r4
	; LOADARG
	write -258 rbp r3
	; LOADARG
	write -262 rbp r2
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -266 rbp r5
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
	read -266 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -270 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -274 rbp r12
	; LABEL
Label___shivyc_label81:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -274 rbp r2
	or r0 r2 r12
	read -262 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label199
	or r0 0 r1
Label___shivyc_label199:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label83
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -274 rbp r2
	; MULT
	load32 1 r12
	mult r2 r12 r2
	; ADD
	read -258 rbp r12
	add r2 r12 r2
	; SET
	; SETAT
	write 0 r2 r1
	; LABEL
Label___shivyc_label82:
	or r0 r0 r0
	; SET
	read -274 rbp r1
	; ADD
	read -274 rbp r1
	add r1 1 r1
	; SET
	write -274 rbp r1
	; JUMP
	jump Label___shivyc_label81
	; LABEL
Label___shivyc_label83:
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
	sub rsp 286 rsp
	; LOADARG
	write -278 rbp r5
	; LOADARG
	write -282 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -278 rbp r5
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
	read -278 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -282 rbp r12
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
	write -286 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -286 rbp r12
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
	sub rsp 298 rsp
	; LOADARG
	write -290 rbp r5
	; LOADARG
	write -294 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -290 rbp r5
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
	read -290 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -294 rbp r12
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
	write -298 rbp r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -298 rbp r12
	add r1 r12 r1
	; SET
	write -298 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -298 rbp r12
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
	sub rsp 302 rsp
	; LOADARG
	write -302 rbp r5
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
	read -302 rbp r12
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
Label___shivyc_label84:
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
	jump Label___shivyc_label85
	; JUMP
	jump Label___shivyc_label84
	; LABEL
Label___shivyc_label85:
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
	sub rsp 310 rsp
	; LOADARG
	write -306 rbp r5
	; LOADARG
	write -310 rbp r4
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
	read -306 rbp r12
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
	read -310 rbp r12
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
	sub rsp 186 rsp
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
	sub rsp 318 rsp
	; LOADARG
	write -314 rbp r5
	; LOADARG
	write -318 rbp r4
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
	read -314 rbp r12
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
	read -318 rbp r5
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
	read -318 rbp r12
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
	sub rsp 186 rsp
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
Label_wizWriteResponseFromMemory:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 350 rsp
	; LOADARG
	write -326 rbp r5
	; LOADARG
	write -330 rbp r4
	; LESSOREQCMP
	or r0 1 r1
	read -330 rbp r12
	load32 0 r13
	bgt r12 r13 2
	jump Label___shivyc_label200
	or r0 0 r1
Label___shivyc_label200:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label86
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label86:
	or r0 r0 r0
	; SET
	load32 0 r12
	write -334 rbp r12
	; LABEL
Label___shivyc_label87:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -334 rbp r2
	or r0 r2 r12
	read -330 rbp r13
	beq r13 r12 2
	jump Label___shivyc_label201
	or r0 0 r1
Label___shivyc_label201:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label88
	; ADDROF
	addr2reg Label_wizGetSockReg8 r1
	; CALL
	or r0 3 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label202
	or r0 0 r2
Label___shivyc_label202:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label89
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit360 r5
	; SET
	; CALL
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
Label___shivyc_label89:
	or r0 r0 r0
	; SUBTR
	read -330 rbp r1
	read -334 rbp r12
	sub r1 r12 r1
	; SET
	write -338 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -338 rbp r12
	load32 512 r13
	bge r13 r12 2
	jump Label___shivyc_label203
	or r0 0 r1
Label___shivyc_label203:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label90
	; SET
	load32 512 r12
	write -338 rbp r12
	; LABEL
Label___shivyc_label90:
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
	write -342 rbp r1
	; SET
	load32 0 r12
	write -346 rbp r12
	; LABEL
Label___shivyc_label91:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -342 rbp r2
	or r0 r2 r12
	read -338 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label204
	or r0 0 r1
Label___shivyc_label204:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label92
	; SET
	read -346 rbp r1
	; ADD
	read -346 rbp r1
	add r1 1 r1
	; SET
	write -346 rbp r1
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
	write -342 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -346 rbp r12
	load32 1000 r13
	bge r13 r12 2
	jump Label___shivyc_label205
	or r0 0 r1
Label___shivyc_label205:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label93
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	or r0 8 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit50 r5
	; SET
	; CALL
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
Label___shivyc_label93:
	or r0 r0 r0
	; JUMP
	jump Label___shivyc_label91
	; LABEL
Label___shivyc_label92:
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
	write -350 rbp r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; SET
	read -334 rbp r3
	; MULT
	load32 1 r12
	mult r3 r12 r3
	; ADD
	read -326 rbp r12
	add r3 r12 r3
	; CALL
	read -350 rbp r12
	or r0 r12 r5
	or r0 20 r4
	read -338 rbp r12
	or r0 r12 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -350 rbp r4
	read -338 rbp r12
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
	; ADD
	read -334 rbp r1
	read -338 rbp r12
	add r1 r12 r1
	; SET
	write -334 rbp r1
	; JUMP
	jump Label___shivyc_label87
	; LABEL
Label___shivyc_label88:
	or r0 r0 r0
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizWriteResponseFromUSB:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 362 rsp
	; LOADARG
	write -354 rbp r5
	; ADDROF
	addr2reg Label_CH376_setCursor r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label95
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label95:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label94
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit198 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label94:
	or r0 r0 r0
	; SET
	load32 0 r12
	write -358 rbp r12
	; LABEL
Label___shivyc_label96:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -358 rbp r2
	or r0 r2 r12
	read -354 rbp r13
	beq r13 r12 2
	jump Label___shivyc_label206
	or r0 0 r1
Label___shivyc_label206:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label97
	; SUBTR
	read -354 rbp r1
	read -358 rbp r12
	sub r1 r12 r1
	; SET
	write -362 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -362 rbp r12
	load32 512 r13
	bge r13 r12 2
	jump Label___shivyc_label207
	or r0 0 r1
Label___shivyc_label207:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label98
	; SET
	load32 512 r12
	write -362 rbp r12
	; LABEL
Label___shivyc_label98:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_readFile r1
	; ADDROF
	addr2reg Label_fileBuffer r5
	; SET
	; CALL
	read -362 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label100
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label100:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label99
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit600 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label99:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; ADDROF
	addr2reg Label_fileBuffer r5
	; SET
	; CALL
	read -362 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label102
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label102:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label101
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit17 r5
	; SET
	; CALL
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
Label___shivyc_label101:
	or r0 r0 r0
	; ADD
	read -358 rbp r1
	read -362 rbp r12
	add r1 r12 r1
	; SET
	write -358 rbp r1
	; JUMP
	jump Label___shivyc_label96
	; LABEL
Label___shivyc_label97:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_closeFile r1
	; CALL
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
	sub rsp 374 rsp
	; LOADARG
	write -370 rbp r5
	; LOADARG
	write -374 rbp r4
	; EQUALCMP
	or r0 1 r1
	read -374 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label208
	or r0 0 r1
Label___shivyc_label208:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label103
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label103:
	or r0 r0 r0
	; GREATERCMP
	or r0 1 r1
	read -374 rbp r12
	load32 1024 r13
	bge r13 r12 2
	jump Label___shivyc_label209
	or r0 0 r1
Label___shivyc_label209:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label104
	; SET
	load32 1022 r12
	write -374 rbp r12
	; LABEL
Label___shivyc_label104:
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
	read -370 rbp r12
	or r0 r12 r3
	read -374 rbp r12
	or r0 r12 r2
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -374 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -370 rbp r12
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
	sub rsp 378 rsp
	; LOADARG
	; LOADARG
	write -378 rbp r4
	; GREATERCMP
	or r0 1 r1
	read -378 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label210
	or r0 0 r1
Label___shivyc_label210:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label105
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
	read -378 rbp r12
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
Label___shivyc_label105:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizSend404Response:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 186 rsp
	; ADDROF
	addr2reg Label___strlit163 r5
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	or r0 128 r4
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
Label_wizGetFilePath:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 186 rsp
	; LOADARG
	or r0 r5 r8
	; LOADARG
	or r0 r4 r9
	; SET
	load32 0 r5
	; SET
	load32 0 r4
	; SET
	load32 0 r2
	; SET
	load32 0 r3
	; LABEL
Label___shivyc_label106:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	or r0 r5 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label211
	or r0 0 r1
Label___shivyc_label211:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label107
	; EQUALCMP
	or r0 1 r1
	or r0 r4 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label212
	or r0 0 r1
Label___shivyc_label212:
	; SET
	load32 1 r10
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label109
	; SET
	or r0 r2 r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	or r0 r8 r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r11
	or r0 r1 r12
	load32 32 r13
	bne r13 r12 2
	jump Label___shivyc_label213
	or r0 0 r11
Label___shivyc_label213:
	; JUMPZERO
	sub r11 0 r12
	bne r0 r12 2
	jump Label___shivyc_label109
	; JUMP
	jump Label___shivyc_label110
	; LABEL
Label___shivyc_label109:
	or r0 r0 r0
	; SET
	load32 0 r10
	; LABEL
Label___shivyc_label110:
	or r0 r0 r0
	; JUMPZERO
	sub r10 0 r12
	bne r0 r12 2
	jump Label___shivyc_label108
	; SET
	load32 1 r4
	; JUMP
	jump Label___shivyc_label111
	; LABEL
Label___shivyc_label108:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	or r0 r4 r12
	load32 1 r13
	bne r13 r12 2
	jump Label___shivyc_label214
	or r0 0 r1
Label___shivyc_label214:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label112
	; SET
	or r0 r2 r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	or r0 r8 r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r10
	or r0 r1 r12
	load32 32 r13
	bne r13 r12 2
	jump Label___shivyc_label215
	or r0 0 r10
Label___shivyc_label215:
	; JUMPZERO
	sub r10 0 r12
	bne r0 r12 2
	jump Label___shivyc_label113
	; SET
	load32 1 r5
	; JUMP
	jump Label___shivyc_label114
	; LABEL
Label___shivyc_label113:
	or r0 r0 r0
	; SET
	or r0 r2 r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	or r0 r8 r12
	add r1 r12 r1
	; READAT
	read 0 r1 r10
	; SET
	or r0 r3 r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	or r0 r9 r12
	add r1 r12 r1
	; SETAT
	write 0 r1 r10
	; SET
	or r0 r3 r1
	; ADD
	or r0 r3 r1
	add r1 1 r1
	; SET
	or r0 r1 r3
	; LABEL
Label___shivyc_label114:
	or r0 r0 r0
	; LABEL
Label___shivyc_label112:
	or r0 r0 r0
	; LABEL
Label___shivyc_label111:
	or r0 r0 r0
	; SET
	or r0 r2 r1
	; ADD
	or r0 r2 r1
	add r1 1 r1
	; SET
	or r0 r1 r2
	; JUMP
	jump Label___shivyc_label106
	; LABEL
Label___shivyc_label107:
	or r0 r0 r0
	; SET
	or r0 r3 r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	or r0 r9 r12
	add r1 r12 r1
	; SETAT
	load32 0 r12
	write 0 r1 r12
	; ADD
	or r0 r3 r1
	add r1 1 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_wizServeFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 394 rsp
	; LOADARG
	write -386 rbp r5
	; MULT
	or r0 0 r1
	mult r1 1 r1
	; ADD
	read -386 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 47 r13
	bne r13 r12 2
	jump Label___shivyc_label216
	or r0 0 r2
Label___shivyc_label216:
	; SET
	load32 1 r3
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label116
	; MULT
	or r0 1 r1
	mult r1 1 r1
	; ADD
	read -386 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label217
	or r0 0 r2
Label___shivyc_label217:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label116
	; JUMP
	jump Label___shivyc_label117
	; LABEL
Label___shivyc_label116:
	or r0 r0 r0
	; SET
	load32 0 r3
	; LABEL
Label___shivyc_label117:
	or r0 r0 r0
	; JUMPZERO
	sub r3 0 r12
	bne r0 r12 2
	jump Label___shivyc_label115
	; ADDROF
	addr2reg Label___strlit461 r5
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	or r0 52 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
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
	; LABEL
Label___shivyc_label115:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label118
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit567 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; MULT
	or r0 0 r5
	mult r5 1 r5
	; ADD
	read -386 rbp r12
	add r5 r12 r5
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit730 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label118:
	or r0 r0 r0
	; SET
	load32 0 r12
	write -390 rbp r12
	; ADDROF
	addr2reg Label_CH376_sendFileName r1
	; MULT
	or r0 0 r5
	mult r5 1 r5
	; ADD
	read -386 rbp r12
	add r5 r12 r5
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label120
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label120:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label119
	; SET
	load32 404 r12
	write -390 rbp r12
	; LABEL
Label___shivyc_label119:
	or r0 r0 r0
	; SET
	load32 1 r1
	; JUMPZERO
	read -390 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label122
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label122:
	or r0 r0 r0
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label121
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label124
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label124:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label123
	; SET
	load32 404 r12
	write -390 rbp r12
	; LABEL
Label___shivyc_label123:
	or r0 r0 r0
	; LABEL
Label___shivyc_label121:
	or r0 r0 r0
	; SET
	load32 1 r1
	; JUMPZERO
	read -390 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label126
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label126:
	or r0 r0 r0
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label125
	; ADDROF
	addr2reg Label_CH376_getFileSize r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -394 rbp r1
	; LABEL
Label___shivyc_label125:
	or r0 r0 r0
	; SET
	load32 1 r1
	; JUMPZERO
	read -390 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label128
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label128:
	or r0 r0 r0
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label127
	; EQUALCMP
	or r0 1 r1
	read -394 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label218
	or r0 0 r1
Label___shivyc_label218:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label129
	; SET
	load32 404 r12
	write -390 rbp r12
	; LABEL
Label___shivyc_label129:
	or r0 r0 r0
	; LABEL
Label___shivyc_label127:
	or r0 r0 r0
	; SET
	load32 1 r1
	; JUMPZERO
	read -390 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label131
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label131:
	or r0 r0 r0
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label130
	; ADD
	read -394 rbp r2
	add r2 1 r2
	; EQUALCMP
	or r0 1 r1
	or r0 r2 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label219
	or r0 0 r1
Label___shivyc_label219:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label132
	; SET
	load32 404 r12
	write -390 rbp r12
	; LABEL
Label___shivyc_label132:
	or r0 r0 r0
	; LABEL
Label___shivyc_label130:
	or r0 r0 r0
	; JUMPZERO
	read -390 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label133
	; ADDROF
	addr2reg Label___strlit334 r5
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	or r0 66 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_sendFileName r1
	; ADDROF
	addr2reg Label___strlit394 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label135
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label135:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label134
	; ADDROF
	addr2reg Label_wizSend404Response r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label136
	; LABEL
Label___shivyc_label134:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_getFileSize r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -394 rbp r1
	; ADDROF
	addr2reg Label_wizWriteResponseFromUSB r1
	; CALL
	read -394 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label136:
	or r0 r0 r0
	; JUMP
	jump Label___shivyc_label137
	; LABEL
Label___shivyc_label133:
	or r0 r0 r0
	; ADDROF
	addr2reg Label___strlit246 r5
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	or r0 35 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWriteResponseFromUSB r1
	; CALL
	read -394 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label137:
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
Label_wizHandleSession:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 1550 rsp
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	or r0 38 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -1550 rbp r1
	; EQUALCMP
	or r0 1 r1
	read -1550 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label220
	or r0 0 r1
Label___shivyc_label220:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label138
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
	; LABEL
Label___shivyc_label138:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizReadRecvData r1
	; ADDRREL
	sub rbp 1418 r5 ;lea
	; CALL
	read -1550 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label139
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit23 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 1418 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit88 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label139:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizGetFilePath r1
	; ADDRREL
	sub rbp 1417 r5 ;lea
	; ADDRREL
	sub rbp 1546 r4 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; ADDROF
	addr2reg Label_wizServeFile r1
	; ADDRREL
	sub rbp 1546 r5 ;lea
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
Label_wiz_Init:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 1568 rsp
	; SET
	load32 192 r1
	; SETREL
	write -1554 rbp r1
	; SET
	load32 168 r1
	; SETREL
	write -1553 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -1552 rbp r1
	; SET
	load32 213 r1
	; SETREL
	write -1551 rbp r1
	; SET
	load32 192 r1
	; SETREL
	write -1558 rbp r1
	; SET
	load32 168 r1
	; SETREL
	write -1557 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -1556 rbp r1
	; SET
	load32 1 r1
	; SETREL
	write -1555 rbp r1
	; SET
	load32 222 r1
	; SETREL
	write -1564 rbp r1
	; SET
	load32 173 r1
	; SETREL
	write -1563 rbp r1
	; SET
	load32 190 r1
	; SETREL
	write -1562 rbp r1
	; SET
	load32 239 r1
	; SETREL
	write -1561 rbp r1
	; SET
	load32 36 r1
	; SETREL
	write -1560 rbp r1
	; SET
	load32 100 r1
	; SETREL
	write -1559 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -1568 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -1567 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -1566 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -1565 rbp r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 1554 r3 ;lea
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
	sub rbp 1558 r3 ;lea
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
	sub rbp 1564 r3 ;lea
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
	sub rbp 1568 r3 ;lea
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
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label140
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit563 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label140:
	or r0 r0 r0
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
	sub rsp 1568 rsp
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
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label141
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit262 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label141:
	or r0 r0 r0
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
	sub rsp 1572 rsp
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
	addr2reg Label_CH376_init r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_connectDrive r1
	; CALL
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
Label___shivyc_label142:
	or r0 r0 r0
	; JUMPZERO
	or r0 1 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label143
	; ADDROF
	addr2reg Label_wizGetSockReg8 r1
	; CALL
	or r0 3 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -1572 rbp r1
	; EQUALCMP
	or r0 1 r1
	read -1572 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label221
	or r0 0 r1
Label___shivyc_label221:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label144
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label145
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit46 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label145:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label146
	; LABEL
Label___shivyc_label144:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	read -1572 rbp r12
	load32 23 r13
	bne r13 r12 2
	jump Label___shivyc_label222
	or r0 0 r1
Label___shivyc_label222:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label147
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label148
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit712 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label148:
	or r0 r0 r0
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
	jump Label___shivyc_label149
	; LABEL
Label___shivyc_label147:
	or r0 r0 r0
	; EQUALCMP
	or r0 1 r1
	read -1572 rbp r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label223
	or r0 0 r1
Label___shivyc_label223:
	; SET
	load32 0 r3
	; JUMPNOTZERO
	sub r1 0 r12
	beq r0 r12 2
	jump Label___shivyc_label153
	; EQUALCMP
	or r0 1 r1
	read -1572 rbp r12
	load32 21 r13
	bne r13 r12 2
	jump Label___shivyc_label224
	or r0 0 r1
Label___shivyc_label224:
	; JUMPNOTZERO
	sub r1 0 r12
	beq r0 r12 2
	jump Label___shivyc_label153
	; JUMP
	jump Label___shivyc_label154
	; LABEL
Label___shivyc_label153:
	or r0 r0 r0
	; SET
	load32 1 r3
	; LABEL
Label___shivyc_label154:
	or r0 r0 r0
	; SET
	load32 0 r2
	; JUMPNOTZERO
	sub r3 0 r12
	beq r0 r12 2
	jump Label___shivyc_label151
	; EQUALCMP
	or r0 1 r1
	read -1572 rbp r12
	load32 22 r13
	bne r13 r12 2
	jump Label___shivyc_label225
	or r0 0 r1
Label___shivyc_label225:
	; JUMPNOTZERO
	sub r1 0 r12
	beq r0 r12 2
	jump Label___shivyc_label151
	; JUMP
	jump Label___shivyc_label152
	; LABEL
Label___shivyc_label151:
	or r0 r0 r0
	; SET
	load32 1 r2
	; LABEL
Label___shivyc_label152:
	or r0 r0 r0
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label150
	; JUMP
	jump Label___shivyc_label155
	; LABEL
Label___shivyc_label150:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label156
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit322 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label156:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label155:
	or r0 r0 r0
	; LABEL
Label___shivyc_label149:
	or r0 r0 r0
	; LABEL
Label___shivyc_label146:
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
	jump Label___shivyc_label142
	; LABEL
Label___shivyc_label143:
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
	sub rsp 1568 rsp
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
	sub rsp 1568 rsp
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
	sub rsp 1568 rsp
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
	sub rsp 1568 rsp
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

