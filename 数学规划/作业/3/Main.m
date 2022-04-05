% [x,fval] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,@nonlfun,option)

N = 1000000;
x1 = unifrnd(0, 3, N, 1);   % x1在0~3之间均匀分布
x2 = unifrnd(-1, 10, N, 1);  % x2在-8~7之间均匀分布
%
x3 = 2 - x1.^2;   
max = -inf; % 初始化
for i = 1:N
    x = [x1(i), x2(i), x3(i)];  %构造x向量
    if (x(1)+2*x(1)^2+x(2)+2*x(2)^2+x(3)-10<=0) & (x(1)+x(1)^2+x(2)+x(2)^2-x(3)-50<=0) & (2*x(1)+x(1)^2+2*x(2)+x(3)-40<=0) & (x(1)+2*x(2)>=1)
        result = 2*x(1)+3*x(1)^2+3*x(2)+x(2)^2+x(3) ;  % 满足条件
        if  result > max  
            max = result;  
            x0 = x;
        end
    end
end
disp('蒙特卡罗算法选取的初始值为：')
x0 = x0';
disp(x0)

lb = [0 -inf -inf];

% option = optimoptions('fmincon','Algorithm','interior-point')
% % 使用SQP算法 （序列二次规划法）
% option = optimoptions('fmincon','Algorithm','sqp')
% % 使用active set算法 （有效集法）
% option = optimoptions('fmincon','Algorithm','active-set')
% % 使用trust region reflective (信赖域反射算法)
% option = optimoptions('fmincon','Algorithm','trust-region-reflective')


[x,fval] = fmincon(@fun, x0, [], [], [], [], lb, [], @nonlfun)
fval = -fval
