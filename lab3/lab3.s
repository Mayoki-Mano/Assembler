section .data
	buffer_size equ 1
	nl equ 10
	filename db "/bin/cp", 0
    	arg0 db "cp", 0
    	arg1 db "lolka.txt", 0
    	arg2 db "lolka2.txt", 0
    	argv dq arg0, arg1, arg2, 0
section .bss
	buffer resb buffer_size 
	file_name resb 256
section .text
global _start

_start:
	; чтение имени файла
    mov rax, 0 ; syscall read
    mov rdi, 0 ; дескриптор стандартного ввода (stdin)
    mov rsi, file_name ; указатель на буфер
    mov rdx, 256 ; размер буфера
    syscall
    mov byte[file_name+rax-1], 0
    ; открытие файла
    mov rax, 2 ; syscall open
    mov rdi, file_name ; указатель на имя файла
    mov rsi, 1 ;(открыть только для записи)
    mov rdx, 0666 ; права доступа
    syscall
    mov r8, rax ; сохранить дескриптор файла в r8
    .st:
	xor r9, r9
    	xor r10, r10
    	xor r11, r11
    	xor r12, r12
    	xor r13, r13
    	xor r14, r14
    	xor r15, r15
    	.read_loop:
		mov rax, 0
		mov rdi, 0
		mov rsi, buffer
		mov rdx, buffer_size
		syscall
		cmp rax, 0
		jle .end
		add r9, rax
		jc .end
		mov r12, rax
		sub rsp, r12
		mov rsi, buffer
		mov rdi, rsp
		mov rcx, r12
		rep movsb
		cmp byte[buffer], nl
		je .done
		jmp .read_loop
	.done:
		xor r11, r11
		xor r12, r12
		xor r15, r15
		mov r15, rsp
		add r15, r9
		xor r14, r14
		xor r13, r13
		.skip_separators:
			dec r15
			cmp byte[r15],32
			je .skip_separators
			cmp byte[r15], 9
			je .skip_separators
		
		.find_len_min_word:
			cmp byte[r15], 32
			jle .found
			dec rsp
			mov rsi, r15
			mov rdi, rsp
			mov ecx, 1
			rep movsb
			dec r15
			inc r14
			inc r10
			jmp .find_len_min_word
		
		.found:
			dec rsp
			mov byte[rsp], 32
			inc r10
			.skip_32:
			xor r13, r13
			cmp byte[r15], nl
			je .end_str
			dec r15
		.find_len_current_word:
			cmp byte[r15], 32
			jle .found_current
			dec r15
			inc r13
			jmp .find_len_current_word
		.found_current:
			cmp r13, 0
			je .skip_32
			cmp r14, r13
			jne .skip_32
			inc r15
			mov rsi, r15
			sub rsp, r13
			mov rdi, rsp
			mov rcx, r13
			rep movsb
			add r10, r13
			dec r15
			jmp .found
		.end_str:
			dec rsp
			mov byte[rsp], nl
			inc r10
			mov r15, rsp
			add r15, r10
			.print_reverse:
				dec r15
				mov rax, 1
				mov rdi, r8
				mov rsi, r15
				mov rdx, 1
				syscall
				cmp r15, rsp
				jg .print_reverse
				mov byte[buffer], 10
				mov rax, 1
				mov rdi, 1
				mov rsi, buffer
				mov rdx, 1
				syscall
				add rsp, r9
				add rsp, r10
				jmp .st
		.end:
			mov rdi, r8
			mov rax, 3
			syscall
   			mov rdi, filename             ; Аргумент filename
   	            	mov rsi, argv                 ; Аргумент argv
		        xor rdx, rdx                 ; Аргумент envp
			mov rax, 59
			syscall
			mov rax, 60
			mov rdi, 0
			syscall
		
		

