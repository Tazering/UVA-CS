;	Name: Tyler Kim
; 	Computing Id: tkj9ep
; 	Date: 04/12/2022
;	Filename: threexplusone.s


;	Parameter 1 (in rdi) is x
;	
;	optimizations: changed to bitshifts and additions 
;
;	return long value

	global threexplusone

	section .data
	

	section .text
	
threexplusone:
	mov rax,0
	mov r11,0

threexplusonestart:
	cmp rdi,1
	je done
	mov r11,rdi
	and r11,1
	cmp r11,1
	je odd
	jmp even

odd:
	inc rax
	mov r10, rdi
	shl rdi, 1
	add rdi, r10
	inc rdi
	call threexplusonestart
	ret

even:
	inc rax
	shr rdi,1
	call threexplusonestart
	ret


done:
	ret

	
	
