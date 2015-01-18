    disp('Please enter complete path to image source directory: ') %ask user to give exact directory of image location
    user_input = input('');
    
    user_input1 = strcat(user_input,'*.jpg'); 
    allFiles = dir(user_input1);
    allTemplates = dir('template/*.jpg');
    str = '';
    filename = 'result.txt';
    imgCount = 0; 
    
    fid = fopen(filename, 'w'); %writing to the output text file 
    if fid < 3
        disp('Could not open file!');
    end
   
    if fid >= 3
    disp('Script is running...');
    disp('Processing Images...');
    disp('Locating Signs...');
    
    for i = 1 : length(allFiles) %for each image in the directory
        file = strcat(user_input, allFiles(i).name); 

        y = imread(file); 
        yg = rgb2gray(y); %convert to grayscale
        count = 0;

        for j = 1 :length(allTemplates) %for each TEMPLATE perform task of SURF detection 
            file1 = strcat('template/',allTemplates(j).name);
            x = imread(file1); %template sign
            xg = rgb2gray(x);   %converted to grayscale
            signPoints = detectSURFFeatures(xg);
            scenePoints = detectSURFFeatures(yg);
            [signFeatures,signPoints] = extractFeatures(xg, signPoints);
            [sceneFeatures, scenePoints] = extractFeatures(yg, scenePoints);
            signPairs = matchFeatures(signFeatures, sceneFeatures);

            matchedSignPoints = signPoints(signPairs(:, 1), :);
            matchedScenePoints = scenePoints(signPairs(:, 2), :);

            if size(matchedScenePoints.Location,1) < 1 %if no points detected,
                continue; %next image
            end 
            
            count = count+1; %counter that determines the number of templates that found a sign match
           
        end; %end of inner for loop
        
        totalPointsX = 0.0; 
        totalPointsY = 0.0; 
        for k = 1: length(matchedScenePoints) %loop to determine one particular location in the image for the purpose of output file
            point =  matchedScenePoints(k).Location;
            totalPointsX = totalPointsX + point(1);
            totalPointsY = totalPointsY + point(2);
        end
        
        averageX = totalPointsX/length(matchedScenePoints); % point is determined by taking the AVERAGE x and y coordinates of all matched points
        averageY = totalPointsY/length(matchedScenePoints); 
        
        if count>6 %setting our threshold to check if 6 or more templates find the sign in image
             disp(strcat('Sign FOUND in :', allFiles(i).name));             
             fprintf(fid, '%s\r', strcat(str,'>>>',' ', allFiles(i).name,' : x =',num2str(averageX), ', y =', num2str(averageY)));
             %figure;
             %showMatchedFeatures(xg, yg, matchedSignPoints, matchedScenePoints, 'montage');
             imgCount = imgCount+1; 
        end

    end %end of outside for loop
   
            fclose(fid);
            disp('DONE!');
  
    end %match with if fid >= 3