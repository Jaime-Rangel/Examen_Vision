clc
clear all
close all
warning off
x=imread('coins.png');
imshow(x);
[centers, radii]=imfindcircles(x,[20 30]);
imshow(x);
hold on;
viscircles(centers, radii,'EdgeColor','b');