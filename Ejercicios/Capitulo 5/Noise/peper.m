I = imread('eight.tif');
J = imnoise(I,'salt & pepper', 0.02);
figure, imshow(I), figure, imshow(J)