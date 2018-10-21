function M = estimateCameraProjectionMatrix(imPoints2D,objectPoints3D)
    %% Calculating P matrix
    dim = size(imPoints2D);
    imPoints2D(:,2)
    P = [-1*objectPoints3D,-ones(dim(1),1),zeros(dim(1),4),imPoints2D(:,1).*objectPoints3D;...
        zeros(dim(1),4),-1*objectPoints3D,-ones(dim(1),1),imPoints2D(:,2).*objectPoints3D]
    %% Calculating the r matrix
    r = -1*[imPoints2D(:,1);imPoints2D(:,2)];
    %% Calculating the q matrix
    PTP = P'*P;
    
    
    %iPTPPT = lsqsvd(PTP,P')
    %det(P')
    %det(PTP)
    
    iPTPPT = PTP\P';
    
    arnk = rank(PTP)
    %tol = 1e-16;
    %maxit = 20;
     
    %iPTPPT = qmr(PTP,P',tol,maxit);

    %iPTPPT = pinv(PTP)*P'
    %opts.SYM= true
    %%iPTPPT = linsolve(PTP,P',opts)
    %%linsolve(A,b,opts) ¥˙ÃÊ A\b£¨≤¢…Ë÷√opts.SYM= true
    %%iPTPPT = gmres(P',PTP)
    %%iPTPPT = mldivide(PTP,P')
    q = iPTPPT*r;
    %% Calculating the M matrix
    M = [q(1:4)';q(5:8)';q(9:11)',1];
end