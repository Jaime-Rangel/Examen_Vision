clear all
close all

% Generate a test image using a sine wave
x = 1:120;
s = sin(x * pi / 15);
M = repmat(s, 120, 1);

% Show generated image
figure()
imagesc(M)
colormap("gray")
% title(['Original pattern image'], Interpreter='latex')

% Compute fourier transform and its inverse
F = fft2(M);
Finv = fftshift(F);

figure()
imagesc(abs(Finv))
colormap("gray")
% title(['Fast fourier transform'], Interpreter='latex')

% Find one value where the iff is not zero and use it to map it to a circle
maxiff = max(Finv(:));
miniff = min(Finv(:));

% x and y are the coordinates of the center of the circle
% r is the radius of the circle
% 0.01 is the angle step, bigger values will draw the circle faster but
% you might notice imperfections (not very smooth)
x = 0;
y = 0;
r = 0.4;
ang = 0:0.0001:2*pi;
xp = r*cos(ang);
yp = r*sin(ang);

figure()
f = plot(x+xp,y+yp);

% Make the plot and export it
ax = gca;
set(gca,'xtick',[])
set(gca,'ytick',[])
ax.XColor = 'black';
ax.YColor = 'black';
axis([-1 1 -1 1])
axis equal
xlim([-1 1])
ylim([-1 1])
exportgraphics(ax,'ring_pattern.jpg','Resolution',200)

% Import the plot and map maxiff and miniff into it
img = imread("ring_pattern.jpg");
img = rgb2gray(img);
[nrows, ncols] = size(img);

% Select an index to eliminate the borders of having exported the circle
% plot
borderindex = 8;
img(:,1:borderindex) = 255;
img(:,ncols-borderindex:ncols) = 255;
img(1:borderindex,:) = 255;
img(nrows-borderindex:nrows,:) = 255;
img = double(img);

for index = 1:(nrows * ncols)
    if sum(img(index) == 200:255) == 0
        img(index) = maxiff;
    else
        img(index) = miniff;
    end
end

G = ifft2(img);
G2 = ifftshift(G);
GReal = abs(G2);
% Show recovered image
figure;
imagesc(GReal)
% title(['Recovered droplet pattern'], Interpreter='latex')
ax = gca;
set(gca,'xtick',[])
set(gca,'ytick',[])
ax.XColor = 'none';
ax.YColor = 'none';
% axis([-1 1 -1 1])
axis equal
colormap("gray")
% xlim([-1 1])
% ylim([-1 1])
exportgraphics(ax,'recovered_pattern.png','Resolution',400)

% eof