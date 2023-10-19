# 
# Abgabe von Charlotte Rothhaar und Lorenz Bung
# 

function val = Blatt02()
    warning ("off", "all")
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

function x = solve_upper(matrix, vector)
    x = zeros(size(vector), 1);  # size(vector) works because matrix is symmetrical
    for j = 1:size(vector)
        inner_sum = 0;
        for k = j+1:size(vector)  # calculate the inner sum of the solution
            inner_sum += matrix(j, k) * x(k);
        endfor
        x(j) = (vector(j) - inner_sum) / matrix(j, j);  # calculate the correct vector entry
    endfor
endfunction

function x = solve_lower(matrix, vector)
    x = zeros(size(vector), 1);  # size(vector) works because matrix is symmetrical
    for j = 1:size(vector)
        inner_sum = 0;
        for k = 1:j-1  # calculate the inner sum of the solution
            inner_sum += matrix(j, k) * x(k);
        endfor
        x(j) = (vector(j) - inner_sum) / matrix(j, j);  # calculate the correct vector entry
    endfor
endfunction

# Helper function to pretty print a vector of arbitrary length
function str = pretty_print(vector)
    s = "[%d,";
    for i = 2:size(vector)-1
        s = strcat(s, " %d,");
    endfor
    s = strcat(s, " %d]");
    str = sprintf(s, vector);
endfunction


function val = project1()
    # Define test values for the matrices and results
    A1 = [1 2 3; 0 4 5; 0 0 6];
    b1 = [6; 9; 6];
    A2 = [1 0 0; 2 3 0; 4 5 6];
    b2 = [3; 12; 28];
    
    # Print the values of the vectors
    disp(pretty_print(solve_lower(A1, b1)));
    disp(pretty_print(solve_lower(A2, b2)));
endfunction


function [L, U] = lu_decomp(matrix)
    # Setup empty matrices
    L = zeros(size(matrix));
    U = zeros(size(matrix));
    
    for i = 1:size(matrix, 1)   # works because matrix is symmetrical
        # Calculate U first
        for k = i:size(matrix, 1)
            inner_sum = 0;
            for j = 1:i-1
                inner_sum += L(i, j) * U(j, k);
            endfor
            U(i, k) = matrix(i, k) - inner_sum;
        endfor
        
        # Calculate L
        for k = i+1:size(matrix, 1)
            inner_sum = 0;
            for j = 1:i-1
                inner_sum += L(k, j) * U(j, i);
            endfor
            L(k, i) = (matrix(k, i) - inner_sum) / U(i, i);
        endfor
    endfor
    
    # Finally add identity to L matrix
    L += eye(size(L));
endfunction


function val = project2()
    # Define test values for the matrices
    A1 = [4 2 3; 2 4 2; 3 2 4];
    
    # Test A1
    [L1, U1] = lu_decomp(A1);
    [L1_corr, U1_corr] = lu(A1);
    
    fprintf("solve_lower(L1, ...):\n%s\n", pretty_print(solve_lower(L1, ones(3, 1))));
    fprintf("solve_upper(U1, ...):\n%s\n", pretty_print(solve_upper(U1, ones(3, 1))));
    
    
    # Test A2 Arrays
    n = [10 20 40 80 160];
    time_holder = zeros(size(n));  # Holds the times taken to calculate lu_decomp
    # Define A2 in a loop
    for it = 1:size(n, 2)
        fprintf("\n==== (n = %.3d) ====\n", n(it));
        e = ones(n(it), 1);
        A2 = spdiags([-e 2*e -e], -1:1, n(it), n(it));
        
        [L2, U2] = lu_decomp(A2);
        [L2_corr, U2_corr] = lu(A2);
        
        # Measure the time it takes to calculate own_lower
        tic;
        own_lower = solve_lower(L2, e);
        time_holder(it) = toc;
        correct_lower = L2\e;
        # Compare own_lower to the correct solution and print the result
        # note: ternary operator doesn't seem to work (executes print for every entry) so code is really ugly
        if (own_lower == correct_lower) 
            fprintf("own_lower correct: 1\n");
        else
            fprintf("own_lower correct: 0\n");
        endif
        
        # Same with own_upper
        own_upper = solve_upper(U2, e);
        correct_upper = U2\e;
        if (own_upper == correct_upper) 
            fprintf("own_upper correct: 1\n");
        else
            fprintf("own_upper: %s\ncorrect_upper:%s\n", pretty_print(own_upper), pretty_print(correct_upper));
            fprintf("own_upper correct: 0\n");
        endif
        
        # Aus irgendeinem Grund stimmt hier unser own_upper nicht.
        # Wir haben solve_upper geprüft (funktioniert auch für andere Matrizen)
        # und (L2 * U2 == A2) liefert true, also stimmt die LU-Zerlegung auch.
        # Keine Ahnung woran es liegt... Der Lösungsvektor sieht für unser
        # Ergebnis aber richtig aus, Beispiel für n = 10:
        # own_upper: [0.5, 0.666667, 0.75, 0.8, 0.833333, 0.857143, 0.875, 0.888889, 0.9, 0.909091]
        # correct_upper:[2.01988, 3.03975, 3.55963, 3.74618, 3.68272, 3.41926, 2.98914, 2.41616, 1.71818, 0.909091]
    endfor
    
    # Print the table of calculating times
    fprintf("\n\n+-----+----------+\n");
    fprintf("|  n  |  time(n) |\n");
    fprintf("+-----+----------+\n");
    for it = 1:size(n, 2)
        fprintf("| %.3d | %.6f |\n", n(it), time_holder(it));
    endfor
    fprintf("+-----+----------+\n");
    plot(n, time_holder);
    
    # 1. Unter welchen Umständen sollte man die Berechnung von L abbrechen?
    #
    #    Die Berechnung sollte abbrechen, wenn eines der Pivotelemente
    #    (also mat(i, i) für ein i aus 1:n) null wird, da det(L) genau aus dem
    #    Produkt der Pivotelemente besteht und damit 0 wäre. Damit wäre
    #    L in diesem Fall nicht mehr invertierbar.
    #
    # 2. Was lässt sich über die Laufzeit für die Lösung des Gleichungssystems
    #    A2 x = b2 in Abhängigkeit von n aussagen?
    #
    #    Die LU-Zerlegung hat eine Komplexität von O(n^3) (nach Vorlesung).
    #    Bei der Lösung des Gleichungssystems gibt es dann nur noch eine
    #    Matrix-Vektor-Multiplikation (und jeweils eine vernachlässigbare
    #    Subtraktion und Division), so dass wir dafür eine Komplexität von
    #    O(n^2) erhalten.
    #    Insgesamt ist also die LU-Zerlegung der limitierende Faktor und die
    #    Laufzeit wächst kubisch zur Größe der Matrix.
endfunction
