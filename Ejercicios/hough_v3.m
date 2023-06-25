clear all
close all

I = imread('coins.png');

% Create a binary image.
BW = edge(I, 'canny');

% Define the radius range for circles you want to detect.
radiusRange = [20, 40]; % Adjust the range as needed.

% Initialize the accumulator array.
[rows, cols] = size(BW);
accumulator = zeros(rows, cols, radiusRange(2));

% Define the threshold for circle detection.
threshold = 0.8 * max(accumulator(:)); % Adjust the threshold as needed.

% Perform the Hough Circle Transform.
[rows, cols] = size(BW);
for r = radiusRange(1):radiusRange(2)
    for x = 1:cols
        for y = 1:rows
            if BW(y, x) == 1
               for theta = 1:360
                    a = round(x - r * cos(theta * pi / 180));
                    b = round(y - r * sin(theta * pi / 180));
                    
                    if a >= 1 && a <= cols && b >= 1 && b <= rows
                        accumulator(b, a,  r - radiusRange(1) + 1) = accumulator(b, a , r - radiusRange(1) + 1) + 1;
                    end
                end
            end
        end
    end
end

% Find circle centers with high accumulator values.
[yC, xC, rC] = find(accumulator >= threshold);

circles = zeros(length(rC), 3);

for n = 1:length(rC)
    [~, maxIndex] = max(accumulator(:));
    [y, x, rIndex] = ind2sub(size(accumulator), maxIndex);
    r = rIndex + radiusRange(1) - 1;
    circles(n, :) = [x, y, r];
    accumulator(y, x, rIndex) = 0; % Remove the detected circle from the accumulator
end

% Plot the original image with detected circles.
figure, imshow(I), hold on
for n = 1:length(rC)
    x = circles(n, 1);
    y = circles(n, 2);
    r = circles(n, 3);
    theta = linspace(0, 2*pi, 100);
    circleX = x + r * cos(theta);
    circleY = y + r * sin(theta);
    plot(circleX, circleY, 'LineWidth', 2, 'Color', 'cyan');
end
