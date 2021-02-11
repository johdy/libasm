section .text
    global _ft_strcmp

_ft_strcmp:
	push rbp
	mov rbp, rsp
	xor rax, rax
	xor rcx, rcx
	xor rdx, rdx
	xor r8, r8

_protecti:
	or rdi, rdi
	jz _end
	or rsi, rsi
	jz _end
	jmp _loop

_loop:
	mov dl, [rdi + r8]
	mov cl, [rsi + r8]
	cmp cl, dl
	jz _increm
	jmp _calc_ret

_increm:
	or cl, cl			;si cl=0, comme cl=dl, les deux strings sont terminées
	jz _calc_ret
	inc r8
	jmp _loop

_calc_ret:
	sub rax, rcx		;la valeur de retour est la soustraction entre les char différent de s1 et de s2
	add rax, rdx

_end:
	pop rbp
	ret