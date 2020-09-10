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
	.dw 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Label___strlit27:
	.dw 60 33 68 79 67 84 89 80 69 32 104 116 109 108 62 60 104 116 109 108 62 60 104 101 97 100 62 60 116 105 116 108 101 62 69 82 82 79 82 52 48 52 60 47 116 105 116 108 101 62 60 47 104 101 97 100 62 60 98 111 100 121 62 69 82 82 79 82 32 52 48 52 58 32 84 104 105 115 32 105 115 32 110 111 116 32 116 104 101 32 112 97 103 101 32 121 111 117 32 97 114 101 32 108 111 111 107 105 110 103 32 102 111 114 60 47 98 111 100 121 62 60 47 104 116 109 108 62 0
Label___strlit63:
	.dw 72 84 84 80 47 49 46 49 32 51 48 49 32 77 111 118 101 100 32 80 101 114 109 97 110 101 110 116 108 121 10 76 111 99 97 116 105 111 110 58 32 47 73 78 68 69 88 46 72 84 77 10 0
Label___strlit201:
	.dw 73 110 105 116 32 100 111 110 101 0
Label___strlit269:
	.dw 45 45 45 83 84 65 82 84 32 80 65 84 72 78 65 77 69 45 45 45 0
Label___strlit278:
	.dw 82 101 115 101 116 116 105 110 103 32 115 111 99 107 101 116 0
Label___strlit317:
	.dw 45 45 45 83 84 65 82 84 32 82 69 81 85 69 83 84 45 45 45 0
Label___strlit361:
	.dw 83 111 99 107 101 116 32 99 108 111 115 101 100 0
Label___strlit376:
	.dw 114 101 97 100 32 101 114 114 111 114 0
Label___strlit418:
	.dw 72 84 84 80 47 49 46 49 32 52 48 52 32 78 111 116 32 70 111 117 110 100 10 83 101 114 118 101 114 58 32 70 80 71 67 52 47 49 46 48 10 67 111 110 116 101 110 116 45 84 121 112 101 58 32 116 101 120 116 47 104 116 109 108 10 10 0
Label___strlit435:
	.dw 10 0
Label___strlit476:
	.dw 45 45 45 69 78 68 32 80 65 84 72 78 65 77 69 45 45 45 0
Label___strlit495:
	.dw 69 114 114 111 114 32 119 104 105 108 101 32 119 114 105 116 105 110 103 32 100 97 116 97 0
Label___strlit514:
	.dw 80 114 111 99 101 115 115 105 110 103 32 115 111 99 107 101 116 32 0
Label___strlit529:
	.dw 44 32 73 67 32 118 101 114 115 105 111 110 0
Label___strlit576:
	.dw 47 52 48 52 46 72 84 77 0
Label___strlit580:
	.dw 99 117 114 115 111 114 32 101 114 114 111 114 0
Label___strlit627:
	.dw 72 84 84 80 47 49 46 49 32 50 48 48 32 79 75 10 83 101 114 118 101 114 58 32 70 80 71 67 52 47 49 46 48 10 10 0
Label___strlit645:
	.dw 111 112 101 110 101 100 32 115 111 99 107 101 116 0
Label___strlit683:
	.dw 71 111 116 32 99 111 110 110 101 99 116 105 111 110 0
Label___strlit727:
	.dw 45 45 45 69 78 68 32 82 69 81 85 69 83 84 45 45 45 0
Label___strlit746:
	.dw 69 114 114 111 114 32 119 104 105 108 101 32 114 101 97 100 105 110 103 32 100 97 116 97 0

Label_div:
	sub rsp 1 rsp
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
	or r0 1 r2
	or r0 r5 r12
	or r0 r4 r13
	bgt r13 r12 2
	jump Label___shivyc_label160
	or r0 0 r2
Label___shivyc_label160:
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
	or r0 1 r1
	or r0 r4 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label161
	or r0 0 r1
Label___shivyc_label161:
	; JUMPZERO
	sub r1 0 r12
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
	or r0 1 r1
	or r0 r5 r12
	or r0 r4 r13
	bgt r13 r12 2
	jump Label___shivyc_label162
	or r0 0 r1
Label___shivyc_label162:
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
	or r0 1 r1
	or r0 r2 r12
	or r0 r3 r13
	bge r12 r13 2
	jump Label___shivyc_label163
	or r0 0 r1
Label___shivyc_label163:
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
	read 0 r5 r2
	; SET
	; LABEL
Label___shivyc_label10:
	; SET
	or r0 r2 r1
	; NOTEQUALCMP
	or r0 1 r4
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label164
	or r0 0 r4
Label___shivyc_label164:
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
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit435 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
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
	read -1 rbp r12
	or r0 r12 r5
	or r0 10 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -3 rbp r1
	; SET
	load32 0 r12
	write -4 rbp r12
	; ADDROF
	addr2reg Label_div r1
	; CALL
	read -1 rbp r12
	or r0 r12 r5
	or r0 10 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -1 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -1 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label165
	or r0 0 r1
Label___shivyc_label165:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label12
	; ADDROF
	addr2reg Label_itoar r1
	; CALL
	read -1 rbp r12
	or r0 r12 r5
	read -2 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -4 rbp r12
	add r1 r12 r1
	; SET
	write -4 rbp r1
	; LABEL
Label___shivyc_label12:
	; ADD
	read -3 rbp r2
	add r2 48 r2
	; SET
	read -4 rbp r1
	; ADD
	read -4 rbp r3
	add r3 1 r3
	; SET
	write -4 rbp r3
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -2 rbp r12
	add r1 r12 r1
	; SET
	; SETAT
	write 0 r1 r2
	; RETURN
	read -4 rbp r12
	or r0 r12 r1
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
	read -5 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -5 rbp r12
	add r1 r12 r1
	; SETAT
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
	read -6 rbp r12
	or r0 r12 r5
	or r0 16 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -8 rbp r1
	; SET
	load32 0 r12
	write -9 rbp r12
	; ADDROF
	addr2reg Label_div r1
	; CALL
	read -6 rbp r12
	or r0 r12 r5
	or r0 16 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -6 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -6 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label166
	or r0 0 r1
