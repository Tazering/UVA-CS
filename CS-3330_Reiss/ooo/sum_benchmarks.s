	.file	"sum_benchmarks.c"
	.text
	.p2align 4
	.globl	sum_C
	.type	sum_C, @function
sum_C:
.LFB5483:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	jle	.L4
	leaq	(%rsi,%rdi,2), %rdx
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L3:
	addw	(%rsi), %ax
	addq	$2, %rsi
	cmpq	%rdx, %rsi
	jne	.L3
	ret
	.p2align 4,,10
	.p2align 3
.L4:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE5483:
	.size	sum_C, .-sum_C
	.p2align 4
	.globl	sum_multiple_accum_C
	.type	sum_multiple_accum_C, @function
sum_multiple_accum_C:
.LFB5484:
	.cfi_startproc
	endbr64
	cmpq	$3, %rdi
	jle	.L10
	leaq	-8(%rdi,%rdi), %rax
	xorl	%edx, %edx
	xorl	%ecx, %ecx
	xorl	%edi, %edi
	andq	$-8, %rax
	leaq	8(%rsi,%rax), %r8
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L9:
	addw	(%rsi), %ax
	addw	2(%rsi), %di
	addq	$8, %rsi
	addw	-4(%rsi), %cx
	addw	-2(%rsi), %dx
	cmpq	%rsi, %r8
	jne	.L9
	addl	%edi, %eax
	addl	%ecx, %eax
	addl	%edx, %eax
	ret
	.p2align 4,,10
	.p2align 3
.L10:
	xorl	%eax, %eax
	ret
	.cfi_endproc
.LFE5484:
	.size	sum_multiple_accum_C, .-sum_multiple_accum_C
	.globl	functions
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC0:
	.string	"sum_clang6_O: simple C compiled with clang 6 -O -mavx2"
	.align 8
.LC1:
	.string	"sum_gcc7_O3: simple C compiled with GCC7 -O3 -mavx2"
	.align 8
.LC2:
	.string	"sum_C: simple C compiled on this machine with settings in Makefile"
	.align 8
.LC3:
	.string	"sum_simple: simple ASM implementation"
	.align 8
.LC4:
	.string	"sum_unrolled2: sum_simple but with 2 iterations"
	.align 8
.LC5:
	.string	"sum_unrolled4: sum_unrolled4 but with 4 iterations"
	.align 8
.LC6:
	.string	"sum_multiple_accum: uses four accumulators"
	.align 8
.LC7:
	.string	"sum_multipple_accum_C: four accumulators with c"
	.section	.data.rel,"aw"
	.align 32
	.type	functions, @object
	.size	functions, 144
functions:
	.quad	sum_clang6_O
	.quad	.LC0
	.quad	sum_gcc7_O3
	.quad	.LC1
	.quad	sum_C
	.quad	.LC2
	.quad	sum_simple
	.quad	.LC3
	.quad	sum_unrolled2
	.quad	.LC4
	.quad	sum_unrolled4
	.quad	.LC5
	.quad	sum_multiple_accum
	.quad	.LC6
	.quad	sum_multiple_accum_C
	.quad	.LC7
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
