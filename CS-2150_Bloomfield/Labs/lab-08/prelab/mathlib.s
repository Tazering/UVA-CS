;	Name: Tyler Kim
; 	Computing Id: tkj9ep
; 	Date: 03/29/2022
;	Filename: mathlib.s

;	Parameter 1 (in rdi) is x
;	Parameter 2 (in rsi) is y
;	return long value

	global product
	global power

	section .data

	section .text
	
product:
	xor	rax, rax
	xor r10, r10

product_start:

	cmp r10, rsi	;	is i == y
	je	done_product	;	end loop if they are equal
	add rax, rdi	;	sum = sum + x	
	add r10, 1	;	i++
	jmp	product_start	;	beginning of loop

done_product:

	ret

power:
	xor rax, rax
	mov r11, 1

	
power_start:
	
	mov rax, 1
	cmp rsi, 0	;	base case where y == 0
	je done_power	; return 1
	dec rsi
	call power
	mov rsi, rax
	call product
	

done_power:
	ret
