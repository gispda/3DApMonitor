classdef Aircraft < dynamicprops
   properties
      FlightNo
      CraftNo
      CraftName
      CraftType
      AircraftTrajectorys
      MotionType
      Contours
      IsHaveContours
   end
 
   
   methods
      function at = Aircraft()
            at.FlightNo = '';
            at.CraftNo = 'B3651';
            at.CraftName = '';
            at.CraftType = '';
            at.IsHaveContours = false;
            at.MotionType = AircraftConstants.MotionInAirPortSurFace;

            %if nargin > 0
            %at.AircraftTrajectorys(1,Posnum) = AircraftTrack();
        
           % end
      end
      
      function m = get.FlightNo(obj)         
         m = obj.FlightNo;
      end
      function obj = set.FlightNo(obj,flightno)
         obj.FlightNo = flightno;
      end
      function m = get.CraftNo(obj)         
         m = obj.CraftNo;
      end
      function obj = set.CraftNo(obj,craftno)
         obj.CraftNo = craftno;
      end
      function m = get.CraftName(obj)         
         m = obj.CraftName;
      end
      function obj = set.CraftName(obj,cratname)
         obj.CraftName = cratname;
      end
      function m = get.CraftType(obj)         
         m = obj.CraftType;
      end
      function obj = set.CraftType(obj,craftype)
         obj.CraftType = craftype;
      end
    
      function obj = set.AircraftTrajectorys(obj,aircrafttrajectorys)
         obj.AircraftTrajectorys = aircrafttrajectorys;
      end
      function m = get.AircraftTrajectorys(obj)         
         m = obj.AircraftTrajectorys;
      end
      function m = get.Contours(obj)         
         m = obj.Contours;
      end
      function obj = set.Contours(obj,countours)
         obj.Contours = countours;
      end  
      function m = get.IsHaveContours(obj)         
         m = obj.IsHaveContours;
      end
      function obj = set.IsHaveContours(obj,ishavecountours)
         obj.IsHaveContours = ishavecountours;
      end  
      function obj = set.MotionType(obj,motiontype)
         obj.MotionType = motiontype;
      end
      function m = get.MotionType(obj)         
         m = obj.MotionType;
      end

      %{ 
         
         開始這個飛行器的三維重建.

      %}
      function apt = startTracks(apt,apm,craftimg,wxy)
       posnum = size(wxy,1);
      
        if (apt.IsHaveContours)
               

        end
      end

   end % method
end