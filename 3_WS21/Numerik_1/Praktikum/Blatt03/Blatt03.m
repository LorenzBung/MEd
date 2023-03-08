#
#Abgabe von Charlotte Rothhaar und Lorenz Bung
#

#Projekt 1 i)


A1 = [1 7 -2 3; 5 -1 -4 0; 8 1 3 5; 4 -4 4 -4];

b = [21; -9; 39; -8];

#Berechne die LU-Zerlegung
function [L, U] = luZerlegung(A)
    n = size(A)(1);
    L = eye(size(A));
    U = zeros(size(A));  
    for i = 1:n 
        for k = i:n 
            
            Summe = 0;
            for j = 1:i-1
                Summe = Summe + L(i,j) * U(j,k);
            end
            
            U(i,k) = A(i,k) - Summe;
        end
        
        for k = i+1:n 
        
            Summe2 = 0;
            for j = 1:i-1
                Summe2 = Summe2 + L(k,j) * U(j,i);
            end
            
            L(k,i) = (A(k,i) - Summe2) / U(i,i);
        end
    end    
end

[L, U] = luZerlegung(A1);
#Kommentare entfernen um die LU-Zerlegung zu testen
#display(A1);
#display(L);
#display(U);
#display(L * U);

#Man koennte hier auch nur x zurueckgeben, wir haben es aus Debug-Zwecken mal
#so gelassen
function [x,y] = Gauss(A,b)
    L = eye(size(A));
    U = zeros(size(A));
    n = size(A)(1);
    [L, U] = luZerlegung(A);
    y = zeros(size(b));
    x = zeros(size(b));
    #Berechne Vektor y
    for k = 1:n-1
        for i = k+1:n
            L(i,k) = A(i,k) / A(k,k);
            b(i) = b(i) - L(i,k) * b(k); 
    
            for j = k+1:n 
                A(i,j) = A(i,j) - L(i,k) * A(k,j);
            end
        end    
    end
    y = b;

    #Loese jetzt das Gleichungssystem nach x
    for i = n:-1:1
        x(i) = y(i);
        for j = i+1:n
            x(i) = x(i) - U(i,j) * x(j);
        end
        x(i) = x(i) / U(i,i);
    end
end

[x,y] = Gauss(A1,b);
display(x);

#ii)

function ret = Stoerung()
    for n = 1:10 
        for i = 1:n 
            for j = 1:n 
            
                A(i,j) = 1 / (i + j -1);   
                
                Summe3 = 0; 
                for k = 1:n
                    Summe3 = Summe3 + power (-1,(k-1));
                end 
            end 
            
            b(i) = Summe3 / (i + k -1);
                
            x(i) = power(-1, (i-1));  #Loesung des ungestoerten Gleichungssystems 
            
            d(i) = 1e-5 * cos((i * pi)/n);  #Stoerungsvektor 
        end
        
        [xs,ys] = Gauss(A, b + d);  #Loesung des um d gestoerten Gleichungssystems
        display(xs);


        xnorm = norm(x - xs) / norm(x);  #relativer Fehler 
        
        display(xnorm);
        
        xCond = cond(A, 2);  #Konditionszahl
        
        display(xCond);
       
    end
end

#display(Stoerung) 


#Da die Konditionszahlen sehr gross sind, ist das ein Anzeichen dafuer, dass das Problem schlecht konditioniert ist
#und kleine Aenderungen in den Daten grosse Aenderungen in der Loesung des Problems.


        
#Projekt 2



function [x,y] = Gauss_Spaltenpivotsuche(A,b)
    L = eye(size(A));
    U = zeros(size(A));
    n = size(A)(1);
    [L, U] = luZerlegung(A);  #Berechne LU-Zerlegung
    y = zeros(size(b));
    x = zeros(size(b));
    for k = 1:n-1
        p = 1:n;  #Permutationsvektor (pi auf dem Blatt)
        [maxWert,mptr] = max(abs(A(p(k:end),k)));  #Bestimmung des maximalen Werts (und dessen Index) der k-ten Spalte
        if (maxWert <= 1e-10)
            break;
        end
        
        # Das mit dem Zeilen vertauschen funktioniert leider noch nicht.
        # Wir haben versucht, den Fehler zu finden, aber es leider nicht geschafft.
        # Muesste vermutlich am Vektor p liegen.
        
        tmp = p(k)  #vertausche die Zeilen
        p(k) = p(k - 1 + mptr);
        p(k - 1 + mptr) = tmp;
        
        for i = k+1:n
            L(p(i),k) = A(p(i),k) / A(p(k),k);
            b(p(i)) = b(p(i)) - L(p(i),k) * b(p(k)); 
    
            for j = k+1:n 
                A(p(i),j) = A(p(i),j) - L(p(i),k) * A(p(k),j);
            end
        end
    end
    y = b;

    for i = n:-1:1
        x(i) = y(i);
        for j = i+1:n
            x(i) = x(i) - U(i,j) * x(j);
        end
        x(i) = x(i) / U(i,i);
    end
end

A1 =[1 7 -2 3; 5 -1 -4 0; 8 1 3 5; 4 -4 4 -4];

b =[21; -9; 39; -8];
[x2, y2] = Gauss_Spaltenpivotsuche(A1,b);
# Hier kommt dann halt was falsches für x2 raus
display(x2);

