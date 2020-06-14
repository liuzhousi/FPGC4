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

Label___strlit21:
	.dw 44 32 82 101 97 100 32 114 101 113 117 101 115 116 32 100 111 110 101 32 40 49 100 32 61 61 32 100 105 115 107 32 114 101 97 100 41 0
Label___strlit34:
	.dw 44 32 79 112 101 110 105 110 103 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit37:
	.dw 45 45 45 45 45 45 83 101 110 100 105 110 103 32 102 105 108 101 110 97 109 101 45 45 45 45 45 45 0
Label___strlit46:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 50 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit47:
	.dw 66 121 116 101 32 82 68 32 117 115 98 32 100 97 116 97 48 0
Label___strlit68:
	.dw 45 45 45 45 45 45 70 105 108 101 110 97 109 101 32 115 101 110 116 45 45 45 45 45 45 0
Label___strlit69:
	.dw 67 114 101 97 116 105 110 103 32 102 105 108 101 0
Label___strlit93:
	.dw 67 104 101 99 107 105 110 103 32 100 105 115 107 32 99 111 110 110 101 99 116 105 111 110 32 115 116 97 116 117 115 0
Label___strlit94:
	.dw 114 101 115 101 116 32 100 111 110 101 0
Label___strlit95:
	.dw 44 32 66 121 116 101 32 87 82 32 114 101 113 32 100 111 110 101 32 40 114 101 116 118 97 108 32 61 61 32 100 97 116 97 32 115 105 122 101 41 0
Label___strlit96:
	.dw 44 32 66 121 116 101 32 87 82 32 103 111 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit98:
	.dw 45 45 45 45 45 45 79 112 101 110 105 110 103 32 70 105 108 101 45 45 45 45 45 45 0
Label___strlit120:
	.dw 83 101 116 116 105 110 103 32 99 117 114 115 111 114 32 116 111 32 101 110 100 0
Label___strlit129:
	.dw 45 45 45 45 45 45 67 108 111 115 105 110 103 32 70 105 108 101 45 45 45 45 45 45 0
Label___strlit133:
	.dw 68 101 108 101 116 105 110 103 32 102 105 108 101 0
Label___strlit154:
	.dw 44 32 68 114 105 118 101 32 114 101 97 100 121 32 99 104 101 99 107 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit155:
	.dw 44 32 67 108 111 115 105 110 103 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit156:
	.dw 45 45 45 45 45 45 67 108 111 115 105 110 103 32 100 111 110 101 45 45 45 45 45 45 0
Label___strlit167:
	.dw 77 111 117 110 116 105 110 103 32 100 114 105 118 101 0
Label___strlit188:
	.dw 83 101 110 100 105 110 103 32 102 105 108 101 32 110 97 109 101 0
Label___strlit193:
	.dw 44 32 67 114 101 97 116 105 110 103 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit199:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 48 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit200:
	.dw 82 101 113 117 101 115 116 32 114 101 97 100 32 102 111 114 32 49 48 32 98 121 116 101 115 0
Label___strlit214:
	.dw 44 32 68 101 108 101 116 105 110 103 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit229:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 49 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit230:
	.dw 45 45 45 45 45 45 70 105 108 101 32 79 112 101 110 101 100 45 45 45 45 45 45 0
Label___strlit232:
	.dw 44 32 68 105 115 107 32 99 111 110 110 101 99 116 105 111 110 32 99 104 101 99 107 101 100 32 40 49 53 32 61 61 32 110 101 119 32 100 101 118 105 99 101 32 99 111 110 110 101 99 116 101 100 41 0
Label___strlit234:
	.dw 79 112 101 110 105 110 103 32 102 105 108 101 0
Label___strlit254:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 50 0
Label___strlit258:
	.dw 44 32 66 121 116 101 32 114 100 32 117 115 98 32 100 111 110 101 32 40 114 101 116 118 97 108 32 61 61 32 100 97 116 97 32 115 105 122 101 41 0
