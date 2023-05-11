clear all;
close all;

f = imread('cameraman.tif'); 
theta = pi/4;
T = [cos(theta) sin(theta) 0 - sin(theta) cos(theta) 0 0 0 1];

tform =  maketform('affine',T);
g = imtransform(f, tform);