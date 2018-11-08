function [seita,ox] = CalcNextCentre(oc,ac,ax)
     syms ang xo2 yo2 zo2 

     res = solve(ax(1)==ac(1)*cos(ang)-ac(2)*sin(ang)+(xo2-oc(1)),...
                 ax(2)==ac(1)*sin(ang)+ac(2)*cos(ang)+(yo2-oc(2)),...
                 ax(3)==ac(3)+(zo2-oc(3)),...
                 (xo2-ax(1))*(xo2-ax(1))+(yo2-ax(2))*(yo2-ax(2))+(zo2-ax(3))*(zo2-ax(3))==(oc(1)-ac(1))*(oc(1)-ac(1))+(oc(2)-ac(2))*(oc(2)-ac(2))+(oc(3)-ac(3))*(oc(3)-ac(3)),...
                 [xo2,yo2,zo2,ang]);
    
     
     %vpa(subs(res,{x1,y1,z1,x2,y2,z2,xo1,yo1,zo1},[vx1,vy1,vz1,vx2,vy2,vz2,vxo1,vyo1,vzo1]));

ox(1) = double(res.xo2(2));
ox(2) = double(res.yo2(2));
ox(3) = double(res.zo2(2));
seita = double(res.ang(2));
%    syms a b c X 
%    ox = [0,0,0];
%    ox(3) = ax(3) - ac(3) + oc(3); 
%    
%    cc = -2*oc(1)*ac(1)-2*oc(2)*ac(2);
%    aa = -2*oc(1)*ac(1) - 2*oc(2)*ac(2);
%    bb = 2*oc(1)*ac(2) - 2*oc(2)*ac(1);
%    
%    if bb==0
%  
%    seita = acos(cc/aa);
%    else 
%      
%    res = solve(a*cos(X)+b*sin(X)== c,X); 
%    angle = vpa(subs(res,{a,b,c},[aa bb cc]));
%    end
%    seita=double(angle(1));
%    ang2=double(angle(2))*180/pi;
%    seita = ang2;
%    ox(1) = ax(1)+oc(1)-(ac(1)*cos(seita)-ac(2)*sin(seita));
%    ox(2) = ax(2)+oc(2)-(ac(1)*sin(seita)+ac(2)*cos(seita));
%    
