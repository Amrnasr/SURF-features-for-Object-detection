


clc; clear all; close all;

shapeInserter = vision.ShapeInserter;
% 
% Detect SURF Interest Points in a Grayscale Image
% 
% Open Script
% Read image and detect interest points.




I = imread('orange.jpg');


Igray=rgb2gray(I);

[m,n]=size(Igray);
disp('Image Width is ');
disp(m);
disp('Image Height is ');
disp(n);


points = detectSURFFeatures(Igray,'MetricThreshold' ,10);
% Display locations of interest in image.

imshow(I); hold on;
% plot(points.selectStrongest(20));
plot(points.selectStrongest(200));


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





J = imcrop(I,[minx miny width height]);

figure,imshow(J);


RGB = insertShape(I,'Rectangle',[minx miny width height],'LineWidth',5);

figure,imshow(RGB);

Strongpoints=points.selectStrongest(20);

imshow(I); hold on;
% plot(points.selectStrongest(20));
plot(Strongpoints);
% 
% figure,imshow

title('Best Points');

Strongpoints=points.selectStrongest(5);

imshow(I); hold on;
% plot(points.selectStrongest(20));
plot(Strongpoints);
% 
% figure,imshow

title('Best of the best Points');




for ii=1:size(Strongpoints,1)
    
   disp(ii) 
   PositionsX=Strongpoints.Location(:,1);
   PositionsY=Strongpoints.Location(:,2);
   
   disp(Strongpoints.Location(:,1));
   disp(Strongpoints.Location(:,2));
    
end


for ii=1:size(Strongpoints,1)
    
   
   PosX=Strongpoints.Location(ii,1);
   PosY=Strongpoints.Location(ii,2);
   
   
   if( PosX<12 || PosX>width)
     break;
   end
   
    if( PosY<26 || PosY>height)
     break;
    end
   
    Posxdelta1=PosX-25;
    Posydelta2=PosY-25;
    
    if( Posxdelta1<1 || Posxdelta1>width)
     break;
    end
    
    if( Posydelta2<1 || Posydelta2>height)
     break;
    end
    
    disp('Position X is ');
    disp(PosX);
    disp('Position Y is ');
    disp(PosY);
    
    rectangle1 = int32([Posxdelta1 Posydelta2 50 50]);
    J = shapeInserter(I, rectangle1);
    imshow(J);

   pause(3);
end



% rectangle1 = int32([10 10 30 30]);
% rectangle2 = int32([20 20 30 30;10 10 30 30]);
% %%Draw the rectangle and display the result.
% 
% J = shapeInserter(I, rectangle1);
% J = shapeInserter(I, rectangle2);
% imshow(J);
% 
% 
% 
% 
% 





