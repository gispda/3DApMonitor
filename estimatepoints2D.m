function imPoints2D_estim = estimatepoints2D(objectPoints3D,K,R,t)
    dim = size(objectPoints3D);
    N = K*[R,t];
    
    N = [N(:,1:3),N(:,4)./N(3,4)];
    objPoints3D = [objectPoints3D,ones(dim(1),1)]';
    %AM = sym('m%d%d',[3,4])
    
    points = N*objPoints3D;
    points2D = points(1:2,:)./points(3,:);
    imPoints2D_estim = points2D';
end