clear all;
close all;

f = imread('Fig3.37(a).jpg');

[B, c, r] = roipoly(f);
p = imhist(f(B));

%histograma
plot(p)
%mascara
%figure,imagesc(B)
