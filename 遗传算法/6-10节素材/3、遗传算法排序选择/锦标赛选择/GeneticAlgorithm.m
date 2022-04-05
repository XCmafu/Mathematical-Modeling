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
% axis vis3d % ������Ļ�߿�ȣ�ʹ��һ����ά�������ת����ı�������Ŀ̶���ʾ
% hold on  % ���ر�ͼ�Σ����������滭ͼ

x1 = -1:0.05:12;
x2 = 4:0.05:6;
[x1,x2] = meshgrid(x1, x2);
f = x1.*sin(pi.*x1) + x2.*sin(exp(x2));
figure(1);
mesh(x1, x2, f)
xlabel('x1');  ylabel('x2');  zlabel('f');
hold on  % ���ر�ͼ�Σ����������滭ͼ

% ��������
global M sn
M = 2; % ��̬���Ա任 M
sn = 3; % �������������� sn
% varnum = 1; % ��������
varnum = 2; % ��������
n = 200; % ��Ⱥ��С
% lb = -pi;
% ub = pi;
lb = [-1 4];
ub = [12 6];
eps = 1e-5; % ����
pc = 0.9; % �������
pm = 0.01; % �������
maxgen = 100; % ��������

% ��ʼ����Ⱥ
for i = 1:varnum
    L(i) = ceil(log2((ub(i) - lb(i)) / eps + 1)); % ÿ��������λ��
end
LS = sum(L); % ��λ��
pop = randi([0 1], n, LS); % ��ʼ����Ⱥ(������)
spoint = cumsum([0 L]);

bestfit = [];
bestreal = [];
% ��������ת��Ϊʮ����
for i = 1:n
    for j = 1:varnum
        startpoint = spoint(j) + 1;
        endpoint = spoint(j+1);
        real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
    end
end
% ������Ӧ��ֵ (�����ֵ)
fval = objfun(real);
h = scatter3(real(:,1), real(:,2), fval, '*r');

for iter = 1:maxgen
    % ��������ת��Ϊʮ����
    for i = 1:n
        for j = 1:varnum
            startpoint = spoint(j) + 1;
            endpoint = spoint(j+1);
            real(i,j) = decode(pop(i,startpoint:endpoint), lb(j), ub(j));
        end
    end
    
    % ������Ӧ��ֵ (�����ֵ)
    fit = fitnessfun(real); % 0��f(real)+0.1
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
bestvalue_x = bestreal(bestindexvalue,:) % ���յ�xֵ
bestvalue_f = objfun(bestvalue_x) % ����yֵ

% plot(bestvalue_x,bestvalue_f,'k*')
scatter3(bestvalue_x(:,1), bestvalue_x(:,2), bestvalue_f, '*k')