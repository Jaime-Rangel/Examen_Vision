clear all
close all

I  = imread('coins.png');

% Rotate the image.
rotI = imrotate(I,33,'crop');

% Create a binary image.
BW = edge(I,'canny');

% Create the Hough transform using the binary image.
[H,T,R] = hough(BW);
imshow(H,[],'XData',T,'YData',R,...
            'InitialMagnification','fit');
xlabel('\theta'), ylabel('\rho');
axis on, axis normal, hold on;

% Find peaks in the Hough transform of the image.
P  = houghpeaks(H,5,'threshold',ceil(0.3*max(H(:))));
x = T(P(:,2)); y = R(P(:,1));
plot(x,y,'s','color','white');

% Find circles and plot them.
minRadius = 20; % Minimum radius of circles to detect.
maxRadius = 50; % Maximum radius of circles to detect.
sensitivity = 0.85; % Sensitivity threshold for circle detection.
circleThreshold = 0.5; % Threshold for considering a peak as a circle.

% Initialize variables to store detected circles.
centers = [];
radii = [];

% Iterate over radius range and Hough transform peaks to detect circles.
for r = minRadius:maxRadius
    for i = 1:size(P, 1)
        theta = T(P(i, 2));
        rho = R(P(i, 1));
        
        % Convert Hough coordinates to image coordinates.
        xCenter = rho * cosd(theta);
        yCenter = rho * sind(theta);
        
        % Calculate the gradient direction histogram for the circle region.
        circleRegion = getCircleRegion(BW, xCenter, yCenter, r);
        gradientHistogram = calculateGradientHistogram(circleRegion);
        
        % Check if the peak in the histogram corresponds to a circle.
        peakValue = max(gradientHistogram);
        if peakValue > circleThreshold
            centers = [centers; xCenter, yCenter];
            radii = [radii; r];
        end
    end
end

% Plot the detected circles.
figure, imshow(I), hold on
viscircles(centers, radii, 'EdgeColor', 'b');

% Helper function to extract the circular region from the binary image.
function circleRegion = getCircleRegion(BW, xCenter, yCenter, radius)
    imageSize = size(BW);
    [xGrid, yGrid] = meshgrid(1:imageSize(2), 1:imageSize(1));
    
    circleMask = ((xGrid - xCenter).^2 + (yGrid - yCenter).^2) <= radius^2;
    circleRegion = BW & circleMask;
end

% Helper function to calculate the gradient direction histogram.
function gradientHistogram = calculateGradientHistogram(image)
    sobelX = [-1 0 1; -2 0 2; -1 0 1];
    sobelY = sobelX';
    
    gradientX = conv2(double(image), sobelX, 'same');
    gradientY = conv2(double(image), sobelY, 'same');
    
    gradientDirection = atan2(gradientY, gradientX);
    gradientDirection(gradientDirection < 0) = gradientDirection(gradientDirection < 0) + pi;
    
    binEdges = 0:pi/8:pi;
    gradientHistogram = histcounts(gradientDirection(:), binEdges);
end
