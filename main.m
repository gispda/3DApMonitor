close all;
clear all;
clc;
addpath('/home/gisphd/mexopencv');
addpath('/home/gisphd/mexopencv/opencv_contrib');

addpath data
addpath lib
addpath matGeom
addpath matGeom/polynomialCurves2d
addpath data/AirCraftMotion
addpath('/home/gisphd/project/AirCraftMotion')

PosLat = 32 + 51/60;   %北纬 32度51分
PosLon = 103 + 41/60; % 东经103度41分

airportZeroLat = 12.03/(60 * 60);
airportZeroLon = -5.01/(60*60);
airportZeroHight = 3448; %因为零点高，多减去23，方便计算

cameraPosLat = 24.41/(60 * 60);
cameraPosLon = 13.35/(60*60);
cameraPosHight = 3473; %因为零点高，多减去23，方便计算

w1PosLat = 13.67/(60 * 60)
w1PosLon = -0.19/(60*60)
w1PosHight = 3448+5.94


wtPosLat = 12.22/(60 * 60)
wtPosLon = 5.74/(60*60)
wtPosHight = 3448+5.94


RawData = csvread('00005498.csv');
%syms posWgs posImg;

posWgs = RawData(:,2:4);

posImg = RawData(:,5:6);

posWgs(:,1) = posWgs(:,1)/(60 * 60) +  PosLat;
posWgs(:,2) = posWgs(:,2)/(60 * 60) +  PosLon;

posairportZeroLat = airportZeroLat + PosLat;
posairportZeroLon = airportZeroLon + PosLon;

poscameraLat = cameraPosLat + PosLat;
poscameraLon = cameraPosLon + PosLon;

[x1,y1,utmzone1,utmhemi1] = wgs2utm(posWgs(:,1),posWgs(:,2));
[x0,y0,utmzone0,utmhemi0] = wgs2utm(posairportZeroLat,posairportZeroLon);
[xc,yc,utmzonec,utmhemic] = wgs2utm(poscameraLat,poscameraLon);


% posXY,ÒÔ»ú³¡ÁãµãÎª×ø±êµÄ»ú³¡×ø±êÏµ×ø±ê
posXYZ = [x1-x0,y1-y0,posWgs(:,3)-airportZeroHight];

posCameraXYZ = [xc-x0,-(yc-y0),cameraPosHight-airportZeroHight];


 crafttracks = csvread('crafttracks.csv');
 
 %M = estimateCameraPMatrix(posImg,posXYZ)

 posXYZ = [posXYZ;crafttracks(:,1:3)];
 
 posImg = [posImg;crafttracks(:,4:5)];
 
M = estimateCameraProjectionMatrix(posImg,posXYZ)
 
%t = posCameraXYZ'
[K,R,t] = estimate_KR_fromMT(M)

wxy = csvread('data/AirCraftMotion/crafttracks.csv')
%cap = cv.VideoCapture('data/AirCraftMotion/aircraft.avi');
craftimg = estimatepoints2D(wxy(:,1:3),K,R,t)

%pause(2); % Necessary in some environment. See help cv.VideoCapture
%assert(cap.isOpened(), 'Camera failed to initialized');

disp('開始飛機的三維重建.');

kernel = cv.getStructuringElement('Shape', 'Ellipse', 'KSize',[2,2]);
fgbg = cv.BackgroundSubtractorMOG();
stop = false;
frameidx = 1;
posnum = size(wxy,1);
for imgidx=100:999
  fname=strcat('/home/gisphd/project/AirCraftMotion/','00000',num2str(imgidx),'.ppm');
% while ~stop   
 % frame = cap.read();
 
  frame = imread(fname);
  %frame = cv.cvtColor(frame, 'BGR2GRAY');
  %if isempty(frame)
  %	stop = true;
  %else
  frame = cv.resize(frame,[1080,768], 'Interpolation','Cubic');
  frame_motion = cv.copyTo(frame);

