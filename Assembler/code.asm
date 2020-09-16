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

Label___strlit90:
	.dw 0
Label___strlit109:
	.dw 32 0
Label___strlit156:
	.dw 10 0

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
	jump Label___shivyc_label24
	or r0 0 r1
Label___shivyc_label24:
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
	jump Label___shivyc_label25
	or r0 0 r2
Label___shivyc_label25:
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
	jump Label___shivyc_label26
	or r0 0 r1
Label___shivyc_label26:
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
	jump Label___shivyc_label27
	or r0 0 r1
Label___shivyc_label27:
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
	jump Label___shivyc_label28
	or r0 0 r1
Label___shivyc_label28:
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
	jump Label___shivyc_label29
	or r0 0 r4
Label___shivyc_label29:
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
	addr2reg Label___strlit156 r5
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
	jump Label___shivyc_label30
	or r0 0 r1
Label___shivyc_label30:
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
	jump Label___shivyc_label31
	or r0 0 r1
Label___shivyc_label31:
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
	jump Label___shivyc_label32
	or r0 0 r1
Label___shivyc_label32:
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
	jump Label___shivyc_label33
	or r0 0 r1
Label___shivyc_label33:
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
Label_main:
	sub rsp 1 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 23 rsp
	; SET
	load32 8388609 r1
	; READAT
	read 0 r1 r1
	; SET
	write -21 rbp r1
	; ADDROF
	addr2reg Label_itoah r1
	; RBITSHIFT
	read -21 rbp r5
	shiftr r5 24 r5
	; AND
	or r0 255 r2
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; RBITSHIFT
	read -21 rbp r5
	shiftr r5 16 r5
	; AND
	or r0 255 r2
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; RBITSHIFT
	read -21 rbp r5
	shiftr r5 8 r5
	; AND
	or r0 255 r2
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; AND
	or r0 255 r2
	read -21 rbp r5
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
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
	; SET
	load32 12592950 r1
	; SETAT
	load32 1 r12
	write 0 r1 r12
	; ADDROF
	addr2reg Label_delay r1
	; CALL
	or r0 10 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 102 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 153 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 102 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 153 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
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
	addr2reg Label_SpiBeginTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 3 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 0 r12
	write -22 rbp r12
	; LABEL
Label___shivyc_label18:
	; LESSCMP
	or r0 1 r1
	read -22 rbp r12
	load32 16 r13
	bge r12 r13 2
	jump Label___shivyc_label34
	or r0 0 r1
Label___shivyc_label34:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label20
	; SET
	load32 0 r12
	write -23 rbp r12
	; LABEL
Label___shivyc_label21:
	; LESSCMP
	or r0 1 r1
	read -23 rbp r12
	load32 4 r13
	bge r12 r13 2
	jump Label___shivyc_label35
	or r0 0 r1
Label___shivyc_label35:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label23
	; ADDROF
	addr2reg Label_SpiTransfer r1
	; CALL
	or r0 0 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -21 rbp r1
	; ADDROF
	addr2reg Label_itoah r1
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	read -21 rbp r12
	or r0 r12 r5
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprint r1
	; ADDROF
	addr2reg Label___strlit109 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label22:
	; SET
	read -23 rbp r1
	; ADD
	read -23 rbp r1
	add r1 1 r1
	; SET
	write -23 rbp r1
	; JUMP
	jump Label___shivyc_label21
	; LABEL
Label___shivyc_label23:
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDROF
	addr2reg Label___strlit90 r5
	; SET
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; LABEL
Label___shivyc_label19:
	; SET
	read -22 rbp r1
	; ADD
	read -22 rbp r1
	add r1 1 r1
	; SET
	write -22 rbp r1
	; JUMP
	jump Label___shivyc_label18
	; LABEL
Label___shivyc_label20:
	; ADDROF
	addr2reg Label_SpiEndTransfer r1
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	load32 12592950 r1
	; SETAT
	load32 0 r12
	write 0 r1 r12
	; SET
	load32 8388609 r1
	; READAT
	read 0 r1 r1
	; SET
	write -21 rbp r1
	; ADDROF
	addr2reg Label_itoah r1
	; RBITSHIFT
	read -21 rbp r5
	shiftr r5 24 r5
	; AND
	or r0 255 r2
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; RBITSHIFT
	read -21 rbp r5
	shiftr r5 16 r5
	; AND
	or r0 255 r2
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; RBITSHIFT
	read -21 rbp r5
	shiftr r5 8 r5
	; AND
	or r0 255 r2
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_itoah r1
	; AND
	or r0 255 r2
	read -21 rbp r5
	and r5 r2 r5
	; ADDRREL
	sub rbp 20 r4 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADDROF
	addr2reg Label_uprintln r1
	; ADDRREL
	sub rbp 20 r5 ;lea
	; CALL
	savpc r12
	sub rsp 1 rsp
	write 0 rsp r12
	jumpr 0 r1
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

