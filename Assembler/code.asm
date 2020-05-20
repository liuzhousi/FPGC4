Main:
    load32 0x700000 rsp
    jump Label_main
    halt    













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
    jump Label___shivyc_label7
    or r0 0 r1
Label___shivyc_label7:
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
    jump Label___shivyc_label8
    or r0 0 r1
Label___shivyc_label8:
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
    ; LABEL
Label___shivyc_label4:
    ; SET
    load 0 r1
    ; LABEL
Label___shivyc_label5:
    ; GREATEROREQCMP
    or r0 1 r2
    read -4 rbp r12
    load 9 r13
    bgt r13 r12 2
    jump Label___shivyc_label9
    or r0 0 r2
Label___shivyc_label9:
    ; JUMPZERO
    sub r2 0 r12
    bne r0 r12 2
    jump Label___shivyc_label6
    ; SUBTR
    read -4 rbp r2
    sub r2 1 r2
    ; SET
    write -4 rbp r2
    ; ADD
    add r1 1 r1
    ; SET
    ; JUMP
    jump Label___shivyc_label5
    ; LABEL
Label___shivyc_label6:
    ; ADD
    read -4 rbp r12
    add r1 r12 r1
    ; SET
    ; RETURN
    or r0 rbp rsp
    read 0 rsp rbp
    add rsp 4 rsp
    read 0 rsp r12
    add rsp 4 rsp
    jumpr 4 r12












Int1:
    reti

Int2:
    reti

Int3:
    reti

Int4:
    reti                    ; return from interrupt


