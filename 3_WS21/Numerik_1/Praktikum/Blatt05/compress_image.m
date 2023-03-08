#Abgabe von Charlotte Rothhaar und Lorenz Bung
function compress_image
    RGB = imread('weihnachtsbaum.jpg'); #Bild als Farbbild einlesen
    G = rgb2gray(RGB); #Bild in Grauwerte konvertieren
    D = double(G);
    X = mat2gray(D);
    figure(1);
    subplot(1,2,1); imshow(X); title('Original'); #Plotten des Originalbildes
    [U,S,V] = svd(X); #Singulärwertzerlegung der Matrix, die die Werte der Pixel des Bildes enthält
    for k = 5:5:min(size(U,1),size(V,1)) #k in 5er-Schritten bis zum Minimum der Bildbreite bzw. Bildhöhe wählen
        #Singulärwertzerlegung verwenden, um approximiertes Bild wiederherzustellen.
        #Hier werden jetzt nur die ersten k Spalten bzw. Zeilen gespeichert, d.h. weniger Speicherplatz wird benötigt, aber es geht Bildqualität verloren.
        X_comp = U(:,1:k)*S(1:k,1:k)*V(:,1:k)';
        
        if k == 5 || k == 500
            #Berechne den Fehler nur am Anfang und am Ende, um Rechenzeit zu sparen
            error = frobenius(D, X_comp);
            #Werte in Datei speichern
            save("-append", "error.txt", "k", "error");
        end
        
        subplot(1,2,2); imshow(X_comp); #Komprimiertes Bild plotten
        title('Komprimiert');
        pause;
    end
end

function error = frobenius(X, X_comp)
    #Berechne ||X - X_{comp}||_F
    X_err = X - X_comp;
    summe = 0;
    for i = 1:size(X_err, 1)
        for j = 1:size(X_err, 2)
            summe += abs(X_err(i,j))*abs(X_err(i,j));
        end
    end
    error = sqrt(summe);
end


#Bereits für relativ kleine Werte von k (zum Beispiel k=60) liefert die Komprimierung recht gute Ergebnisse.
#d.h. der Qualitätsverlust ist nicht mehr so auffällig.
#Insbesondere bei Bildern mit vielen kleinen Details oder verrauschten Bildern (siehe baboon.jpg)
#benötigt es nur ein kleines k für gute Ergebnisse.
#Damit eignet sich die Singulärwertzerlegung als Algorithmus für die verlustbehaftete Bildkompression.
