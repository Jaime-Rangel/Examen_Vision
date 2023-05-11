clear all;
close all;
I = im2double(imread('medtest.png'));
I2 = im2double(imread('Gray_Matter.jpg'));

imagesc(I2)
colormap("gray")
I = rgb2gray(I2);

[x,y] = ginput(1);

x =round(x);
y = round(y);

J = regiongrowing(I,x,y,0.2);
figure, imshow(J);