section .text
    global _ft_list_remove_if
    extern _free

_ft_list_remove_if:
	push rbp
	mov rbp, rsp
	xor r13, r13			;flag premier elem OK

_protection:
	or rdi, rdi
	jz _end
	or rdx, rdx
	jz _end
	or rcx, rcx
	jz _end

_init:
	mov r12, rsi
	mov r15, rdi			;r15 garde en mémoire le ptr sur liste
	mov rdi, [rdi]			;on met premier maillon dans rdi
	jmp _boucle

_next_elem:
	mov r15, rdi			;r8 garde en mémoire elem précédent
	mov rdi, [rdi + 8]		;on avance d_un maillon

_boucle:
	or rdi, rdi				;s_il est vide la liste est finie
	jz _end
	push rdi				;on retient l_adresse du maillon
	mov rdi, [rdi]			;on compare la data (rsi est le comparant)
	push rdx
	push rcx
	mov rsi, r12
	call rdx
	pop rcx
	pop rdx
	pop rdi
	or rax, rax				;si les elems sont identiques, on supprime l_elem
	jz _suppr
	mov r13d, 1				;sinon on active le flag qui signale que le premier elem est ok
	jmp _next_elem

_suppr:
	mov r14, [rdi + 8]
	push rbx
	push rcx
	push rdx	
	push rdi				;on retient adresse de ce maillon pour le free
	mov rdi, [rdi]			;on free data
	call rcx
	pop rdi
	push rdi
	call _free				;on free maillon
	pop rdi
	pop rdx
	pop rcx
	pop rbx
	or r13, r13
	jz _new_beginning
	mov [r15 + 8], r14			;on link le maillon précédent avec maillon suivant
	mov rdi, r14				;on passe à l_elem suivant
	jmp _boucle

_new_beginning:
	mov [r15], r14			;on met ptr sur liste sur nouveau premier elem
	mov rdi, r14				;on teste le nouvel elem
	jmp _boucle

_end:
	pop rbp
	ret