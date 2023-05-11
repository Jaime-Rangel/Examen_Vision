img = imread('cameraman.tif');

[hog1,visualization] = extractHOGFeatures(img,'CellSize',[32,32]);
subplot(1,2,1);
imshow(img)
subplot(1,2,2);
plot(visualization)