Label___shivyc_label166:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label13
	; ADDROF
	addr2reg Label_itoahr r1
	; CALL
	read -6 rbp r12
	or r0 r12 r5
	read -7 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -9 rbp r12
	add r1 r12 r1
	; SET
	write -9 rbp r1
	; LABEL
Label___shivyc_label13:
	; GREATERCMP
	or r0 1 r1
	read -8 rbp r12
	load32 9 r13
	bge r13 r12 2
	jump Label___shivyc_label167
	or r0 0 r1
Label___shivyc_label167:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label14
	; ADD
	read -8 rbp r2
	add r2 65 r2
	; SUBTR
	load32 10 r12
	sub r2 r12 r2
	; SET
	; JUMP
	jump Label___shivyc_label15
	; LABEL
Label___shivyc_label14:
	; ADD
	read -8 rbp r2
	add r2 48 r2
	; SET
	; LABEL
Label___shivyc_label15:
	; SET
	read -9 rbp r1
	; ADD
	read -9 rbp r3
	add r3 1 r3
	; SET
	write -9 rbp r3
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -7 rbp r12
	add r1 r12 r1
	; SETAT
	write 0 r1 r2
	; RETURN
	read -9 rbp r12
	or r0 r12 r1
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
	or r0 0 r1
	mult r1 1 r1
	; ADD
	read -10 rbp r12
	add r1 r12 r1
	; SETAT
	load32 48 r12
	write 0 r1 r12
	; MULT
	or r0 1 r1
	mult r1 1 r1
	; ADD
	read -10 rbp r12
	add r1 r12 r1
	; SETAT
	load32 120 r12
	write 0 r1 r12
	; MULT
	or r0 2 r1
	mult r1 1 r1
	; ADD
	read -10 rbp r12
	add r1 r12 r1
	; SET
	write -10 rbp r1
	; ADDROF
	addr2reg Label_itoahr r1
	; CALL
	read -10 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; SET
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -10 rbp r12
	add r1 r12 r1
	; SETAT
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
	; READAT
	read 0 r3 r2
	; EQUALCMP
	or r0 1 r1
	or r0 r2 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label168
	or r0 0 r1
Label___shivyc_label168:
	; JUMPZERO
	sub r1 0 r12
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
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 34 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -11 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -11 rbp r12
	or r0 r12 r1
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
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 34 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -12 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -12 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_sendString:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 13 rsp
	; LOADARG
	write -13 rbp r5
	; READAT
	read -13 rbp r1
	read 0 r1 r5
	; SET
	; LABEL
Label___shivyc_label20:
	; SET
	or r0 r5 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label169
	or r0 0 r2
Label___shivyc_label169:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label21
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -13 rbp r1
	; ADD
	read -13 rbp r1
	add r1 1 r1
	; SET
	write -13 rbp r1
	; READAT
	read -13 rbp r1
	read 0 r1 r5
	; SET
	; JUMP
	jump Label___shivyc_label20
	; LABEL
Label___shivyc_label21:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_sendData:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 16 rsp
	; LOADARG
	write -14 rbp r5
	; LOADARG
	write -15 rbp r4
	; READAT
	read -14 rbp r1
	read 0 r1 r5
	; SET
	; SET
	load32 0 r12
	write -16 rbp r12
	; LABEL
Label___shivyc_label22:
	; LESSCMP
	or r0 1 r1
	read -16 rbp r2
	or r0 r2 r12
	read -15 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label170
	or r0 0 r1
Label___shivyc_label170:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label24
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -14 rbp r1
	; ADD
	read -14 rbp r1
	add r1 1 r1
	; SET
	write -14 rbp r1
	; READAT
	read -14 rbp r1
	read 0 r1 r5
	; SET
	; LABEL
Label___shivyc_label23:
	; SET
	read -16 rbp r1
	; ADD
	read -16 rbp r1
	add r1 1 r1
	; SET
	write -16 rbp r1
	; JUMP
	jump Label___shivyc_label22
	; LABEL
Label___shivyc_label24:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_printICver:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 27 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -27 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 26 r4 ;lea
	; CALL
	read -27 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 26 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit529 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
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
	sub rsp 29 rsp
	; LOADARG
	write -28 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 21 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -28 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -29 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -29 rbp r12
	or r0 r12 r1
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
	sub rsp 26 rsp
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 60 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 5 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 100 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 5 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 81 r13
	bne r13 r12 2
	jump Label___shivyc_label171
	or r0 0 r2
Label___shivyc_label171:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label25
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label26
	; LABEL
Label___shivyc_label25:
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label26:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_connectDrive:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 26 rsp
	; LABEL
Label___shivyc_label27:
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label172
	or r0 0 r2
Label___shivyc_label172:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label28
	; JUMP
	jump Label___shivyc_label27
	; LABEL
Label___shivyc_label28:
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 7 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 81 r13
	beq r13 r12 2
	jump Label___shivyc_label173
	or r0 0 r2
Label___shivyc_label173:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label29
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label29:
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 6 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 81 r13
	beq r13 r12 2
	jump Label___shivyc_label174
	or r0 0 r2
Label___shivyc_label174:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label30
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label30:
	; LABEL
Label___shivyc_label31:
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label175
	or r0 0 r2
Label___shivyc_label175:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label32
	; JUMP
	jump Label___shivyc_label31
	; LABEL
Label___shivyc_label32:
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 48 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
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
	jump Label___shivyc_label33
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label33:
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 49 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label177
	or r0 0 r2
Label___shivyc_label177:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label34
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label34:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_getFileSize:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 30 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 104 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -30 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 8 r1
	; ADD
	read -30 rbp r12
	add r1 r12 r1
	; SET
	write -30 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 16 r1
	; ADD
	read -30 rbp r12
	add r1 r12 r1
	; SET
	write -30 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 24 r1
	; ADD
	read -30 rbp r12
	add r1 r12 r1
	; SET
	write -30 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -30 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_setCursor:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 31 rsp
	; LOADARG
	write -31 rbp r5
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 57 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -31 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -31 rbp r5
	shiftr r5 8 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -31 rbp r5
	shiftr r5 16 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -31 rbp r5
	shiftr r5 24 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label178
	or r0 0 r2