Label___strlit259:
	.dw 67 104 101 99 107 105 110 103 32 105 102 32 100 114 105 118 101 32 105 115 32 114 101 97 100 121 0
Label___strlit260:
	.dw 67 108 111 115 105 110 103 32 102 105 108 101 0
Label___strlit267:
	.dw 45 45 45 45 45 45 82 101 97 100 105 110 103 32 102 105 108 101 45 45 45 45 45 45 0
Label___strlit276:
	.dw 44 32 77 111 117 110 116 105 110 103 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit285:
	.dw 67 104 101 99 107 105 110 103 32 100 105 115 107 32 99 111 110 110 101 99 116 105 111 110 32 115 116 97 116 117 115 0
Label___strlit292:
	.dw 10 0
Label___strlit317:
	.dw 45 45 45 45 45 45 82 101 97 100 105 110 103 32 100 111 110 101 45 45 45 45 45 45 0
Label___strlit318:
	.dw 82 101 113 117 101 115 116 32 119 114 105 116 101 32 102 111 114 32 49 48 32 98 121 116 101 115 0
Label___strlit333:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 48 0
Label___strlit338:
	.dw 66 121 116 101 32 87 82 32 103 111 32 40 117 112 100 97 116 105 110 103 32 102 105 108 101 32 115 105 122 101 41 0
Label___strlit343:
	.dw 44 32 68 105 115 107 32 99 111 110 110 101 99 116 105 111 110 32 99 104 101 99 107 101 100 32 40 49 53 32 61 61 32 110 101 119 32 100 101 118 105 99 101 32 99 111 110 110 101 99 116 101 100 41 0
Label___strlit348:
	.dw 44 32 87 114 105 116 101 32 114 101 113 117 101 115 116 32 100 111 110 101 32 40 49 101 32 61 61 32 100 105 115 107 32 119 114 105 116 101 41 0
Label___strlit354:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 49 0
Label___strlit373:
	.dw 66 121 116 101 32 87 82 32 114 101 113 32 100 97 116 97 0
Label___strlit378:
	.dw 44 32 67 117 114 115 111 114 32 115 101 116 116 105 110 103 32 100 111 110 101 32 40 49 52 32 61 61 32 115 117 99 99 101 115 115 41 0
Label___strlit383:
	.dw 10 0
Label___strlit388:
	.dw 70 105 108 101 32 110 97 109 101 32 115 101 110 116 0

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
	jump Label___shivyc_label42
	or r0 0 r1
Label___shivyc_label42:
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
	jump Label___shivyc_label43
	or r0 0 r2
Label___shivyc_label43:
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
	jump Label___shivyc_label44
	or r0 0 r1
Label___shivyc_label44:
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
	jump Label___shivyc_label45
	or r0 0 r1
Label___shivyc_label45:
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
	; NOTEQUALCMP
	or r0 1 r4
	or r0 r1 r12
	load32 0 r13
	beq r13 r12 2
	jump Label___shivyc_label46
	or r0 0 r4
Label___shivyc_label46:
	; JUMPZERO
	sub r4 0 r12
	bne r0 r12 2
	jump Label___shivyc_label8
	; SET
	; SETAT
	write 0 r3 r2
	; SET
	read 0 r5 r1
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
	addr2reg Label___strlit292 r5
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
	jump Label___shivyc_label47
	or r0 0 r1
Label___shivyc_label47:
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
	jump Label___shivyc_label48
	or r0 0 r1
Label___shivyc_label48:
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
	jump Label___shivyc_label49
	or r0 0 r1
Label___shivyc_label49:
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
	jump Label___shivyc_label50
	or r0 0 r1
Label___shivyc_label50:
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
	; SET
	load32 12592689 r1
	; SETAT
	write 0 r1 r5
	; READAT
	read 0 r1 r1
	; SET
	; RETURN
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
	sub rsp 70 rsp
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
	or r0 60 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit94 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit333 r5
	; SET
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
	write -70 rbp r1
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
	sub rbp 66 r4 ;lea
	; CALL
	read -70 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 66 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit199 r5
	; SET
	; CALL
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
	sub rsp 84 rsp
	; SET
	load32 0 r12
	write -84 rbp r12
	; LABEL
