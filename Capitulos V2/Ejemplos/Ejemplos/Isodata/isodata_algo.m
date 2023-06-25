clear all;
close all;
I = imread('coins.png');
level = isodata(I);
BW = imbinarize(I,level);
imshow(BW)