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
Label___strlit3:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 49 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit16:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 50 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit19:
	.dw 67 97 98 108 101 32 78 117 109 98 101 114 58 32 0
Label___strlit27:
	.dw 45 45 82 65 87 32 68 65 84 65 45 45 0
Label___strlit32:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 50 0
Label___strlit37:
	.dw 67 104 101 99 107 105 110 103 32 100 101 118 105 99 101 32 99 111 110 110 101 99 116 105 111 110 32 115 116 97 116 117 115 0
Label___strlit73:
	.dw 44 32 85 83 66 32 109 111 100 101 32 115 101 116 32 116 111 32 72 79 83 84 95 48 32 40 53 49 32 61 61 32 111 112 101 114 97 116 105 111 110 32 115 117 99 99 101 115 115 102 117 108 41 0
Label___strlit79:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 48 0
Label___strlit82:
	.dw 10 0
Label___strlit87:
	.dw 83 101 116 116 105 110 103 32 85 83 66 32 109 111 100 101 32 116 111 32 72 79 83 84 95 49 0
Label___strlit96:
	.dw 10 0
Label___strlit116:
	.dw 45 45 45 45 45 45 82 101 97 100 121 32 116 111 32 114 101 99 101 105 118 101 45 45 45 45 45 45 0
Label___strlit117:
	.dw 67 73 78 58 32 0
Label___strlit127:
	.dw 69 118 101 110 116 58 32 0
Label___strlit158:
	.dw 45 45 45 45 45 45 83 108 97 118 101 32 97 100 100 114 32 115 101 116 45 45 45 45 45 45 0
Label___strlit172:
	.dw 114 101 115 101 116 32 100 111 110 101 0
Label___strlit192:
	.dw 67 104 101 99 107 105 110 103 32 100 101 118 105 99 101 32 99 111 110 110 101 99 116 105 111 110 32 115 116 97 116 117 115 0
Label___strlit209:
	.dw 78 111 116 101 73 68 58 32 0
Label___strlit223:
	.dw 86 101 108 111 99 105 116 121 58 32 0
Label___strlit270:
	.dw 68 101 118 105 99 101 32 99 111 110 110 101 99 116 101 100 0
Label___strlit287:
	.dw 68 101 118 105 99 101 32 99 111 110 110 101 99 116 101 100 0
Label___strlit288:
	.dw 67 104 97 110 110 101 108 58 32 0
Label___strlit295:
	.dw 45 45 45 45 45 45 72 111 115 116 32 97 100 100 114 32 115 101 116 45 45 45 45 45 45 0
Label___strlit311:
	.dw 45 45 80 65 82 83 69 68 32 68 65 84 65 45 45 0

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
	jump Label___shivyc_label43
	or r0 0 r1
Label___shivyc_label43:
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
	jump Label___shivyc_label44
	or r0 0 r2
Label___shivyc_label44:
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
	jump Label___shivyc_label45
	or r0 0 r1
Label___shivyc_label45:
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
	jump Label___shivyc_label46
	or r0 0 r1
Label___shivyc_label46:
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
	jump Label___shivyc_label47
	or r0 0 r1
Label___shivyc_label47:
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
	jump Label___shivyc_label48
	or r0 0 r4
Label___shivyc_label48:
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
	addr2reg Label___strlit96 r5
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
	jump Label___shivyc_label49
	or r0 0 r1
Label___shivyc_label49:
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
	jump Label___shivyc_label50
	or r0 0 r1
Label___shivyc_label50:
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
	jump Label___shivyc_label51
	or r0 0 r1
Label___shivyc_label51:
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
	jump Label___shivyc_label52
	or r0 0 r1
