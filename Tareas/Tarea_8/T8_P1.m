clear all;
close all;
load data_points.mat

[r,c,p] = size(data);
points = zeros(0,2);

index = 1;

for i = 1:r
    for ip = 1:p
       
        points(index,1) = data(i,1,ip);
        points(index,2) = data(i,2,ip);
        index = index + 1;
    end
end

plot(points(:,1),points(:,2), 'o')