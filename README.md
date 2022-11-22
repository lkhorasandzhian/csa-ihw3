# Отчёт по ИДЗ №3 АВС, вариант 4 - Хорасанджян Л. А., БПИ218

## Выполненные критерии на 4 балла

### Код на C (файл 4variant.c):

```c
#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]) {
    double x = atof(argv[1]);
    if (x <= -1 || x >= 1) {
        printf("Incorrect data: x must be  in range (-1; 1)!\n");
        return 0;
    }
    int m = atoi(argv[2]);

    printf("Input data:\n");
    printf("x = %f\n", x);
    printf("m = %d\n\n", m);

    double previous = 1;
    double current = 1 + x * m;

    int m_multiplier = m;  // accumulator type: m * (m - 1) * (m - 2) * ... * (m - i + 1) * ...
    double x_multiplier = x;  // accumulator type: x * x * ... * x ...
    int factorial = 1;  // accumulator type: 1 * 2 * ... * i * ...

    int i;
    for (i = 2;; ++i) {
        if (current - previous < 0.001 * previous) {
            break;
        }

        m_multiplier *= m - i + 1;
        x_multiplier *= x;
        factorial *= i;

        previous = current;
        current += x_multiplier * m_multiplier / factorial;
    }

    printf("Output data:\n");
    printf("(1 + x) ^ m = (1 + %f) ^ %d = %f\n", x, m, current);

    return 0;
}
```
Пояснения к программе:
В начале программы производится проверка на кол-во аргументов, введённых в консоль. Если передано НЕ 2 аргумента (в коде написано != 3, потому что при запуске с пустой командной линией argc = 1), программа досрочно завершается с сообщением об ошибке. От пользователя требуется вводить сначала вещественное число x, а потом через пробел целое число m. Например, '0.123 12' (без кавычек). В самой программе выполняется проверка на корректность ввода вещественного числа: оно должно быть в диапазоне (-1; 1), иначе - преждевременный выход. Дабы избежать излишних нагромождений в виде функция по типу factorial и пр., я ввёл "накопительные" переменные (такого термина нет, но назвал их так, потому что с каждым шагом в цикле они возрастают и приобретают необходимое значение с учётом предыдущих умножений). Такими являются m_multiplier, x_multiplier и factorial. Более того, в этом случае на каждом шаге не придётся произоводить n операций умножения, а сразу за одну операцию умножения получать необходимый на i-ом шаге результат. Далее немного о цикле: в начале стоит условие выхода (когда мы добъёмся необходимой нам точности), далее, если точность нам не подошла, то мы считаем значения для "накопительных" переменных, перекидываем текущее значение в предыдущее, а к самому текущему значению прибавляем произведение накопительных переменных xMultiplier и mMultiplier, делённое на factorial. После получения необходимой нам точности мы выйдем из цикла и выведем текущий элемент на экран.

### Стандартная компиляция программы (получим файл 4variant.s):

```sh
gcc -O0 -Wall -masm=intel -S 4variant.c -o 4variant.s
```

### Компиляция программы с оптимизацией (получим файл 4variant_optimized.s):

```sh
gcc -O0 -Wall -masm=intel -S -fno-asynchronous-unwind-tables -fcf-protection=none 4variant.c -o 4variant_optimized.s
```

### Тестовое покрытие (демонстрация эквивалентности функционирования программ 4variant.s и 4variant_optimized.s):
| Input data                 | usual                      | optimized                  |
|----------------------------|----------------------------|----------------------------|
| *empty*                    | *exception message 1*      | *exception message 1*      |
| 1.123 12                   | *exception message 2*      | *exception message 2*      |
| 0.123 12                   | 4.022700                   | 4.022700                   |
| 0.136 17                   | 8.737961                   | 8.737961                   |

## Выполненные критерии на 5 баллов

### Комментарии к 4variant_func_optimized.s - фрагмент 1:

```assembly
powerTaylorSeries:
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -56[rbp], xmm0	# double x = xmm0. (Приём входных данных)
	mov	DWORD PTR -60[rbp], edi		# int m = edi. (Приём входных данны)
```

### Комментарии к 4variant_func_optimized.s - фрагмент 2:

```assembly
	movsd	xmm0, QWORD PTR -16[rbp]	# xmm0 = double current. (Возврат выходных данных)
	jmp	.L8
.L7:
```
```assembly
.L8:
	movq	rax, xmm0
	movq	xmm0, rax
	pop	rbp
	ret
```

### Комментарии к 4variant_func_optimized.s - фрагмент 3:

```assembly
	mov	edx, DWORD PTR -20[rbp]		# edx = int m. (m - main'овая)
	mov	rax, QWORD PTR -16[rbp]		# rax = double x. (x - main'овая) 
	mov	edi, edx			# int m. (m - powerTaylorSeries'овая)
	movq	xmm0, rax			# double x. (x - powerTaylorSeries'овая)
	call	powerTaylorSeries		# Вызов функции.
	movq	rax, xmm0			# rax = xmm0.
	mov	QWORD PTR -8[rbp], rax		# double result = rax. (Приём выходных данных)
```

## Выполненные критерии на 6 баллов

### Код на C с регистрами (файл 4variant_reg.c):

```c
#include <stdio.h>
#include <stdlib.h>

double powerTaylorSeries(double x, int m) {
    double previous = 1;
    double current = 1 + x * m;

    register int m_multiplier asm("r13") = m;  // accumulator type: m * (m - 1) * (m - 2) * ... * (m - i + 1) * ...
    double x_multiplier = x;  // accumulator type: x * x * ... * x ...
    register int factorial asm("r14") = 1;  // accumulator type: 1 * 2 * ... * i * ...

    register int i asm("r15");
    for (i = 2;; ++i) {
        if (current - previous < 0.001 * previous) {
            return current;
        }

        m_multiplier *= m - i + 1;
        x_multiplier *= x;
        factorial *= i;

        previous = current;
        current += x_multiplier * m_multiplier / factorial;
    }
}

int main(int argc, char *argv[]) {
    if (argc != 3) {
        printf("Incorrect data: command line must contains exactly 2 arguments!\n");
        return 0;
    }

    double x = atof(argv[1]);
    if (x <= -1 || x >= 1) {
        printf("Incorrect data: x must be  in range (-1; 1)!\n");
        return 0;
    }
    register int m asm("r12") = atoi(argv[2]);

    printf("Input data:\n");
    printf("x = %f\n", x);
    printf("m = %d\n\n", m);

    double result = powerTaylorSeries(x, m);

    printf("Output data:\n");
    printf("(1 + x) ^ m = (1 + %f) ^ %d = %f\n", x, m, result);

    return 0;
}
```

Примечание:
Каждая локальная переменная была переписана в формате: register 'TYPE' 'NAME' asm("'REGISTER_NAME'").
Решил не приписывать комментарии в очевидных местах, как я написал выше.

### Сопоставление размеров объектных файлов 4variant.o и 4variant_reg_optimized.o
| 4variant.o          | 4variant\_reg\_optimized |
|---------------------|--------------------------|
| 2,7 кБ (2 728 байт) | 2,5 кБ (2 528 байт)      |

### Тестовое покрытие (демонстрация эквивалентности функционирования программ 4variant.s и 4variant_reg_optimized.s):
| Input data                 | usual                      | with registers                  |
|----------------------------|----------------------------|---------------------------------|
| *empty*                    | *exception message 1*      | *exception message 1*           |
| 1.123 12                   | *exception message 2*      | *exception message 2*           |
| 0.123 12                   | 4.022700                   | 4.022700                        |
| 0.136 17                   | 8.737961                   | 8.737961                        |
