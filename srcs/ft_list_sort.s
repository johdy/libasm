section .text
    global ft_list_sort

ft_list_sort:					;tri à bulles
	push rbp
	mov rbp, rsp
	push rbx
	push r14
	push r15

_protect:						;si la fonction n_existe pas
	or rsi, rsi					;ou si le pointeur sur liste
	jz _end						;ou le premier élément de la liste
	or rdi, rdi					;n_existent pas, on sort de la fonction
	jz _end
	cmp qword [rdi], 0
	jz _end

_begin:
	mov rbx, rsi				;sauvegarde de la fct dans rbx
	mov r14, rdi					;r14 adresse du next précédent
	mov r15, r14					;r15 pointeur vers le premier maillon de la liste 
	mov rdi, [rdi]				;initialisation avec premier élément de la liste

_compare:
	mov rsi, [rdi + 8]			;on compare rdi avec l_élément suivant
	cmp rsi, 0					;si rsi est vide, la liste à été parcourue
	jz _end
	push rdi					;on met les éléments sur la stack
	push rsi					;afin de mettre les datas dans rdi rsi
	push r14
	push r15
	mov rdi, [rdi]
	mov rsi, [rsi]				;|adresse de data (8 octets)|adresse de l_elem suivant (8 octets)|
	call rbx					;on appelle la fonction
	pop r15
	pop r14
	pop rsi
	pop rdi
	cmp rax, 0					;si rax > 0, on intervertit les datas
	jg _switch
	mov r14, rdi
	add r14, 8
	mov rdi, [rdi + 8]			;sinon on passe à l_élément suivant
	jmp _compare

_switch:
	mov r10, [rsi + 8]
	mov r11, rdi
	mov [rdi + 8], r10
	mov [rsi + 8], r11
	mov [r14], rsi
	cmp r14, r15
	jz _update_first
	mov rdi, [r15]				;on recommence le tri du début de la liste
	mov r14, r15
	jmp _compare

_update_first:
	mov [r15], rsi
	mov rdi, [r15]
	mov r14, r15
	jmp _compare

_end:
	pop r15
	pop r14
	pop rbx
	pop rbp
	ret
