function [uxo,uyo,uzo,uang] = CalcNextCentre(oc,ac,ax)
	 addpath matGeom/geom3d
     syms ang xo2 yo2 zo2 
     res = solve(ax(1)==ac(1)*cos(ang)-ac(2)*sin(ang)+(xo2-oc(1)),...
                 ax(2)==ac(1)*sin(ang)+ac(2)*cos(ang)+(yo2-oc(2)),...
                 ax(3)==ac(3)+(zo2-oc(3)),...
                 (xo2-ax(1))*(xo2-ax(1))+(yo2-ax(2))*(yo2-ax(2))+(zo2-ax(3))*(zo2-ax(3))==(oc(1)-ac(1))*(oc(1)-ac(1))+(oc(2)-ac(2))*(oc(2)-ac(2))+(oc(3)-ac(3))*(oc(3)-ac(3)),...
                 [xo2,yo2,zo2,ang]);
    
     
    
	vxo = res.xo2;
	vyo = res.yo2;
	vzo = res.zo2;
	vang = res.ang;

	hline = createLine3d(ac,ax);

    oline = parallelLine3d(hline, oc);  
	if size(vxo,1)>=1
   		for i=1:size(vxo,1)
   		  uxo = double(vxo(i));
   	 	  uyo = double(vyo(i));
   	      uzo = double(vzo(i));
   	  	  uang = double(vang(i));
   	  
          b = isPointOnLine3d([uxo uyo uzo], oline,1e-6);
          
          if b==1 
             break;
          end 
      
        end
    end
