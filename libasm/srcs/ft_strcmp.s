section .text
    global ft_strcmp

ft_strcmp:
	push rbp
	mov rbp, rsp
	xor rax, rax			;mise a zero des registres utilises
	xor rcx, rcx
	xor rdx, rdx
	xor r8, r8
	or rdi, rdi				;protection si chaînte inexistante
	jz _end
	or rsi, rsi
	jz _end

_loop:
	mov dl, [rdi + r8]		;on utilise le premier octet de rcx et rdx pour comparer les caracteres
	mov cl, [rsi + r8]
	cmp cl, dl
	jz _increm
	jmp _calc_ret

_increm:
	or cl, cl			;si cl=0, comme cl=dl, les deux strings sont terminées
	jz _end
	inc r8				;si les caracteres sont les memes on incremente le pointeur
	jmp _loop

_calc_ret:
	sub rax, rcx		;la valeur de retour est la soustraction entre les char différent de s1 et de s2
	add rax, rdx

_end:
	pop rbp
	ret