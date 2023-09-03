	.file	"sum_benchmarks.c"
	.text
	.globl	sum_C
	.type	sum_C, @function
sum_C:
.LFB5483:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	jle	.L4
	movl	$0, %eax
	movl	$0, %edx
.L3:
	movslq	%eax, %rcx
	addw	(%rsi,%rcx,2), %dx
	incl	%eax
	movslq	%eax, %rcx
	cmpq	%rdi, %rcx
	jl	.L3
.L1:
	movl	%edx, %eax
	ret
.L4:
	movl	$0, %edx
	jmp	.L1
	.cfi_endproc
.LFE5483:
	.size	sum_C, .-sum_C
	.globl	sum_with_sixteen_accumulators
	.type	sum_with_sixteen_accumulators, @function
sum_with_sixteen_accumulators:
.LFB5484:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, -8(%rsp)
	testq	%rdi, %rdi
	jle	.L9
	movq	%rsi, %rdx
	movl	$0, %eax
	movl	$0, %esi
	movl	$0, %edi
	movl	$0, %r8d
	movl	$0, %r9d
	movl	$0, %r10d
	movl	$0, %r11d
	movl	$0, %ebx
	movl	$0, %ebp
	movl	$0, %r12d
	movl	$0, %r13d
	movl	$0, %r14d
	movl	$0, %r15d
	movw	$0, -10(%rsp)
	movw	$0, -12(%rsp)
	movw	$0, -14(%rsp)
	movw	$0, -16(%rsp)
.L8:
	movslq	%eax, %rcx
	movzwl	(%rdx,%rcx,2), %ecx
	addw	%cx, -16(%rsp)
	leal	1(%rax), %ecx
	movslq	%ecx, %rcx
	movzwl	(%rdx,%rcx,2), %ecx
	addw	%cx, -14(%rsp)
	leal	2(%rax), %ecx
	movslq	%ecx, %rcx
	movzwl	(%rdx,%rcx,2), %ecx
	addw	%cx, -12(%rsp)
	leal	3(%rax), %ecx
	movslq	%ecx, %rcx
	movzwl	(%rdx,%rcx,2), %ecx
	addw	%cx, -10(%rsp)
	leal	4(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r15w
	leal	5(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r14w
	leal	6(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r13w
	leal	7(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r12w
	leal	8(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %bp
	leal	9(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %bx
	leal	10(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r11w
	leal	11(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r10w
	leal	12(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r9w
	leal	13(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r8w
	leal	14(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %di
	leal	15(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %si
	addl	$16, %eax
	movslq	%eax, %rcx
	cmpq	-8(%rsp), %rcx
	jl	.L8
.L7:
	movzwl	-12(%rsp), %eax
	addw	-10(%rsp), %ax
	addl	%r15d, %eax
	addl	%r14d, %eax
	addl	%r13d, %eax
	addl	%r12d, %eax
	addl	%ebp, %eax
	addl	%ebx, %eax
	addl	%r11d, %eax
	addl	%r10d, %eax
	addl	%r9d, %eax
	addl	%r8d, %eax
	addl	%edi, %eax
	addl	%esi, %eax
	movzwl	-16(%rsp), %edx
	addw	-14(%rsp), %dx
	addl	%edx, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L9:
	.cfi_restore_state
	movl	$0, %esi
	movl	$0, %edi
	movl	$0, %r8d
	movl	$0, %r9d
	movl	$0, %r10d
	movl	$0, %r11d
	movl	$0, %ebx
	movl	$0, %ebp
	movl	$0, %r12d
	movl	$0, %r13d
	movl	$0, %r14d
	movl	$0, %r15d
	movw	$0, -10(%rsp)
	movw	$0, -12(%rsp)
	movw	$0, -14(%rsp)
	movw	$0, -16(%rsp)
	jmp	.L7
	.cfi_endproc
.LFE5484:
	.size	sum_with_sixteen_accumulators, .-sum_with_sixteen_accumulators
	.globl	sum_AVX
	.type	sum_AVX, @function
sum_AVX:
.LFB5485:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	jle	.L15
	movl	$0, %eax
	vpxor	%xmm0, %xmm0, %xmm0
.L14:
	movslq	%eax, %rdx
	vpaddw	(%rsi,%rdx,2), %ymm0, %ymm0
	addl	$16, %eax
	movslq	%eax, %rdx
	cmpq	%rdi, %rdx
	jl	.L14
.L13:
	vmovdqa	%xmm0, %xmm1
	vpextrw	$2, %xmm0, %eax
	vpextrw	$3, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$4, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$5, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$6, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$7, %xmm0, %edx
	addl	%edx, %eax
	vextracti128	$0x1, %ymm0, %xmm0
	vpextrw	$0, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$1, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$2, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$3, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$4, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$5, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$6, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$7, %xmm0, %edx
	addl	%edx, %eax
	vpextrw	$1, %xmm1, %edx
	vpextrw	$0, %xmm1, %ecx
	addl	%ecx, %edx
	addl	%edx, %eax
	ret
.L15:
	vpxor	%xmm0, %xmm0, %xmm0
	jmp	.L13
	.cfi_endproc
.LFE5485:
	.size	sum_AVX, .-sum_AVX
	.globl	sum_with_eight_accumulators
	.type	sum_with_eight_accumulators, @function
sum_with_eight_accumulators:
.LFB5486:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	testq	%rdi, %rdi
	jle	.L20
	movq	%rdi, %rbp
	movq	%rsi, %rdx
	movl	$0, %eax
	movl	$0, %r9d
	movl	$0, %r10d
	movl	$0, %r11d
	movl	$0, %ebx
	movl	$0, %r12d
	movl	$0, %esi
	movl	$0, %r8d
	movl	$0, %edi
.L19:
	movslq	%eax, %rcx
	addw	(%rdx,%rcx,2), %di
	leal	1(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r8w
	leal	2(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %si
	leal	3(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r12w
	leal	4(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %bx
	leal	5(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r11w
	leal	6(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r10w
	leal	7(%rax), %ecx
	movslq	%ecx, %rcx
	addw	(%rdx,%rcx,2), %r9w
	addl	$8, %eax
	movslq	%eax, %rcx
	cmpq	%rbp, %rcx
	jl	.L19
.L18:
	leal	(%rsi,%r12), %eax
	addl	%ebx, %eax
	addl	%r11d, %eax
	addl	%r10d, %eax
	addl	%r9d, %eax
	addl	%r8d, %edi
	addl	%edi, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L20:
	.cfi_restore_state
	movl	$0, %r9d
	movl	$0, %r10d
	movl	$0, %r11d
	movl	$0, %ebx
	movl	$0, %r12d
	movl	$0, %esi
	movl	$0, %r8d
	movl	$0, %edi
	jmp	.L18
	.cfi_endproc
.LFE5486:
	.size	sum_with_eight_accumulators, .-sum_with_eight_accumulators
	.globl	functions
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"C (local)"
.LC1:
	.string	"C (clang6 -O)"
.LC2:
	.string	"sixteen accumulators (C)"
.LC3:
	.string	"eight accumulators (C)"
.LC4:
	.string	"sum AVX"
	.section	.data.rel,"aw"
	.align 32
	.type	functions, @object
	.size	functions, 96
functions:
	.quad	sum_C
	.quad	.LC0
	.quad	sum_clang6_O
	.quad	.LC1
	.quad	sum_with_sixteen_accumulators
	.quad	.LC2
	.quad	sum_with_eight_accumulators
	.quad	.LC3
	.quad	sum_AVX
	.quad	.LC4
	.quad	0
	.quad	0
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
