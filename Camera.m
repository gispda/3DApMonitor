classdef Camera
   properties
      PosLat
      PosLon
      PosHight
      K
      R
      T
      M
      PosXYZ
   

   end
 
   
   methods
      function cm = Camera()
            cm.PosLat = 24.41/(60 * 60);
            cm.PosLon = 13.35/(60*60);
            cm.PosHight = 3473; %因为零点高，多减去23，方便计算            

            if nargin > 0

            
        
            end
      end
      
      function m = get.PosLat(obj)         
         m = obj.PosLat;
      end
      function obj = set.PosLat(obj,lat)
         obj.PosLat = lat;
      end
      function m = get.PosLon(obj)         
         m = obj.PosLon;
      end
      function obj = set.PosLon(obj,lon)
         obj.PosLon = lon;
      end
      function m = get.PosHight(obj)         
         m = obj.PosHight;
      end
      function obj = set.PosHight(obj,height)
         obj.PosHight = height;
      end
      function m = get.K(obj)         
         m = obj.K;
      end
      function obj = set.K(obj,k)
         obj.K = k;
      end
      function m = get.R(obj)         
         m = obj.R;
      end
      function obj = set.R(obj,r)
         obj.R = r;
      end
      function m = get.T(obj)         
         m = obj.T;
      end
      function obj = set.T(obj,t)
         obj.T = t;
      end
       function m = get.M(obj)         
         m = obj.M;
      end
      function obj = set.M(obj,m)
         obj.M = m;
      end               

    function m = get.PosXYZ(obj)         
         m = obj.PosXYZ;
      end
      function obj = set.PosXYZ(obj,xyz)
         obj.PosXYZ = xyz;
      end
  
      %{ 
         
         開始相機標定.

      %}
      function cm = estimateCamera(cm,apm)
         RawData = csvread('00005498.csv');
         %syms posWgs posImg;

         posWgs = RawData(:,2:4);

         posImg = RawData(:,5:6);

         posWgs(:,1) = posWgs(:,1)/(60 * 60) +  apm.BigLat;
         posWgs(:,2) = posWgs(:,2)/(60 * 60) +  apm.BigLon;

         posairportZeroLat = apm.ZeroLat + apm.BigLat;
         posairportZeroLon = apm.ZeroLon + apm.BigLon;

         poscameraLat = cm.PosLat + apm.BigLat;
         poscameraLon = cm.PosLon + apm.BigLon;

         [x1,y1,utmzone1,utmhemi1] = wgs2utm(posWgs(:,1),posWgs(:,2));
         [x0,y0,utmzone0,utmhemi0] = wgs2utm(posairportZeroLat,posairportZeroLon);
         [xc,yc,utmzonec,utmhemic] = wgs2utm(poscameraLat,poscameraLon);


        
         posXYZ = [x1-x0,y1-y0,posWgs(:,3)-apm.ZeroHight];

         cm.PosXYZ = [xc-x0,-(yc-y0),cm.PosHight-apm.ZeroHight];       
  
         crafttracks = csvread('crafttracks.csv');
 
         %M = estimateCameraPMatrix(posImg,posXYZ)

         posXYZ = [posXYZ;crafttracks(:,1:3)];
 
         posImg = [posImg;crafttracks(:,4:5)];
         cm.M = estimateCameraProjectionMatrix(posImg,posXYZ);
         [cm.K,cm.R,cm.T] = estimate_KR_fromMT(cm.M);

      end
      function [craftimg,wxy] = getAircraftImageTracks(cm)

         if ~isempty(M)
            wxy = csvread('data/AirCraftMotion/crafttracks.csv')
            craftimg = estimatepoints2D(wxy(:,1:3),cm.K,cm.R,cm.T)
         end
    
      end
   end % method
end