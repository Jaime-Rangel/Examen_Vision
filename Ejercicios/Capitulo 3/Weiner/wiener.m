close all;
n = 3;

I = imread('Fig3.35(a).jpg');

J = double(I);

w = fspecial('gaussian',[3,3],1);
g = imfilter(I,w,'conv','replicate');

subplot(1,2,1)
imagesc(g)
colormap("gray")


K = wiener2(J,[n,n]);
subplot(1,2,2)
imagesc(K)
colormap("gray")

% L = imfilter(double(J),ones(n));
% 
% M = medfilt2(double(J),[n,n]);