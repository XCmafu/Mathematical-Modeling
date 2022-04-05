%% ��������ֲ����Ž�,�þ�������
%% f = 11*sin(6*x) + 7*cos(5*x) ���ֵ 
clear;close;clc
%%
syms x
f = 11*sin(6*x) + 7*cos(5*x);
% f = @(x) 11*sin(6*x) + 7*cos(5*x);
fplot(f)
hold on 
h = plot(0,0,'*');

% ��������
varnum = 1; % varnum ��������
n = 500; % n ��Ⱥ��С
lb = -pi; % ����
ub = pi; % ����
% lb = [-pi -3 -2 -1 0];
% ub = [pi pi pi pi pi];
eps = 1e-4; % eps ����
pc = 0.9; % ������� pc
pm = 0.01; % ������� pm 
maxgen = 100; % ��������

% ��ʼ����Ⱥ
for i = 1:varnum
    L(i) = ceil(log2((ub(i) - lb(i)) / eps + 1)); % ����
end
LS = sum(L); % ��λ��
pop = randi([0 1], n, LS); % ÿ����Ⱥ�����б��� �Ķ�����������n*LS��ֻ��0 1�ľ���
spoint = cumsum([0 L]);

bestfit = [];
bestreal = [];
for iter = 1:maxgen
    % ��������ת��Ϊʮ����
    for i = 1:n
        for j = 1:varnum
            startpoint = spoint(j) + 1;
            endpoint = spoint(j+1);
            real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
        end
    end
    
    % ������Ӧ��ֵ�������ֵ��
    fit = fitnessfun(real); % 0��f(real)+0.01
    fval = objfun(real);
    h.XData = real;
    h.YData = fval;
    pause(0.1)
    
    [bestfitness, bestindex] = max(fit);
    bestfit = [bestfit; bestfitness];
    bestrealness = real(bestindex,:);
    bestreal = [bestreal; bestrealness];

    % ѡ��
    [dad, mom] = selection (pop, fit);
    
    % ����
    newpop1 = crossover(dad, mom, pc);
    
    % ����
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
