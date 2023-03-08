#
#Abgabe von Charlotte Rothhaar und Lorenz Bung
#

# Projekt 2

function Blatt04_2()
    test_projekt2();
endfunction

function test_projekt2()
    i = [1:7];
    t = [0.1, 0.2, 0.6, 0.9, 1.1, 1.2, 2.0];
    x = [0.73, 1.28, 4.24, 6.11, 7.69, 8.21, 13.83];
    y = [0.96; 1.81; 4.23; 5.05; 5.15; 4.81; 0.55];
    
    A = zeros(size(t,2), 2);
    for i = 1:size(t,2)
        A(i,1) = t(i);
        A(i,2) = - 1/2 * t(i) * t(i);
    endfor
    ATA = A' * A;
    ATy = A' * y;
    
    vy_g = inv(ATA) * ATy;
    vy = vy_g(1);
    g = vy_g(2);
    
    vx = x / t;
    yt = zeros(size(t));
    for i = 1:size(yt,2)
        yt(i) = vy * t(i) - 1/2 * g * t(i) * t(i);
    endfor
    
    hold on
    plot(t, y, 'b*');
    plot(t, yt, 'r-');
    hold off
endfunction
