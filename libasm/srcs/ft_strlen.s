section .text
    global _ft_strlen

_ft_strlen:
	push rbp				;prologue, signale la fonction courante pour le debugging
	mov rbp, rsp			;prologue, signale la fonction courante pour le debugging
	push rbx
	xor rax, rax			;mise à 0 du registre de retour rax (comparaison bit à bit avec ou exclusif)
	xor rbx, rbx
_loop:
	cmp [rdi + rbx], byte 0	;comparaison bit à bit de la valeur à l_adresse rdi avec elle-même, vaut 0 si [rdi] = 0 (équivaut à cmp [rdi], byte 0)
	jz _end					;jump à end si \0
	inc rax
	inc rbx					;incrément de l_adresse de la string d_un octet
	jmp _loop

_end:
	pop rbx
	pop rbp					;épilogue, sortie de la fonction
	ret