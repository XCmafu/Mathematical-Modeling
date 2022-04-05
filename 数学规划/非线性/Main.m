% [x,fval] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,@nonlfun,option)
% @fun表示目标函数
% @nonlfun表示非线性约束的函数
% x0表示给定的初始值（用行向量或者列向量表示，对应的lb,ub就用行向量或者列向量）
% option 表示求解非线性规划使用的方法

% 使用interior point算法 （内点法）
option = optimoptions('fmincon','Algorithm','interior-point')
% 使用SQP算法 （序列二次规划法）
option = optimoptions('fmincon','Algorithm','sqp')
% 使用active set算法 （有效集法）
option = optimoptions('fmincon','Algorithm','active-set')
% 使用trust region reflective (信赖域反射算法)
option = optimoptions('fmincon','Algorithm','trust-region-reflective')

x0 = [];  % 任意给定的初始值 
A = [];   % 不等式约束Ax<=b的系数矩阵
b = []';  % 列向量，不等式约束Ax<=b的常数项
Aeq = []; % 等式约束Aeq x=beq的系数矩阵
beq = []; % 列向量，等式约束Aeq x=beq的常数项
lb = []'; % X的下限
ub = []'; % X的上限