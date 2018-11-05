function ply = AircraftTrackToPolyLineError(aircrafttracks,nowidx)
     

    ply = zeros(nowidx,2);
  
    for i=1:nowidx

      ply(i,1)=aircrafttracks(i).Gu;
      ply(i,2)=aircrafttracks(i).Gv
    end
    
 
end