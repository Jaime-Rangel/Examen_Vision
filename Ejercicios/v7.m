clear all
close all

I  = imread('coins.png');

% Create a binary image.
BW = edge(I,'canny');

% Define the radius range for circles to be detected.
minRadius = 20;
maxRadius = 30;

[rows, cols] = size(BW);

% Define the accumulator matrix.
accumulator = zeros(rows, cols, maxRadius);

% Iterate over the binary image.
for x = 1:size(BW, 2)
    for y = 1:size(BW, 1)
        %Iterare if there's an edge in the image
        if BW(y, x) == 1
            % Iterate over possible radii.
            for r = minRadius:maxRadius
                % Iterate over possible center coordinates.
                for theta = 1:360
                    
                    a = round(x - r * cos(theta * pi / 180));
                    b = round(y - r * sin(theta * pi / 180));
                    
                    % Check if the center coordinates are within the image boundaries.
                    if a >= 1 && a <= size(BW, 2) && b >= 1 && b <= size(BW, 1)
                        % Increment the accumulator at the specified center and radius.
                        accumulator(b, a, r) = accumulator(b, a, r) + 1;
                    end
                end
            end
        end
    end
end

%Find the peaks in the accumulator matrix.
numPeaks = 40;
peaks = [];

for i = 1:numPeaks
    [maxValue, maxIndex] = max(accumulator(:));
    [y, x, r] = ind2sub(size(accumulator), maxIndex);
    peaks = [peaks; x, y, r];
    accumulator(y, x, r) = 0; % Clear the peak to find the next one.
end

% Plot the original image with the detected circles.
figure, imshow(I), hold on

for i = 1:size(peaks, 1)
    x = peaks(i, 1);
    y = peaks(i, 2);
    r = peaks(i, 3);
    
    % Plot the circle.
    theta = linspace(0, 2 * pi, 100);
    xPos = x + r * cos(theta);
    yPos = y + r * sin(theta);
    plot(xPos, yPos, 'LineWidth', 2, 'Color', 'red');
end

figure, imshow(I),
