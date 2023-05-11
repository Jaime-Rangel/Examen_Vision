close all;
clear all;
x = 1:120;

%Los ciclos 120 => 4 curvas
s = sin(x * pi / 30);

M = repmat(s,120,1);
%imagesc(M);
t = M + transpose(M);
%imagesc(t);

F = fft2(t);
F2 = fftshift(F);
imagesc(abs(F2))
colormap("gray");

F3 = F2;
