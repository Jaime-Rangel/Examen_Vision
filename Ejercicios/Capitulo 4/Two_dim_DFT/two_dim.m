I = imread('cameraman.tif'); sum(sum(I))
F=fft2(I);
F2=fftshift(F);
F2(129,129) 
subplot(2,1,1) 
imagesc(I) 
subplot(2,1,2) 
imagesc(log(abs(F2))) 
colormap(gray)