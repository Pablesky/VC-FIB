caracol1 = rgb2gray((imread('_61A5845.jpg')));
caracol2 = rgb2gray((imread('_61A5855.jpg')));
caracol3 = rgb2gray((imread('_61A5861.jpg')));

Sv = [-1, 0, 1; -2, 0, 2; -1, 0, 1];
Sh = [-1, -2, -1; 0, 0, 0; 1, 2, 1];

caracol1sv = imfilter(caracol1, Sv);
caracol1sh = imfilter(caracol1, Sh);
caracol1s = abs(caracol1sh) + abs(caracol1sv);

caracol2sv = imfilter(caracol2, Sv);
caracol2sh = imfilter(caracol2, Sh);
caracol2s = abs(caracol2sh) + abs(caracol2sv);

caracol3sv = imfilter(caracol3, Sv);
caracol3sh = imfilter(caracol3, Sh);
caracol3s = abs(caracol3sh) + abs(caracol3sv);

figure
montage({caracol1, caracol1s})

figure
montage({caracol2, caracol2s})

figure
montage({caracol3, caracol3s})

multiplicador = 0
caracol1size = size(caracol1s);
temp = zeros(max(caracol1size(1), caracol1size(2)), max(caracol1size(1), caracol1size(2)))
for i = 1:caracol1size(1)
    for j = i:(caracol1size(2) - i)
        temp(i, j) = multiplicador
    end
    multiplicador = multiplicador + 1
end

