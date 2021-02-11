section .text
    global _ft_strcpy

_ft_strcpy:
	push rbp
	mov rbp, rsp
	xor rcx, rcx
	mov rax, rdi			;on définit la valeur de retour comme l_adresse en rdi (dest) avant de la modifier

_protection:
	or rsi, rsi
	jz _end

_loop:
	cmp [rsi], byte 0			;copie jusque \0 de src
	jz _null_term
	mov cl, [rsi]			;on se sert de cl (premier octet du registre rcx car on copie un char) comme tampon
	mov [rdi], cl			;car mov mémoire, mémoire est impossible
	inc rsi
	inc rdi
	jmp _loop

_null_term:
	mov [rdi], byte 0		;on null-terminate la string copiée

_end:
	pop rbp
	ret