%计算前景掩码
   fgmask = fgbg.apply(frame_motion);
    opts = { 'Type','Binary','MaxValue',255};
    draw1 = cv.threshold(fgmask,'Otsu',opts{:});
    draw1 = cv.dilate(draw1,'Element',kernel,'Iterations',2);
    drawcpy = cv.copyTo(draw1);
    [contours, hierarchy] = cv.findContours(drawcpy, ...
        'Mode','External', 'Method','Simple');
    contours_poly = cell(size(contours));
    boundRect = cell(size(contours));
    center = cell(size(contours));
    radius = zeros(size(contours));
    for i=1:numel(contours)
    % approximate to polygon with accuracy +/- 3 where curve must me closed
    contours_poly{i} = cv.approxPolyDP(contours{i}, ...
        'Epsilon',3, 'Closed',true);
    % find a bounding rect for polygon
    boundRect{i} = cv.boundingRect(contours{i});
    % find a minimum enclosing circle for polygon
    [center{i}, radius(i)] = cv.minEnclosingCircle(contours{i});
    end

%% Draw
% Draw polygonal contour + bonding rects + circles

%%% 計算得到飛機的坐標信息，反算到圖像坐標系，準備計算得到飛機機頭的圖像坐標系的圖像坐標，從而能夠得到質心坐標
   %wxy(frameidx,:);
   %wxy(frameidx,1);
   %wxy(frameidx,2);
    
    %craftpos = [wxy(frameidx) ]
    tempidx = mod(imgidx-100,25);
    
    if (tempidx == 0) && (frameidx <= posnum)
    craftimgpos = estimatepoints2D(wxy(frameidx,1:3),K,R,t);

    
   
   drawing = zeros([size(draw1) 3], 'uint8');

    clear headp;

   
    dmin = zeros(numel(contours),2);
    
    for i=1:numel(contours)
        
        polygonxy = celltoPointsMatrix(contours{i});
        headp(i).divpos = [-1 -1];
        headp(i).headpos = [-1 -1];
        headp(i).dmin = 9999;
        headp(i).view = false;
    
        headp(i).polygonxy = polygonxy; 
        
        if size(polygonxy,1)>=3 
       % dmin(i,1)= p_poly_dist(craftimgpos(:,1), craftimgpos(:,2), polygonxy(:,1), polygonxy(:,2));        
         %headp(i).dmin = p_poly_dist(craftimgpos(:,1), craftimgpos(:,2), polygonxy(:,1), polygonxy(:,2));        
          [headp.divpos, headp.dmin(i,1)] = projPointOnPolygon(craftimgpos,headp(i).polygonxy);
        elseif size(polygonxy,1)==2 
        headp(i).dmin=point_to_line_distance(craftimgpos, polygonxy(1,:), polygonxy(2,:));
        end

        headp(i).view = false;
        %dmin(i,2)=false;
        
       
    end
   %if ~isempty(dmin)
   if ~isempty(headp)
     %dmin = sort(dmin,1);
     [nheadp,nheadpidx] = sort([headp.dmin])
     craftimgpos
     %dmin(1,1)
    
     %if dmin(1,1)>0
      %for i=1:12   
      for i=1:size(headp,1)
        if headp(i).dmin < 99
          headp(i).view=true;
        end
      end
  
    % end
  end
  for i=1:numel(contours)
       
       
        clr = randi([0 255], [1 3], 'uint8');
        if headp(i).view
        drawing = cv.drawContours(drawing, contours, ...
            'Hierarchy',hierarchy, 'ContourIdx',i-1, 'MaxLevel',0, ...
            'Color',clr, 'Thickness',2, 'LineType',8);
        end
    end

  %imshow(draw1);

  imshow(drawing);  
  %imshow(frame);
  frameidx = frameidx + 1;
 
  end % end tempidx ==0 
  end % end for imgidx = 100:1000
 % end %end while ~stop
  
  

