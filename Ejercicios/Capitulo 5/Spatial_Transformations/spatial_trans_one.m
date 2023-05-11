clear all;
close all;
f = imread('cameraman.tif'); 
s = 0.8;

T = [s 0 0;
    0 s 0;
    0 0 1];

tform = maketform('affine', T); 
g = imtransform(f, tform);

subplot(2,1,1)
imagesc(f);
colormap(gray)
subplot(2,1,2)
imagesc(g);
colormap(gray)