Label___shivyc_label178:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label35
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label35:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_readFile:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 37 rsp
	; LOADARG
	write -32 rbp r5
	; LOADARG
	write -36 rbp r4
	; EQUALCMP
	or r0 1 r1
	read -36 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label179
	or r0 0 r1
Label___shivyc_label179:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label36
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label36:
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 58 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -36 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -36 rbp r5
	shiftr r5 8 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 29 r13
	beq r13 r12 2
	jump Label___shivyc_label180
	or r0 0 r2
Label___shivyc_label180:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label37
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label37:
	; SET
	load32 0 r12
	write -33 rbp r12
	; SET
	load32 0 r12
	write -34 rbp r12
	; LABEL
Label___shivyc_label38:
	; EQUALCMP
	or r0 1 r1
	read -34 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label181
	or r0 0 r1
Label___shivyc_label181:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label39
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 39 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -35 rbp r1
	; SET
	load32 0 r12
	write -37 rbp r12
	; LABEL
Label___shivyc_label40:
	; LESSCMP
	or r0 1 r1
	read -37 rbp r2
	or r0 r2 r12
	read -35 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label182
	or r0 0 r1
Label___shivyc_label182:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label42
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; SET
	; SET
	read -33 rbp r2
	; MULT
	load32 1 r12
	mult r2 r12 r2
	; ADD
	read -32 rbp r12
	add r2 r12 r2
	; SETAT
	write 0 r2 r1
	; ADD
	read -33 rbp r1
	add r1 1 r1
	; SET
	write -33 rbp r1
	; LABEL
Label___shivyc_label41:
	; SET
	read -37 rbp r1
	; ADD
	read -37 rbp r1
	add r1 1 r1
	; SET
	write -37 rbp r1
	; JUMP
	jump Label___shivyc_label40
	; LABEL
Label___shivyc_label42:
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 59 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label183
	or r0 0 r2
Label___shivyc_label183:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label43
	; SET
	load32 1 r12
	write -34 rbp r12
	; JUMP
	jump Label___shivyc_label44
	; LABEL
Label___shivyc_label43:
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 29 r13
	bne r13 r12 2
	jump Label___shivyc_label184
	or r0 0 r2
Label___shivyc_label184:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label45
	; JUMP
	jump Label___shivyc_label46
	; LABEL
Label___shivyc_label45:
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit746 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label46:
	; LABEL
Label___shivyc_label44:
	; JUMP
	jump Label___shivyc_label38
	; LABEL
Label___shivyc_label39:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_writeFile:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 42 rsp
	; LOADARG
	write -38 rbp r5
	; LOADARG
	write -41 rbp r4
	; EQUALCMP
	or r0 1 r1
	read -41 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label185
	or r0 0 r1
Label___shivyc_label185:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label47
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label47:
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 60 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -41 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; RBITSHIFT
	read -41 rbp r5
	shiftr r5 8 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 30 r13
	beq r13 r12 2
	jump Label___shivyc_label186
	or r0 0 r2
Label___shivyc_label186:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label48
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label48:
	; SET
	load32 0 r12
	write -39 rbp r12
	; SET
	load32 0 r12
	write -40 rbp r12
	; LABEL
Label___shivyc_label49:
	; EQUALCMP
	or r0 1 r1
	read -40 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label187
	or r0 0 r1
Label___shivyc_label187:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label50
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 45 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -42 rbp r1
	; ADDROF
	addr2reg Label_CH376_sendData r1
	; SET
	read -39 rbp r5
	; MULT
	load32 1 r12
	mult r5 r12 r5
	; ADD
	read -38 rbp r12
	add r5 r12 r5
	; CALL
	read -42 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -39 rbp r1
	read -42 rbp r12
	add r1 r12 r1
	; SET
	write -39 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 61 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
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
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label51
	; SET
	load32 1 r12
	write -40 rbp r12
	; JUMP
	jump Label___shivyc_label52
	; LABEL
Label___shivyc_label51:
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 30 r13
	bne r13 r12 2
	jump Label___shivyc_label189
	or r0 0 r2
Label___shivyc_label189:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label53
	; JUMP
	jump Label___shivyc_label54
	; LABEL
Label___shivyc_label53:
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit495 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label54:
	; LABEL
Label___shivyc_label52:
	; JUMP
	jump Label___shivyc_label49
	; LABEL
Label___shivyc_label50:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_openFile:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 26 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 50 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label190
	or r0 0 r2
Label___shivyc_label190:
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
	jump Label___shivyc_label191
	or r0 0 r2
Label___shivyc_label191:
	; JUMPNOTZERO
	sub r2 0 r12
	beq r0 r12 2
	jump Label___shivyc_label56
	; JUMP
	jump Label___shivyc_label57
	; LABEL
Label___shivyc_label56:
	; SET
	load32 1 r3
	; LABEL
Label___shivyc_label57:
	; JUMPZERO
	sub r3 0 r12
	bne r0 r12 2
	jump Label___shivyc_label55
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label58
	; LABEL
Label___shivyc_label55:
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label58:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_deleteFile:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 26 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 53 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
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
	jump Label___shivyc_label59
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label60
	; LABEL
Label___shivyc_label59:
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label60:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_closeFile:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 26 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 54 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label193
	or r0 0 r2
Label___shivyc_label193:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label61
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label62
	; LABEL
Label___shivyc_label61:
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label62:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_createDir:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 26 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 64 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label194
	or r0 0 r2
Label___shivyc_label194:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label63
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; JUMP
	jump Label___shivyc_label64
	; LABEL
Label___shivyc_label63:
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label64:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_createFile:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 26 rsp
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 52 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_WaitGetStatus r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label195
	or r0 0 r2
