close all;
clear all;
clc;
addpath('/home/gisphd/mexopencv');
addpath('/home/gisphd/mexopencv/opencv_contrib');

addpath data
addpath lib
addpath data/AirCraftMotion


PosLat = 32 + 51/60   %北纬 32度51分
PosLon = 103 + 41/60 % 东经103度41分

airportZeroLat = 12.03/(60 * 60)
airportZeroLon = -5.01/(60*60)
airportZeroHight = 3448 %因为零点高，多减去23，方便计算

cameraPosLat = 24.41/(60 * 60)
cameraPosLon = 13.35/(60*60)
cameraPosHight = 3473 %因为零点高，多减去23，方便计算


