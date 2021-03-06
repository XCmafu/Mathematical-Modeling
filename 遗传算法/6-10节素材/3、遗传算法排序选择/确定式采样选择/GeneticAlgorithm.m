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
f = 11*sin(6*x) + 13*cos(5*x);
% f =@(x) 11*sin(6*x) + 13*cos(5*x);
fplot(f)
hold on 
h = plot(0,0,'*');

global M
M = 2;
varnum = 1;
n = 100;
lb = -pi;
ub = pi;
eps = 1e-5;
q = 0.3;
pc = 0.9;
pm = 0.01;
maxgen = 100;


%% 初始化种群
for i = 1:varnum
    L(i) = ceil(log2((ub(i) - lb(i)) / eps + 1));
end

LS = sum(L);%总位长
pop = randi([0 1], n, LS);
spoint = cumsum([0 L]);

for iter = 1:maxgen
    %% 将二进制转化为十进制
    for i = 1:n
        for j = 1:varnum
            startpoint = spoint(j) + 1;
            endpoint = spoint(j+1);
            real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
        end
    end
    
    %% 计算适应度值
    fitvalue = fitnessfun(real);
    fval = objfun(real);
    h.XData = real;
    h.YData = fval;
    pause(0.1)
    
    %% 选择
    [dad, mom] = selection (pop, fitvalue);
    
    %% 交叉
    newpop1 = crossover(dad, mom, pc);
    
    %% 变异
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
fitvalue = fitnessfun(real);

[bestfitness, bestindex] = max(fitvalue)
bestindividual = real(bestindex,:)
fval = objfun(bestindividual)

plot(bestindividual,fval,'k*')