Label___shivyc_label195:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label65
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label65:
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 1 rsp
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
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label66
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label66:
	; ADDROF
	addr2reg Label_CH376_closeFile r1
	; CALL
	savpc r12
	sub rsp 1 rsp
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
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label68
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label68:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_CH376_sendFileName:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 61 rsp
	; LOADARG
	write -59 rbp r5
	; SET
	load32 1 r12
	write -60 rbp r12
	; SETREL
	load32 47 r12
	write -58 rbp r12
	; SET
	load32 1 r12
	write -61 rbp r12
	; LABEL
Label___shivyc_label70:
	; SET
	read -60 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -59 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; NOTEQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label196
	or r0 0 r2
Label___shivyc_label196:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label71
	; SET
	read -60 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -59 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 47 r13
	bne r13 r12 2
	jump Label___shivyc_label197
	or r0 0 r2
Label___shivyc_label197:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label72
	; SET
	read -61 rbp r1
	; SETREL
	or r0 rbp r13
	load32 1 r12
	mult r12 r1 r12
	add r13 r12 r13
	load32 58 r12
	sub r13 r12 r13
	load32 0 r12
	write 0 r13 r12
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 47 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_sendString r1
	; ADDRREL
	sub rbp 58 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -61 rbp r12
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 1 rsp
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
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label73
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label73:
	; JUMP
	jump Label___shivyc_label75
	; LABEL
Label___shivyc_label72:
	; SET
	read -60 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -59 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r2
	; SET
	read -61 rbp r1
	; SETREL
	or r0 rbp r13
	load32 1 r12
	mult r12 r1 r12
	add r13 r12 r13
	load32 58 r12
	sub r13 r12 r13
	write 0 r13 r2
	; SET
	read -61 rbp r1
	; ADD
	read -61 rbp r1
	add r1 1 r1
	; SET
	write -61 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -61 rbp r12
	load32 13 r13
	bge r13 r12 2
	jump Label___shivyc_label198
	or r0 0 r1
Label___shivyc_label198:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label76
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label76:
	; LABEL
Label___shivyc_label75:
	; SET
	read -60 rbp r1
	; ADD
	read -60 rbp r1
	add r1 1 r1
	; SET
	write -60 rbp r1
	; JUMP
	jump Label___shivyc_label70
	; LABEL
Label___shivyc_label71:
	; SET
	read -61 rbp r1
	; SETREL
	or r0 rbp r13
	load32 1 r12
	mult r12 r1 r12
	add r13 r12 r13
	load32 58 r12
	sub r13 r12 r13
	load32 0 r12
	write 0 r13 r12
	; EQUALCMP
	or r0 1 r1
	read -61 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label199
	or r0 0 r1
Label___shivyc_label199:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label77
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label77:
	; ADDROF
	addr2reg Label_CH376_spiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 47 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_sendString r1
	; ADDRREL
	sub rbp 58 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_WizSpiBeginTransfer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 58 rsp
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
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_WizSpiEndTransfer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 58 rsp
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
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_WizSpiTransfer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 58 rsp
	; LOADARG
	; ASMCODE
	load32 0xC02734 r1
	write 0 r1 r5
	read 0 r1 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizWrite:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 66 rsp
	; LOADARG
	write -64 rbp r5
	; LOADARG
	write -65 rbp r4
	; LOADARG
	write -62 rbp r3
	; LOADARG
	write -63 rbp r2
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -64 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -64 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -65 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -66 rbp r12
	; LABEL
Label___shivyc_label78:
	; LESSCMP
	or r0 1 r1
	read -66 rbp r2
	or r0 r2 r12
	read -63 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label200
	or r0 0 r1
Label___shivyc_label200:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label80
	; ADDROF
	addr2reg Label_WizSpiTransfer r2
	; SET
	read -66 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -62 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r2
	; LABEL
Label___shivyc_label79:
	; SET
	read -66 rbp r1
	; ADD
	read -66 rbp r1
	add r1 1 r1
	; SET
	write -66 rbp r1
	; JUMP
	jump Label___shivyc_label78
	; LABEL
Label___shivyc_label80:
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizWriteSingle:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 69 rsp
	; LOADARG
	write -67 rbp r5
	; LOADARG
	write -68 rbp r4
	; LOADARG
	write -69 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -67 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -67 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -68 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -69 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -69 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizWriteDouble:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 72 rsp
	; LOADARG
	write -70 rbp r5
	; LOADARG
	write -71 rbp r4
	; LOADARG
	write -72 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -70 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -70 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -71 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
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
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -72 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizRead:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 77 rsp
	; LOADARG
	write -75 rbp r5
	; LOADARG
	write -76 rbp r4
	; LOADARG
	write -73 rbp r3
	; LOADARG
	write -74 rbp r2
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -75 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -75 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -76 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -77 rbp r12
	; LABEL
Label___shivyc_label81:
	; LESSCMP
	or r0 1 r1
	read -77 rbp r2
	or r0 r2 r12
	read -74 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label201
	or r0 0 r1
Label___shivyc_label201:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label83
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -77 rbp r2
	; MULT
	load32 1 r12
	mult r2 r12 r2
	; ADD
	read -73 rbp r12
	add r2 r12 r2
	; SET
	; SETAT
	write 0 r2 r1
	; LABEL
Label___shivyc_label82:
	; SET
	read -77 rbp r1
	; ADD
	read -77 rbp r1
	add r1 1 r1
	; SET
	write -77 rbp r1
	; JUMP
	jump Label___shivyc_label81
	; LABEL
