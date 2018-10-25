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
      U
      V
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
            at.U = 0;
            at.V = 0;
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
      function obj = set.U(obj,u)
         obj.U = u;
      end
      function m = get.U(obj)         
         m = obj.U;
      end
      function obj = set.V(obj,v)
         obj.V = v;
      end
      function m = get.V(obj)         
         m = obj.V;
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

      %}
      function bsucceed = calcHeadPos(at,preat,headp)
        
        [nheadp,nheadpidx] = sort([headp.dmin]); 
        

        aircraftvvline = createLine([preat.U preat.V],[at.U at.V]);
        
        for i=1:5

        end

        bsucceed = true;

      end



      %{
      function obj = set.Material(obj,material)
         if (strcmpi(material,'aluminum') ||...
               strcmpi(material,'stainless steel') ||...
              strcmpi(material,'carbon steel'))
           obj.Material = material;
         else
            error('Invalid Material')
         end
      end
      %}
      
      %{
      function m = get.Modulus(obj)
         ind = find(obj.Strain > 0);
         m = mean(obj.Stress(ind)./obj.Strain(ind));
      end


      function obj = set.Modulus(obj,~)
         fprintf('%s%d\n','Modulus is: ',obj.Modulus)
         error('You cannot set Modulus property');
      end
      
      function disp(td)
         sprintf('Material: %s\nSample Number: %g\nModulus: %1.5g\n',...
            td.Material,td.SampleNumber,td.Modulus)
      end
      
      function plot(td,varargin)
         plot(td.Strain,td.Stress,varargin{:})
         title(['Stress/Strain plot for Sample ',...
            num2str(td.SampleNumber)])
         xlabel('Strain %')
         ylabel('Stress (psi)')
      end
      %}
   end % method
end