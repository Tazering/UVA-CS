; shellcode.s

	global shellcode
	
	section .text

shellcode:
	section .text
	mysyscall:
		jmp afterString
	string:
		db "Tyler Kim, your grade on this assignment is an A"
	afterString:
		xor rax, rax ; zero out %rax
		mov al, 1 ; set code write for when we initiate a system call
		mov rdi, rax
		lea rsi, [rel string] ; move string to first parameter
		xor rdx, rdx ; zero out %rdx
		mov dl, 48
		syscall	
		xor rax, rax
		mov al, 60
		xor rdi, rdi
		syscall
