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
.LFB6:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 64
	mov	DWORD PTR -52[rbp], edi
	mov	QWORD PTR -64[rbp], rsi
	cmp	DWORD PTR -52[rbp], 3		# if (argc != 3). (Начало)
	je	.L2				# if (argc != 3). (Конец)
	lea	rax, .LC0[rip]			# printf("Incorrect data: command line must contains exactly 2 arguments!\n"). (Начало)
	mov	rdi, rax
	call	puts@PLT			# printf("Incorrect data: command line must contains exactly 2 arguments!\n"). (Конец)
	mov	eax, 0				# Код 0 для возврата.
	jmp	.L3				# Переход к метке-выходу с кодом 0.
.L2:
	mov	rax, QWORD PTR -64[rbp]		# double x = atof(argv[1]). (Начало)
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atof@PLT
	movq	rax, xmm0
	mov	QWORD PTR -8[rbp], rax		# double x = atof(argv[1]). (Конец)
	movsd	xmm0, QWORD PTR .LC1[rip]	# Проверка на корректность в диапазоне (-1; 1). (Начало)
	comisd	xmm0, QWORD PTR -8[rbp]
	jnb	.L4
	movsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC2[rip]
	comisd	xmm0, xmm1
	jb	.L11				# Проверка на корректность в диапазоне (-1; 1). (Конец)
.L4:						# Обработка случая, когда введённое значение x вне допустимого диапазона. (x <= -1 || x >= 1)
	lea	rax, .LC3[rip]			# printf("Incorrect data: x must be  in range (-1; 1)!\n"). (Начало)
	mov	rdi, rax
	call	puts@PLT			# printf("Incorrect data: x must be  in range (-1; 1)!\n"). (Конец)
	mov	eax, 0				# Код 0 для возврата.
	jmp	.L3				# Переход к метке-выходу с кодом 0.
.L11:
	mov	rax, QWORD PTR -64[rbp]		# int m = atoi(argv[2]). (Начало)
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	mov	rdi, rax
	call	atoi@PLT
	mov	DWORD PTR -36[rbp], eax		# int m = atoi(argv[2]). (Конец)
	lea	rax, .LC4[rip]			# printf("Input data:\n"). (Начало)
	mov	rdi, rax
	call	puts@PLT			# printf("Input data:\n"). (Конец)
	mov	rax, QWORD PTR -8[rbp]		# printf("x = %f\n", x). (Начало)
	movq	xmm0, rax
	lea	rax, .LC5[rip]
	mov	rdi, rax
	mov	eax, 1
	call	printf@PLT			# printf("x = %f\n", x). (Конец)
	mov	eax, DWORD PTR -36[rbp]		# printf("m = %d\n\n", m). (Начало)
	mov	esi, eax
	lea	rax, .LC6[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT			# printf("m = %d\n\n", m). (Конец)
	movsd	xmm0, QWORD PTR .LC2[rip]	# double previous = 1. (Начало)
	movsd	QWORD PTR -32[rbp], xmm0	# double previous = 1. (Конец)
	pxor	xmm0, xmm0			# double current = 1 + x * m. (Начало)
	cvtsi2sd	xmm0, DWORD PTR -36[rbp]
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC2[rip]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0	# double current = 1 + x * m. (Конец)
	mov	eax, DWORD PTR -36[rbp]		# int m_multiplier = m. (Начало)
	mov	DWORD PTR -48[rbp], eax		# int m_multiplier = m. (Конец)
	movsd	xmm0, QWORD PTR -8[rbp]		# double x_multiplier = x. (Начало)
	movsd	QWORD PTR -16[rbp], xmm0	# double x_multiplier = x. (Конец)
	mov	DWORD PTR -44[rbp], 1		# int factorial = 1.
	mov	DWORD PTR -40[rbp], 2		# i = 2.
.L10:
	movsd	xmm0, QWORD PTR -24[rbp]	# Проверка точности: if (current - previous < 0.001 * previous). (Начало)
	movapd	xmm1, xmm0
	subsd	xmm1, QWORD PTR -32[rbp]
	movsd	xmm2, QWORD PTR -32[rbp]
	movsd	xmm0, QWORD PTR .LC7[rip]
	mulsd	xmm0, xmm2
	comisd	xmm0, xmm1
	ja	.L12				# Проверка точности: if (current - previous < 0.001 * previous). (Конец)
	mov	eax, DWORD PTR -36[rbp]		# m_multiplier *= m - i + 1. (Начало)
	sub	eax, DWORD PTR -40[rbp]
	lea	edx, 1[rax]
	mov	eax, DWORD PTR -48[rbp]
	imul	eax, edx
	mov	DWORD PTR -48[rbp], eax		# m_multiplier *= m - i + 1. (Конец)
	movsd	xmm0, QWORD PTR -16[rbp]	# x_multiplier *= x. (Начало)
	mulsd	xmm0, QWORD PTR -8[rbp]
	movsd	QWORD PTR -16[rbp], xmm0	# x_multiplier *= x. (Конец)
	mov	eax, DWORD PTR -44[rbp]		# factorial *= i. (Начало)
	imul	eax, DWORD PTR -40[rbp]
	mov	DWORD PTR -44[rbp], eax		# factorial *= i. (Конец)
	movsd	xmm0, QWORD PTR -24[rbp]	# previous = current. (Начало)
	movsd	QWORD PTR -32[rbp], xmm0	# previous = current. (Конец)
	pxor	xmm0, xmm0			# current += x_multiplier * m_multiplier / factorial. (Начало)
	cvtsi2sd	xmm0, DWORD PTR -48[rbp]
	mulsd	xmm0, QWORD PTR -16[rbp]
	pxor	xmm1, xmm1
	cvtsi2sd	xmm1, DWORD PTR -44[rbp]
	divsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR -24[rbp]
	addsd	xmm0, xmm1
	movsd	QWORD PTR -24[rbp], xmm0	# current += x_multiplier * m_multiplier / factorial. (Конец)
	add	DWORD PTR -40[rbp], 1		# ++i.
	jmp	.L10				# Возврат к началу в теле цикла for(i = 2;;++i).
.L12:
	nop					# Пустая команда. (побольше бы таких...)
	lea	rax, .LC8[rip]			# printf("Output data:\n"). (Начало)
	mov	rdi, rax
	call	puts@PLT			# printf("Output data:\n"). (Конец)
	movsd	xmm0, QWORD PTR -24[rbp]	# printf("(1 + x) ^ m = (1 + %f) ^ %d = %f\n", x, m, current). (Начало)
	mov	edx, DWORD PTR -36[rbp]
	mov	rax, QWORD PTR -8[rbp]
	movapd	xmm1, xmm0
	mov	esi, edx
	movq	xmm0, rax
	lea	rax, .LC9[rip]
	mov	rdi, rax
	mov	eax, 2
	call	printf@PLT			# printf("(1 + x) ^ m = (1 + %f) ^ %d = %f\n", x, m, current). (Конец)
	mov	eax, 0				# Код 0 для возврата.
.L3:						# Метка-выход.
	leave					# Завершение программы с кодом 0. (Начало)
	.cfi_def_cfa 7, 8
	ret					# Завершение программы с кодом 0. (Конец)
	.cfi_endproc
.LFE6:
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
