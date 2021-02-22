section .text
    global ft_write
    extern __errno_location

ft_write:
	push rbp
	mov rbp, rsp
	mov rax, 0x2000004		;code du syscall write
	syscall
	cmp rax, 0				;si rax < 0 le read a échoué
	jl _err
	jmp _end

_err:
	push rax				;sauvegarde du code erreur dans registre neutre
	push r15				;alignement de la stack
	call __errno_location	;appel d___error qui va mettre le pointeur errno dans rax
	pop r15
	pop rcx
	neg rcx
	mov [rax], rcx			;mise du code erreur à adresse de errno
	mov rax, -1				;valeur de retour : -1

_end:
	pop rbp
	ret