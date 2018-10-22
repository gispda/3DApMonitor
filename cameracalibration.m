close all;
clear all;
clc;

addpath data
addpath lib

PosLat = 32 + 51/60   %��γ 32��51��
PosLon = 103 + 41/60 % ����103��41��

airportZeroLat = 12.03/(60 * 60)
airportZeroLon = -5.01/(60*60)
airportZeroHight = 3448 %��Ϊ���ߣ����ȥ23���������

cameraPosLat = 24.41/(60 * 60)
cameraPosLon = 13.35/(60*60)
cameraPosHight = 3473 %��Ϊ���ߣ����ȥ23���������

w1PosLat = 13.67/(60 * 60)
w1PosLon = -0.19/(60*60)
w1PosHight = 3448+5.94


wtPosLat = 12.22/(60 * 60)
wtPosLon = 5.74/(60*60)
wtPosHight = 3448+5.94


%RawData = sym('rawdata%d%d',[17,6])
%posXYZ = sym('pwgs%d%d',[17,3])
%posImg = sym('pimg%d%d',[17,2])


RawData = csvread('00005498.csv')
%syms posWgs posImg;

posWgs = RawData(:,2:4)

posImg = RawData(:,5:6)

posWgs(:,1) = posWgs(:,1)/(60 * 60) +  PosLat
posWgs(:,2) = posWgs(:,2)/(60 * 60) +  PosLon

posairportZeroLat = airportZeroLat + PosLat
posairportZeroLon = airportZeroLon + PosLon

poscameraLat = cameraPosLat + PosLat
poscameraLon = cameraPosLon + PosLon

posw1Lat = w1PosLat + PosLat
posw1Lon = w1PosLon + PosLon


poswtLat = wtPosLat + PosLat
poswtLon = wtPosLon + PosLon

 %syms x1 y1 x0 y0;
 


[x1,y1,utmzone1,utmhemi1] = wgs2utm(posWgs(:,1),posWgs(:,2))
[x0,y0,utmzone0,utmhemi0] = wgs2utm(posairportZeroLat,posairportZeroLon)
[xc,yc,utmzonec,utmhemic] = wgs2utm(poscameraLat,poscameraLon)


% posXY,�Ի������Ϊ����Ļ�������ϵ����
posXYZ = [x1-x0,y1-y0,posWgs(:,3)-airportZeroHight]

posCameraXYZ = [xc-x0,-(yc-y0),cameraPosHight-airportZeroHight]



 crafttracks = csvread('crafttracks.csv');
 
 %M = estimateCameraPMatrix(posImg,posXYZ)

 posXYZ = [posXYZ;crafttracks(:,1:3)];
 
 posImg = [posImg;crafttracks(:,4:5)];
 
 M = estimateCameraProjectionMatrix(posImg,posXYZ)
 
%t = posCameraXYZ'
[K,R,t] = estimate_KR_fromMT(M)
%[K,R,t] = estimate_KRt_fromM(M)

 %[R, t, K] = calibration2Dto3D(posXYZ', posImg')



% groundimgU = 712
% groundimgV = 428
% 
% testWgsLat = 13.91/(60*60) +  PosLat
% testWgsLon = 3.40/(60*60) +  PosLon
% testWgsHeight =  3448
% 
% [testGroundX,testGroundY,utmzoneg,utmhemig] = wgs2utm(testWgsLat,testWgsLon)
% 
% testGroundXYZ = [testGroundX-x0,testGroundY-y0,testWgsHeight-airportZeroHight]
% 
% oneGroundXYZ = [390.6716217881767,264.6478325733915,12]
% 
% onePtImg = estimatepoints2D(oneGroundXYZ,K,R,t)



 [yaw,pitch,roll] = dcm2angle(R)
% %pitch = pitch -0.1
% %yaw = yaw -1.8
% % roll = roll + 0.0001
%r = angle2dcm( yaw,pitch , roll )
 %[yaw1,pitch1,roll1] = dcm2angle(r);
%R

%  
%  t(3,:)=t(3,:)
%testPtImg = estimatepoints2DImg(testGroundXYZ,M)
%testPtImg = estimatepoints2D(testGroundXYZ,K,R,t)

%eptImg= estimatepoints2DImg(posXYZ,M)
eptImg1= estimatepoints2D(posXYZ,K,R,t)


%t

pltxy = [posImg(:,1)-eptImg1(:,1),posImg(:,2)-eptImg1(:,2)]
%pltxy = [posImg(:,1)-eptImg(:,1),posImg(:,2)-eptImg(:,2)]

plot(pltxy(:,1),pltxy(:,2))
%norm(pltxy)

% yaw
% pitch
% roll


