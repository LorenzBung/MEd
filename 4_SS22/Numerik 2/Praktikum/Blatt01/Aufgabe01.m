% Abgabe von Lorenz Bung und Charlotte Rothhaar
function result = Aufgabe01()
    A = [0.2161 0.1441; 1.2969 0.8648];
    b = [0.1440; 0.8642];
    x = [2; -2];
    x_cramer = cramer(A, b);
    x_gauss = A\b;
    fprintf("x Cramer: %e\nx Gauß: %e\n\n", x_cramer, x_gauss);

    fprintf("Konditionszahl von A: %i\n\n", cond(A));

    vf_cramer = fehler_v(x, x_cramer);
    rf_cramer = fehler_r(A, x_cramer, b);
    fprintf("Vorwärtsfehler Cramer: %e\nRückwärtsfehler Cramer: %e\n\n", vf_cramer, rf_cramer);

    vf_gauss = fehler_v(x, x_gauss);
    rf_gauss = fehler_r(A, x_gauss, b);
    fprintf("Vorwärtsfehler Gauß: %e\nRückwärtsfehler Gauß: %e\n", vf_gauss, rf_gauss);
end

function x = cramer(A, b)
    n = size(A);
    x = [];
    d = det(A);
    for i = 1:n
        A_i = A;
        A_i(:,i) = b;
        h = det(A_i) / d;
        x = [x; h];
    end
end

function err = fehler_v(x, x2)
    err = norm(x - x2, Inf) / norm(x, Inf);
end

function err = fehler_r(A, x2, b)
    err = norm(A * x2 - b, Inf) / norm(b, Inf);
end

% Man sieht, dass der Vorwärtsfehler bei Cramer und Gauß so gut wie
% identisch ist, der Rückwärtsfehler jedoch bei Gauß deutlich geringer
% ausfällt.
