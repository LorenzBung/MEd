#include <cmath>
#include <ostream>
#include <iostream>
#include <iomanip>

void project1() {
    // First, using double data type
    double x = 1.0;
    while (1 + x > 1) {
        x = x / 2;
    }
    // Now use float data type
    float y = 1.0;
    while (1 + y > 1) {
        y = y / 2;
    }
    std::cout << "+--------+------------+" << std::endl;
    std::cout << "|  type  | value of x |" << std::endl;
    std::cout << "+========+============+" << std::endl;
    std::cout << "| double | " << std::setprecision(4) << std::scientific
              << x  << " |" << std::endl;
    std::cout << "+--------+------------+" << std::endl;
    std::cout << "| float  | " << std::setprecision(4) << std::scientific
              << y  << " |" << std::endl;
    std::cout << "+--------+------------+" << std::endl;
}

double f(double x) {
    return (1 / x) - (1 / (x + 1));
}

double g(double x) {
    return 1 / (x * (x + 1));
}

void project2() {
    std::cout << "+----+------------+" << std::endl
              << "|  k |     d_k    |" << std::endl
              << "+====+============+" << std::endl;
    for (int k = 1; k <= 15; k++) {
        double x_k = std::pow(10, k);
        double value = std::abs(f(x_k) - g(x_k)) / std::abs(g(x_k));
        std::cout << "| " << std::setw(2) << k << " | "
                  << std::setprecision(4) << std::scientific << value
                  << " |" << std::endl;
    }
    std::cout << "+----+------------+" << std::endl;
}

int main() {
    std::cout << "=======================" << std::endl
              << "       PROJECT 1       " << std::endl
              << "=======================" << std::endl
              << std::endl;
    project1();
    
    std::cout << std::endl
              << std::endl
              << "=======================" << std::endl
              << "       PROJECT 2       " << std::endl
              << "=======================" << std::endl
              << std::endl;
    project2();
    
    /*
     * Beispielhafte Tabelle mit Ausgabewerten von project2():
     * 
     * +----+------------+
     * | k  |     d_k    |
     * +====+============+
     * |  1 | 3.8164e-16 |
     * |  2 | 8.2128e-16 |
     * |  3 | 2.1621e-14 |
     * |  4 | 6.3865e-14 |
     * |  5 | 6.2504e-13 |
     * |  6 | 1.0755e-10 |
     * |  7 | 9.2815e-10 |
     * |  8 | 1.0319e-08 |
     * |  9 | 1.5021e-07 |
     * | 10 | 6.1460e-07 |
     * | 11 | 3.1724e-08 |
     * | 12 | 4.8436e-05 |
     * | 13 | 9.0672e-04 |
     * | 14 | 6.0353e-03 |
     * | 15 | 1.3924e-02 |
     * +----+------------+
     * 
     * Man kann beobachten, dass der Fehler d_k für wachsendes k zunimmt.
     * Der Grund dafür ist, dass mit wachsendem k die Werte für f(x_k) und
     * g(x_k) immer kleiner werden. Da die Werte jedoch gerundet mit Typ double
     * gespeichert werden, wird der auftretende Fehler immer größer.
     */
}
