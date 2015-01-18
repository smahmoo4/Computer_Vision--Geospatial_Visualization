fileID = fopen('outLane.txt');
fileID2 = fopen('outBoundary.txt');
format long;
data = textscan(fileID, '%f %f %f '); 
data2 = textscan(fileID2, '%f %f %f');
fclose(fileID);
fclose(fileID2);

    figure, scatter3(data{1},data{2},data{3},36,'.','k');hold on; 
    scatter3(data2{1},data2{2},data2{3},36,'.','r'); view(0,90);