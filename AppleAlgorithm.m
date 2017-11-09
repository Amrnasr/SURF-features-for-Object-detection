

clc; clear all; close all;


% 
% Detect SURF Interest Points in a Grayscale Image
% 
% Open Script
% Read image and detect interest points.




I = imread('apple.jpg');
Igray=rgb2gray(I);
points = detectSURFFeatures(Igray,'MetricThreshold' ,10);
% Display locations of interest in image.

imshow(I); hold on;
% plot(points.selectStrongest(20));
plot(points.selectStrongest(200));

% [centers, assignments] = kmeans(double(features), 100);

Loc=points.Location;

minx=min(Loc(:,1));
minx=floor(minx);

maxx=floor(max(Loc(:,1)));

miny=floor(min(Loc(:,2)));
maxy=floor(max(Loc(:,2)));


% You can also specify the size and position of the crop rectangle as parameters when you call imcrop. Specify the crop rectangle as a four-element position vector, [xmin ymin width height].
% 
% In this example, you call imcrop specifying the image to crop, I, and the crop rectangle. imcrop returns the cropped image in J.
% 
% I = imread('circuit.tif');

width=maxx-minx;
height=maxy-miny;
J = imcrop(I,[minx miny width height]);

figure,imshow(J);


RGB = insertShape(I,'Rectangle',[minx miny width height],'LineWidth',5);

figure,imshow(RGB);


