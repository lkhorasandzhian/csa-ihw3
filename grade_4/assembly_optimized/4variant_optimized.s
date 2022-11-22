	.file	"4variant.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Incorrect data: command line must contains exactly 2 arguments!"
	.align 8
.LC3:
	.string	"Incorrect data: x must be  in range (-1; 1)!"
.LC4:
	.string	"Input data:"
.LC5:
	.string	"x = %f\n"
.LC6:
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
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 3
	je	.L2
	lea	rax, .LC0[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L3
.L2:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atof@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax
	movsd	xmm0, QWORD PTR .LC1[rip]
	comisd	xmm0, QWORD PTR -8[rbp]
	jnb	.L4
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]
	comisd	xmm0, xmm1
	jb	.L11
.L4:
	lea	rax, .LC3[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	eax, 0
	jmp	.L3
.L11:
	mov	rax, QWORD PTR -64[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -36[rbp], eax
	lea	rax, .LC4[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -8[rbp]
	movq	xmm0, rax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, DWORD PTR -36[rbp]
	mov	esi, eax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	movsd	xmm0, QWORD PTR .LC2[rip]
	movsd	QWORD PTR -32[rbp], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -36[rbp]
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	mov	eax, DWORD PTR -36[rbp]
	mov	DWORD PTR -48[rbp], eax
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	DWORD PTR -44[rbp], 1
	mov	DWORD PTR -40[rbp], 2
.L10:
	movsd	xmm0, QWORD PTR -24[rbp]
	movapd	xmm1, xmm0
	subsd	xmm1, QWORD PTR -32[rbp]
	movsd	xmm2, QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm2
	comisd	xmm0, xmm1
	ja	.L12
	mov	eax, DWORD PTR -36[rbp]
	sub	eax, DWORD PTR -40[rbp]
	lea	edx, 1[rax]
	mov	eax, DWORD PTR -48[rbp]
	imul	eax, edx
	mov	DWORD PTR -48[rbp], eax
	movsd	xmm0, QWORD PTR -16[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	eax, DWORD PTR -44[rbp]
	imul	eax, DWORD PTR -40[rbp]
	mov	DWORD PTR -44[rbp], eax
	movsd	xmm0, QWORD PTR -24[rbp]
	movsd	QWORD PTR -32[rbp], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -48[rbp]
	mulsd	xmm0, QWORD PTR -16[rbp]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, DWORD PTR -44[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -24[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0
	add	DWORD PTR -40[rbp], 1
	jmp	.L10
.L12:
	nop
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	puts@PLT
	movsd	xmm0, QWORD PTR -24[rbp]
	mov	edx, DWORD PTR -36[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movapd	xmm1, xmm0
	mov	esi, edx
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	mov	eax, 0
.L3:
	leave
	ret
	.size	main, .-main
	.section	.rodata
	.align 8
.LC1:
	.long	0
	.long	-1074790400
	.align 8
.LC2:
	.long	0
	.long	1072693248
	.align 8
.LC7:
	.long	-755914244
	.long	1062232653
	.ident	"GCC: (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0"
	.section	.note.GNU-stack,"",@progbits
