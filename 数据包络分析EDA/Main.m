clc,clear
load Data.mat
% load Data2.mat

[n, m] = size(X); % m输入指标个数 n评价对象个数
s = size(Y,2); % 输出指标个数

A = [-X Y];
b = zeros(n,1);
lb = zeros(m+s,1); % 下界
% ub = ones(m+s,1);
ub = []; % 上界

for i = 1:n
    c = [zeros(1,m) -Y(i,:)];
    Aeq = [X(i,:), zeros(1,s)];
    beq = 1;
    w(:,i) = linprog(c,A,b,Aeq,beq,lb,ub);
    E(i,i) = Y(i,:) * w(m+1:m+s,i);
end

theta = diag(E)';
disp('用DEA方法对此的相对评价结果为：');
disp(theta);
omega = w(1:m,:);
mu = w(m+1:m+s,:);