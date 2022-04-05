clear;clc
load Date.mat

% APP，Neural Fitting app.

sim( net, X_predict(1,:)')   % 根据情况看是否要将指标变为列向量，然后再用sim函数预测

% 循环，预测接下来的样本
n = size( X_predict, 1)
Y_predict = zeros(10,1); % 初始化
for i = 1:n
    result = sim( net, X_predict(i,:)');
    Y_predict(i) = result;
end
disp('预测值为：')
disp(Y_predict)