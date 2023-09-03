	.file	"dot_product_benchmarks.c"
	.text
	.globl	dot_product_C
	.type	dot_product_C, @function
dot_product_C:
.LFB5483:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	jle	.L4
	movl	$0, %eax
	movl	$0, %r9d
.L3:
	movslq	%eax, %r8
	movzwl	(%rsi,%r8,2), %ecx
	movzwl	(%rdx,%r8,2), %r8d
	imull	%r8d, %ecx
	addl	%ecx, %r9d
	incl	%eax
	movslq	%eax, %rcx
	cmpq	%rdi, %rcx
	jl	.L3
.L1:
	movl	%r9d, %eax
	ret
.L4:
	movl	$0, %r9d
	jmp	.L1
	.cfi_endproc
.LFE5483:
	.size	dot_product_C, .-dot_product_C
	.globl	vectorized_dot_product_C
	.type	vectorized_dot_product_C, @function
vectorized_dot_product_C:
.LFB5484:
	.cfi_startproc
	endbr64
	testq	%rdi, %rdi
	jle	.L9
	movl	$0, %eax
	vpxor	%xmm2, %xmm2, %xmm2
	vmovdqa	%ymm2, %ymm1
.L8:
	movslq	%eax, %rcx
	vpmovzxwd	(%rsi,%rcx,2), %ymm0
	vpmovzxwd	(%rdx,%rcx,2), %ymm3
	vpmulld	%ymm3, %ymm0, %ymm0
	vpaddd	%ymm1, %ymm0, %ymm1
	leal	8(%rax), %ecx
	movslq	%ecx, %rcx
	vpmovzxwd	(%rsi,%rcx,2), %ymm3
	vpmovzxwd	(%rdx,%rcx,2), %ymm0
	vpmulld	%ymm3, %ymm0, %ymm0
	vpaddd	%ymm2, %ymm0, %ymm2
	addl	$16, %eax
	movslq	%eax, %rcx
	cmpq	%rdi, %rcx
	jl	.L8
.L7:
	vpaddd	%ymm2, %ymm1, %ymm1
	vpextrd	$1, %xmm1, %eax
	vmovd	%xmm1, %edx
	addl	%edx, %eax
	vpextrd	$2, %xmm1, %edx
	addl	%edx, %eax
	vpextrd	$3, %xmm1, %edx
	addl	%edx, %eax
	vextracti128	$0x1, %ymm1, %xmm1
	vmovd	%xmm1, %edx
	addl	%edx, %eax
	vpextrd	$1, %xmm1, %edx
	addl	%edx, %eax
	vpextrd	$2, %xmm1, %edx
	addl	%edx, %eax
	vpextrd	$3, %xmm1, %edx
	addl	%edx, %eax
	ret
.L9:
	vpxor	%xmm2, %xmm2, %xmm2
	vmovdqa	%ymm2, %ymm1
	jmp	.L7
	.cfi_endproc
.LFE5484:
	.size	vectorized_dot_product_C, .-vectorized_dot_product_C
	.globl	functions
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"C (local)"
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC1:
	.string	"C (compiled with GCC7.2 -O3 -mavx2)"
	.section	.rodata.str1.1
.LC2:
	.string	"vectorized dot product"
	.section	.data.rel,"aw"
	.align 32
	.type	functions, @object
	.size	functions, 64
functions:
	.quad	dot_product_C
	.quad	.LC0
	.quad	dot_product_gcc7_O3
	.quad	.LC1
	.quad	vectorized_dot_product_C
	.quad	.LC2
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
