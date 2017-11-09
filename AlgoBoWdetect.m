


clc; clear all; close all;

I=imread('Culinary_fruits_front_view.jpg');

figure,imshow(I);

original=I;


scale = 1.3;
J = imresize(original, scale);

theta = 31;
distorted = imrotate(J,theta);
figure
imshow(distorted);


% Detect the features in both images. Use the BRISK detectors first, followed by the SURF detectors.
original=rgb2gray(original);
ptsOriginalBRISK  = detectBRISKFeatures(original,'MinContrast',0.01);
distorted=rgb2gray(distorted);

ptsDistortedBRISK = detectBRISKFeatures(distorted,'MinContrast',0.01);

ptsOriginalSURF  = detectSURFFeatures(original);
ptsDistortedSURF = detectSURFFeatures(distorted);

% Extract descriptors from the original and distorted images. 
% The BRISK features use the FREAK descriptor by default.

[featuresOriginalFREAK,validPtsOriginalBRISK]  = ...
        extractFeatures(original,ptsOriginalBRISK);
[featuresDistortedFREAK,validPtsDistortedBRISK] = ...
        extractFeatures(distorted,ptsDistortedBRISK);

[featuresOriginalSURF,validPtsOriginalSURF]  = ...
        extractFeatures(original,ptsOriginalSURF);
[featuresDistortedSURF,validPtsDistortedSURF] = ...
        extractFeatures(distorted,ptsDistortedSURF);
    
    
%     Determine candidate matches by matching FREAK descriptors first, and then SURF descriptors. To obtain as many feature matches as possible, start with detector and matching thresholds that are lower than the default values. Once you get a working solution, you can gradually increase the thresholds to reduce the computational load required to extract and match features.

indexPairsBRISK = matchFeatures(featuresOriginalFREAK,...
            featuresDistortedFREAK,'MatchThreshold',40,'MaxRatio',0.8);

indexPairsSURF = matchFeatures(featuresOriginalSURF,featuresDistortedSURF);
% Obtain candidate matched points for BRISK and SURF.

matchedOriginalBRISK  = validPtsOriginalBRISK(indexPairsBRISK(:,1));
matchedDistortedBRISK = validPtsDistortedBRISK(indexPairsBRISK(:,2));

matchedOriginalSURF  = validPtsOriginalSURF(indexPairsSURF(:,1));
matchedDistortedSURF = validPtsDistortedSURF(indexPairsSURF(:,2));
% Visualize the BRISK putative matches.

figure
showMatchedFeatures(original,distorted,matchedOriginalBRISK,...
            matchedDistortedBRISK)
title('Putative matches using BRISK & FREAK')
legend('ptsOriginalBRISK','ptsDistortedBRISK')


% % % Compare the original and recovered image.

outputView = imref2d(size(original));
% recovered  = imwarp(distorted,tformTotal,'OutputView',outputView);
% 
% figure;
% imshowpair(original,recovered,'montage')

disp('Count point with Scale less than zero');


featurePoints=validPtsOriginalSURF;

featurePointsScales=featurePoints.Scale;



myfeatures=featuresOriginalSURF;

[centers, assignments] = kmeans(double(myfeatures), 10);



