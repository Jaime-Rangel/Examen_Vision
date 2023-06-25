% Read the image
image = imread('coins.png');

% Convert the image to grayscale
BW = edge(I, 'canny');

% Parameters for circle detection
radiusRange = [10 30]; % Range of possible circle radii
threshold = 0.4; % Threshold for circle detection

% Apply the Hough Circle Transform
[height, width] = size(BW);
accumulator = zeros(height, width, diff(radiusRange)+1);
radii = radiusRange(1):radiusRange(2);
numRadii = numel(radii);

% Calculate gradient magnitude of the image
gradientImage = imgradient(BW);

% Perform the Hough Circle Transform
for r = 1:numRadii
    radius = radii(r);
    theta = linspace(0, 2*pi, 360);
    x = radius * cos(theta);
    y = radius * sin(theta);
    x = round(x);
    y = round(y);
    numPoints = numel(x);
    
    for i = 1:numPoints
        cx = x(i);
        cy = y(i);
        if cx > 0 && cx <= width && cy > 0 && cy <= height
            x0 = cx + x;
            y0 = cy + y;
            validIndices = x0 > 0 & x0 <= width & y0 > 0 & y0 <= height;
            x0 = x0(validIndices);
            y0 = y0(validIndices);
            gradientValues = gradientImage(y0 + (x0-1)*height);
            accumulator(y0 + (x0-1)*height + (r-1)*height*width) = ...
                accumulator(y0 + (x0-1)*height + (r-1)*height*width) + gradientValues;
        end
    end
end

% Find the peaks in the accumulator
[~, sortedIndices] = sort(accumulator(:), 'descend');
sortedIndices = sortedIndices(1:ceil(numel(sortedIndices) * threshold));

% Retrieve the centers and radii of the detected circles
[cy, cx, cr] = ind2sub(size(accumulator), sortedIndices);
centers = [cx, cy];
radii = radii(cr);

% Display the detected circles
imshow(image);
viscircles(centers, radii, 'EdgeColor', 'b');
