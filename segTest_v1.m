%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% segmentation with Ostu thresholding
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc, clear, close all
tic %start stopwatch timer
f = filesep; %return the file separator character for this platform
%folder where the source data is stored
%path = ['C:\MATLAB Work\Nguyen\Project\data\']; 
path = '.\data\';
%output folder
output_path = ['.\output\Two_measure'];
if exist(output_path) ~= 7 %if the folder does not exist (return value not equal to 7)
   mkdir(output_path) %make directory
end

%index all jpg images
img_dir = dir(fullfile(path, '**\*.jpg')); %list folder contents
HeightMode = 1; %plot the height in the image
%parameters to determine the height
th_Top = 100;  %threshold to determine the upper limit of the height

for i = 1:length(img_dir)
%estimate height first

   im = imread([img_dir(i).folder '\' img_dir(i).name]); %read images from the folder
   [highHeight, lowHeight, heightValue, BWs] = HeightEstimate(im, th_Top); %call function
   [row col three] = size(im);
    
   %%
   %plot
   figure(1), imshow(im), hold on %create figure window
   if HeightMode == 1
       line([1 col], [lowHeight lowHeight], 'color', 'red'), %create a line at the top 
       line([1 col], [highHeight highHeight], 'color', 'red'), %create a line at the bottom
       line([round(col/2) round(col/2)], [lowHeight highHeight], 'color', 'red', 'linestyle', '--') %create a vertical line at the middle
       text(round(col/2),lowHeight+(highHeight - lowHeight)/2, [num2str(heightValue) ' pixels'], 'color', 'red') %output value
   end
   outputName = [output_path '\' img_dir(i).name]; 
   print(gcf,'-dtiff', outputName)
   close all
end
toc %read the stopwatch timer