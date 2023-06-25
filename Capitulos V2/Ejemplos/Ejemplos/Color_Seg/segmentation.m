im = imread('peppers.png');

S = colorseg('EUCLIDEAN',im,25,[254,189,0]);

imagesc(S)