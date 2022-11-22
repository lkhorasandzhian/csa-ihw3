#include <stdio.h>
#include <stdlib.h>

double powerTaylorSeries(double x, int m) {
    double previous = 1;
    double current = 1 + x * m;

    int m_multiplier = m;  // accumulator type: m * (m - 1) * (m - 2) * ... * (m - i + 1) * ...
    double x_multiplier = x;  // accumulator type: x * x * ... * x ...
    int factorial = 1;  // accumulator type: 1 * 2 * ... * i * ...

    int i;
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
    int m = atoi(argv[2]);

    printf("Input data:\n");
    printf("x = %f\n", x);
    printf("m = %d\n\n", m);

    double result = powerTaylorSeries(x, m);

    printf("Output data:\n");
    printf("(1 + x) ^ m = (1 + %f) ^ %d = %f\n", x, m, result);

    return 0;
}
