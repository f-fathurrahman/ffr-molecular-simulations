// Divide to float, converted (implicitly) to int

#include <stdio.h>

int main() {
    int i;
    double a, b, c;

    a = 11.2;
    b = 0.3;
    i = a/b; // c
    c = a/b; // double
    printf("First case:\n");
    printf("double result = %f\n", c);
    printf("int result    = %d\n", i);

    printf("\n");

    a = 12.2;
    b = 0.3;
    i = a/b; // c
    c = a/b; // double
    printf("Second case:\n");
    printf("double result = %f\n", c);
    printf("int result    = %d\n", i);

    return 0;
}

// The result: floor