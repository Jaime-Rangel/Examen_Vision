I = imread('coins.png');

level = graythresh(I);

BW = imbinarize(I,level);
imshowpair(I,BW,'montage')