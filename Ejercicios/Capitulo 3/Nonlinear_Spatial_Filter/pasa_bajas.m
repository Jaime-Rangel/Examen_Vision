close all;
original = imread('Fig3.37(a).jpg');

g = medfilt2(original,[3,3]);
imagesc(g)
colormap("gray")
