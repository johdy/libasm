section .text
	global _ft_atoi_base
	extern _ft_strlen

_ft_atoi_base:
	push rbp
	mov rbp, rsp
	push rbx
	push r14
	push r15
	xor rbx, rbx				;rbx premier compteur
	mov rcx, 1					;rcx second compteur
	xor r8, r8					;r8 char
	xor r9, r9					;r9 flag min (set à 0 = '+')
	xor r14, r14				;r14 flag pour _is_white_space (activé si white space)
	xor r15, r15				;r15 flag pour _is_white_space (erreur ou boucle)

_get_base_length:
	push rdi					;on préserve arg1
	mov rdi, rsi				;on met arg2 dans arg1 pour strlen
	call _ft_strlen
	mov r10, rax				;r10 taille de la base
	xor rax, rax
	pop rdi
	mov r8b, [rsi]				;r8 caractère que l_on vérifie

_check_base_inval_char:
	cmp r8b, 43					;erreur si + ou - dans la base
	jz _invalid_base			;.
	cmp r8b, 45					;.
	jz _invalid_base			;.	
	jmp _is_white_space

_check_base_double:
	cmp rcx, r10				;si c2 = taille_base, on inc c1
	jz _next_char
	cmp r8b, [rsi + rcx]		;si le char est égal à str[c2] base invalide
	jz _invalid_base
	inc rcx						;c2++
	jmp _check_base_double

_next_char:
	inc rbx						;c1 valide donc on passe au char suivant
	cmp rbx, r10				;si c1 = taille_base check over
	jz _valid_base
	mov r8b, [rsi + rbx]		;on update r8
	mov rcx, rbx				;c2 = c1 + 1
	inc rcx
	jmp _check_base_inval_char

_invalid_base:
	mov rax, 0					;si erreur return 0
	jmp _end

_valid_base:					;si base ok, on réinitialise les compteurs
	xor rcx, rcx
	xor rbx, rbx
	mov r15, 1
	mov r8b, [rdi]

_is_white_space:
	cmp r8b, 0x20
	jz _white_space
	cmp r8b, 0x09
	jz _white_space
	cmp r8b, 0x0a
	jz _white_space
	cmp r8b, 0x0b
	jz _white_space
	cmp r8b, 0x0c
	jz _white_space
	cmp r8b, 0x0d
	jz _white_space
	or r15, r15
	jz _check_base_double
	jmp _check_neg

_white_space:
	or r15, r15
	jz _invalid_base
	inc rdi
	mov r8b, [rdi]
	jmp _is_white_space

_check_neg:
	cmp r8b, 45					;if r8 != '-'
	jnz _check_pos				;go à check_pos
	mov r9b, 1					;sinon flag neg activé
	inc rdi
	mov r8b, [rdi]
	jmp _update_char			;go à parse

_check_pos:
	cmp r8b, 43					;avancer pointeur si [rdi] = '+'
	jnz _update_char
	inc rdi

_update_char:					;boucle 1 : sur s1
	mov r8b, [rdi + rbx]		;.

_parse_nb:						;.
	cmp r8b, 0					;.check si s1 finie
	jz _end						;.
	xor rcx, rcx				;.remise à zéro compteur boucle 2

_define_unit:					;.boucle 2 : recherche s1[x] dans s2
	cmp rcx, r10				;..si le caractère n_a pas été trouvé, les args sont invalides
	jz _end						;..
	cmp r8b, [rsi + rcx]		;..si caractère trouvé, on update rax
	jz _update_nb				;..
	inc rcx						;..sinon on continue à le chercher, incrément c2
	jmp _define_unit			;..

_update_nb:
	mul r10d					;update rax
	add eax, ecx				;update rax
	inc rbx						;incrément c1
	jmp _update_char
	
_end:							;on multiplie rax par -1 si le flag neg est activé
	cmp r9, 0
	jz _return
	neg eax

_return:
	pop r15
	pop r14
	pop rbx
	pop rbp
	ret