function [soloOjos, masOjos, imagenMarcada, inicioHorizonte, inicioVertical, factorInverso, inicioVerticalMas, finalHorizontal, finalVertical, hayOjos] = caras(imagen,modelo)
    [cara, bbox] = searchFace(imagen);
    resizear = imresize(cara, 513/width(cara));
    
    hayOjos = false;
    %inicio = 0;
    soloOjos = [];
    masOjos = [];

    for i = 1:(round(113/2) - 1):(height(resizear)-113)
        trozo = resizear(i:(i+112), :, :);
        %imshow(trozo)

        [score, ~] = ejecutarPredictor(trozo, modelo);
        if (score == 1)
            masOjos = resizear((i - 60):(i+112), :, :);
            hayOjos = true;
            %inicio = i;
            soloOjos = trozo;
            break;
        end
    end
    
    if hayOjos == true
        factorInverso = width(cara)/513;
        inicioHorizonte = bbox(1);
        rectangulo =[bbox(1), bbox(2) + round(i*factorInverso), round(513 * factorInverso), round(113 * factorInverso)];
        inicioVertical = bbox(2) + (i*factorInverso);
        inicioVerticalMas = bbox(2) + ((i - 60)*factorInverso);
        finalVertical = rectangulo(4);
        finalHorizontal = rectangulo(3);
        marca = false([height(imagen), width(imagen)]);
        marca(rectangulo(2):(rectangulo(2) + rectangulo(4)), rectangulo(1):(rectangulo(1) + rectangulo(3)) , :) = true;
        marcaGrande = imdilate(marca, strel('square', 10));
        marcaFinal = marcaGrande - marca;

        imagenMarcada = imoverlay(imagen, marcaFinal, 'red');
    end
end