Label___shivyc_label83:
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizReadSingle:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 80 rsp
	; LOADARG
	write -78 rbp r5
	; LOADARG
	write -79 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -78 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -78 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -79 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -80 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -80 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizReadDouble:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 83 rsp
	; LOADARG
	write -81 rbp r5
	; LOADARG
	write -82 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -81 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -81 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -82 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 8 r1
	; SET
	write -83 rbp r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -83 rbp r12
	add r1 r12 r1
	; SET
	write -83 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -83 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizCmd:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 85 rsp
	; LOADARG
	write -84 rbp r5
	; LOADARG
	write -85 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; LBITSHIFT
	read -84 rbp r5
	shiftl r5 5 r5
	; ADD
	load32 12 r12
	add r5 r12 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -85 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizSetSockReg8:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 88 rsp
	; LOADARG
	write -86 rbp r5
	; LOADARG
	write -87 rbp r4
	; LOADARG
	write -88 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -87 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; LBITSHIFT
	read -86 rbp r5
	shiftl r5 5 r5
	; ADD
	load32 12 r12
	add r5 r12 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -88 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizGetSockReg8:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 91 rsp
	; LOADARG
	write -89 rbp r5
	; LOADARG
	write -90 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -90 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -90 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	read -89 rbp r5
	shiftl r5 5 r5
	; ADD
	load32 8 r12
	add r5 r12 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -91 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -91 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizSetSockReg16:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 94 rsp
	; LOADARG
	write -92 rbp r5
	; LOADARG
	write -93 rbp r4
	; LOADARG
	write -94 rbp r3
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -93 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; LBITSHIFT
	read -92 rbp r5
	shiftl r5 5 r5
	; ADD
	load32 12 r12
	add r5 r12 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RBITSHIFT
	read -94 rbp r5
	shiftr r5 8 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -94 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizGetSockReg16:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 97 rsp
	; LOADARG
	write -95 rbp r5
	; LOADARG
	write -96 rbp r4
	; ADDROF
	addr2reg Label_WizSpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
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
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	read -96 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	read -95 rbp r5
	shiftl r5 5 r5
	; ADD
	load32 8 r12
	add r5 r12 r5
	; SET
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LBITSHIFT
	shiftl r1 8 r1
	; SET
	write -97 rbp r1
	; ADDROF
	addr2reg Label_WizSpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -97 rbp r12
	add r1 r12 r1
	; SET
	write -97 rbp r1
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	read -97 rbp r12
	or r0 r12 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizWriteResponseFromMemory:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 105 rsp
	; LOADARG
	write -98 rbp r5
	; LOADARG
	write -99 rbp r4
	; LOADARG
	write -100 rbp r3
	; LESSOREQCMP
	or r0 1 r1
	read -100 rbp r12
	load32 0 r13
	bgt r12 r13 2
	jump Label___shivyc_label202
	or r0 0 r1
Label___shivyc_label202:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label84
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label84:
	; SET
	load32 0 r12
	write -101 rbp r12
	; LABEL
Label___shivyc_label85:
	; NOTEQUALCMP
	or r0 1 r1
	read -101 rbp r2
	or r0 r2 r12
	read -100 rbp r13
	beq r13 r12 2
	jump Label___shivyc_label203
	or r0 0 r1
Label___shivyc_label203:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label86
	; ADDROF
	addr2reg Label_wizGetSockReg8 r1
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	or r0 3 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label204
	or r0 0 r2
Label___shivyc_label204:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label87
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label87:
	; SUBTR
	read -100 rbp r1
	read -101 rbp r12
	sub r1 r12 r1
	; SET
	write -102 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -102 rbp r12
	load32 256 r13
	bge r13 r12 2
	jump Label___shivyc_label205
	or r0 0 r1
Label___shivyc_label205:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label88
	; SET
	load32 256 r12
	write -102 rbp r12
	; LABEL
Label___shivyc_label88:
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	or r0 32 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -103 rbp r1
	; SET
	load32 0 r12
	write -104 rbp r12
	; LABEL
Label___shivyc_label89:
	; LESSCMP
	or r0 1 r1
	read -103 rbp r2
	or r0 r2 r12
	read -102 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label206
	or r0 0 r1
Label___shivyc_label206:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label90
	; SET
	read -104 rbp r1
	; ADD
	read -104 rbp r1
	add r1 1 r1
	; SET
	write -104 rbp r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	or r0 32 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -103 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -104 rbp r12
	load32 1000 r13
	bge r13 r12 2
	jump Label___shivyc_label207
	or r0 0 r1
Label___shivyc_label207:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label91
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	or r0 8 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label91:
	; JUMP
	jump Label___shivyc_label89
	; LABEL
Label___shivyc_label90:
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	or r0 36 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -105 rbp r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; LBITSHIFT
	read -98 rbp r4
	shiftl r4 5 r4
	; ADD
	load32 20 r12
	add r4 r12 r4
	; SET
	read -101 rbp r3
	; MULT
	load32 1 r12
	mult r3 r12 r3
	; ADD
	read -99 rbp r12
	add r3 r12 r3
	; CALL
	read -105 rbp r12
	or r0 r12 r5
	read -102 rbp r12
	or r0 r12 r2
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -105 rbp r3
	read -102 rbp r12
	add r3 r12 r3
	; SET
	; ADDROF
	addr2reg Label_wizSetSockReg16 r1
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	or r0 36 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	or r0 32 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -101 rbp r1
	read -102 rbp r12
	add r1 r12 r1
	; SET
	write -101 rbp r1
	; JUMP
	jump Label___shivyc_label85
	; LABEL
Label___shivyc_label86:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizWriteResponseFromUSB:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 109 rsp
	; LOADARG
	write -106 rbp r5
	; LOADARG
	write -107 rbp r4
	; ADDROF
	addr2reg Label_CH376_setCursor r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label93
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label93:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label92
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit580 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label92:
	; SET
	load32 0 r12
	write -108 rbp r12
	; LABEL
Label___shivyc_label94:
	; NOTEQUALCMP
	or r0 1 r1
	read -108 rbp r2
	or r0 r2 r12
	read -107 rbp r13
	beq r13 r12 2
	jump Label___shivyc_label208
	or r0 0 r1
Label___shivyc_label208:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label95
	; SUBTR
	read -107 rbp r1
	read -108 rbp r12
	sub r1 r12 r1
	; SET
	write -109 rbp r1
	; GREATERCMP
	or r0 1 r1
	read -109 rbp r12
	load32 1024 r13
	bge r13 r12 2
	jump Label___shivyc_label209
	or r0 0 r1