Label___shivyc_label15:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -84 rbp r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label51
	or r0 0 r1
Label___shivyc_label51:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label16
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit285 r5
	; SET
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
	write -84 rbp r1
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
	sub rbp 80 r4 ;lea
	; CALL
	read -84 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 80 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit343 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label15
	; LABEL
Label___shivyc_label16:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit354 r5
	; SET
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
	or r0 7 r5
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
	write -84 rbp r1
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
	sub rbp 80 r4 ;lea
	; CALL
	read -84 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 80 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit229 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit254 r5
	; SET
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
	or r0 6 r5
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
	write -84 rbp r1
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
	sub rbp 80 r4 ;lea
	; CALL
	read -84 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 80 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
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
	; SET
	load32 0 r12
	write -84 rbp r12
	; LABEL
Label___shivyc_label17:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -84 rbp r12
	load32 21 r13
	beq r13 r12 2
	jump Label___shivyc_label52
	or r0 0 r1
Label___shivyc_label52:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label18
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit93 r5
	; SET
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
	write -84 rbp r1
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
	sub rbp 80 r4 ;lea
	; CALL
	read -84 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 80 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit232 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label17
	; LABEL
Label___shivyc_label18:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit259 r5
	; SET
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
	; SET
	load32 0 r12
	write -84 rbp r12
	; LABEL
Label___shivyc_label19:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -84 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label53
	or r0 0 r1
Label___shivyc_label53:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label20
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
	write -84 rbp r1
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
	sub rbp 80 r4 ;lea
	; CALL
	read -84 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 80 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit154 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label19
	; LABEL
Label___shivyc_label20:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit167 r5
	; SET
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
	; SET
	load32 0 r12
	write -84 rbp r12
	; LABEL
Label___shivyc_label21:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -84 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label54
	or r0 0 r1
Label___shivyc_label54:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label22
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
	write -84 rbp r1
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
	sub rbp 80 r4 ;lea
	; CALL
	read -84 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 80 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit276 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label21
	; LABEL
Label___shivyc_label22:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
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
Label_CH376_setCursor:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 98 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit120 r5
	; SET
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
	or r0 57 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 255 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 255 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 255 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 255 r5
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
	write -98 rbp r12
	; LABEL
Label___shivyc_label23:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -98 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label55
	or r0 0 r1
Label___shivyc_label55:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label24
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
	write -98 rbp r1
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
	sub rbp 94 r4 ;lea
	; CALL
	read -98 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 94 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit378 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label23
	; LABEL
Label___shivyc_label24:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
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
Label_CH376_readFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 116 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit200 r5
	; SET
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
	or r0 58 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 20 r5
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
	write -112 rbp r12
	; LABEL
Label___shivyc_label25:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -112 rbp r12
	load32 29 r13
	beq r13 r12 2
	jump Label___shivyc_label56
	or r0 0 r1
Label___shivyc_label56:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label26
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
	write -112 rbp r1
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
	sub rbp 108 r4 ;lea
	; CALL
	read -112 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 108 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit21 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label25
	; LABEL
Label___shivyc_label26:
	or r0 r0 r0
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
	addr2reg Label___strlit47 r5
	; SET
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
	write -112 rbp r1
	; SET
	load32 0 r12
	write -116 rbp r12
	; LABEL
Label___shivyc_label27:
	or r0 r0 r0
	; LESSCMP
	or r0 1 r1
	read -116 rbp r12
	load32 20 r13
	bge r12 r13 2
	jump Label___shivyc_label57
	or r0 0 r1
Label___shivyc_label57:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label29
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	; ADDROF
	addr2reg Label_uprintc r2
	; SET
	; CALL
	or r0 r1 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r2
	; LABEL
Label___shivyc_label28:
	or r0 r0 r0
	; SET
	read -116 rbp r1
	; ADD
	read -116 rbp r1
	add r1 1 r1
	; SET
	write -116 rbp r1
	; JUMP
	jump Label___shivyc_label27
	; LABEL
