clear
close
clc
%% GeneticAlgorithm
% varnum变量个数
% eps 精度
% lb ub变量范围
% n 种群大小
% 交叉概率 pc
% 变异概率 pm
% 动态线性变换 M
syms x
f = 11*sin(6*x) + 7*cos(5*x);
% f =@(x) 11*sin(6*x) + 7*cos(5*x);
fplot(f)
hold on
h = plot(0,0,'*');


varnum = 1;
n = 200;
lb = -pi;
ub = pi;
pc = 0.5;
pm = 0.001;
maxgen = 200;

%% 初始化种群 10进制
for i = 1:varnum
    pop(:,i) = lb(i) + (ub(i)-lb(i))*rand(n,1);
end

for iter = 1:maxgen
    %% 计算适应度值
    fitvalue = fitnessfun(pop);
    fval = objfun(pop);
    h.XData = pop;
    h.YData = fval;
    pause(0.05)
    
    %% 选择
    [dad, mom] = selection(pop, fitvalue);
    
    %% 交叉
    newpop1 = crossover(dad, pc);
    
    %% 变异
    newpop2 = mutation(newpop1, pm, lb, ub);
    
    pop = newpop2;  
end

fitvalue = fitnessfun(pop);

%%
[bestfitness, bestindex] = max(fitvalue)
bestindividual = pop(bestindex,:)
fval = objfun(bestindividual)

plot(bestindividual, fval, 'k*')