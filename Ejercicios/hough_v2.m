clear all
close all

I  = imread('coins.png');

% Rotate the image.
rotI = imrotate(I,33,'crop');

% Create a binary image.
BW = edge(I,'canny');

[height, width] = size(BW);

% Define the radius range for circle detection.
minRadius = 10;
maxRadius = 30;

% Define the step size for radius.
radiusStep = 1;

% Define the threshold for circle detection.
%threshold = 50;

% Define the number of circles to detect.
numCircles = 20;

% Initialize the accumulator array for the Hough circle transform.
[rows, cols] = size(BW);
accArray = zeros(rows, cols, maxRadius);

% Perform the Hough circle transform manually.
for r = minRadius:maxRadius
    for x = 1:cols
        for y = 1:rows
            if BW(y, x) == 1
               for theta = 1:360
                    a = round(x - r * cos(theta));
                    b = round(y + r * sin(theta));

                    if a >= 1 && a <= cols && b >= 1 && b <= rows
                        accArray(b, a, r - minRadius + 1) = accArray(b, a, r - minRadius + 1) + 1;
                    end
                end
            end
        end
    end
end

% Find the centers and radii of the detected circles.
centers = zeros(numCircles, 2);
radii = zeros(numCircles, 1);

% Find the circles with the highest accumulator values.
circles = zeros(numCircles, 3);
for n = 1:numCircles
    [~, maxIndex] = max(accArray(:));
    [y, x, rIndex] = ind2sub(size(accArray), maxIndex);
    r = rIndex + minRadius - 1;
    circles(n, :) = [x, y, r];
    accArray(y, x, rIndex) = 0; % Remove the detected circle from the accumulator
end


% Plot the original image with detected circles.
figure, imshow(I), hold on
for n = 1:numCircles
    x = circles(n, 1);
    y = circles(n, 2);
    r = circles(n, 3);
    theta = linspace(0, 2*pi, 100);
    circleX = x + r * cos(theta);
    circleY = y + r * sin(theta);
    plot(circleX, circleY, 'LineWidth', 2, 'Color', 'cyan');
end