Label___shivyc_label209:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label96
	; SET
	load32 1024 r12
	write -109 rbp r12
	; LABEL
Label___shivyc_label96:
	; ADDROF
	addr2reg Label_CH376_readFile r1
	; ADDROF
	addr2reg Label_fileBuffer r5
	; SET
	; CALL
	read -109 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label98
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label98:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label97
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit376 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label97:
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; ADDROF
	addr2reg Label_fileBuffer r4
	; SET
	; CALL
	read -106 rbp r12
	or r0 r12 r5
	read -109 rbp r12
	or r0 r12 r3
	savpc r12
	sub rsp 1 rsp
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
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label99
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label99:
	; ADD
	read -108 rbp r1
	read -109 rbp r12
	add r1 r12 r1
	; SET
	write -108 rbp r1
	; JUMP
	jump Label___shivyc_label94
	; LABEL
Label___shivyc_label95:
	; ADDROF
	addr2reg Label_CH376_closeFile r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizReadRecvData:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 112 rsp
	; LOADARG
	write -110 rbp r5
	; LOADARG
	write -111 rbp r4
	; LOADARG
	write -112 rbp r3
	; EQUALCMP
	or r0 1 r1
	read -112 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label210
	or r0 0 r1
Label___shivyc_label210:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label101
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label101:
	; GREATERCMP
	or r0 1 r1
	read -112 rbp r12
	load32 1024 r13
	bge r13 r12 2
	jump Label___shivyc_label211
	or r0 0 r1
Label___shivyc_label211:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label102
	; SET
	load32 1022 r12
	write -112 rbp r12
	; LABEL
Label___shivyc_label102:
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	read -110 rbp r12
	or r0 r12 r5
	or r0 40 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	or r0 r1 r5
	; ADDROF
	addr2reg Label_wizRead r1
	; LBITSHIFT
	read -110 rbp r4
	shiftl r4 5 r4
	; ADD
	load32 24 r12
	add r4 r12 r4
	; CALL
	read -111 rbp r12
	or r0 r12 r3
	read -112 rbp r12
	or r0 r12 r2
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	read -112 rbp r1
	; MULT
	load32 1 r12
	mult r1 r12 r1
	; ADD
	read -111 rbp r12
	add r1 r12 r1
	; SETAT
	load32 0 r12
	write 0 r1 r12
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizFlush:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 114 rsp
	; LOADARG
	write -113 rbp r5
	; LOADARG
	write -114 rbp r4
	; GREATERCMP
	or r0 1 r1
	read -114 rbp r12
	load32 0 r13
	bge r13 r12 2
	jump Label___shivyc_label212
	or r0 0 r1
Label___shivyc_label212:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label103
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	read -113 rbp r12
	or r0 r12 r5
	or r0 40 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; ADD
	read -114 rbp r12
	add r1 r12 r1
	; SET
	or r0 r1 r3
	; ADDROF
	addr2reg Label_wizSetSockReg16 r1
	; CALL
	read -113 rbp r12
	or r0 r12 r5
	or r0 40 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -113 rbp r12
	or r0 r12 r5
	or r0 64 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label103:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizSend404Response:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 58 rsp
	; LOADARG
	; ADDROF
	addr2reg Label___strlit27 r4
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	or r0 128 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizGetFilePath:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 58 rsp
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
Label___shivyc_label104:
	; EQUALCMP
	or r0 1 r1
	or r0 r5 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label213
	or r0 0 r1
Label___shivyc_label213:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label105
	; EQUALCMP
	or r0 1 r1
	or r0 r4 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label214
	or r0 0 r1
Label___shivyc_label214:
	; SET
	load32 1 r10
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label107
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
	jump Label___shivyc_label215
	or r0 0 r11
Label___shivyc_label215:
	; JUMPZERO
	sub r11 0 r12
	bne r0 r12 2
	jump Label___shivyc_label107
	; JUMP
	jump Label___shivyc_label108
	; LABEL
Label___shivyc_label107:
	; SET
	load32 0 r10
	; LABEL
Label___shivyc_label108:
	; JUMPZERO
	sub r10 0 r12
	bne r0 r12 2
	jump Label___shivyc_label106
	; SET
	load32 1 r4
	; JUMP
	jump Label___shivyc_label109
	; LABEL
Label___shivyc_label106:
	; EQUALCMP
	or r0 1 r1
	or r0 r4 r12
	load32 1 r13
	bne r13 r12 2
	jump Label___shivyc_label216
	or r0 0 r1
Label___shivyc_label216:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label110
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
	jump Label___shivyc_label217
	or r0 0 r10
Label___shivyc_label217:
	; JUMPZERO
	sub r10 0 r12
	bne r0 r12 2
	jump Label___shivyc_label111
	; SET
	load32 1 r5
	; JUMP
	jump Label___shivyc_label112
	; LABEL
Label___shivyc_label111:
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
Label___shivyc_label112:
	; LABEL
Label___shivyc_label110:
	; LABEL
Label___shivyc_label109:
	; SET
	or r0 r2 r1
	; ADD
	or r0 r2 r1
	add r1 1 r1
	; SET
	or r0 r1 r2
	; JUMP
	jump Label___shivyc_label104
	; LABEL
Label___shivyc_label105:
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
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizServeFile:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 118 rsp
	; LOADARG
	write -115 rbp r5
	; LOADARG
	write -116 rbp r4
	; MULT
	or r0 0 r1
	mult r1 1 r1
	; ADD
	read -116 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 47 r13
	bne r13 r12 2
	jump Label___shivyc_label218
	or r0 0 r2
Label___shivyc_label218:
	; SET
	load32 1 r3
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label114
	; MULT
	or r0 1 r1
	mult r1 1 r1
	; ADD
	read -116 rbp r12
	add r1 r12 r1
	; READAT
	read 0 r1 r1
	; SET
	; EQUALCMP
	or r0 1 r2
	or r0 r1 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label219
	or r0 0 r2
