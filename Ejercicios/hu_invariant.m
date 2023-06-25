clear all
close all

I = imread('A.jpg');
I=rgb2gray(I);

bw1 = I < 180;
bw1 = imtranslate(bw1,[10 20],'FillValues',0);
bw1 = imresize(bw1,0.7); 
bw2 = imrotate(bw1,31);
bw3 = imresize(bw2,1.3); 
bw3 = imtranslate(bw3,[-10 20],'FillValues',0);
bw3 = imrotate(bw3,-45);
bw4 = imresize(bw3,3); 
bw4 = imrotate(bw4,90);
bw4 = imtranslate(bw4,[200 100],'FillValues',0);

subplot(2,2,1)
imagesc(bw1)
subplot(2,2,2)
imagesc(bw2)
subplot(2,2,3)
imagesc(bw3)
subplot(2,2,4)
imagesc(bw4)
colormap(gray)


phi(1,:) = invmoments(bw1);
phi(2,:) = invmoments(bw2);
phi(3,:) = invmoments(bw3);
phi(4,:) = invmoments(bw4);

phi1=phi;

I = imread('B.jpg');
I=rgb2gray(I);

bw1 = I < 180;
bw1 = imtranslate(bw1,[-20 10],'FillValues',0);
bw1 = imresize(bw1,1.5); 
bw2 = imrotate(bw1,-40);
bw3 = imresize(bw2,0.5); 
bw3 = imtranslate(bw3,[10 -20],'FillValues',0);
bw3 = imrotate(bw3,45);
bw4 = imresize(bw3,3); 
bw4 = imrotate(bw4,-90);
bw4 = imtranslate(bw4,[200 100],'FillValues',0);

figure
subplot(2,2,1)
imagesc(bw1)
subplot(2,2,2)
imagesc(bw2)
subplot(2,2,3)
imagesc(bw3)
subplot(2,2,4)
imagesc(bw4)
colormap(gray)


phi(1,:) = invmoments(bw1);
phi(2,:) = invmoments(bw2);
phi(3,:) = invmoments(bw3);
phi(4,:) = invmoments(bw4);

phi2=phi;

figure
plot3(phi1(:,1),phi1(:,2),phi1(:,3),'ob')
hold on
plot3(phi2(:,1),phi2(:,2),phi2(:,3),'or')
grid on