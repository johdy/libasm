section .text
    global _ft_read
    extern ___error

_ft_read:
	push rbp
	mov rbp, rsp
	mov rax, 0x2000003		;code du syscall write
	syscall
	jc _err					;jump si flag carry est activé (une erreur de read l_active)
	jmp _end

_err:
	push rax				;sauvegarde du code erreur dans registre neutre
	push r15				;alignement de la stack
	call ___error			;appel d___error qui va mettre le pointeur errno dans rax
	pop r15
	pop rcx
	mov r9, rax
	mov [r9], rcx			;mise du code erreur à adresse de errno
	mov rax, -1				;valeur de retour : -1

_end:
	pop rbp
	ret