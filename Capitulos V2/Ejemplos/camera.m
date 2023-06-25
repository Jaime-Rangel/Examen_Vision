clear all;
close all;
camObject = webcam(1);


%preview(camObject)

%Adquire and display a single frame
while(true)
    img = snapshot(camObject);
    imshow(img)
    
    BW = edge(rgb2gray(img),'canny');
    figure, 
    imshow(BW)
end

clear camObject;

