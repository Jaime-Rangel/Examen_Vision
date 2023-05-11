clear all;
close all;
img = imread('BWfigs.png');
imtool(img);
BW = img < 25;
CC = bwconncomp(BW,4);
display(CC)
L = bwlabel(BW);
imtool(L);