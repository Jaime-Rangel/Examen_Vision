I = imread('cameraman.tif');

S = edge(I,"sobel");
C = edge(I,"canny");
figure, imshow(S);
figure, imshow(C);
