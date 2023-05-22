section .text
global AssemblyDesaturation

AssemblyDesaturation:
    ;unsigned char *data,unsigned char* image_data,int width, int height
    ;rdi rsi dword[rdx] dword[r8]
    xor rax,rax
    mov eax,dword[rdx]
    mov eax,dword[r8d]
    xor rdx, rdx
    mov edx, r8d
    mul rdx
    mov r9, rax ; r9=width*height
    xor r10, r10 ;r10=i
    xor rax, rax
    xor rdx,rdx
    xor rbx, rbx
    xor rcx, rcx
    xor r11, r11
    xor r12, r12
    .for: ; r11=min r12=max
	mov r15, rdi
	add r15, r10
	add r15, r10
	add r15, r10
        mov al, byte[r15]
        mov bl, byte[r15+1]
        mov cl, byte[r15+2]
        cmp al,bl
        jge .first_if
        cmp bl,cl
        jge .second_if
        mov r11b, al
        mov r12b, cl
        jmp .end_if
        .second_if:
            mov r12b, bl
            cmp al,cl
            jge .third_if
            mov r11b,al
            jmp .end_if
            .third_if:
                mov r11b, cl
                jmp .end_if
        .first_if:
            cmp al,cl
            jge .fourth_if
            mov r11b, bl
            mov r12b, cl
            jmp .end_if
            .fourth_if:
                mov r12b,al
                cmp bl,cl
                jge .fifth_if
                mov r11b, bl
                jmp .end_if
                .fifth_if:
                    mov r11b,cl
        .end_if:
        mov ax,r11w
        add ax, r12w
        xor rdx, rdx
        mov rbx, 2
        div rbx ;rax=(max+min)/2
        add rsi, r10
        mov byte[rsi], al
	sub rsi, r10
        inc r10
        cmp r10,r9
        jne .for
    ret
