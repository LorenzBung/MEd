% Abgabe von Charlotte Rothhaar und Lorenz Bung
function result = Aufgabe01()
    for i = 0:3
        n = 2^i;
        x_aequi = linspace(-1, 1, n);
        x_tscheb = getTscheby(n);

        % Berechne Funktionswerte an äquidistanten Stützstellen
        f_aequi = zeros(1, length(x_aequi));
        g_aequi = zeros(1, length(x_aequi));
        h_aequi = zeros(1, length(x_aequi));
        for j = 1:length(x_aequi)
            f_aequi(j) = f(x_aequi(j));
            g_aequi(j) = g(x_aequi(j));
            h_aequi(j) = h(x_aequi(j));
        end
        
        % Berechne Funktionswerte an Tschebyscheff-Stützstellen
        f_tscheb = zeros(1, length(x_tscheb));
        g_tscheb = zeros(1, length(x_tscheb));
        h_tscheb = zeros(1, length(x_tscheb));
        for j = 1:length(x_tscheb)
            f_tscheb(j) = f(x_tscheb(j));
            g_tscheb(j) = g(x_tscheb(j));
            h_tscheb(j) = h(x_tscheb(j));
        end
        
        LOOPSIZE = 100;

        yj_f_aequi = zeros(LOOPSIZE, 1);
        yj_f_tscheb = zeros(LOOPSIZE, 1);
        yj_g_aequi = zeros(LOOPSIZE, 1);
        yj_g_tscheb = zeros(LOOPSIZE, 1);
        yj_h_aequi = zeros(LOOPSIZE, 1);
        yj_h_tscheb = zeros(LOOPSIZE, 1);
        zs = zeros(LOOPSIZE, 1);
        % Auswertung der Interpolationspolynome mit dem Horner-Schema
        for j = 0:LOOPSIZE
            z = -1 + 2 * j / LOOPSIZE;
            zs(j+1) = z;
            % https://pythonnumericalmethods.berkeley.edu/notebooks/chapter17.05-Newtons-Polynomial-Interpolation.html
            yj_f_aequi(j+1) = horner(x_aequi, f_aequi, z);
            yj_f_tscheb(j+1) = horner(x_tscheb, f_tscheb, z);
            yj_g_aequi(j+1) = horner(x_aequi, g_aequi, z);
            yj_g_tscheb(j+1) = horner(x_tscheb, g_tscheb, z);
            yj_h_aequi(j+1) = horner(x_aequi, h_aequi, z);
            yj_h_tscheb(j+1) = horner(x_tscheb, h_tscheb, z);
        end
        plot(zs, yj_f_aequi, 'r-');
        hold on
        plot(zs, yj_g_aequi, 'b-');
        plot(zs, yj_h_aequi, 'g-');
        title(sprintf("n = %d", n));
        legend('f_aequi', 'g_aequi', 'h_aequi');
        hold off
        pause
        clf
    end
end

% getTscheby von Blatt 1 übernommen
function x = getTscheby(n)
    x = zeros(n, 1);
    for j = 0:n-1
        x(j+1) = cos((j + 1/2) * pi / n);
    end
end

function y = f(x)
    y = sin(pi * x);
end

function y = g(x)
    y = 1 / (1 + 25 * x * x);
end

function y = h(x)
    y = abs(x);
end

% Berechnet die Koeffizienten q_j(t) an der Stelle t für die Stützstellen x
function q = getNewtonBasis(x, t)
    n = length(x);
    q = zeros(n+1, 1);
    q(1) = 1;
    for j = 2:n+1
        prod = 1;
        for k = 1:j-1
            prod = prod * (t - x(k));
        end
        q(j) = prod;
    end
end

function lamda = getLamdas(x, y)
    n = length(x) - 1; % wir haben n+1 Stützstellen
    A = zeros(n+1, n+1);
    lamda = zeros(n+1, 1);
    % Initialisierung der Matrix
    for i = 1:n+1
        A(i, 1) = y(i);
    end
    for j = 1:n
        for i = 0:n-(j+1)
            A(i+1, j+1) = (A(i+2, j) - A(i+1, j))/(x(i+1+j+1) - x(i+1));
        end
    end
    % Lamdas auslesen
    for j = 0:n
        lamda(j+1) = A(1, j+1);
    end
end

function y = horner(x, y, t)
    n = length(x) - 1; % n+1 Stützstellen
    %https://de.wikibooks.org/wiki/Algorithmensammlung:_Numerik:_Horner-Schema#Octave
    lamda = getLamdas(x, y);
    a = fliplr(lamda);
    result = a(1);
    for j = 2:n
        result = result * t + a(j);
    end
    y = result;
end
