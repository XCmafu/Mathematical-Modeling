%% 容易陷入局部最优解,用竞标赛法
%% f = 11*sin(6*x) + 7*cos(5*x) 最大值 
clear;close;clc
%%
syms x
f = 11*sin(6*x) + 7*cos(5*x);
% f = @(x) 11*sin(6*x) + 7*cos(5*x);
fplot(f)
hold on 
h = plot(0,0,'*');

% 参数定义
varnum = 1; % varnum 变量个数
n = 500; % n 种群大小
lb = -pi; % 下限
ub = pi; % 上限
% lb = [-pi -3 -2 -1 0];
% ub = [pi pi pi pi pi];
eps = 1e-4; % eps 精度
pc = 0.9; % 交叉概率 pc
pm = 0.01; % 变异概率 pm 
maxgen = 100; % 迭代次数

% 初始化种群
for i = 1:varnum
    L(i) = ceil(log2((ub(i) - lb(i)) / eps + 1)); % 整数
end
LS = sum(L); % 总位长
pop = randi([0 1], n, LS); % 每个种群的所有变量 的二进制数，（n*LS的只含0 1的矩阵）
spoint = cumsum([0 L]);

bestfit = [];
bestreal = [];
for iter = 1:maxgen
    % 将二进制转化为十进制
    for i = 1:n
        for j = 1:varnum
            startpoint = spoint(j) + 1;
            endpoint = spoint(j+1);
            real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
        end
    end
    
    % 计算适应度值（求最大值）
    fit = fitnessfun(real); % 0或f(real)+0.01
    fval = objfun(real);
    h.XData = real;
    h.YData = fval;
    pause(0.1)
    
    [bestfitness, bestindex] = max(fit);
    bestfit = [bestfit; bestfitness];
    bestrealness = real(bestindex,:);
    bestreal = [bestreal; bestrealness];

    % 选择
    [dad, mom] = selection (pop, fit);
    
    % 交叉
    newpop1 = crossover(dad, mom, pc);
    
    % 变异
    newpop2 = mutation(newpop1, pm);
    
    pop = newpop2;
end

for i = 1:n
    for j = 1:varnum
        startpoint = spoint(j) + 1;
        endpoint = spoint(j+1);
        real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
    end
end
fit = fitnessfun(real);
[bestfitness, bestindex] = max(fit);
bestfit = [bestfit; bestfitness];
bestrealness = real(bestindex,:);
bestreal = [bestreal; bestrealness];

%% 
[bestfitvalue, bestindexvalue] = max(bestfit)
bestvalue_x = bestreal(bestindexvalue,:)
bestvalue_f = objfun(bestvalue_x)

plot(bestvalue_x,bestvalue_f,'k*')