Label___shivyc_label29:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit383 r5
	; SET
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
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 108 r4 ;lea
	; CALL
	read -112 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 108 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit258 r5
	; SET
	; CALL
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
	; RETURN
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
	sub rsp 130 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit318 r5
	; SET
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
	or r0 60 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 10 r5
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
	write -130 rbp r12
	; LABEL
Label___shivyc_label30:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -130 rbp r12
	load32 30 r13
	beq r13 r12 2
	jump Label___shivyc_label58
	or r0 0 r1
Label___shivyc_label58:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label31
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
	write -130 rbp r1
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
	sub rbp 126 r4 ;lea
	; CALL
	read -130 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 126 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit348 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label30
	; LABEL
Label___shivyc_label31:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit373 r5
	; SET
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
	write -130 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 65 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 66 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 67 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 68 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 69 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 70 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 71 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 72 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 73 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 74 r5
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
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 126 r4 ;lea
	; CALL
	read -130 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 126 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit95 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit338 r5
	; SET
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
	; SET
	load32 0 r12
	write -130 rbp r12
	; LABEL
Label___shivyc_label32:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -130 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label59
	or r0 0 r1
Label___shivyc_label59:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label33
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
	write -130 rbp r1
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
	sub rbp 126 r4 ;lea
	; CALL
	read -130 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 126 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit96 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label32
	; LABEL
Label___shivyc_label33:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
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
Label_CH376_openFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 144 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit234 r5
	; SET
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
	; SET
	load32 0 r12
	write -144 rbp r12
	; LABEL
Label___shivyc_label34:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -144 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label60
	or r0 0 r1
Label___shivyc_label60:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label35
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
	write -144 rbp r1
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
	sub rbp 140 r4 ;lea
	; CALL
	read -144 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 140 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit34 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label34
	; LABEL
Label___shivyc_label35:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
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
Label_CH376_createFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 158 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit69 r5
	; SET
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
	; SET
	load32 0 r12
	write -158 rbp r12
	; LABEL
Label___shivyc_label36:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -158 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label61
	or r0 0 r1
Label___shivyc_label61:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label37
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
	write -158 rbp r1
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
	sub rbp 154 r4 ;lea
	; CALL
	read -158 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 154 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit193 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label36
	; LABEL
Label___shivyc_label37:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
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
Label_CH376_deleteFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 172 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit133 r5
	; SET
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
	; SET
	load32 0 r12
	write -172 rbp r12
	; LABEL
Label___shivyc_label38:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -172 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label62
	or r0 0 r1
Label___shivyc_label62:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label39
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
	write -172 rbp r1
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
	sub rbp 168 r4 ;lea
	; CALL
	read -172 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 168 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit214 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label38
	; LABEL
Label___shivyc_label39:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
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
Label_CH376_closeFile:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 186 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit260 r5
	; SET
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
	; SET
	load32 0 r12
	write -186 rbp r12
	; LABEL
Label___shivyc_label40:
	or r0 r0 r0
	; NOTEQUALCMP
	or r0 1 r1
	read -186 rbp r12
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label63
	or r0 0 r1
Label___shivyc_label63:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label41
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
	write -186 rbp r1
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
	sub rbp 182 r4 ;lea
	; CALL
	read -186 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 182 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit155 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label40
	; LABEL
Label___shivyc_label41:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
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
Label_CH376_sendFileName:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 182 rsp
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit188 r5
	; SET
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
	or r0 47 r5
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
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 84 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 69 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 83 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 84 r5
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
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 46 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 84 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 88 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 84 r5
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
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit388 r5
	; SET
	; CALL
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
	sub rsp 182 rsp
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
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit37 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_sendFileName r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit68 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit98 r5
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
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit230 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit267 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_readFile r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit317 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit129 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_closeFile r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit156 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; RETURN
	load32 48 r1
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
	sub rsp 182 rsp
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
	sub rsp 182 rsp
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
	sub rsp 182 rsp
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
	sub rsp 182 rsp
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

