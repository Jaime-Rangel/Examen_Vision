clear all
close all

f = zeros (101);

f (46:56,46:56) = 255;

subplot(2,2,1)
imagesc(f)

F = fft2(f);

subplot(2,2,2)
imagesc(abs(F))

F2=fftshift(F);

subplot(2,2,3)
imagesc(abs(F2))

F3=ifftshift(F2);

F4=ifft2(F3)

subplot(2,2,4)
imagesc(abs(F4))

colormap(gray)
