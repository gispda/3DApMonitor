classdef AircraftTrack
   properties
      HeadX
      HeadY
      HeadZ

      Yaw
      Pitch
      Yoll
      AX
      AY
      AZ
      OX
      OY
      OZ
      Au
      Av
      Hu
      Hv
      Gu
      Gv     
      MotionType

   end
 
   
   methods
      function at = AircraftTrack()
         %if nargin > 0
            at.HeadX = 0;
            at.HeadY = 0;
            at.HeadZ = 0;
            at.Yaw = 0;
            at.Pitch = 0;
            at.Yoll = 0;
            at.AX = 0;
            at.AY = 0;
            at.AZ = 0;
            at.OX = 0;
            at.OY = 0;
            at.OZ = 0;
            at.Au = 0;
            at.Av = 0;
            at.Hu = 0;
            at.Hv = 0;
            at.Gu = 0;
            at.Gv = 0;
            at.MotionType = AircraftConstants.MotionInAirPortSurFace;
        % end
      end
      
      function m = get.HeadX(obj)         
         m = obj.HeadX;
      end
      function obj = set.HeadX(obj,headx)
         obj.HeadX = headx;
      end
      function m = get.HeadY(obj)         
         m = obj.HeadY;
      end
      function obj = set.HeadY(obj,heady)
         obj.HeadY = heady;
      end
      function m = get.HeadZ(obj)         
         m = obj.HeadZ;
      end
      function obj = set.HeadZ(obj,headz)         
         obj.HeadZ = headz;
      end      
      function obj = set.OX(obj,ox)
         obj.OX = ox;
      end
      function m = get.OX(obj)         
         m = obj.OX;
      end
      function obj = set.OY(obj,oy)
         obj.OY = oy;
      end
      function m = get.OY(obj)         
         m = obj.OY;
      end
      function obj = set.OZ(obj,oz)
         obj.OZ = oz;
      end
      function m = get.OZ(obj)         
         m = obj.OZ;
      end
      function obj = set.Au(obj,au)
         obj.Au = au;
      end
      function m = get.Au(obj)         
         m = obj.Au;
      end
      function obj = set.Av(obj,av)
         obj.Av = av;
      end
      function m = get.Av(obj)         
         m = obj.Av;
      end      
      function obj = set.Hu(obj,hu)
         obj.Hu = hu;
      end
      function m = get.Hu(obj)         
         m = obj.Hu;
      end
      function obj = set.Hv(obj,hv)
         obj.Hv = hv;
      end
      function m = get.Hv(obj)         
         m = obj.Hv;
      end
     function obj = set.Gu(obj,gu)
         obj.Gu = gu;
      end
      function m = get.Gu(obj)         
         m = obj.Gu;
      end
      function obj = set.Gv(obj,gv)
         obj.Gv = gv;
      end
      function m = get.Gv(obj)         
         m = obj.Gv;
      end
      function obj = set.MotionType(obj,motiontype)
         obj.MotionType = motiontype;
      end
      function m = get.MotionType(obj)         
         m = obj.MotionType;
      end

      %{ 
         輸入preat 前一個飛機航班軌跡點的AircraftTrack對象，
         計算出當前AircraftTrack對象的機頭坐標
         需要將坐標系從圖像坐標系轉成正常坐標系，也就是說v值爲負。


      %}
      function [bsucceed,at] = calcHeadPos(at,preat,headp)
        
        [nheadp,nheadpidx] = sort([headp.dmin]); 
        
           
        aircraftavline = createLine([-at.Au at.Av],[-preat.Au preat.Av]);
        aircrafthvline = parallelLine(aircraftavline,[-preat.Hu preat.Hv]);
        aircraftprehaline = createLine([-preat.Au preat.Av],[-preat.Hu preat.Hv]);
        aircraftathaline = parallelLine(aircraftprehaline, [-at.Au at.Av]);
        headpointl = intersectLines(aircraftathaline, aircrafthvline);

        nmheadmin = 9999;
        nmheadminidx = -1;
        clear nmheadpos;
        nmheadpos = [9999 9999];
        for i=1:3
            pg = headp(nheadpidx(i)).polygonxy;
            
            [headpoint, edgeidx] = intersectLinePolyline(aircrafthvline, pg);
            
            
            if ~isempty(headpoint)
                  for j=1:size(headpoint,1)
                     tempnm = norm(headpointl-headpoint);
                     if nmheadmin > tempnm
                     nmheadmin = tempnm;
                     nmheadminidx = j;
                     nmheadpos = headpoint(j,:);
                     end
                  end
                      
            end 
        end
        if nmheadmin ~= 9999 
             if nmheadmin < 40
               at.Hu = -nmheadpos(1,1);
               at.Hv = nmheadpos(1,2);  
             else
               at.Hu = -headpointl(1,1);
               at.Hv = headpointl(1,2);
                 
             end
        else
         at.Hu = -headpointl(1,1);
         at.Hv = headpointl(1,2);

        end

        if (at.Hu == 0) && (at.Hv==0)
        bsucceed = false;
        else
         bsucceed = true;
        end 
      end


   end % method
end