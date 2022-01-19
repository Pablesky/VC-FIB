function[score, algo] = ejecutarPredictor(imagen, clasificador) 

    imagenGris = rgb2gray(imagen);
    cell = [16 16];
    %imshow(imagenGris)

    HOGFeatures = extractHOGFeatures(imagenGris, 'CellSize', cell);
    HOGFeatures = [HOGFeatures 1];
    
    titulos = strings(width(HOGFeatures), 1);
    for i = 1: width(HOGFeatures)
        titulos(i) = "Atr " + int2str(i);
    end
    
    titulos(width(HOGFeatures)) = "Clase";
    
    tabla = array2table(HOGFeatures);
    tabla.Properties.VariableNames = titulos;
    
    [score, algo] = clasificador.predictFcn(tabla);
end