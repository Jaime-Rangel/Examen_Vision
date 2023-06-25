clear all;
close all;
% im = imread('breast.tif');
% g = ice('image',im);

im = imread('peppers.png');
g = ice('image',im,'space','hsv');

imshow(g) 