# 
# Abgabe von Charlotte Rothhaar und Lorenz Bung
# 

function val = Blatt01()
    fprintf("=======================\n");
    fprintf("       PROJECT 1       \n");
    fprintf("=======================\n\n");
    
    project1();
    
    fprintf("\n\n");
    fprintf("=======================\n");
    fprintf("       PROJECT 2       \n");
    fprintf("=======================\n\n");
    
    project2();
endfunction

function val = project1()
    x = single(1.0);
    while (1 + x > 1)
        x = x / 2;
    endwhile
    
    y = double(1.0);
    while (1 + y > 1)
        y = y / 2;
    endwhile
    fprintf("+--------+------------+\n");
    fprintf("|  type  | value of x |\n");
    fprintf("+========+============+\n");
    fprintf("| float  | %.4e |\n", x);
    fprintf("+--------+------------+\n");
    fprintf("| double | %.4e |\n", y);
    fprintf("+--------+------------+\n");
endfunction

function val = project2()
    function y = f(x)
        y = (1 / x) - (1 / (x + 1));
    endfunction
    
    function y = g(x)
        y = 1 / (x * (x + 1));
    endfunction

    fprintf("+----+------------+\n");
    fprintf("|  k |     d_k    |\n");
    fprintf("+====+============+\n");
    
    for k = 1:15
        x_k = 10 ** k;
        val = abs(f(x_k) - g(x_k)) / abs(g(x_k));
        fprintf("| %.2i | %.4e |\n", k, val);
    endfor
    
    fprintf("+----+------------+\n");
endfunction

# 
# 
# Beispielhafte Tabelle mit Ausgabewerten von project2():
# 
# +----+------------+
# | k  |     d_k    |
# +====+============+
# |  1 | 3.8164e-16 |
# |  2 | 8.2128e-16 |
# |  3 | 2.1621e-14 |
# |  4 | 6.3865e-14 |
# |  5 | 6.2504e-13 |
# |  6 | 1.0755e-10 |
# |  7 | 9.2815e-10 |
# |  8 | 1.0319e-08 |
# |  9 | 1.5021e-07 |
# | 10 | 6.1460e-07 |
# | 11 | 3.1724e-08 |
# | 12 | 4.8436e-05 |
# | 13 | 9.0672e-04 |
# | 14 | 6.0353e-03 |
# | 15 | 1.3924e-02 |
# +----+------------+
# 
# Man kann beobachten, dass der Fehler d_k für wachsendes k zunimmt.
# Der Grund dafür ist, dass mit wachsendem k die Werte der Brüche  in f(x_k) 
# immer kleiner werden und die Differenz der beiden Brüche immer geringer
# wird. Dadurch kommt es zu Auslöschungseffekten. In g(x) ist keine solche
# kritische Subtraktion, weswegen hier keine Auslöschung passiert.
# Der relative Fehler zwischen den beiden Funktionen explodiert also für
# wachsendes k.

