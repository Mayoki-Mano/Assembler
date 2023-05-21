section .data
        str_format db "%s", 0
        input_msg db "Input x: ", 0
	input_acr_msg db "Input accuracy: ", 0
        float_format db "%f", 0
        msg_res_float_format db "Theoretical result: %f",0x0a,"Received result: %f", 0x0a,0
	x dd 0.0
	acr dd 0.0
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
	; Ввод acr
        xor rax, rax
        mov rsi, str_format
        mov rdi, input_acr_msg
        call printf
	xor rax,rax
        lea rdi, [float_format]
        mov rsi, acr
        call scanf

	;подсчёт sqrt(1+x)
	mov rbx, 1
	cvtsi2ss xmm11, rbx
	addss xmm11, [x] ;1+x
	sqrtss xmm11, xmm11

	cvtsi2ss xmm1, rbx
	cvtsi2ss xmm2, rbx
	mov r12, 0
	mov r13, 4
	cvtsi2ss xmm3, r12
	cvtsi2ss xmm10, rbx
	addss xmm10, xmm10
	mov r9, 0 ;n
	.while: ;xmm2- result  xmm1-член ряда xmm12 - точность xmm11 - sqrt(1+x)
		movss xmm12, xmm11
		subss xmm12, xmm2
		ucomiss xmm3, xmm12
		jc .positive
		subss xmm3,xmm12
		movss xmm12, xmm3
		cvtsi2ss xmm3, r12
		.positive:
		ucomiss xmm12, dword[acr]
		jc .end
		;xmm4 (2n+1) xmm5 (n+1) xmm6 (1-2n) xmm7 (x/4) xmm8 xmm9 xmm10 для промежуточных вычислений
		cvtsi2ss xmm8, rbx
		cvtsi2ss xmm9, r9
		addss xmm9, xmm8
		movss xmm5, xmm9
		addss xmm9, xmm9
		subss xmm9, xmm8
		movss xmm4, xmm9
		cvtsi2ss xmm9, r9
		addss xmm9, xmm9
		subss xmm8, xmm9
		movss xmm6, xmm8
		movss xmm8, dword[x]
		cvtsi2ss xmm9, r13
		divss xmm8, xmm9
		movss xmm7, xmm8
		mulss xmm1, xmm10
		mulss xmm1, xmm4
		divss xmm1, xmm5
		mulss xmm1, xmm6
		subss xmm6, xmm10
		divss xmm1, xmm6
		mulss xmm1, xmm7 ;xmm1 - вычеслен как член ряда
		mov rax, r9
		mov r15, 2
		xor rdx, rdx
		div r15
		mov r15, rdx
		inc r9
		cmp r15, 1
		je .not_even
		subss xmm2, xmm1
		jmp .while
		.not_even:
			addss xmm2, xmm1
		jmp .while
	.end:
	;вывод sqrt(1+x) и потом посчитанного числа
	cvtss2sd xmm1, xmm2
	cvtss2sd xmm0, xmm11
        mov rdi, msg_res_float_format
        mov eax, 2
        call printf
        ; Выход из программы
        xor eax, eax
        add rsp, 8
        ret
