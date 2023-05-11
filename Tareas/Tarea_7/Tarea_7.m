close all;
clear all;
% Define parameters
amplitude = 1;
frequency = 0.1; 
image_size = 680;

% Generate meshgrid
[X, Y] = meshgrid(1:image_size, 1:image_size);

% Compute radial circular function
radius = sqrt((X - image_size/2).^2 + (Y - image_size/2).^2);
circular_function = amplitude * sin(2 * pi * frequency * radius);

M=repmat(circular_function,1,1); % M+M’

% Display the circular function
subplot(2,1,1)
imagesc(M);
title('Radial Circular Function')
colormap(gray)

subplot(2,1,2)
F=fft2(circular_function);
F2=fftshift(F);
imagesc(abs(F2))