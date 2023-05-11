img = imread('rosa.jpg');
%image(img)

%function method for rezising image
img2 = imresize(img,[64 64]);

%image(img2);
%grey color
img3 = imresize(img2,[1024 1024],"bicubic");
img4 = imresize(img2,[1024 1024],"bilinear");
img5 = imresize(img2,[1024 1024],"nearest");

image(img3)

subplot(1,3,1)
image(img3)
subplot(1,3,2)
image(img4)
subplot(1,3,3)
image(img5)

%figure
resta = img3 - img4;
imagesc(resta)
colormap(gray);



