function mPxy = celltoPointsMatrix(contour)
     
    dim = numel(contour);

    mPxy = zeros(dim,2); 
  
    for i=1:dim

      mPxy(i,1)=-contour{i}(1);
      mPxy(i,2)=contour{i}(2);
    end
    
 
end