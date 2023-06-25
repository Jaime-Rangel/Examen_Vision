function [centers, radii] = hough_circle_transform(image, radius_range, threshold)
    % Convert the image to grayscale
    if size(image, 3) > 1
        image = rgb2gray(image);
    end
    
    % Initialize the accumulator matrix
    accumulator = zeros(size(image));
    
    % Define the range of radii to search
    min_radius = radius_range(1);
    max_radius = radius_range(2);
    
    % Perform the Hough Circle Transform
    [rows, cols] = size(image);
    for y = 1:rows
        for x = 1:cols
            if image(y, x) > 0
                for radius = min_radius:max_radius
                    % Calculate the center coordinates for each radius
                    for theta = 0:pi/36:2*pi
                        a = round(x - radius * cos(theta));
                        b = round(y - radius * sin(theta));
                        
                        if a >= 1 && a <= cols && b >= 1 && b <= rows
                            accumulator(b, a) = accumulator(b, a) + 1;
                        end
                    end
                end
            end
        end
    end
    
    % Find the circle centers with votes above the threshold
    [y_centers, x_centers] = find(accumulator > threshold);
    
    % Get the corresponding radii for each center
    radii = zeros(size(x_centers));
    for i = 1:numel(x_centers)
        x = x_centers(i);
        y = y_centers(i);
        radii(i) = radius_range(1) + (radius_range(2) - radius_range(1)) * (accumulator(y, x) / max(accumulator(:)));
    end
    
    % Combine the center coordinates and radii into a single matrix
    centers = [x_centers, y_centers];
end
