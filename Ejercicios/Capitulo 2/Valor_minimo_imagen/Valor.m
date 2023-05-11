clear all
close all

I = imread('Fig2.21(a).jpg');

[rows,cols] = size(I);
minimo = 255;
x = 0;
y = 0;

for i = 1:rows
    for j = 1:cols
        val = I(i,j);
        if val < minimo
            minimo = val;
            x = i; y = j;
        end
    end
end

disp(minimo)
disp(x);disp(y)

% [r,c]=find(I==min(I(:)));
% 
% disp(r);disp(c)


