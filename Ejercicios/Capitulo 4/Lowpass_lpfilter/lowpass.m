I = double(imread('Fig3.35(a).jpg'));
F = fft2(I);
F2 = fftshift(F);
H = lpfilter ('gauss',500,500,50);
F3=F2.*H;
F4=ifftshift(F3);
f5=ifft2(F4);
subplot(2,1,1)
imagesc(I);
colormap("gray")
subplot(2,1,2)
imagesc(real(f5));
colormap("gray")


% I=double(imread('fig3.35(a).jpg'));
% F=fft2(I);
% F2=fftshift(F);
% H = lpfilter ('btw',500,500,5,2);
% F3=F2.*(1-H);
% F4=ifftshift(F3);
% f5=ifft2(F4);
% subplot(2,1,1)
% imagesc(I);
% colormap("gray")
% subplot(2,1,2)
% imagesc(real(f5));
% colormap("gray")

