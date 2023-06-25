clear all;
close all;

im = imread('peppers.png');
h = rgb2hsv(im);

H = h(:,:,1);
S = h(:,:,2);
I = h (:,:,3);

w = fspecial('average',25);
i_filtered = imfilter(I,w,"replicate");

h = cat(3,H,S,i_filtered);
f = hsv2rgb(h);
f = min(f,1);
imshow(f)

figure
imshow(f)