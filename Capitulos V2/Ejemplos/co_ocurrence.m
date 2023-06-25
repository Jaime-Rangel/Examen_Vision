I = imread('cell.tif');

imshow(I)
glcm = graycomatrix(I,'Offset',[2 0]);
stats = graycoprops(glcm);