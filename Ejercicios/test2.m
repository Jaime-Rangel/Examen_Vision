clear all;clc;
I = imread('coins.jpg');
I =im2bw(I);
[y,x]=find(I);
[sy,sx]=size(I);
imshow(I);

totalpix = length(x);

HM = zeros(sy,sx,50);
R = 1:50;
R2 = R.^2;
sz = sy*sx;

for cnt = 1:totalpix
    for cntR = 1:50
        b = 1:sy;
        a = (round(x(cnt) - sqrt(R2(cntR) - (y(cnt) - [1:sy]).^2)));
        b = b(imag(a)==0 & a>0);
        a = a(imag(a)==0 & a>0);
        ind = sub2ind([sy,sx],b,a);
        HM(sz*(cntR-1)+ind) = HM(sz*(cntR-1)+ind) + 1;
    end
end

for cnt = 1:50
    H(cnt) = max(max(HM(:,:,cnt)));
end

[maxval, maxind] = max(H);
[B,A] = find(HM(:,:,maxind)==maxval);
imshow(I); hold on;
plot(mean(A),mean(B),'xr')
text(mean(A),mean(B),num2str(maxind),'color','green')
