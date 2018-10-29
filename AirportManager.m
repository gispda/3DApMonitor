classdef AirportManager
   properties
      Aircrafts
      Cameras
      BigLat
      BigLon
      ZeroLat
      ZeroLon
      ZeroHight
      IsInit
   end
 
   
   methods
      function apm = AirportManager(craftnum,cameranum)
            apm.BigLat = 0;  
            apm.BigLon = 0; 
            apm.ZeroLat = 0;
            apm.ZeroLon = 0;
            apm.ZeroHight = 0;
            apm.IsInit = false;
         if nargin > 0
           apm.Aircrafts(1,craftnum) = Aircraft();
           apm.Cameras(1,cameranum) = Camera();         
         else
           apm.Aircrafts(1,2) = Aircraft();
           apm.Cameras(1,1) = Camera();
         end
      end
      function m = get.Aircrafts(obj)         
         m = obj.Aircrafts;
      end
      function obj = set.Aircrafts(obj,aircrafts)
         obj.Aircrafts = aircrafts;
      end     
      function m = get.Cameras(obj)         
         m = obj.Cameras;
      end
      function obj = set.Cameras(obj,cameras)
         obj.Cameras = cameras;
      end           
      function m = get.BigLat(obj)         
         m = obj.BigLat;
      end
      function obj = set.BigLat(obj,lat)
         obj.BigLat = lat;
      end
      function m = get.BigLon(obj)         
         m = obj.BigLon;
      end
      function obj = set.BigLon(obj,lon)
         obj.BigLon = lon;
      end
      function m = get.ZeroLat(obj)         
         m = obj.ZeroLat;
      end
      function obj = set.ZeroLat(obj,lat)
         obj.ZeroLat = lat;
      end
      function m = get.ZeroLon(obj)         
         m = obj.ZeroLon;
      end
      function obj = set.ZeroLon(obj,lon)
         obj.ZeroLon = lon;
      end
      function m = get.ZeroHight(obj)         
         m = obj.ZeroHight;
      end
      function obj = set.ZeroHight(obj,height)
         obj.ZeroHight = height;
      end
      function m = get.IsInit(obj)         
         m = obj.IsInit;
      end
      function obj = set.IsInit(obj,isinit)
         obj.IsInit = isinit;
      end

      function ac = FindAircraft(apm,craftno)
          
         if ~isempty(apm.Aircrafts)
            ac = findobj(apm.Aircrafts,'CraftNo','B3651');
         end
      end
 
      %{ 
         設置機場的參數，開始標定相機


      %}
      function apm = initAirport(apm,icaocode)
          if ~apm.IsInit
          apm.BigLat = 32 + 51/60;   %北纬 32度51分
          apm.BigLon = 103 + 41/60; % 东经103度41分
          apm.ZeroLat = 12.03/(60 * 60);
          apm.ZeroLon = -5.01/(60*60);
          apm.ZeroHight = 3448; %因为零点高，多减去23，方便计算  

          apm.Cameras(1) = apm.Cameras(1).estimateCamera(apm);  
          apm.IsInit = true;
          end
      end


      %{ 
         開始跟蹤


      %}
      function startMonitor(apm,craftno)
           apm = apm.initAirport('');


           [craftimg,wxy] = apm.Cameras(1).getAircraftImageTracks(apm);  
           %apm.Aircrafts(1).startTracks(apm,craftimg,wxy);
           ac = FindAircraft(apm,craftno);
           ac.startTracks(apm,craftimg,wxy);
      
      end


   end % method
end