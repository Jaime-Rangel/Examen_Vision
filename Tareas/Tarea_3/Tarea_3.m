clear
close all

img = imread('Fig2.21(a).jpg');
figure
m = 1;

%image(img);
xlabel(num2str(2^8));

for i = 4:-1:1

    %Powers of 2
    l = 2^i;
    %Gray levels (16,8,4 and 2)
    q_size = 256/(l);
    subplot(2,2,m);

    %Here we divide the function with the real values decimals
    Q = floor(double(img)/q_size) * q_size + (q_size/2);
    image(Q);

    colormap(gray)
    xlabel(num2str(l));

    m = m + 1;
end