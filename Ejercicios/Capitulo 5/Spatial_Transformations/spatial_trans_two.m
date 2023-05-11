clear all;
close all;
f = imread('cameraman.tif');

T = [1 0 0;
    0 1 0;
    100 50 1];

tform = maketform('affine',T);
g = imtransform(f,tform,'XData',[1 size(f,2)],'YData',[1 size(f,1)]);
imagesc(g);
colormap('gray')