function [imin, imax, center, radii, d1, d2, medio, encontrado] = lagrimal(soloOjos)
    I = soloOjos;
    mitad = imcrop(I, [round(width(I)/2), 0, round(width(I)/3), height(I)]);
    %mitad = imcrop(I, [0, 0, round(width(I)/2), height(I)]);

    Rmin = 12;
    Rmax = 50;
    encontrado = false;
    [center, radii] = imfindcircles(mitad,[Rmin Rmax],'ObjectPolarity','dark');
    tamano = size(center);
    if tamano(1) ~= 0
        encontrado = true;
        center = center(1,:);
        radii = radii(1);

        binarizada = imbinarize(rgb2gray(mitad), "adaptive");
        circulito = false([height(mitad) width(mitad)]);
        %Crear un circulo donde iris
        R = radii - 2.5;
        circulito(round(center(2)), round(center(1))) = 1;
        soloCirculo = bwdist(circulito) <= R;
        % imshow(soloCirculo)
        % temp4 = temp1 | soloCirculo;
        % imshow(temp4)
        % temp5 = imdilate(temp4, [1 1 1 1 1 1]);
        % imshow(temp5)
        % componentes = bwconncomp(temp5);
        limpieza = imdilate((binarizada | soloCirculo), [1 1 1 1 1 1]);
        componentes = bwconncomp(limpieza);

        %BUscar el componente mas grande
        numPixels = cellfun(@numel,componentes.PixelIdxList);
        [biggest,idx] = max(numPixels);

        canvasVacio = false([height(binarizada) width(binarizada)]);
        canvasVacio(componentes.PixelIdxList{idx}) = 1;
        % imshow(canvasVacio)
        mirar = imoverlay(mitad, canvasVacio);
        %imshow(mirar)
        puntos = componentes.PixelIdxList{idx};
        sumita = sum(canvasVacio);
        imin = 1; 
        found = false;
        tamano = size(sumita);
        while (imin < tamano(2))
            if (sumita(imin) > 0)
                break
            end
            imin = imin + 1;
        end

        imax = tamano(2);
        while (imax > 0)
            if (sumita(imax) > 0)
                break
            end
            imax = imax - 1;
        end

        sumitaAlReves = sum(transpose(canvasVacio));
        tamano = size(sumitaAlReves);
        jmin = 1;
        while (jmin < tamano(2))
            if (sumitaAlReves(jmin) > 0)
                break
            end
            jmin = jmin + 1;
        end

        jmax = tamano(2);
        while (jmax > 0)
            if (sumitaAlReves(jmax) > 0)
                break
            end
            jmax = jmax - 1;
        end

        media = fix((jmax + jmin) / 2);
        %plot(rightPoint(1), rightPoint(2), 's', 'Color', 'r', MarkerSize=20);
        %plot(leftPoint(1), leftPoint(2), 's', 'Color', 'r', MarkerSize=20);
        %hold on;
        %imshow(mitad);
        imin = imin;
        imax = imax - 5;
        medio = round(center(2)) + 10;
        %viscircles(center, radii,'Color','b');
        %plot(imin,medio , 's','MarkerSize', 20 ,'Color','r');
        %plot(imax, medio, 's','MarkerSize', 20 ,'Color','yellow');
        %hold off;
        d1 = center(1) - imin;
        d2 = imax - center(1);
    %     factorizamos = d1/d2;
    % 
    %     if (factorizamos < 0.8)
    %         msgbox("Esta mirando a la izquierda");
    %     elseif(factorizamos > 1.2)
    %         msgbox("Esta mirando a la derecha");
    %     else
    %         msgbox("Esta mirando al centro.")
    %     end
    end
end

