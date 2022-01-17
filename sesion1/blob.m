%{
I = imread('oval.png');
circulo = im2bw(I, 0);
imshow(circulo);
[y, x] = find(I);

nx = x - mean(x);
ny = y - mean(y);

nx = nx';
ny = ny';
%}
%{
x = rand(1, 100) + rand();
y = rand() .* x + rand(1, 100);

nx = x - mean(x);
ny = y - mean(y);
%}

I = imread('oval.png');
circulo = im2bw(I, 0);
imshow(circulo);
[y, x] = find(I);

nx = x - mean(x);
ny = y - mean(y);

nx = nx';
ny = ny';

c = cov(nx, ny);
[evectors, evalues] = eig(c);

[value, ind] = max(diag(evalues));

escala = 2;

theta = -pi/2-atan2(evectors(ind, 2), evectors(ind, 1));
theta1 = -pi/2-atan2(evectors(ind, 1), evectors(ind, 2));

R = [cos(-theta), sin(-theta); -sin(-theta), cos(-theta)];
Rn = [cos(-theta1), sin(-theta1); -sin(-theta1), cos(-theta1)];

rp = R * [nx;ny];

rpn = Rn * [nx;ny];

figure
hold on
axis equal
scatter(nx, ny);
axis equal
plot([evectors(1, 1)*-escala, evectors(1, 1)*escala], [evectors(1, 2)*-escala, evectors(1, 2)*escala]);
plot([evectors(2, 1)*-escala, evectors(2, 1)*escala], [evectors(2, 2)*-escala, evectors(2, 2)*escala]);
hold off

figure
hold on
axis equal
plot([evectors(1, 1)*-escala, evectors(1, 1)*escala], [evectors(1, 2)*-escala, evectors(1, 2)*escala]);
plot([evectors(2, 1)*-escala, evectors(2, 1)*escala], [evectors(2, 2)*-escala, evectors(2, 2)*escala]);
scatter(nx, ny);
scatter(rp(1,:),rp(2,:), 'r');
hold off

figure
hold on
axis equal
plot([evectors(1, 1)*-escala, evectors(1, 1)*escala], [evectors(1, 2)*-escala, evectors(1, 2)*escala]);
plot([evectors(2, 1)*-escala, evectors(2, 1)*escala], [evectors(2, 2)*-escala, evectors(2, 2)*escala]);
scatter(rpn(1,:),rpn(2,:), 'g');
hold off