#include <stdio.h>

unsigned long long fibonacci(unsigned int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
}

int main() {
    int n;
    printf("Enter the Fibonacci number you want to calculate (0-93): ");
    scanf("%d", &n);

    if (n < 0 || n > 93) {
        printf("Please enter a number between 0 and 93.\n");
        return 1;
    }

    printf("The %dth Fibonacci number is %llu\n", n, fibonacci(n));
    return 0;
}
