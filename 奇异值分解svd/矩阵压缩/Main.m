A = [4 0 1 6;
    0 0 5 1;
    2 1 3 2]  % A : m*n

[U,S,V] = svd(A)  % U*S*V'== A       U:m*m         S��m*n      V �� n*n
U*S*V' - A   % ԼΪ0

compress_A = U(:,1:2)*S(1:2,1:2)*V(:,1:2)'  %ѹ����
% U(:,1:3)*S(1:3,1:3)*V(:,1:3)'  ����A

svd_custom( A, 0.9);