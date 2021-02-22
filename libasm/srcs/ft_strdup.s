section .text
    global ft_strdup
    extern ft_strlen
    extern malloc
    extern ft_strcpy
    extern __errno_location

ft_strdup:
	push rbp
	mov rbp, rsp
	push rbx			;on retient rbx qui est callee saved

_protect_and_count:
	or rdi, rdi
	jz _end
	call ft_strlen		;strlen met la longueur de l_arg dans rax

_m_word:
	push rdi			;on push puis recupere l_arg de strdup (aligenemt stack grace a push rbx)
	inc rax				;strlen + 1
	mov rdi, rax		;qu_on met dans rdi car c_est l_arg de malloc
	call malloc
	pop rdi
	or rax, rax			;si malloc n_a rien renvoye alors malloc a echoue
	jz _err

_copy:
	mov rsi, rdi		;on prepare les arguments de strcpy
	mov rdi, rax
	call ft_strcpy
	jmp _end

_err:
	push r15
	call ___errno_location
	pop r15
	mov rbx, rax
	mov rcx, 12			;12 code d_erreur en cas de mauvais malloc
	mov [rbx], rcx
	mov rax, 0

_end:
	pop rbx
	pop rbp
	ret

