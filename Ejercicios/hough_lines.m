clear all
close all

I  = imread('coins.png');

% Rotate the image.
rotI = imrotate(I,33,'crop');

% Create a binary image.
BW = edge(I,'canny');

% Define Hough circle parameters.
radiusRange = [10, 30];  % Range of circle radii to detect.
numCircles = 40;          % Number of circles to detect.

% Perform the Hough transform.
[height, width] = size(BW);
maxRadius = radiusRange(2);
accumMatrix = zeros(height, width, maxRadius + 1);

for y = 1:height
    for x = 1:width
        if BW(y, x) == 1
            for r = radiusRange(1):maxRadius
               for theta = linspace(0, 2*pi, 100)
                    a = round(x - r * cos(theta));
                    b = round(y - r * sin(theta));
                    if a >= 1 && a <= width && b >= 1 && b <= height
                        accumMatrix(b, a, r - radiusRange(1) + 1) = accumMatrix(b, a, r - radiusRange(1) + 1) + 1;
                    end
                end
            end
        end
    end
end

% Find the centers and radii of the detected circles.
centers = zeros(numCircles, 2);
radii = zeros(numCircles, 1);

for k = 1:numCircles
    [maxValue, maxIndex] = max(accumMatrix(:));
    [y, x, rIndex] = ind2sub(size(accumMatrix), maxIndex);
    centers(k, :) = [x, y];
    radii(k) = rIndex + radiusRange(1) - 1;
    
    % Set the accumulator values around the detected circle to zero.
    [X, Y] = meshgrid(1:width, 1:height);
    distFromCircle = sqrt((X - x).^2 + (Y - y).^2);
    accumMatrix(distFromCircle <= radii(k), :, :) = 0;
end

% Display the original image.
figure;
imshow(I);
title('Original Image');

% Display the detected circles.
figure;
imshow(I);
title('Detected Circles');
viscircles(centers, radii);
