clear all;
close all;

load data_points.mat
directory = 'Im_Faces';
Files=dir(strcat(directory,'/*.pgm'));
[rows,columns,points] = size(data);

%image reference
refImage = imread(strcat(directory,'/',Files(1).name));

%Points
index_fixed_points = 1;
fixedPoints = zeros(0,2);

for ip = 1:points
    fixedPoints(index_fixed_points,1) = data(1,1,ip);
    fixedPoints(index_fixed_points,2) = data(1,2,ip);
    index_fixed_points = index_fixed_points + 1;
end
   
PosError = zeros(rows, 1);

for i = 1:rows
    %iterate for image registration
    regImage = imread(strcat(directory,'/',Files(i).name));
        
    %Points
    movingPoints = zeros(0,2);
    index_points = 1;

    for ip = 1:points
        movingPoints(index_points,1) = data(i,1,ip);
        movingPoints(index_points,2) = data(i,2,ip);
        index_points = index_points + 1;
    end

    tform = fitgeotrans(movingPoints,fixedPoints,'affine'); 
    Roriginal = imref2d(size(refImage));
    recovered = imwarp(regImage,tform,'OutputView',Roriginal);
      
    %error
    movedPoints = transformPointsForward(tform, movingPoints);
    distance = sqrt(sum((fixedPoints - movedPoints).^2, 2));
    PosError(i) = sum(distance);

end

[errorPoint, errorIndex] = sort(PosError);
%index of the original data with calculate error
selectBest = errorIndex(1:100);

pointsDistribution = zeros(0,2);
ipoints = 1;

for i = 2:100
    index = selectBest(i);

    for ip = 1:points
       
        pointsDistribution(ipoints,1) = data(index,1,ip);
        pointsDistribution(ipoints,2) = data(index,2,ip);
        ipoints = ipoints + 1;
    end
end

plot(pointsDistribution(:,1),pointsDistribution(:,2), 'o')