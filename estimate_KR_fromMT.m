function [K,R,t] = estimate_KR_fromMT(M)
    B = M(1:3,1:3);
    b = M(:,4);
    lambda = 0;
    %% Calculating parameters in K
    C = B*B';
    
    u0 = C(1,3)
    v0=  C(2,3)
    beta = sqrt(C(2,2)-v0*v0)
    gama = (C(2,1)-u0*v0)/beta
    alfa = sqrt(C(1,1)-u0*u0-gama*gama)
    
    K = [alfa gama u0;0 beta v0;0 0 1]
    %% Calculating lambda (absolute value)
     lambda = 1/sqrt(C(3,3));
%     
   
%    %% Calculating K
%    % t = lambda*(K\b);
%     
%     K = T*b'/lambda
    
    %% clculating the parameters
%     xc = (lambda^2)*C(1,3);
%     yc = (lambda^2)*C(2,3);
%     fy = sqrt((lambda^2)*C(2,2)-yc^2);
%     alpha = ((lambda^2)*C(1,2)-xc*yc)/fy;
%     fx = sqrt((lambda^2)*C(1,1)-(alpha^2)-xc^2);
%     K = [fx,alpha,xc;0,fy,yc;0,0,1];
    %% Calculating Matrix R
    R = inv(K)*B
    t = inv(K)*b
    %R = lambda*(K\B);
    %% Checking if det(R) = 1
%     detR = det(R);
%     if ~(abs(detR - 1) < 0.001)
%         R = -R;
%     end

end