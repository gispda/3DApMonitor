%% Code
addpath('/home/gisphd/mexopencv');
addpath('/home/gisphd/mexopencv/opencv_contrib');

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

stop=false;
%bs = cv.BackgroundSubtractorMOG2('History',200);
  bs = cv.BackgroundSubtractorMOG2();
  bs.ShadowValue = 55;
  while ~stop

  frame = cap.read();
  frame = cv.cvtColor(frame, 'BGR2GRAY');
 
  foregroud = bs.apply(frame, 'LearningRate', -1);
  
      

  imshow(foregroud);
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