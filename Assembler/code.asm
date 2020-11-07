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

Label_UARTbufferIndex:
	.dw 0
Label_currentCommand:
	.dw 0
Label_UARTbuffer:
	.dw 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Label___strlit101:
	.dw 47 47 47 47 47 47 47 47 47 47 47 47 0
Label___strlit122:
	.dw 45 45 45 0
Label___strlit303:
	.dw 10 0

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
	jump Label___shivyc_label44
	load32 0 r1
Label___shivyc_label44:
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
	jump Label___shivyc_label45
	load32 0 r2
Label___shivyc_label45:
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
	jump Label___shivyc_label46
	load32 0 r1
Label___shivyc_label46:
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
	jump Label___shivyc_label47
	load32 0 r1
Label___shivyc_label47:
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
	jump Label___shivyc_label48
	load32 0 r1
Label___shivyc_label48:
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
	jump Label___shivyc_label49
	load32 0 r4
Label___shivyc_label49:
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
	addr2reg Label___strlit303 r5
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
	jump Label___shivyc_label50
	load32 0 r1
Label___shivyc_label50:
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
	jump Label___shivyc_label51
	load32 0 r1
Label___shivyc_label51:
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
	jump Label___shivyc_label52
	load32 0 r1
Label___shivyc_label52:
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
	jump Label___shivyc_label53
	load32 0 r1
Label___shivyc_label53:
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
Label_SpiBeginTransfer:
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
	load 0b1111101111111111 r2
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
Label_SpiEndTransfer:
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
	load 0b10000000000 r2
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
Label_SpiTransfer:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; ASMCODE
	load32 0xC02735 r1
	write 0 r1 r5
	read 0 r1 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_initSPI:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 12592950 r1
	; SETAT
	or r0 r1 r1
	load32 1 r12
	write 0 r1 r12
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 102 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 153 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 102 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 153 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_readDeviceID:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 22 rsp
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 144 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -21 rbp r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -22 rbp r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	read -22 rbp r5
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
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_readAndPrint:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 27 rsp
	; LOADARG
	; LOADARG
	; LOADARG
	; LOADARG
	; SET
	write -23 rbp r5
	; SET
	write -24 rbp r4
	; SET
	write -25 rbp r3
	; SET
	write -26 rbp r2
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 3 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -24 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -25 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -26 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 0 r12
	write -27 rbp r12
	; LABEL
Label___shivyc_label18:
	; LESSCMP
	load32 1 r1
	read -27 rbp r12
	read -23 rbp r13
	bge r12 r13 2
	jump Label___shivyc_label54
	load32 0 r1
Label___shivyc_label54:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label20
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; ADDROF
	addr2reg Label_uprintc r2
	; SET
	; CALL
	or r0 r1 r5
	or r0 r2 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label19:
	; SET
	read -27 rbp r1
	; ADD
	read -27 rbp r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	write -27 rbp r1
	; JUMP
	jump Label___shivyc_label18
	; LABEL
Label___shivyc_label20:
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
Label_readStatusRegister:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 29 rsp
	; LOADARG
	write -28 rbp r5
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; EQUALCMP
	load32 1 r1
	read -28 rbp r12
	load32 2 r13
	bne r13 r12 2
	jump Label___shivyc_label55
	load32 0 r1
Label___shivyc_label55:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label21
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 53 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMP
	jump Label___shivyc_label22
	; LABEL
Label___shivyc_label21:
	; EQUALCMP
	load32 1 r1
	read -28 rbp r12
	load32 3 r13
	bne r13 r12 2
	jump Label___shivyc_label56
	load32 0 r1
Label___shivyc_label56:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label23
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 21 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMP
	jump Label___shivyc_label24
	; LABEL
Label___shivyc_label23:
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 5 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label24:
	; LABEL
Label___shivyc_label22:
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 0 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	write -29 rbp r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; RETURN
	read -29 rbp r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_enableWrite:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 20 rsp
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 6 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_chipErase:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 20 rsp
	; ADDROF
	addr2reg Label_enableWrite r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_readStatusRegister r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; AND
	or r0 r1 r12
	load32 2 r13
	and r12 r13 r12
	or r0 r12 r1
	; EQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label57
	load32 0 r2
Label___shivyc_label57:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label25
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label25:
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 199 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 1 r1
	; LABEL
Label___shivyc_label26:
	; AND
	or r0 r1 r12
	load32 1 r13
	and r12 r13 r12
	or r0 r12 r1
	; EQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 1 r13
	bne r13 r12 2
	jump Label___shivyc_label58
	load32 0 r2
