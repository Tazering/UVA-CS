	.file	"min_benchmarks.c"
	.text
	.globl	min_C
	.type	min_C, @function
min_C:
.LFB5483:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	jle	.L4
	movl	$0, %eax
	movl	$32767, %edx
.L3:
	movslq	%eax, %rcx
	movzwl	(%rsi,%rcx,2), %ecx
	cmpw	%cx, %dx
	cmovg	%ecx, %edx
	incl	%eax
	movslq	%eax, %rcx
	cmpq	%rdi, %rcx
	jl	.L3
.L1:
	movl	%edx, %eax
	ret
.L4:
	movl	$32767, %edx
	jmp	.L1
	.cfi_endproc
.LFE5483:
	.size	min_C, .-min_C
	.globl	vectorized_min_C
	.type	vectorized_min_C, @function
vectorized_min_C:
.LFB5484:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	subq	$64, %rsp
	movq	%fs:40, %rax
	movq	%rax, 56(%rsp)
	xorl	%eax, %eax
	testq	%rdi, %rdi
	jle	.L11
	vmovdqa	.LC0(%rip), %ymm0
.L8:
	movslq	%eax, %rdx
	vpminsw	(%rsi,%rdx,2), %ymm0, %ymm0
	addl	$16, %eax
	movslq	%eax, %rdx
	cmpq	%rdi, %rdx
	jl	.L8
.L7:
	vmovdqu	%ymm0, 16(%rsp)
	vpextrw	$0, %xmm0, %edx
	leaq	18(%rsp), %rax
	leaq	48(%rsp), %rsi
.L9:
	movzwl	(%rax), %ecx
	cmpw	%cx, %dx
	cmovg	%ecx, %edx
	addq	$2, %rax
	cmpq	%rsi, %rax
	jne	.L9
	movq	56(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L15
	movl	%edx, %eax
	leave
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
.L11:
	.cfi_restore_state
	vmovdqa	.LC0(%rip), %ymm0
	jmp	.L7
.L15:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5484:
	.size	vectorized_min_C, .-vectorized_min_C
	.globl	functions
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC1:
	.string	"C (local)"
.LC2:
	.string	"C (vectorized)"
	.section	.data.rel.local,"aw"
	.align 32
	.type	functions, @object
	.size	functions, 48
functions:
	.quad	min_C
	.quad	.LC1
	.quad	vectorized_min_C
	.quad	.LC2
	.quad	0
	.quad	0
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC0:
	.quad	9223231297218904063
	.quad	9223231297218904063
	.quad	9223231297218904063
	.quad	9223231297218904063
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
