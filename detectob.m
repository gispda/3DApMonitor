%% Code
addpath('/home/gisphd/mexopencv');
addpath('/home/gisphd/mexopencv/opencv_contrib');
%addpath('/home/gisphd/mexopencv/+cv');

addpath data
addpath data/video


cap = cv.VideoCapture('data/video/aircraft.avi');

pause(2); % Necessary in some environment. See help cv.VideoCapture
assert(cap.isOpened(), 'Camera failed to initialized');




% im = cap.read();
% assert(~isempty(im), 'Failed to read frame');
% im = cv.resize(im, 0.5, 0.5);

disp('The subtractor will learn the background for a few seconds.');
%disp('Keep out of the frame.');

% 设置变量


  
  kernel = cv.getStructuringElement('Shape', 'Ellipse', 'KSize',[2,2]);

%   kernel = cv.getStructuringElement(cv.MORPH_ELLIPSE, (2, 2))  % 定义结构元素
% color_m = (255, 0, 0)

% 背景差法
% fgbg = cv.bgsegm.createBackgroundSubtractorMOG()

  fgbg = cv.BackgroundSubtractorMOG();

   
 

stop=false;
%bs = cv.BackgroundSubtractorMOG2('History',200);
 % bs = cv.BackgroundSubtractorMOG2();
 % bs.ShadowValue = 55;
 
 %cap.set('FrameWidth',1080);
 %cap.set('FrameHeight',768);

  cap.FrameWidth = 1080;
  cap.FrameHeight = 768;

  while ~stop
   
   %cap.open();

  frame = cap.read();
  %frame = cv.cvtColor(frame, 'BGR2GRAY');
  frame = cv.resize(frame,[1080,768], 'Interpolation','Cubic');
  frame_motion = cv.copyTo(frame);


%计算前景掩码
   fgmask = fgbg.apply(frame_motion);
    opts = { 'Type','Binary','MaxValue',255};
    draw1 = cv.threshold(fgmask,'Otsu',opts{:});

    draw1 = cv.dilate(draw1,'Element',kernel,'Iterations',1);

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
   drawing = zeros([size(draw1) 3], 'uint8');

    for i=1:numel(contours)
        clr = randi([0 255], [1 3], 'uint8');
        drawing = cv.drawContours(drawing, contours, ...
            'Hierarchy',hierarchy, 'ContourIdx',i-1, 'MaxLevel',0, ...
            'Color',clr, 'Thickness',2, 'LineType',8);
    end
    %image_m, contours_m, hierarchy_m = cv.findContours(draw1.copy(), cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);


    %draw1 = cv.threshold(fgmask, 25, 255, cv.THRESH_BINARY)[1]  # 二值化
    %draw1 = cv.dilate(draw1, kernel, iterations=1)
 % foregroud = bs.apply(frame, 'LearningRate', -1);

      

  %imshow(draw1);

  imshow(drawing);
  
  %imshow(frame);
  if isempty(frame)
  	stop = true;
  end
  


end
    
    
%     VideoCapture capture("../768X576.avi");
% 	if(!capture.isOpened())
% 		return 0;
% 	Mat frame;
% 	Mat foreground, foreground2;
% 	BackgroundSubtractorMOG mog;
% 	BackgroundSubtractorMOG2 mog2;
% 	bool stop(false);
% 	namedWindow("Extracted Foreground");
% 	while ~stop)
% 	{
% 		if(!capture.read(frame))
% 			break;
% 		cvtColor(frame, frame, CV_BGR2GRAY);
% 		long long t = getTickCount();
% 		mog(frame, foreground, 0.01);
% 		long long t1 = getTickCount();
% 		mog2(frame, foreground2, -1);
% 		long long t2 = getTickCount();
% 		cout<<"t1 = "<<(t1-t)/getTickFrequency()<<" t2 = "<<(t2-t1)/getTickFrequency()<<endl;
% 		imshow("Extracted Foreground", foreground);
% 		imshow("Extracted Foreground2", foreground2);
% 		imshow("video", frame);
% 		if(waitKey(10) >= 0)
% 			stop = true;
% 	}
% 	
% 	waitKey();