Label___shivyc_label58:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label27
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
	addr2reg Label_readStatusRegister r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; JUMP
	jump Label___shivyc_label26
	; LABEL
Label___shivyc_label27:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_blockErase:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 32 rsp
	; LOADARG
	; LOADARG
	; LOADARG
	; SET
	write -30 rbp r5
	; SET
	write -31 rbp r4
	; SET
	write -32 rbp r3
	; ADDROF
	addr2reg Label_enableWrite r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_readStatusRegister r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; AND
	or r0 r1 r12
	load32 2 r13
	and r12 r13 r12
	or r0 r12 r1
	; EQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label59
	load32 0 r2
Label___shivyc_label59:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label28
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label28:
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 82 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -30 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -31 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -32 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 1 r1
	; LABEL
Label___shivyc_label29:
	; AND
	or r0 r1 r12
	load32 1 r13
	and r12 r13 r12
	or r0 r12 r1
	; EQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 1 r13
	bne r13 r12 2
	jump Label___shivyc_label60
	load32 0 r2
Label___shivyc_label60:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label30
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
	addr2reg Label_readStatusRegister r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; JUMP
	jump Label___shivyc_label29
	; LABEL
Label___shivyc_label30:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_pageProgram:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 36 rsp
	; LOADARG
	; RBITSHIFT
	or r0 r5 r12
	load32 16 r13
	shiftr r12 r13 r12
	or r0 r12 r1
	; SET
	write -33 rbp r1
	; RBITSHIFT
	or r0 r5 r12
	load32 8 r13
	shiftr r12 r13 r12
	or r0 r12 r1
	; SET
	write -34 rbp r1
	; SET
	write -35 rbp r5
	; ADDROF
	addr2reg Label_enableWrite r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_readStatusRegister r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; AND
	or r0 r1 r12
	load32 2 r13
	and r12 r13 r12
	or r0 r12 r1
	; EQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label61
	load32 0 r2
Label___shivyc_label61:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label31
	; RETURN
	load32 0 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label31:
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 2 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -33 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -34 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	read -35 rbp r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 0 r12
	write -36 rbp r12
	; LABEL
Label___shivyc_label32:
	; LESSCMP
	load32 1 r1
	read -36 rbp r12
	load32 256 r13
	bge r12 r13 2
	jump Label___shivyc_label62
	load32 0 r1
Label___shivyc_label62:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label34
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	load32 65 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label33:
	; SET
	read -36 rbp r1
	; ADD
	read -36 rbp r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	write -36 rbp r1
	; JUMP
	jump Label___shivyc_label32
	; LABEL
Label___shivyc_label34:
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	load32 1 r1
	; LABEL
Label___shivyc_label35:
	; AND
	or r0 r1 r12
	load32 1 r13
	and r12 r13 r12
	or r0 r12 r1
	; EQUALCMP
	load32 1 r2
	or r0 r1 r12
	load32 1 r13
	bne r13 r12 2
	jump Label___shivyc_label63
	load32 0 r2
Label___shivyc_label63:
	; JUMPZERO
	or r0 r2 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label36
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
	addr2reg Label_readStatusRegister r1
	; CALL
	load32 1 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	; JUMP
	jump Label___shivyc_label35
	; LABEL
Label___shivyc_label36:
	; RETURN
	load32 1 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 1 rsp
	read 0 rsp r12
	add rsp 1 rsp
	jumpr 4 r12
Label_processCommand:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 20 rsp
	; EQUALCMP
	load32 1 r1
	addr2reg Label_currentCommand r7
	read 0 r7 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label64
	load32 0 r1
Label___shivyc_label64:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label37
	; LABEL
Label___shivyc_label37:
	; EQUALCMP
	load32 1 r1
	addr2reg Label_currentCommand r7
	read 0 r7 r12
	load32 114 r13
	bne r13 r12 2
	jump Label___shivyc_label65
	load32 0 r1
Label___shivyc_label65:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label38
	; READREL
	addr2reg Label_UARTbuffer r7
	read 1 r7 r5
	; LBITSHIFT
	or r0 r5 r12
	load32 16 r13
	shiftl r12 r13 r12
	or r0 r12 r5
	; SET
	; READREL
	addr2reg Label_UARTbuffer r7
	read 2 r7 r1
	; LBITSHIFT
	or r0 r1 r12
	load32 8 r13
	shiftl r12 r13 r12
	or r0 r12 r1
	; ADD
	or r0 r5 r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	or r0 r1 r5
	; READREL
	addr2reg Label_UARTbuffer r7
	read 3 r7 r1
	; ADD
	or r0 r5 r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	or r0 r1 r5
	; READREL
	addr2reg Label_UARTbuffer r7
	read 4 r7 r4
	; SET
	; READREL
	addr2reg Label_UARTbuffer r7
	read 5 r7 r3
	; SET
	; READREL
	addr2reg Label_UARTbuffer r7
	read 6 r7 r2
	; SET
	; ADDROF
	addr2reg Label_readAndPrint r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; LABEL
