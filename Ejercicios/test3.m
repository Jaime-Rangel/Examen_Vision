image = imread('coins.jpg');
grayImage = rgb2gray(image);

edgeImage = edge(grayImage, 'Canny');

[H, theta, rho] = hough(edgeImage);

peaks = houghpeaks(H, numPeaks);

circles = houghcircles(edgeImage, rho, theta, peaks);

imshow(image);
hold on;
viscircles(circles(:, 1:2), circles(:, 3), 'EdgeColor', 'r');
hold off;


