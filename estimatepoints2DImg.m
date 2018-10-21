function imPoints2D_estim = estimatepoints2DImg(objectPoints3D,M)
    dim = size(objectPoints3D);
    %M = K*[R,t];
    objPoints3D = [objectPoints3D,ones(dim(1),1)]';
    %AM = sym('m%d%d',[3,4])
    
    points = M*objPoints3D;
    points2D = points(1:2,:)./points(3,:);
    imPoints2D_estim = points2D';
end