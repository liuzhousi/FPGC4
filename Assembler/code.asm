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

Label_sum:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; LOADARG
	; LOADARG
	; ADD
	or r0 r5 r1
	add r1 r4 r1
	; RETURN
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
Label_g:
	sub rsp 4 rsp
	write 0 rsp rbp
	or r0 rsp rbp
	sub rsp 0 rsp
	; ADDROF
	addr2reg Label_sum r1
	; CALL
	or r0 1 r5
	or r0 2 r4
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
	sub rsp 8 rsp
	; SET
	load 5 r12
	write -4 rbp r12
	; SET
	load 0 r12
	write -8 rbp r12
	; LABEL
Label___shivyc_label1:
	; LESSCMP
	or r0 1 r1
	read -8 rbp r12
	load 3 r13
	bge r12 r13 2
	jump Label___shivyc_label8
	or r0 0 r1
Label___shivyc_label8:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label3
	; ADDROF
	addr2reg Label_sum r1
	; CALL
	read -4 rbp r12
	or r0 r12 r5
	read -8 rbp r12
	or r0 r12 r4
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; SET
	write -4 rbp r1
	; LABEL
Label___shivyc_label2:
	; SET
	read -8 rbp r1
	; ADD
	read -8 rbp r1
	add r1 1 r1
	; SET
	write -8 rbp r1
	; JUMP
	jump Label___shivyc_label1
	; LABEL
Label___shivyc_label3:
	; EQUALCMP
	or r0 1 r1
	read -4 rbp r12
	load 8 r13
	bne r13 r12 2
	jump Label___shivyc_label9
	or r0 0 r1
Label___shivyc_label9:
	; JUMPZERO
	sub r1 0 r12
	bne r0 r12 2
	jump Label___shivyc_label4
	; ADDROF
	addr2reg Label_g r1
	; CALL
	savpc r12
	sub rsp 4 rsp
	write 0 rsp r12
	jumpr 0 r1
	; ADD
	read -4 rbp r12
	add r1 r12 r1
	; SET
	write -4 rbp r1
	; JUMP
	jump Label___shivyc_label5
	; LABEL
Label___shivyc_label4:
	; RETURN
	or r0 999 r1
	or r0 rbp rsp
	read 0 rsp rbp
	add rsp 4 rsp
	read 0 rsp r12
	add rsp 4 rsp
	jumpr 4 r12
	; LABEL
Label___shivyc_label5:
	; SET
	load 0 r1
	; LABEL
Label___shivyc_label6:
	; GREATEROREQCMP
	or r0 1 r2
	read -4 rbp r12
	load 9 r13
	bgt r13 r12 2
	jump Label___shivyc_label10
	or r0 0 r2
Label___shivyc_label10:
	; JUMPZERO
	sub r2 0 r12
	bne r0 r12 2
	jump Label___shivyc_label7
	; SUBTR
	read -4 rbp r2
	sub r2 1 r2
	; SET
	write -4 rbp r2
	; ADD
	add r1 1 r1
	; SET
	; JUMP
	jump Label___shivyc_label6
	; LABEL
Label___shivyc_label7:
	; ADD
	read -4 rbp r12
	add r1 r12 r1
	; RETURN
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
	sub rsp 0 rsp
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
	sub rsp 0 rsp
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
	sub rsp 0 rsp
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
	sub rsp 0 rsp
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

