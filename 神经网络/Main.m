clear;clc
load Date.mat

% APP��Neural Fitting app.

sim( net, X_predict(1,:)')   % ����������Ƿ�Ҫ��ָ���Ϊ��������Ȼ������sim����Ԥ��

% ѭ����Ԥ�������������
n = size( X_predict, 1)
Y_predict = zeros(10,1); % ��ʼ��
for i = 1:n
    result = sim( net, X_predict(i,:)');
    Y_predict(i) = result;
end
disp('Ԥ��ֵΪ��')
disp(Y_predict)