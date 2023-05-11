clear all;
close all;

original = imread('Fig3.37(a).jpg');
%original = double(original)/255;


noise = imnoise(original,'gaussian',0.01);
imgN = imnoise(original,'gaussian');
w=fspecial('gaussian',[3,3],1);

g = imfilter(imgN,w,'conv','replicate');
figure,imagesc(original)
colormap("gray")
figure,imagesc(g)
colormap("gray")

