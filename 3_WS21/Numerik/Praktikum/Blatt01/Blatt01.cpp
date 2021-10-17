#include <stdio.h>
#include <stdlib.h>
#include <cmath>

void project1() {
    // First, using double data type
    double x = 1.0;
    while (1+x > 1) {
        x = x/2;
    }
    // Now use float data type
    float y = 1.0;
    while (1+y > 1) {
        y = y/2;
    }
    printf("value for 'double' data type: %.25f\n", x);
    printf("value for 'float' data type: %.25f\n", y);
}

double f(double x) {
    return 1/x - 1/(x+1);
}

double g(double x) {
    return 1/(x*(x+1));
}

void project2() {
    for (int k = 1; k <= 15; k++) {
        double x_k = pow(10,k);
        double value = std::abs(f(x_k) - g(x_k)) / std::abs(g(x_k));
        printf("d_%.2i: %.25f\n", k, value);
    }
}

int main() {
    project1();
    project2();
}
