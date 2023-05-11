clear all
close all
tic
%Method function
img = imread('Fig3.04(a).jpg');
img_star = imread('Fig3.05(a).jpg');

g = imadjust(img,[0,1],[1,0]);
imtool(g)

% Method substract
s = 255 - img;
figure
imtool(s)

k = log(1 + double(img_star));
imtool(k)
toc