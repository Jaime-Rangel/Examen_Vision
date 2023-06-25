clear all;
close all;
I = im2double(imread('medtest.png'));

imagesc(I)
colormap("gray")

[y,x] = ginput(1);

x = round(x);
y = round(y);

J = regiongrowing(I,x,y,0.2);
figure
imshow(I + J)