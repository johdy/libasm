section .text
    global _ft_list_size

_ft_list_size:
	push rbp
	mov rbp, rsp
	xor rax, rax			;compteur du nombre d_élément

_protec:
	or rdi, rdi
	jz _end
	mov rdi, [rdi + 8]		;|adresse de data (8 octets)|adresse de l_elem suivant (8 octets)|
	inc rax
	jmp _protec

_end:
	pop rbp
	ret