close all;
clear all;
clc;

oc = [110.92,48.944,3.87];
ac = [125.92,48.944,5.94];
ax = [130.44,47.574,5.94];

[seita,ox] = CalcNextCentre(oc,ac,ax);