Label___shivyc_label219:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label114
	; JUMP
	jump Label___shivyc_label115
	; LABEL
Label___shivyc_label114:
	; SET
	load32 0 r3
	; LABEL
Label___shivyc_label115:
	; JUMPZERO
	sub r3 0 r12
	bne r0 r12 2
	jump Label___shivyc_label113
	; ADDROF
	addr2reg Label___strlit63 r4
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	or r0 52 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	or r0 8 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label113:
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label116
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit269 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; MULT
	or r0 0 r5
	mult r5 1 r5
	; ADD
	read -116 rbp r12
	add r5 r12 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit476 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label116:
	; SET
	load32 0 r12
	write -117 rbp r12
	; ADDROF
	addr2reg Label_CH376_sendFileName r1
	; MULT
	or r0 0 r5
	mult r5 1 r5
	; ADD
	read -116 rbp r12
	add r5 r12 r5
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label118
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label118:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label117
	; SET
	load32 404 r12
	write -117 rbp r12
	; LABEL
Label___shivyc_label117:
	; SET
	load32 1 r1
	; JUMPZERO
	read -117 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label120
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label120:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label119
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label122
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label122:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label121
	; SET
	load32 404 r12
	write -117 rbp r12
	; LABEL
Label___shivyc_label121:
	; LABEL
Label___shivyc_label119:
	; SET
	load32 1 r1
	; JUMPZERO
	read -117 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label124
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label124:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label123
	; ADDROF
	addr2reg Label_CH376_getFileSize r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -118 rbp r1
	; LABEL
Label___shivyc_label123:
	; SET
	load32 1 r1
	; JUMPZERO
	read -117 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label126
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label126:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label125
	; EQUALCMP
	or r0 1 r1
	read -118 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label220
	or r0 0 r1
Label___shivyc_label220:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label127
	; SET
	load32 404 r12
	write -117 rbp r12
	; LABEL
Label___shivyc_label127:
	; LABEL
Label___shivyc_label125:
	; SET
	load32 1 r1
	; JUMPZERO
	read -117 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label129
	; SET
	load32 0 r1
	; LABEL
Label___shivyc_label129:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label128
	; ADD
	read -118 rbp r2
	add r2 1 r2
	; EQUALCMP
	or r0 1 r1
	or r0 r2 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label221
	or r0 0 r1
Label___shivyc_label221:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label130
	; SET
	load32 404 r12
	write -117 rbp r12
	; LABEL
Label___shivyc_label130:
	; LABEL
Label___shivyc_label128:
	; JUMPZERO
	read -117 rbp r12
	bne r0 r12 2
	jump Label___shivyc_label131
	; ADDROF
	addr2reg Label___strlit418 r4
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	or r0 66 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_sendFileName r1
	; ADDROF
	addr2reg Label___strlit576 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_openFile r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 1 r2
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label133
	; SET
	load32 0 r2
	; LABEL
Label___shivyc_label133:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label132
	; ADDROF
	addr2reg Label_wizSend404Response r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label134
	; LABEL
Label___shivyc_label132:
	; ADDROF
	addr2reg Label_CH376_getFileSize r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -118 rbp r1
	; ADDROF
	addr2reg Label_wizWriteResponseFromUSB r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	read -118 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label134:
	; JUMP
	jump Label___shivyc_label135
	; LABEL
Label___shivyc_label131:
	; ADDROF
	addr2reg Label___strlit627 r4
	; SET
	; SET
	; ADDROF
	addr2reg Label_wizWriteResponseFromMemory r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	or r0 35 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWriteResponseFromUSB r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	read -118 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label135:
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -115 rbp r12
	or r0 r12 r5
	or r0 8 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizHandleSession:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 1272 rsp
	; LOADARG
	write -1271 rbp r5
	; ADDROF
	addr2reg Label_wizGetSockReg16 r1
	; CALL
	read -1271 rbp r12
	or r0 r12 r5
	or r0 38 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -1272 rbp r1
	; EQUALCMP
	or r0 1 r1
	read -1272 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label222
	or r0 0 r1
Label___shivyc_label222:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label136
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -1271 rbp r12
	or r0 r12 r5
	or r0 8 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label136:
	; ADDROF
	addr2reg Label_wizReadRecvData r1
	; ADDRREL
	sub rbp 1142 r4 ;lea
	; CALL
	read -1271 rbp r12
	or r0 r12 r5
	read -1272 rbp r12
	or r0 r12 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label137
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit317 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 1142 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit727 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label137:
	; ADDROF
	addr2reg Label_wizGetFilePath r1
	; ADDRREL
	sub rbp 1141 r5 ;lea
	; ADDRREL
	sub rbp 1270 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; ADDROF
	addr2reg Label_wizServeFile r1
	; ADDRREL
	sub rbp 1270 r4 ;lea
	; CALL
	read -1271 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wiz_Init:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 1290 rsp
	; SET
	load32 192 r1
	; SETREL
	write -1276 rbp r1
	; SET
	load32 168 r1
	; SETREL
	write -1275 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -1274 rbp r1
	; SET
	load32 213 r1
	; SETREL
	write -1273 rbp r1
	; SET
	load32 192 r1
	; SETREL
	write -1280 rbp r1
	; SET
	load32 168 r1
	; SETREL
	write -1279 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -1278 rbp r1
	; SET
	load32 1 r1
	; SETREL
	write -1277 rbp r1
	; SET
	load32 222 r1
	; SETREL
	write -1286 rbp r1
	; SET
	load32 173 r1
	; SETREL
	write -1285 rbp r1
	; SET
	load32 190 r1
	; SETREL
	write -1284 rbp r1
	; SET
	load32 239 r1
	; SETREL
	write -1283 rbp r1
	; SET
	load32 36 r1
	; SETREL
	write -1282 rbp r1
	; SET
	load32 100 r1
	; SETREL
	write -1281 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -1290 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -1289 rbp r1
	; SET
	load32 255 r1
	; SETREL
	write -1288 rbp r1
	; SET
	load32 0 r1
	; SETREL
	write -1287 rbp r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 1276 r3 ;lea
	; CALL
	or r0 15 r5
	or r0 4 r4
	or r0 4 r2
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 1280 r3 ;lea
	; CALL
	or r0 1 r5
	or r0 4 r4
	or r0 4 r2
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 1286 r3 ;lea
	; CALL
	or r0 9 r5
	or r0 4 r4
	or r0 6 r2
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizWrite r1
	; ADDRREL
	sub rbp 1290 r3 ;lea
	; CALL
	or r0 5 r5
	or r0 4 r4
	or r0 4 r2
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label138
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit201 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label138:
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_wizInitSocketTCP:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 1291 rsp
	; LOADARG
	write -1291 rbp r5
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -1291 rbp r12
	or r0 r12 r5
	or r0 16 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizSetSockReg8 r1
	; CALL
	read -1291 rbp r12
	or r0 r12 r5
	or r0 2 r4
	or r0 255 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizSetSockReg8 r1
	; CALL
	read -1291 rbp r12
	or r0 r12 r5
	or r0 0 r4
	or r0 1 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizSetSockReg16 r1
	; CALL
	read -1291 rbp r12
	or r0 r12 r5
	or r0 4 r4
	or r0 80 r3
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -1291 rbp r12
	or r0 r12 r5
	or r0 1 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizCmd r1
	; CALL
	read -1291 rbp r12
	or r0 r12 r5
	or r0 2 r4
	savpc r12
	sub rsp 1 rsp
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
	addr2reg Label___strlit645 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label139:
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
	sub rsp 1295 rsp
	; ADDROF
	addr2reg Label_WizSpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 100 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_init r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_connectDrive r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wiz_Init r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 1 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 2 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 3 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 4 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 5 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 6 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	or r0 7 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label140:
	; JUMPZERO
	or r0 1 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label141
	; SET
	load32 0 r12
	write -1294 rbp r12
	; LABEL
