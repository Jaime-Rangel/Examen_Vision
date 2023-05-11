
%----------------------------------------------------------
fabric = imread('fabric.png');
%figure(1), imshow(fabric), title('fabric');

%----------------------------------------------------------
load regioncoordinates;

nColors = 6;
sample_regions = false([size(fabric,1) size(fabric,2) nColors]);

for count = 1:nColors
  sample_regions(:,:,count) = roipoly(fabric,region_coordinates(:,1,count),...
                                      region_coordinates(:,2,count));
end

%imshow(sample_regions(:,:,2)),title('sample region for red');


%----------------------------------------------------------

lab_fabric = rgb2lab(fabric);

% For RGB color space
space_r = fabric(:,:,1);
space_g = fabric(:,:,2);
space_b = fabric(:,:,3);

%----------------------------------------------------------
a = lab_fabric(:,:,2);
b = lab_fabric(:,:,3);
color_markers = repmat(0, [nColors, 2]);

for count = 1:nColors
  color_markers(count,1) = mean2(space_r(sample_regions(:,:,count)));
  color_markers(count,2) = mean2(space_g(sample_regions(:,:,count)));
  color_markers(count,3) = mean2(space_b(sample_regions(:,:,count)));
end

%----------------------------------------------------------
disp(sprintf('[%0.3f,%0.3f]',color_markers(2,1),color_markers(2,2)));

%----------------------------------------------------------

color_labels = 0:nColors-1;

%----------------------------------------------------------

space_r = double(space_r);
space_g = double(space_g);
space_b = double(space_b);
distance = repmat(0,[size(space_r), nColors]);

%----------------------------------------------------------

for count = 1:nColors
 distance(:,:,count) = ((space_r - color_markers(count,1)).^2 + ...
                        (space_g - color_markers(count,2)).^2 + ...
                        (space_b - color_markers(count,3)).^2).^0.5;
end

[value, label] = min(distance,[],3);
label = color_labels(label);
clear value distance;

%--------------- Classification ---------------------------

rgb_label = repmat(label,[1 1 3]);
segmented_images = repmat(uint8(0),[size(fabric), nColors]);

for count = 1:nColors
  color = fabric;
  color(rgb_label ~= color_labels(count)) = 0;
  segmented_images(:,:,:,count) = color;
end

imshow(segmented_images(:,:,:,2)), title('red objects');

%----------------------------------------------------------
imshow(segmented_images(:,:,:,3)), title('green objects');

%----------------------------------------------------------
imshow(segmented_images(:,:,:,4)), title('purple objects');

%----------------------------------------------------------
imshow(segmented_images(:,:,:,5)), title('magenta objects');

%----------------------------------------------------------
imshow(segmented_images(:,:,:,6)), title('yellow objects');

%----------------------------------------------------------
purple = [119/255 73/255 152/255];
plot_labels = {'k', 'r', 'g', purple, 'm', 'y'};

%figure
% for count = 1:nColors
%   plot(a(label==count-1),b(label==count-1),'.','MarkerEdgeColor', ...
%        plot_labels{count}, 'MarkerFaceColor', plot_labels{count});
%   hold on;
% end

%title('Scatterplot of the segmented pixels in ''a*b*'' space');
%xlabel('''a*'' values');
%ylabel('''b*'' values');

%----------------------------------------------------------