clear all;
close all;
c1 = imread('Fig3.15(a)2.jpg');
c2 = imread('Fig3.15(a)1top.jpg');

g = histeq(c1);
imtool(g)

g1 = histeq(c2);
imtool(g1)
