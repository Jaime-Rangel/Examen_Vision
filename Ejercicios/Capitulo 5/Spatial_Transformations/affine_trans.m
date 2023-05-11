clear all;
close all;

fixed=double(rgb2gray(imread('BrainSlice.jpg'))); 
moving=imresize(fixed,0.7);
moving = imrotate(moving, 30, 'bilinear', 'crop');

subplot(2,1,1)
imagesc(moving);
colormap(gray)
