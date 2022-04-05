clc,clear
load Data.mat

X = X';
Y = Y';
[m, n] = size(X); % m����ָ����� n���۶������
s = size(Y,1); % ���ָ�����

A = [-X' Y'];
b = zeros(n,1);
lb = zeros(m+s,1); % �½�
% ub = ones(m+s,1);
ub = []; % �Ͻ�

for i = 1:n
    c = [zeros(1,m) -Y(:,i)'];
    Aeq = [X(:,i)', zeros(1,s)];
    beq = 1;
    w(:,i) = linprog(c,A,b,Aeq,beq,lb,ub);
    E(i,i) = Y(:,i)' * w(m+1:m+s,i);
end

theta = diag(E)';
disp('��DEA�����Դ˵�������۽��Ϊ��');
disp(theta);
omega = w(1:m,:);
mu = w(m+1:m+s,:);