clear all
W = [-1,-1,-1;1,8,-1;-1,-1,-1];

I = imread("Fig3.35(a).jpg");
I = double(I);

w=fspecial('log',[20 20],10);
O = imfilter(I,w);
