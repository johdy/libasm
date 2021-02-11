section .text
    global _ft_list_push_front
    extern _malloc
    extern ___error

_ft_list_push_front:
	push rbp
	mov rbp, rsp
	xor rbx, rbx

_malloc_and_set:				;malloc du nouvel élem
	push rdi					;on conserve rdi et rsi sur la stack
	push rsi
	mov rdi, 16					;16 octets taille du malloc (2 * 8)
	call _malloc
	pop rsi
	pop rdi
	or rax, rax					;si le malloc à échoué on sort proprement
	jz _err
	mov [rax], rsi				;sinon on met le data dans l_élem mallocé

_does_list_exist:				;si le pointeur sur liste est vide
	or rdi, rdi					;ou la liste n_a pas d_elem 
	jz _pointer_hook			;on ne fait que mettre à jour le pointeur
	cmp qword [rdi], 0
	jz _pointer_hook

_hook:
	mov rbx, [rdi]				;on se sert de rbx comme variable tampon
	mov [rax + 8], rbx			;pour stocker l_adresse du premier elem qu_on définit comme next du nouvel elem

_pointer_hook:
	mov [rdi], rax				;on fait pointer le pointeur sur le nouvel elem
	jmp _end		

_err:
	call ___error
	mov rbx, rax
	mov rcx, 12
	mov [rbx], rcx
	mov rax, 0	

_end:
	pop rbp
	ret