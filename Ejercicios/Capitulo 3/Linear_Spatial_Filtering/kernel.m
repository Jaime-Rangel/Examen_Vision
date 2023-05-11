close all;
% w = fspecial('average',[50,50]);
% mesh(w)
% 
% k = fspecial('gaussian',[50,50],10);
% mesh(k)

original = imread('Fig3.30(a).jpg');
original = double(original)/255;

noise = imnoise(original,'gaussian',0.01);
w = ones(30);

g = imfilter(noise,w,'conv','replicate');
imagesc(g)
colormap("gray")
e=noise-g;



