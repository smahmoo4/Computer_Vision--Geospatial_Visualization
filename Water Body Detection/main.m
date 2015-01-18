im= imread('img4.png');

%run function on image
pic = colorDetect(im);

%convert to black and white
bw = im2bw(pic,.01);
hcsc = vision.ColorSpaceConverter;
hcsc.Conversion = 'RGB to intensity';
hautothresh = vision.Autothresholder;

%using structuring element to paint over remaining water pixels
se =  strel('square',5);
img = imclose(bw, se); 

%adding bounding box for each body
stats = regionprops(logical(img),'Area','Centroid','Perimeter','BoundingBox');
BoundingBox=cat(1,stats.BoundingBox);

%store the final result
mask = false(size(img,1),size(img,2));

for i = 1:size(BoundingBox,1) %for each box... do 

    %Initialize a mask representing each bounding box
    mask2 = false(size(img,1),size(img,2));

    % Get the coordinates of a box
    y1 = round(BoundingBox(i,1));
    y2 = y1 + round(BoundingBox(i,3))-1;
    x1 = round(BoundingBox(i,2));
    x2 = x1 + round(BoundingBox(i,4))-1;
    
    %create the mask
    mask2(x1:x2,y1:y2) = true;
    mask = mask + imdilate(edge(mask2,'sobel'),strel('square',1));
end

%Get box around the original waterbodies
mask = mask + img;
figure,imshow(mask);