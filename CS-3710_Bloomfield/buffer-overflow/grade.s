	.file	"grade.c"
	.text
	.globl	print_buffer_address
	.bss
	.align 4
	.type	print_buffer_address, @object
	.size	print_buffer_address, 4
print_buffer_address:
	.zero	4
	.globl	global_name
	.align 32
	.type	global_name, @object
	.size	global_name, 100
global_name:
	.zero	100
	.section	.rodata
.LC0:
	.string	"%lx\n"
.LC1:
	.string	"Please enter your name:"
	.text
	.globl	vulnerable
	.type	vulnerable, @function
vulnerable:
.LFB6:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$224, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movl	print_buffer_address(%rip), %eax
	testl	%eax, %eax
	je	.L2
	leaq	-208(%rbp), %rax
	addq	$32, %rax
	movq	%rax, -216(%rbp)
	movq	-216(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$0, %edi
	call	exit@PLT
.L2:
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movq	stdin(%rip), %rdx
	leaq	-208(%rbp), %rax
	movl	$1000000, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	leaq	-208(%rbp), %rax
	movl	$199, %edx
	movq	%rax, %rsi
	leaq	global_name(%rip), %rax
	movq	%rax, %rdi
	call	strncpy@PLT
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L4
	call	__stack_chk_fail@PLT
.L4:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	vulnerable, .-vulnerable
	.section	.rodata
.LC2:
	.string	"--print-buffer-address"
	.align 8
.LC3:
	.string	"\n%s, your grade on this assignment is a F\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB7:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movl	%edi, -20(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	cmpl	$2, -20(%rbp)
	jne	.L6
	movq	-32(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L6
	movl	$1, print_buffer_address(%rip)
.L6:
	leaq	-12(%rbp), %rax
	andq	$-4096, %rax
	movl	$7, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	mprotect@PLT
	leaq	main(%rip), %rax
	andq	$-4096, %rax
	movl	$7, %edx
	movl	$1, %esi
	movq	%rax, %rdi
	call	mprotect@PLT
	movl	$0, %eax
	call	vulnerable
	leaq	global_name(%rip), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	leaq	-1(%rax), %rdx
	leaq	global_name(%rip), %rax
	movb	$0, (%rdx,%rax)
	leaq	global_name(%rip), %rax
	movq	%rax, %rsi
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	nop
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L7
	call	__stack_chk_fail@PLT
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
