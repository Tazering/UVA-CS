// worked with Edward Pasco
// This is assembly is roughly equivalent to the following C code:
// unsigned short sum_C(long size, unsigned short * a) {
//    unsigned short sum = 0;
//    for (int i = 0; i < size; ++i) {
//        sum += a[i];
//    }
//    return sum;
//}

// This implementation follows the Linux x86-64 calling convention:
//    %rdi contains the size
//    %rsi contains the pointer a
// and
//    %ax needs to contain the result when the function returns
// in addition, this code uses
//    %rcx to store i

// the '.global' directive indicates to the assembler to make this symbol 
// available to other files.
.global sum_multiple_accum
sum_multiple_accum:
    // set sum (%ax) to 0
    xor %eax, %eax
    // return immediately; special case if size (%rdi) == 0
    test %rdi, %rdi
    je .L_done
    // store i = 0 in rcx
    movq $0, %rcx
	xor %r8w, %r8w
	xor %r9w, %r9w
	xor %r10w, %r10w
// labels starting with '.L' are local to this file
.L_loop:
    // sum (%ax) += a[i] for four times, i, i + 1, i + 2, i + 3
    addw (%rsi,%rcx,2), %ax
	addw 2(%rsi,%rcx,2), %r8w
	addw 4(%rsi,%rcx,2), %r9w
	addw 6(%rsi,%rcx,2), %r10w

	addq $4, %rcx
	cmpq %rdi, %rcx	
	jl .L_loop

.L_done:
	addw %r8w, %ax
	addw %r9w, %ax
	addw %r10w, %ax
	retq
