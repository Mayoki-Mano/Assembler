section .data
    str_format db "%s", 0
    input_msg db "Input x: ", 0

section .text
    extern scanf, printf
    global main

main:
	; Ввод x
	xor rax, rax
	mov rsi, str_format
    	mov rdi, input_msg
    	call printf

    	; Выход из программы
    	xor eax, eax
    	ret
