function [highHeight, lowHeight, heightValue, BWs] = HeightEstimate(im, th)
%Estimate the height of the person
%input: im, image
%       th, threshold for gradient
%output: highHeight, lowHeight, heightValue
  
%upper part for edge detection
   %based on gradient map
    tmp = rgb2gray(im); %convert RGB image to grayscale
    [row col] = size(tmp); %dimensions of the image
    [Gmag,Gdir] = imgradient(tmp); %return the gradient magnitude and gradient direction
    BWs = Gmag>th; %find pixels where Gmag > th, return 1, otherwise return 0
    [rowID colID] = find(BWs == 1); %locations where BWs = 1
    lowHeight = min(rowID); %pixel location on the top

%lower part based on ostu thresholding
    [row col] = size(tmp);
    [counts,x] = imhist(tmp,16); %typically set the histogram on 16 level
    T = otsuthresh(counts); %compute a global threshold T from counts
    BW = imbinarize(tmp,T); %convert the grayscale image to binary image using T, values above T are replaced by 1, others are set to 0
    [rowID colID] = find(BW == 0); %locations where BW = 0
    highHeight = max(rowID); %pixel locations on the bottom
    heightValue = highHeight - lowHeight;  %height value

end

