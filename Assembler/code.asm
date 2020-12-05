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

Label___strlit57:
	.dw 68 101 108 97 121 32 68 111 110 101 0
Label___strlit77:
	.dw 10 0
Label___strlit92:
	.dw 68 101 108 97 121 32 83 116 97 114 116 101 100 0
Label___strlit98:
	.dw 72 101 108 108 111 63 32 73 115 32 105 116 32 109 101 32 121 111 117 39 114 101 32 108 111 111 107 105 110 103 32 102 111 114 63 0

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
	jump Label___shivyc_label18
	load32 0 r1
Label___shivyc_label18:
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
	jump Label___shivyc_label19
	load32 0 r2
Label___shivyc_label19:
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
	jump Label___shivyc_label20
	load32 0 r1
Label___shivyc_label20:
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
	jump Label___shivyc_label21
	load32 0 r1
Label___shivyc_label21:
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
	jump Label___shivyc_label22
	load32 0 r1
Label___shivyc_label22:
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
	load32 12592931 r1
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
	load32 12592931 r3
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
	jump Label___shivyc_label23
	load32 0 r4
Label___shivyc_label23:
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
	addr2reg Label___strlit77 r5
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
	jump Label___shivyc_label24
	load32 0 r1
Label___shivyc_label24:
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
	jump Label___shivyc_label25
	load32 0 r1
Label___shivyc_label25:
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
	jump Label___shivyc_label26
	load32 0 r1
Label___shivyc_label26:
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
	load32 12592953 r1
	; SETAT
	or r0 r1 r1
	write 0 r1 r5
	; SET
	load32 12592954 r1
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
	jump Label___shivyc_label27
	load32 0 r1
Label___shivyc_label27:
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
Label_main:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 21 rsp
	; ADDROF
	addr2reg Label___strlit98 r5
	; SET
	; SET
	; ADDROF
	addr2reg Label_uprintln r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 1024 r12
	write -21 rbp r12
	; ADDROF
	addr2reg Label_itoa r1
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	read -21 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	read -21 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit92 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	load32 1000 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit57 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
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
	sub rsp 20 rsp
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
	sub rsp 20 rsp
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
	sub rsp 20 rsp
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
	sub rsp 20 rsp
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

