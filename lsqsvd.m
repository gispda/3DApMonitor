function x = lsqsvd(A, b)
% The least squares solution x to the overdetermined
% linear system Ax = b using the reduced singular
% value decomposition of A.
[m, n] = size(A);
if m < n
 error('System must be overdetermined')
end
[U,S,V] = svd(A,0);
d = diag(S);
r = sum(d > 0);
b1 = U(:,1:r)'*b;
w = d(1:r).\b1;
x = V(:,1:r)*w;
re = b - A*x; % One step of the iterative
b1 = U(:,1:r)'*re; % refinement
w = d(1:r).\b1;
e = V(:,1:r)*w;
x = x + e;