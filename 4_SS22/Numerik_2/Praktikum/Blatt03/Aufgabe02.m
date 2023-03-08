function res = Aufgabe02()
    for s = 1:5
        n = 2^s;
        
        % Generiere Vektor X
        X = zeros(n);
        for j = 1:n
            x = 2 * pi * j / n;
            X(j) = f(x);
        end
        beta = fft(X);
        beta_real = real(beta);
        beta_imag = imag(beta);

        % Generiere p(x)
        P = zeros(n);
        for j = 1:n
            x = 2 * pi * j / n;
            summe = 0;
            for k = 1:n
                summe = summe + beta(k) * exp(1)^(1i * k * x);
            end
            P(j) = summe;
        end

        % Generiere q(x)
        Q = zeros(n);
        for j = 1:n
            x = 2 * pi * j / n;
            
        end

        % Plots
        plot(1:n, X, 'r*');
        hold on;
        plot(1:n, real(P), 'b*');
        plot(1:n, imag(P), 'g*');
        hold off;
        title(sprintf('n = %d', n));
        legend('f(x)', 'real(p(x))', 'imag(p(x))');
        pause;
        clf;
    end
end

function y = f(x)
    if (0 <= x) && (x <= pi)
        y = x;
    else
        y = 2 * pi - x;
    end
end