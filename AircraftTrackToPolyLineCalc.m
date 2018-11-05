function ply = AircraftTrackToPolyLineCalc(aircrafttracks,nowidx)
     

    ply = zeros(nowidx,2);
  
    for i=1:nowidx

      ply(i,1)=aircrafttracks(i).Hu;
      ply(i,2)=aircrafttracks(i).Hv
    end
    
 
end