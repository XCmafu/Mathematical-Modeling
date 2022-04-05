clear;close;clc
%%
% syms x
% f = 11*sin(6*x) + 13*cos(5*x);
% % f =@(x) 11*sin(6*x) + 13*cos(5*x);
% fplot(f)
% hold on 
% h = plot(0, 0, '*');

% x1 = -15:1:15;
% x2 = -15:1:15;
% [x1,x2] = meshgrid(x1, x2);
% f = x1.^2 + x2.^2 - x1.*x2 - 10*x1 - 4*x2 + 60;
% figure(1);
% mesh(x1, x2, f)
% xlabel('x1');  ylabel('x2');  zlabel('f');
% axis vis3d % 冻结屏幕高宽比，使得一个三维对象的旋转不会改变坐标轴的刻度显示
% hold on  % 不关闭图形，继续在上面画图

x1 = -1:0.05:12;
x2 = 4:0.05:6;
[x1,x2] = meshgrid(x1, x2);
f = x1.*sin(pi.*x1) + x2.*sin(exp(x2));
figure(1);
mesh(x1, x2, f)
xlabel('x1');  ylabel('x2');  zlabel('f');
hold on  % 不关闭图形，继续在上面画图

% 参数定义
global M sn
M = 2; % 动态线性变换 M
sn = 3; % 锦标赛参与人数 sn
% varnum = 1; % 变量个数
varnum = 2; % 变量个数
n = 200; % 种群大小
% lb = -pi;
% ub = pi;
lb = [-1 4];
ub = [12 6];
eps = 1e-5; % 精度
pc = 0.9; % 交叉概率
pm = 0.01; % 变异概率
maxgen = 100; % 迭代次数

% 初始化种群
for i = 1:varnum
    L(i) = ceil(log2((ub(i) - lb(i)) / eps + 1)); % 每个变量的位长
end
LS = sum(L); % 总位长
pop = randi([0 1], n, LS); % 初始化种群(二进制)
spoint = cumsum([0 L]);

bestfit = [];
bestreal = [];
% 将二进制转化为十进制
for i = 1:n
    for j = 1:varnum
        startpoint = spoint(j) + 1;
        endpoint = spoint(j+1);
        real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
    end
end
% 计算适应度值 (求最大值)
fval = objfun(real);
h = scatter3(real(:,1), real(:,2), fval, '*r');

for iter = 1:maxgen
    % 将二进制转化为十进制
    for i = 1:n
        for j = 1:varnum
            startpoint = spoint(j) + 1;
            endpoint = spoint(j+1);
            real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
        end
    end
    
    % 计算适应度值 (求最大值)
    fit = fitnessfun(real); % 0或f(real)+0.1
    fval = objfun(real);
%     h.XData = real;
%     h.YData = fval;
    h.XData = real(:,1);
    h.YData = real(:,2);
    h.ZData = fval;
    pause(0.05)
    
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
bestvalue_x = bestreal(bestindexvalue,:) % 最终的x值
bestvalue_f = objfun(bestvalue_x) % 最终y值

% plot(bestvalue_x,bestvalue_f,'k*')
scatter3(bestvalue_x(:,1), bestvalue_x(:,2), bestvalue_f, '*k')