close all;
clear all;
clc;

oc = [110.92,48.944,3.87];
ac = [125.92,48.944,5.94];
ax = [130.44,47.574,5.94];

[vxo,vyo,vzo,vang] = CalcNextCentre(oc,ac,ax);
load motion.mat M;

% if size(vxo,1)>=1
%    for i=1:size(vxo,1)
%    	  uxo = double(vxo(i));
%    	  uyo = double(vyo(i));
%    	  uzo = double(vzo(i));
%    	  uang = double(vang(i));
%    	  
%       uptImg = estimatepoints2DImg([uxo uyo uzo],M);
% 
%       
%    end
% end