Label___shivyc_label142:
	; LESSCMP
	or r0 1 r1
	read -1294 rbp r12
	load32 8 r13
	bge r12 r13 2
	jump Label___shivyc_label223
	or r0 0 r1
Label___shivyc_label223:
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
	addr2reg Label___strlit514 r5
	; SET
	; SET
	; ADDROF
	addr2reg Label_uprint r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	load32 48 r1
	read -1294 rbp r12
	add r1 r12 r1
	; SET
	; SETREL
	write -1293 rbp r1
	; SETREL
	load32 0 r12
	write -1292 rbp r12
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 1293 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label145:
	; ADDROF
	addr2reg Label_wizGetSockReg8 r1
	; CALL
	read -1294 rbp r12
	or r0 r12 r5
	or r0 3 r4
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -1295 rbp r1
	; EQUALCMP
	or r0 1 r1
	read -1295 rbp r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label224
	or r0 0 r1
Label___shivyc_label224:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label146
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label147
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit361 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label147:
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	read -1294 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label148
	; LABEL
Label___shivyc_label146:
	; EQUALCMP
	or r0 1 r1
	read -1295 rbp r12
	load32 23 r13
	bne r13 r12 2
	jump Label___shivyc_label225
	or r0 0 r1
Label___shivyc_label225:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label149
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label150
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit683 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label150:
	; ADDROF
	addr2reg Label_wizHandleSession r1
	; CALL
	read -1294 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	read -1294 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label151
	; LABEL
Label___shivyc_label149:
	; EQUALCMP
	or r0 1 r1
	read -1295 rbp r12
	load32 20 r13
	bne r13 r12 2
	jump Label___shivyc_label226
	or r0 0 r1
Label___shivyc_label226:
	; SET
	load32 0 r3
	; JUMPNOTZERO
	sub r1 0 r12
	beq r0 r12 2
	jump Label___shivyc_label155
	; EQUALCMP
	or r0 1 r1
	read -1295 rbp r12
	load32 21 r13
	bne r13 r12 2
	jump Label___shivyc_label227
	or r0 0 r1
Label___shivyc_label227:
	; JUMPNOTZERO
	sub r1 0 r12
	beq r0 r12 2
	jump Label___shivyc_label155
	; JUMP
	jump Label___shivyc_label156
	; LABEL
Label___shivyc_label155:
	; SET
	load32 1 r3
	; LABEL
Label___shivyc_label156:
	; SET
	load32 0 r2
	; JUMPNOTZERO
	sub r3 0 r12
	beq r0 r12 2
	jump Label___shivyc_label153
	; EQUALCMP
	or r0 1 r1
	read -1295 rbp r12
	load32 22 r13
	bne r13 r12 2
	jump Label___shivyc_label228
	or r0 0 r1
Label___shivyc_label228:
	; JUMPNOTZERO
	sub r1 0 r12
	beq r0 r12 2
	jump Label___shivyc_label153
	; JUMP
	jump Label___shivyc_label154
	; LABEL
Label___shivyc_label153:
	; SET
	load32 1 r2
	; LABEL
Label___shivyc_label154:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label152
	; JUMP
	jump Label___shivyc_label157
	; LABEL
Label___shivyc_label152:
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label158
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit278 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label158:
	; ADDROF
	addr2reg Label_wizInitSocketTCP r1
	; CALL
	read -1294 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label157:
	; LABEL
Label___shivyc_label151:
	; LABEL
Label___shivyc_label148:
	; LABEL
Label___shivyc_label143:
	; SET
	read -1294 rbp r1
	; ADD
	read -1294 rbp r1
	add r1 1 r1
	; SET
	write -1294 rbp r1
	; JUMP
	jump Label___shivyc_label142
	; LABEL
Label___shivyc_label144:
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label140
	; LABEL
Label___shivyc_label141:
	; RETURN
	load32 0 r1
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
	sub rsp 1293 rsp
	; SET
	load32 4980736 r1
	; SETAT
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
	sub rsp 1293 rsp
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
	sub rsp 1293 rsp
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
	sub rsp 1293 rsp
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

