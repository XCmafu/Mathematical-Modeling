clear
close
clc
%% GeneticAlgorithm
% varnum��������
% eps ����
% lb ub������Χ
% n ��Ⱥ��С
% ������� pc
% ������� pm
% ��̬���Ա任 M
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

%% ��ʼ����Ⱥ 10����
for i = 1:varnum
    pop(:,i) = lb(i) + (ub(i)-lb(i))*rand(n,1);
end

for iter = 1:maxgen
    %% ������Ӧ��ֵ
    fitvalue = fitnessfun(pop);
    fval = objfun(pop);
    h.XData = pop;
    h.YData = fval;
    pause(0.05)
    
    %% ѡ��
    [dad, mom] = selection(pop, fitvalue);
    
    %% ����
    newpop1 = crossover(dad, pc);
    
    %% ����
    newpop2 = mutation(newpop1, pm, lb, ub);
    
    pop = newpop2;  
end

fitvalue = fitnessfun(pop);

%%
[bestfitness, bestindex] = max(fitvalue)
bestindividual = pop(bestindex,:)
fval = objfun(bestindividual)

plot(bestindividual, fval, 'k*')