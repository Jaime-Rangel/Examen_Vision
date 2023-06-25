clear all;
close all;

I = imread('cell.tif');
imshow(I)

gaborBank = gabor([4 8],[0 90]); 
gaborMag = imgaborfilt(I,gaborBank); 
figure
subplot(2,2,1);

for p = 1:4
    subplot(2,2,p)
    imshow(gaborMag(:,:,p),[]);
    theta = gaborBank(p).Orientation;
    lambda = gaborBank(p).Wavelength; 
    title(sprintf('Orientation=%d, Wavelength=%d',theta,lambda));
end

Imagesc(real(gaborBank(3).SpatialKernel))