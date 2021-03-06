close all;
clear all;
clc;

addpath data
addpath lib

PosLat = 32 + 51/60   %Ã¯Â¿Â½Ã¯Â¿Â½ÃŽÂ³ 32Ã¯Â¿Â½Ã¯Â¿Â½51Ã¯Â¿Â½Ã¯Â¿Â½
PosLon = 103 + 41/60 % Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½103Ã¯Â¿Â½Ã¯Â¿Â½41Ã¯Â¿Â½Ã¯Â¿Â½

airportZeroLat = 12.03/(60 * 60)
airportZeroLon = -5.01/(60*60)
airportZeroHight = 3448 %Ã¯Â¿Â½Ã¯Â¿Â½ÃŽÂªÃ¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½ÃŸÂ£Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½ÃˆÂ¥23Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½

cameraPosLat = 24.41/(60 * 60)
cameraPosLon = 13.35/(60*60)
cameraPosHight = 3473 %Ã¯Â¿Â½Ã¯Â¿Â½ÃŽÂªÃ¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½ÃŸÂ£Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½ÃˆÂ¥23Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½

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
[xw1,yw1,utmzonew1,utmhemiw1] = wgs2utm(posw1Lat,posw1Lon)
[xwt,ywt,utmzonewt,utmhemiwt] = wgs2utm(poswtLat,poswtLon)


% posXY,Ã¯Â¿Â½Ã”Â»Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½ÃŽÂªÃ¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã„Â»Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½ÃÂµÃ¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½Ã¯Â¿Â½
posXYZ = [x1-x0,y1-y0,posWgs(:,3)-airportZeroHight]

posCameraXYZ = [xc-x0,-(yc-y0),cameraPosHight-airportZeroHight]
posW1XYZ = [xw1-x0,-(yw1-y0),w1PosHight-airportZeroHight]
posWtXYZ = [xwt-x0,-(ywt-y0),wtPosHight-airportZeroHight]


pdist =  getDist(xw1,yw1,xwt,ywt)


subdist = pdist/(36-1)

[wxx,wyy]=fillline([xw1-x0 yw1-y0],[xwt-x0 ywt-y0],36-1)

wzz =  repmat(wtPosHight-airportZeroHight,size(wxx'),1)




[ixx,iyy]=fillline([929 357],[323 404],35)
ixxyy = [round(ixx') round(iyy')];

wxxyy = [wxx' wyy' wzz ixxyy];
%csvwrite('craftimgtracks.csv',ixxyy);

csvwrite('crafttracks.csv',wxxyy);
