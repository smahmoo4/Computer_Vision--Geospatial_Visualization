
%give the image into colorDetect
%calculates the HSV of the image and 
%calls the findWater function to detect
%the blue hues

function map= colorDetect(rgbImage)
hsv=rgb2hsv(rgbImage);
      BW=false;
      BW=BW|findWater(hsv);
BW = imclose(BW,ones(5));

for ii=3:-1:1
   Q=regionprops(BW,rgbImage(:,:,ii),'MeanIntensity');
     cmap(:,ii)=vertcat(Q.MeanIntensity)/255;
end
map=label2rgb(bwlabel(BW),cmap,'k');


%function to locate blue hue in the original image
function bw=findWater(hsv)
   vthresh=.001; 
   H=hsv(:,:,1);
   S=hsv(:,:,2);
   V=hsv(:,:,3);
   Vbin=V>=vthresh;
   
   %blue hue values
   Hbin=abs(H-.55)<=.1;
   Sbin=S>=.5;
   bw=Hbin&Sbin&Vbin;