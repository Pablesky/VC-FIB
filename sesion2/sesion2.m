A = double(imread('_MG_7735.JPG'))/255;
B = double(imread('_MG_7737.JPG')) /255;

DIF = abs(A-B); % imatge diferencia
maxim = max(DIF(:));
DIF = DIF/maxim; % dividim pel seu valor màxim
%figure
%imshow(DIF);

Bd = imtranslate(B,[20, -20]);
DIF = abs(A-Bd);
maxim = max(DIF(:));
DIF = DIF/maxim;
%figure
%imshow(DIF);

Am = (A+Bd)/2; % imatge millorada
red = imadjust(adapthisteq(Am(:, :, 1)));
green = imadjust(adapthisteq(Am(:, :, 2)));
blue = imadjust(adapthisteq(Am(:, :, 3)));

rgbImage = cat(3, red, green, blue);

figure
montage ({A,rgbImage});