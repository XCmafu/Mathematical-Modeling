% [x fval] = linprog(c, A, b, Aeq, beq, lb,ub, x0) %求最小值


c = []';  % 列向量，目标函数的系数
A = [];   % 不等式约束Ax<=b的系数矩阵
b = []';  % 列向量，不等式约束Ax<=b的常数项
Aeq = []; % 等式约束Aeq x=beq的系数矩阵
beq = []; % 列向量，等式约束Aeq x=beq的常数项
lb = []'; % X的下限
ub = []'; % X的上限