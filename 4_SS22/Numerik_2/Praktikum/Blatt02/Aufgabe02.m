% Abgabe von Charlotte Rothhaar und Lorenz Bung
function result = Aufgabe02
    PLOT_RESOLUTION = 1000;
    % Teil (i) der Aufgabe
    f1 = figure;
    f2 = figure;
    %f3 = figure;
    %f4 = figure;
    for j = 1:4
        n = 2^j;
        xa = zeros(1, n+1); % Teil (i)(a)
        ya = zeros(1, n+1);
        xb = zeros(1, n+1); % Teil (i)(b)
        yb = zeros(1, n+1);
        xf = zeros(1, PLOT_RESOLUTION); % Reale Funktion f, 1000 Stützstellen
        yf = zeros(1, PLOT_RESOLUTION);
        yg = zeros(1, PLOT_RESOLUTION); % Reale Funktion g, 1000 Stützstellen
        yc = zeros(1, n+1); % Teil (ii)(a)
        yd = zeros(1, n+1); % Teil (ii)(b)
        for i = 1:PLOT_RESOLUTION
            xf(i) = i/PLOT_RESOLUTION;

            yf(i) = f(xf(i));
            yg(i) = g(xf(i));
        end
        for i = 0:n
            xa(i+1) = i/n;
            ya(i+1) = f(xa(i+1));
            yc(i+1) = g(xa(i+1));

            xb(i+1) = (i/n)^4;
            yb(i+1) = f(xb(i+1));
            yd(i+1) = g(xb(i+1));
        end
        % Berechne Splines
        %splineA = zeros(1, PLOT_RESOLUTION);
        %splineB = zeros(1, PLOT_RESOLUTION);
        %for i = 1:PLOT_RESOLUTION
        %    splineA(i) = cubicSpline(xa, yc, xf(i));
        %    splineB(i) = cubicSpline(xb, yd, xf(i));
        %end
        % Plotte Teil (i)
        figure(f1);
        plot(xa, ya, 'r-*');
        hold on
        plot(xf, yf, 'b-');
        legend(sprintf('i/n, n=%d', n), 'f(x) = sqrt(x)');
        hold off
        figure(f2);
        plot(xb, yb, 'r-*');
        hold on
        plot(xf, yf, 'b-');
        legend(sprintf('(i/n)^4, n=%d', n), 'f(x) = sqrt(x)');
        hold off

        % Plotte Teil (ii)
        %figure(f3);
        %plot(xf, splineA, 'r-');
        %hold on
        %plot(xf, yg, 'b-');
        %legend(sprintf('cubic spline, i/n, n=%d', n), 'g(x) = sin(2 * pi * x)');
        %hold off
        %figure(f4);
        %plot(xf, splineB, 'r-');
        %hold on
        %plot(xf, yg, 'b-');
        %legend(sprintf('cubic spline, (i/n)^4, n=%d', n), 'g(x) = sin(2 * pi * x)');
        %hold off
        pause
        clf
    end
    % Wie man bei den Plots von Teil (i) der Aufgabe sieht, ist der Fehler
    % der Approximation in Teil (i)(b) geringer als in Teil (i)(a). Dies
    % liegt daran, dass sich die Wurzelfunktion mit immer größer werdenden
    % x immer mehr einer linearen Funktion annähert und deshalb auch bei
    % der linearen Approximation nicht mehr so große Fehler entstehen. Die
    % Fehler im Bereich nahe x=0 sind jedoch deutlich größer, da eine
    % lineare Funktion hier nur eine schlechte Approximation bietet.
    % In Teil (i)(b) wird das Problem dadurch umgangen, dass in den
    % Bereichen nahe x=0 mehr Stützstellen gewählt werden und dafür nahe
    % x=1 weniger. Das führt zu einem geringeren Fehler.
end

% TODO Hier funktioniert sehr wahrscheinlich sehr viel noch nicht!!!
% Indizes sind noch falsch, werden in Z. 100 geworfen

% Interpolationsfunktion für kubische Splines.
% Berechnet den Wert des Splines mithilfe der Stützstellen x und Stützwerte
% y an der Stelle t.
function yt = cubicSpline(x, y, t)
    n = length(x);
    disp(n);
    disp(x);
    A = zeros(n, 3);
    b = zeros(n, 1);
    h = zeros(n, 1);
    % Berechne h(i)
    for i = 1:n-1
        h(i) = x(i+1) - x(i);
    end
    disp(h);
    % Initiiere das Gleichungssystem Ax = b
    for i = 1:n-1
        A(i, 1) = h(i) / 6;
        A(i, 2) = (h(i+1) + h(i)) / 3;
        A(i, 3) = h(i+1) / 6;
        b(i) = (y(i+2) - y(i+1)) / h(i+1) - (y(i+1) - y(i)) / h(i);
    end
    % LGS lösen
    gamma = A\b;
    % Werte für b(i) und d(i) berechnen
    b = zeros(1, n);
    d = zeros(1, n);
    for i = 1:n
        d(i) = (gamma(i+1) - gamma(i))/h(i);
        b(i) = (y(i+1) - y(i)) / h(i)- gamma(i) / 2 * h(i) - d(i) / 6 * h(i) * h(i);
    end

    % Berechne den Index i+1, ab dem x(i) > t
    xmax = 0;
    for i = 2:n
        if (t > x(i))
            xmax = i;
            break;
        end
    end
    xmin = xmax - 1;
    % Wert des Splines an der Stelle t berechnen
    yt = y(xmin) + b(xmin) * (t - x(xmin)) + gamma(xmin) / 2 * (t - x(xmin))^2 + d(xmin) / 6 * (t - x(xmin))^3;
end

% Funktion f aus Teil (i)
function y = f(x)
    y = sqrt(x);
end

% Funktion f aus Teil (ii), hier g(x) genannt
function y = g(x)
    y = sin(2 * pi * x);
end
