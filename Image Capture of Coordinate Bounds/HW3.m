x = imread('img.jpg'); 
[centers, radii] = imfindcircles(x,[5 8],'ObjectPolarity','dark','Sensitivity',.90);
imshow(x); %shows the detected points 
h = viscircles(centers,radii);

%sortrows sorts points based on x(1) or y(2)
sortCenters = sortrows(centers,2);
%disp(sortCenters);
sortCentersX = sortrows(centers,1); 

%(xCord,yCord) is the top left point or the starting point of the crop
xCord = sortCentersX(1,1); 
yCord = sortCenters(1,2); 

%width is the distance between two x coordinates 
width = abs(sortCenters(1,1) - sortCenters(2,1));

%height is the distance between two y coordinates
height = abs(sortCenters(1,2) - sortCenters(3,2)); 

%cropping here
croppedImage = imcrop(x,[xCord yCord width height]);

imwrite(croppedImage, 'output_img.jpg');%output bounding box image to current working directory

%final image bounding box
figure, imshow(croppedImage); 
