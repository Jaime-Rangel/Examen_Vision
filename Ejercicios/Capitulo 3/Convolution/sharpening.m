clear all;
close all;
W = [-1,-1,-1;1,8,-1;-1,-1,-1];
%W = [1,1,1;1,1,1;1,1,1];

I = imread("Fig3.35(a).jpg");
O = imread("Fig3.35(a).jpg");
I = double(I);

[rows,cols] = size(I);
g = zeros(rows,cols);

for i = 2: rows - 1
    for j = 2: cols - 1
        I2 = I(i-1:i+1,j-1:j+1);
%         g(i,j) = sum(sum(w. * I2);
          g(i,j) = W(1,1)*I2(1,1)+W(1,2)*I2(1,2)+W(1,3)*I2(1,3) + W(2,1)*I2(2,1)+W(2,2)*I2(2,2)+W(2,3)*I2(2,3) + W(3,1)*I2(3,1)+W(3,2)*I2(3,2) + W(3,3)*I2(3,3);
    end
end

%Convolucion +  laplace
L = g + I;
%imagesc(L)
subplot(1,2,1)
imagesc(O)
colormap("gray")
subplot(1,2,2)
imagesc(L)
colormap("gray")

% W = [0,1,0;1,-4,1;0,1,0];
% k = imfilter(I,W,'conv','replicate');
% imagesc(k)
% colormap("gray")