Label___shivyc_label38:
	; EQUALCMP
	load32 1 r1
	addr2reg Label_currentCommand r7
	read 0 r7 r12
	load32 101 r13
	bne r13 r12 2
	jump Label___shivyc_label66
	load32 0 r1
Label___shivyc_label66:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label39
	; LABEL
Label___shivyc_label39:
	; SET
	load32 0 r12
	addr2reg Label_currentCommand r7
	write 0 r7 r12
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
	sub rsp 46 rsp
	; ADDROF
	addr2reg Label_initSPI r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_readDeviceID r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit122 r5
	; SET
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_pageProgram r1
	; CALL
	load32 2048 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SET
	or r0 r1 r5
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 46 r4 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 46 r5 ;lea
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
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
	; ADDROF
	addr2reg Label_uprintc r1
	; CALL
	load32 64 r5
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; SETREL
	load32 114 r12
	addr2reg Label_UARTbuffer r7
	write 0 r7 r12
	; SETREL
	load32 0 r12
	addr2reg Label_UARTbuffer r7
	write 1 r7 r12
	; SETREL
	load32 32 r12
	addr2reg Label_UARTbuffer r7
	write 2 r7 r12
	; SETREL
	load32 0 r12
	addr2reg Label_UARTbuffer r7
	write 3 r7 r12
	; SETREL
	load32 0 r12
	addr2reg Label_UARTbuffer r7
	write 4 r7 r12
	; SETREL
	load32 0 r12
	addr2reg Label_UARTbuffer r7
	write 5 r7 r12
	; SETREL
	load32 0 r12
	addr2reg Label_UARTbuffer r7
	write 6 r7 r12
	; SETREL
	load32 10 r12
	addr2reg Label_UARTbuffer r7
	write 7 r7 r12
	; SET
	load32 114 r12
	addr2reg Label_currentCommand r7
	write 0 r7 r12
	; LABEL
Label___shivyc_label40:
	; JUMPZERO
	load32 1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label41
	; ADDROF
	addr2reg Label_processCommand r1
	; CALL
	or r0 r1 r13
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r13
	; JUMP
	jump Label___shivyc_label40
	; LABEL
Label___shivyc_label41:
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
	sub rsp 46 rsp
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
	sub rsp 46 rsp
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
	sub rsp 46 rsp
	; EQUALCMP
	load32 1 r1
	addr2reg Label_currentCommand r7
	read 0 r7 r12
	load32 0 r13
	bne r13 r12 2
	jump Label___shivyc_label67
	load32 0 r1
Label___shivyc_label67:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label42
	; SET
	load32 12592687 r1
	; READAT
	or r0 r1 r1
	read 0 r1 r3
	; SET
	; ADDROF
	addr2reg Label_UARTbuffer r2
	; SET
	; SET
	; SET
	addr2reg Label_UARTbufferIndex r7
	read 0 r7 r1
	; MULT
	or r0 r1 r12
	load32 1 r13
	mult r12 r13 r12
	or r0 r12 r1
	; ADD
	or r0 r2 r12
	or r0 r1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SETAT
	or r0 r1 r1
	write 0 r1 r3
	; SET
	addr2reg Label_UARTbufferIndex r7
	read 0 r7 r1
	; ADD
	addr2reg Label_UARTbufferIndex r7
	read 0 r7 r12
	load32 1 r13
	add r12 r13 r12
	or r0 r12 r1
	; SET
	addr2reg Label_UARTbufferIndex r7
	write 0 r7 r1
	; EQUALCMP
	load32 1 r1
	addr2reg Label_UARTbufferIndex r7
	read 0 r7 r12
	load32 8 r13
	bne r13 r12 2
	jump Label___shivyc_label68
	load32 0 r1
Label___shivyc_label68:
	; JUMPZERO
	or r0 r1 r12
	sub r12 0 r12
	bne r0 r12 2
	jump Label___shivyc_label43
	; READAT
	or r0 r2 r2
	read 0 r2 r1
	; SET
	addr2reg Label_currentCommand r7
	write 0 r7 r1
	; SET
	load32 0 r12
	addr2reg Label_UARTbufferIndex r7
	write 0 r7 r12
	; LABEL
Label___shivyc_label43:
	; LABEL
Label___shivyc_label42:
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
	sub rsp 46 rsp
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

