% Abgabe von Lorenz Bung und Charlotte Rothhaar
function result = Aufgabe02()
    for i = 0:5
        n = 2^i;
        fprintf("n = %i:\n", n);

        [x_aequi, y_aequi] = getAequi(n);
        [x_tscheb, y_tscheb] = getTscheby(n);
        disp(x_tscheb);
        xa = pi/8;
        xb = pi/4;
        xa_aeq = neville(x_aequi, y_aequi, xa);
        xb_aeq = neville(x_aequi, y_aequi, xb);
        xa_tscheb = neville(x_tscheb, y_tscheb, xa);
        xb_tscheb = neville(x_tscheb, y_tscheb, xb);

        fprintf("f(xa): %e\nf(xb): %e\nxa_aeq: %e\nxb_aeq: %e\nxa_tscheb: %e\nxb_tscheb: %e\n\n", f(xa), f(xb), xa_aeq, xb_aeq, xa_tscheb, xb_tscheb);

    end
end

% Berechnet Tschebyscheff-Stützstellen
function [x, y] = getTscheby(n)
    x = zeros(n, 1);
    y = zeros(n, 1);
    for j = 0:n-1
        x(j+1) = cos((j + 1/2) * pi / n);
        y(j+1) = f(x(j+1));
    end
end

% Berechnet äquidistante Stützstellen
function [x, y] = getAequi(n)
    x = zeros(n, 1);
    y = zeros(n, 1);
    for j = 1:n+1
        x(j) = -1 + (j-1) * 2/n;
        y(j) = f(x(j));
    end
end

% Die zu approximierende Funktion f
function y = f(x)
    y = 1 / (1 + 25 * x * x);
end

% Berechnet den Wert des Langrange-Polynoms p an der Stelle t mit
% Stützstellen x und Stützwerten y.
function p = neville(x, y, t)
    n = length(x) - 1;    % n+1 Stützstellen, also -1
    P = zeros(n+1, n+1);
    
    % Initialisierung der ersten Spalte der Matrix
    for i = 1:n+1
        P(i, 1) = y(i);
    end

    for j = 2:n+1    % Sukzessive Berechnung der Spalten 2..n+1
        for i = 1:n+2-j    % Obere Dreiecksmatrix, daher nicht alle Zeilen
            % Berechnung des Lagrange-Polynoms
            P(i, j) = ((t - x(i)) * P(i+1, j-1) - (t - x(i+j-1)) * P(i, j-1)) / (x(i+j-1) - x(i));
        end
    end
    % Zum Schluss ist der Eintrag oben rechts in der Matrix das Ergebnis.
    p = P(1, n+1);
end

% Betrachtet man die berechneten Werte für xa und xb, so fällt auf, dass
% insbesondere bei großen n die Tschebyscheff-Knoten eine weitaus bessere
% Approximation der Funktion liefern:
% |f(xa) - xa_tscheb| < |f(xa) - xa_aeq| sowie für xb dasselbe.
% Bei kleinen n wie z.B. n=1 liefern die äquidistanten Stützstellen ein
% besseres Ergebnis, was jedoch vermutlich an der Implementierung liegt:
% wir haben bei n=1 3 äquidistante Stützstellen (x1=-1, x2=0, x3=1), jedoch
% nur einen Tschebyscheff-Knoten.
% (vielleicht haben wir da auch was falsch gemacht. Kann natürlich sein.
% Bei großen n sieht man aber ja sehr eindeutig, dass die Tschebyscheff-
% Knoten besser sind.
