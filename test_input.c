/* Sample C program to test the lexical analyzer */
// Demonstrates keywords, identifiers, operators, constants

#include <stdio.h>

int factorial(int n) {
    if (n <= 1)
        return 1;
    return n * factorial(n - 1);
}

int main() {
    int x = 10;
    float pi = 3.14;
    char grade = 'A';
    int result;

    /* Compute factorial using a loop */
    result = 1;
    for (int i = 1; i <= x; i++) {
        result *= i;
    }

    // Conditional check
    if (result > 1000 && x != 0) {
        result += 5;
    } else {
        result--;
    }

    while (x > 0) {
        x -= 2;
    }

    return 0;
}
