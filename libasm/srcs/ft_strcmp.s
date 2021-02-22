section .text
    global _ft_strcmp

_ft_strcmp:
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
	cmp cl, dl		;on definit la veleur de retour selon la string superieure
	ja _above
	mov rax, 1
	jmp _end

_above:
	mov rax, -1

_end:
	pop rbp
	ret