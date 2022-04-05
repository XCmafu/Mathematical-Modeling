%% f = 11*sin(6*x) + 7*cos(5*x) ���ֵ
clear
close
clc
%% GeneticAlgorithm
% varnum ��������
% eps ����
% lb ub ������Χ
% n ��Ⱥ��С
% ������� pc
% ������� pm 
% ��̬���Ա任 M
syms x
f = 11*sin(6*x) + 7*cos(5*x);
% f = @(x) 11*sin(6*x) + 7*cos(5*x);
fplot(f)
hold on 
h = plot(0, 0, '*');

global M
M = 2;
varnum = 1; % varnum ��������
n = 200; % n ��Ⱥ��С
lb = -pi;
ub = pi;
eps = 1e-2; % eps ����
pc = 0.9; % ������� pc
pm = 0.005; % ������� pm 
maxgen = 100; % ��������

%% ��ʼ����Ⱥ
for i = 1:varnum
    L(i) = ceil(log2((ub(i) - lb(i)) / eps + 1));
end

LS = sum(L); % ��λ��
pop = randi([0 1],n,LS); % ÿ����Ⱥ�����б��� �Ķ�����������n*LS��ֻ��0 1�ľ���
spoint = cumsum([0 L]);

for iter = 1:maxgen
    %% ��������ת��Ϊʮ����
    for i = 1:n
        for j = 1:varnum
            startpoint = spoint(j) + 1;
            endpoint = spoint(j+1);
            real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
        end
    end
    
    %% ������Ӧ��ֵ
    fitvalue = fitnessfun(real);
    fval = objfun(real);
    h.XData = real;
    h.YData = fval;
    pause(0.1)
    
    %% ѡ��
    [dad, mom] = selection (pop, fitvalue);
    
    %% ����
    newpop1 = crossover(dad, mom, pc);
    
    %% ����
    newpop2 = mutation(newpop1, pm);
    
    pop = newpop2;
end

for i = 1:n
    for j = 1:varnum
        startpoint = spoint(j) + 1;
        endpoint = spoint(j+1);
        real(i,j) = decode(pop(i,startpoint:endpoint),lb(j),ub(j));
    end
end
fitvalue = fitnessfun(real);

%%
[bestfitness, bestindex] = max(fitvalue)
bestindividual = real(bestindex,:)
fval = objfun(bestindividual)

plot(bestindividual,fval,'k*')