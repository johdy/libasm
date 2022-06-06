section .text
    global ft_list_push_front
    extern malloc
    extern __errno_location

ft_list_push_front:
	push rbp
	mov rbp, rsp
	xor r9, r9
	or rdi, rdi
	jz _end

_malloc_and_set:				;malloc du nouvel élem
	push rdi					;on conserve rdi et rsi sur la stack
	push rsi
	mov rdi, 16					;16 octets taille du malloc (2 * 8)
	call malloc
	pop rsi
	pop rdi
	or rax, rax					;si le malloc à échoué on sort proprement
	jz _err
	mov [rax], rsi				;sinon on met le data dans l_élem mallocé

_does_list_exist:				;si le pointeur sur liste est vide
	mov r12, [rdi]				;ou la liste n_a pas d_elem 
	or r12, r12					;on ne fait que mettre à jour le pointeur
	jz _no_list
	mov r13, [r12]
	or r13, r13
	jz _no_list

_hook:
	mov r9, [rdi]				;on se sert de r9 comme variable tampon
	mov [rax + 8], r9			;pour stocker l_adresse du premier elem qu_on définit comme next du nouvel elem
	jmp _pointer_hook

_no_list:
	mov r9, 0
	mov [rax + 8], r9

_pointer_hook:
	mov [rdi], rax				;on fait pointer le pointeur sur le nouvel elem
	jmp _end		

_err:
	call __errno_location
	mov r9, rax
	mov rcx, 12
	mov [r9], rcx
	mov rax, 0	

_end:
	pop rbp
	ret
