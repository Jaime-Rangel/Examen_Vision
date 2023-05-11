i = imread('Fig3.37(a).jpg');
g = imnoise(i,'salt & pepper',.25);

k = medfilt2(g,[7 7]);
f = adpmedian(g,7);

subplot(3,1,1)
%Image with noise
imagesc(g);
subplot(3,1,2)
imagesc(f);
subplot(3,1,3)
imagesc(k);
colormap("gray")
