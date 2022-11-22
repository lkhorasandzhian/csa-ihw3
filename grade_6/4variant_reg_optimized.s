	.file	"4variant_reg.c"
	.intel_syntax noprefix
	.text
	.globl	powerTaylorSeries
	.type	powerTaylorSeries, @function
powerTaylorSeries:
	push	rbp
	mov	rbp, rsp
	push	r15
	push	r14
	push	r13
	movsd	QWORD PTR -64[rbp], xmm0
	mov	DWORD PTR -68[rbp], edi
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -48[rbp], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -68[rbp]
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -64[rbp]
	movsd	xmm0, QWORD PTR .LC0[rip]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -40[rbp], xmm0
	mov	r13d, DWORD PTR -68[rbp]
	movsd	xmm0, QWORD PTR -64[rbp]
	movsd	QWORD PTR -32[rbp], xmm0
	mov	r14d, 1
	mov	r15d, 2
.L5:
	movsd	xmm0, QWORD PTR -40[rbp]
	movapd	xmm1, xmm0
	subsd	xmm1, QWORD PTR -48[rbp]
	movsd	xmm2, QWORD PTR -48[rbp]
	movsd	xmm0, QWORD PTR .LC1[rip]
	mulsd	xmm0, xmm2
	comisd	xmm0, xmm1
	jbe	.L7
	movsd	xmm0, QWORD PTR -40[rbp]
	jmp	.L8
.L7:
	mov	edx, r15d
	mov	eax, DWORD PTR -68[rbp]
	sub	eax, edx
	add	eax, 1
	mov	edx, r13d
	imul	eax, edx
	mov	r13d, eax
	movsd	xmm0, QWORD PTR -32[rbp]
	mulsd	xmm0, QWORD PTR -64[rbp]
	movsd	QWORD PTR -32[rbp], xmm0
	mov	edx, r14d
	mov	eax, r15d
	imul	eax, edx
	mov	r14d, eax
	movsd	xmm0, QWORD PTR -40[rbp]
	movsd	QWORD PTR -48[rbp], xmm0
	mov	eax, r13d
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, eax
	mulsd	xmm0, QWORD PTR -32[rbp]
	mov	eax, r14d
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, eax
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -40[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -40[rbp], xmm0
	mov	eax, r15d
	add	eax, 1
	mov	r15d, eax
	jmp	.L5
.L8:
	movq	rax, xmm0
	movq	xmm0, rax
	pop	r13
	pop	r14
	pop	r15
	pop	rbp
	ret
	.size	powerTaylorSeries, .-powerTaylorSeries
	.section	.rodata
	.align 8
.LC2:
	.string	"Incorrect data: command line must contains exactly 2 arguments!"
	.align 8
.LC4:
	.string	"Incorrect data: x must be  in range (-1; 1)!"
.LC5:
	.string	"Input data:"
.LC6:
	.string	"x = %f\n"
.LC7:
	.string	"m = %d\n\n"
.LC8:
	.string	"Output data:"
	.align 8
.LC9:
	.string	"(1 + x) ^ m = (1 + %f) ^ %d = %f\n"
	.text
	.globl	main
	.type	main, @function
main:
	push	rbp
	mov	rbp, rsp
	push	r12
	sub	rsp, 40
	mov	DWORD PTR -36[rbp], edi
	mov	QWORD PTR -48[rbp], rsi
	cmp	DWORD PTR -36[rbp], 3
	je	.L10
	lea	rax, .LC2[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L11
.L10:
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atof@PLT
	movq	rax, xmm0
	mov	QWORD PTR -32[rbp], rax
	movsd	xmm0, QWORD PTR .LC3[rip]
	comisd	xmm0, QWORD PTR -32[rbp]
	jnb	.L12
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	xmm1, QWORD PTR .LC0[rip]
	comisd	xmm0, xmm1
	jb	.L15
.L12:
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L11
.L15:
	mov	rax, QWORD PTR -48[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	r12d, eax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, r12d
	mov	esi, eax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	edx, r12d
	mov	rax, QWORD PTR -32[rbp]
	mov	edi, edx
	movq	xmm0, rax
	call	powerTaylorSeries
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	edx, r12d
	movsd	xmm0, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -32[rbp]
	movapd	xmm1, xmm0
	mov	esi, edx
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	mov	eax, 0
.L11:
	mov	r12, QWORD PTR -8[rbp]
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1072693248
	.align 8
.LC1:
	.long	-755914244
	.long	1062232653
	.align 8
.LC3:
	.long	0
	.long	-1074790400
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
