section .data
        str_format db "%s", 0
        input_msg db "Input x: ", 0
        float_format db "%f", 0
        msg_res_float_format db "Result: %f", 0x0a,0
        x dw 0.0
global main

section .text
    extern scanf, printf

main:
        ; Ввод x
        sub rsp, 8
        xor rax, rax
        mov rsi, str_format
        mov rdi, input_msg
        call printf

        mov rax, 0
        lea rdi, [float_format]
        mov rsi, x
        call scanf

        cvtss2sd xmm0, [x]
        mov rdi, msg_res_float_format
        mov eax, 1
        call printf

        ; Выход из программы
        xor eax, eax
        add rsp, 8
        ret
