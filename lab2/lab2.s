section .data
matrix: db 5, 5 ; количество строк и столбцов матрицы
        dq 0, 1, 3, 2, 1 ; элементы матрицы
        dq 0, 0, 4, 2, 5
        dq 9, 10, 0, 9, 4
        dq 1, 2, 3, 5, 4
        dq 1, 1, 1, 1, 1
section .text
global _start
_start:
    mov rbp, rsp; for correct debugging
    xor r8, r8
    xor r10,r10
    xor r11,r11
    xor r12, r12
    mov r10b, byte[matrix]
    mov r11b, byte[matrix+1]
    .for_loop_rows:
        cmp r8b, r10b
        jge .exit_rows_loop
        xor r9, r9
        add r9b,1
        add r12, 1
        .for_loop_colls:
            cmp r9b, r11b
            jge .exit_colls_loop
            xor rdi, rdi
            xor rsi, rsi
            mov rdi, qword[matrix+r12*8+2] ; key=data[i]    
            mov rbx, 0 ;lo
            mov rcx, r9 ;hi
            .while_loop:
                cmp rbx, rcx
                jge .exit_while
                mov rax, rcx ;hi
                add rax, rbx ;hi+lo
                xor rdx, rdx
                mov r15, 2
                div r15 ;(hi+lo)//2 mid
                xor rdx, rdx
                mov rsi, rax ;mid
                mov rax, r8 ; номер строки
                mul r11 ; смещение 
                add rax, rsi ; data[mid]=matrix[rax*8+2]
                mov r13, qword[matrix+rax*8+2] ;data[mid]
 
                ; сравниваем значения в регистрах rdi и r13
                %ifdef RIGHT_SORT
                    cmp rdi, r13
                %else
                    cmp r13, rdi
                %endif
                jge .else_block ; переходим к метке else_block, если rdi >= r13
                mov rcx, rsi
                jmp .end_if 
                .else_block:
                    mov rbx, rsi ; присваиваем rbx значение rsi + 1
                    add rbx,1
                .end_if: ;rsi rax rcx free
                jmp .while_loop
            .exit_while:
                mov rsi, rbx ;lo    
                mov r14, r9  ;j
                .for_loop_j:
                    cmp rsi, r14
                    je .exit_loop_j
                    mov rax, r8 ; номер строки
                    mul r11 ; смещение 
                    add rax, r14 ; data[j]=matrix[rax*8+2]
                    mov rcx, qword[matrix+rax*8-6]
                    mov qword[matrix+rax*8+2], rcx
                    dec r14 ;j
                    jmp .for_loop_j
                .exit_loop_j:
                    mov rax, r8 ; номер строки
                    mul r11 ; смещение 
                    add rax, rbx ; data[lo]=matrix[rax*8+2]
                    mov qword[matrix+rax*8+2], rdi
            inc r12
            inc r9b
            jmp .for_loop_colls
        .exit_colls_loop:
        inc r8b
        jmp .for_loop_rows
    .exit_rows_loop:
        jmp .end
    .end:
    xor rax, rax
    mov eax,60
    syscall
