	.file	"4variant_func.c"
	.intel_syntax noprefix
	.text
	.globl	powerTaylorSeries
	.type	powerTaylorSeries, @function
powerTaylorSeries:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -56[rbp], xmm0	# double x = xmm0. (Приём входных данных)
	mov	DWORD PTR -60[rbp], edi		# int m = edi. (Приём входных данны)
	movsd	xmm0, QWORD PTR .LC0[rip]
	movsd	QWORD PTR -24[rbp], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -60[rbp]
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -56[rbp]
	movsd	xmm0, QWORD PTR .LC0[rip]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	mov	eax, DWORD PTR -60[rbp]
	mov	DWORD PTR -36[rbp], eax
	movsd	xmm0, QWORD PTR -56[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	mov	DWORD PTR -32[rbp], 1
	mov	DWORD PTR -28[rbp], 2
.L5:
	movsd	xmm0, QWORD PTR -16[rbp]
	movapd	xmm1, xmm0
	subsd	xmm1, QWORD PTR -24[rbp]
	movsd	xmm2, QWORD PTR -24[rbp]
	movsd	xmm0, QWORD PTR .LC1[rip]
	mulsd	xmm0, xmm2
	comisd	xmm0, xmm1
	jbe	.L7
	movsd	xmm0, QWORD PTR -16[rbp]	# xmm0 = double current. (Возврат выходных данных)
	jmp	.L8
.L7:
	mov	eax, DWORD PTR -60[rbp]
	sub	eax, DWORD PTR -28[rbp]
	lea	edx, 1[rax]
	mov	eax, DWORD PTR -36[rbp]
	imul	eax, edx
	mov	DWORD PTR -36[rbp], eax
	movsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, QWORD PTR -56[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	mov	eax, DWORD PTR -32[rbp]
	imul	eax, DWORD PTR -28[rbp]
	mov	DWORD PTR -32[rbp], eax
	movsd	xmm0, QWORD PTR -16[rbp]
	movsd	QWORD PTR -24[rbp], xmm0
	pxor	xmm0, xmm0
	cvtsi2sd	xmm0, DWORD PTR -36[rbp]
	mulsd	xmm0, QWORD PTR -8[rbp]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, DWORD PTR -32[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -16[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -16[rbp], xmm0
	add	DWORD PTR -28[rbp], 1
	jmp	.L5
.L8:
	movq	rax, xmm0
	movq	xmm0, rax
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
	sub	rsp, 48
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
	mov	QWORD PTR -16[rbp], rax
	movsd	xmm0, QWORD PTR .LC3[rip]
	comisd	xmm0, QWORD PTR -16[rbp]
	jnb	.L12
	movsd	xmm0, QWORD PTR -16[rbp]
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
	mov	DWORD PTR -20[rbp], eax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	call	puts@PLT
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT
	mov	eax, DWORD PTR -20[rbp]
	mov	esi, eax
	lea	rax, .LC7[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	mov	edx, DWORD PTR -20[rbp]		# edx = int m. (m - main'овая)
	mov	rax, QWORD PTR -16[rbp]		# rax = double x. (x - main'овая) 
	mov	edi, edx			# int m. (m - powerTaylorSeries'овая)
	movq	xmm0, rax			# double x. (x - powerTaylorSeries'овая)
	call	powerTaylorSeries		# Вызов функции.
	movq	rax, xmm0			# rax = xmm0.
	mov	QWORD PTR -8[rbp], rax		# double result = rax. (Приём выходных данных)
	lea	rax, .LC8[rip]
	mov	rdi, rax
	call	puts@PLT
	movsd	xmm0, QWORD PTR -8[rbp]
	mov	edx, DWORD PTR -20[rbp]
	mov	rax, QWORD PTR -16[rbp]
	movapd	xmm1, xmm0
	mov	esi, edx
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT
	mov	eax, 0
.L11:
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