Label___shivyc_label52:
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
Label_AssemblyImports:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ASMCODE
	`include example/data_music_midi.asm
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
Label_CH376_setUSBmode:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 72 rsp
	; LOADARG
	write -68 rbp r5
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
	read -68 rbp r12
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
	write -72 rbp r1
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
	read -72 rbp r12
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
	sub rsp 82 rsp
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
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label20
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit172 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label20:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label21
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit79 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label21:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 5 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	or r0 r1 r5
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label22
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 82 r4 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 82 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit73 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
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
Label_setUSBspeed:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 82 rsp
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
	or r0 11 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 23 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 216 r5
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
	or r0 20 r5
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
Label_connectDevice:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 92 rsp
	; SET
	load32 0 r5
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label23
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit192 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label23:
	or r0 r0 r0
	; LABEL
Label___shivyc_label24:
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
	jump Label___shivyc_label53
	or r0 0 r2
Label___shivyc_label53:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label25
	; JUMP
	jump Label___shivyc_label24
	; LABEL
Label___shivyc_label25:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label26
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit287 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label26:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label27
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit87 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label27:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_CH376_setUSBmode r1
	; CALL
	or r0 7 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	or r0 r1 r5
	; SET
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label28
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 92 r4 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 92 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit3 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label28:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label29
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit32 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
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
	or r0 r1 r5
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label30
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 92 r4 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 92 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit16 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label30:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label31
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
	; LABEL
Label___shivyc_label31:
	or r0 r0 r0
	; LABEL
Label___shivyc_label32:
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
	jump Label___shivyc_label54
	or r0 0 r2
Label___shivyc_label54:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label33
	; JUMP
	jump Label___shivyc_label32
	; LABEL
Label___shivyc_label33:
	or r0 r0 r0
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label34
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit270 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label34:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_toggle_recv:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 92 rsp
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
	or r0 28 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	addr2reg Label_endp_mode r7
	read 0 r7 r12
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
	; XOR
	addr2reg Label_endp_mode r7
	read 0 r7 r1
	xor r1 64 r1
	; SET
	addr2reg Label_endp_mode r7
	write 0 r7 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_issue_token:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 96 rsp
	; LOADARG
	write -96 rbp r5
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
	or r0 79 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -96 rbp r12
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
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_RD_USB_DATA:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 146 rsp
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
	or r0 40 r5
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
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -134 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -142 rbp r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -126 rbp r1
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
	addr2reg Label_CH376_spiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 12592946 r1
	; SETAT
	read -142 rbp r12
	write 0 r1 r12
	; SETAT
	read -126 rbp r12
	write 0 r1 r12
	; SETAT
	read -114 rbp r12
	write 0 r1 r12
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label35
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit27 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -134 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -142 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -126 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -114 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; AND
	read -134 rbp r1
	and r1 240 r1
	; SET
	write -110 rbp r1
	; AND
	read -134 rbp r1
	and r1 15 r1
	; SET
	write -118 rbp r1
	; AND
	read -142 rbp r1
	and r1 15 r1
	; SET
	write -122 rbp r1
	; AND
	read -142 rbp r1
	and r1 240 r1
	; SET
	write -130 rbp r1
	; SET
	read -126 rbp r12
	write -138 rbp r12
	; SET
	read -114 rbp r12
	write -146 rbp r12
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit311 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit19 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -110 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit117 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -118 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit288 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -122 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit127 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -130 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit209 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -138 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit223 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 106 r4 ;lea
	; CALL
	read -146 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 106 r5 ;lea
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit82 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label35:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_set_addr:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 150 rsp
	; LOADARG
	write -150 rbp r5
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
	or r0 69 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -150 rbp r12
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
	or r0 20 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label36
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit295 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
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
	or r0 19 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -150 rbp r12
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
	or r0 20 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMPZERO
	or r0 0 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label37
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit158 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label37:
	or r0 r0 r0
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_set_config:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 154 rsp
	; LOADARG
	write -154 rbp r5
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
	or r0 73 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_CH376_spiTransfer r1
	; CALL
	read -154 rbp r12
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
	or r0 20 r5
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
Label_startMidiPlayer:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 106 rsp
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
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_main:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 106 rsp
	; ADDROF
	addr2reg Label_CH376_init r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_connectDevice r1
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
	; ADDROF
	addr2reg Label_set_addr r1
	; CALL
	or r0 5 r5
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
	addr2reg Label_set_config r1
	; CALL
	or r0 1 r5
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
	jump Label___shivyc_label38
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit116 r5
	; SET
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label38:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_startMidiPlayer r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label39:
	or r0 r0 r0
	; JUMPZERO
	or r0 1 r1
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label40
	; ADDROF
	addr2reg Label_toggle_recv r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_issue_token r1
	; CALL
	or r0 89 r5
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label41:
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
	load32 20 r13
	beq r13 r12 2
	jump Label___shivyc_label55
	or r0 0 r2
Label___shivyc_label55:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label42
	; JUMP
	jump Label___shivyc_label41
	; LABEL
Label___shivyc_label42:
	or r0 r0 r0
	; ADDROF
	addr2reg Label_RD_USB_DATA r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; JUMP
	jump Label___shivyc_label39
	; LABEL
Label___shivyc_label40:
	or r0 r0 r0
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
	sub rsp 106 rsp
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
	sub rsp 106 rsp
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
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_int3:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 106 rsp
	; SET
	load32 12592686 r1
	; SETAT
	load32 45 r12
	write 0 r1 r12
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
	sub rsp 106 rsp
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

