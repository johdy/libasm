section .text
    global _ft_strdup
    extern _ft_strlen
    extern _malloc
    extern _ft_strcpy
    extern ___error

_ft_strdup:
	push rbp
	mov rbp, rsp
	push rbx

_protect_and_count:
	or rdi, rdi
	jz _end
	call _ft_strlen

_m_word:
	push rdi
	inc rax
	mov rdi, rax
	call _malloc
	pop rdi
	or rax, rax
	jz _err

_copy:
	mov rsi, rdi
	mov rdi, rax
	call _ft_strcpy
	jmp _end

_err:
	call ___error
	mov rbx, rax
	mov rcx, 12
	mov [rbx], rcx
	mov rax, 0

_end:
	pop rbx
	pop rbp
	ret

