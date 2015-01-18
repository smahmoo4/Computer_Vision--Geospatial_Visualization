disp('Please enter complete path to image source directory: ') %ask user to give exact directory of image location
user_input = input('');

disp('Processing Images...');
disp('Generating Result...'); 
user_input1 = strcat(user_input,'*.jpg'); 

allFiles = dir(user_input1);  %specific directory
mask = zeros(2032,2032); %using black image equivalent to size of input images as mask,

empty = []; %an empty list needed to be created...
empty = mask; % ... to input the mask in; 

for i = 1 : length(allFiles) % for each image in specific directory... 
    file = strcat(user_input, allFiles(i).name); % store in variable file
    x = imread(file); %each file is iterated ...s
    toBinary = im2bw(x); %... and read/converted to binary
    empty = empty + toBinary; %modifying the original mask with the superpositiond images
end 

%empty is now a superposition of ALL images added to the original, but
%constantly changing mask

average = empty/length(allFiles); %taking the average of the superpositioned images
output = imcomplement(adapthisteq(average)); %not the image, and histogram equalize 'average'

imwrite(imresize(output, 0.75), 'output_img.jpg'); %output resulting binary image to current working directory
disp('Output Image was saved in current working directory with filename: output_img.jpg');
imshow('output_img.jpg'); 

