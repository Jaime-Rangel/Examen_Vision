clear all
close all
I = imread("Fig3.45(a).jpg");
I = double(I);

gx = [-1,-2,-1;0,0,0;1,2,1];
gy = [-1,0,1;-2,0,2;-1,0,1];

[rows,cols] = size(I);
g1 = zeros(rows,cols);
g2 = zeros(rows,cols);


for i=2:rows-1
    for j=2:cols-1
        i2=I(i-1:i+1,j-1:j+1);
        % Se suman los extremos hasta i+1 y j+1 
        g1(i,j)=sum(sum(gx.*i2));
        g2(i,j)=sum(sum(gy.*i2));
    end
end

output = g1 + g2;
magnitud = sqrt(g1.^2+g2.^2);
direction = atan(g1 ./ g2);
deg = rad2deg(direction);

subplot(2,3,1)
imagesc(g1)
title('Gx')
colormap("gray");
subplot(2,3,2)
imagesc(g2)
title('Gy')
colormap("gray");
subplot(2,3,3)
imagesc(magnitud)
title('∇f')
colormap("gray");
subplot(2,3,4)
imagesc(deg)
title('θ')
colormap("gray");
subplot(2,3,5)
quiver(g1,g2)
title('magnitud and direction')
colormap("gray");

