%% Matlab�Դ�������Ⱥ���� particleswarm
clear;clc

%% ֱ�ӵ���particleswarm�����������
narvs = 30; % ��������

% Sphere����
% x_low = -100*ones(1,30); % x���½�
% x_up = 100*ones(1,30); % x���Ͻ�
% 
% Rosenbrock����
x_low = -30*ones(1,30); % x���½�
x_up = 30*ones(1,30); % x���Ͻ�
% 
% Rastrigin����
% x_low = -5.12*ones(1,30); % x���½�
% x_up = 5.12*ones(1,30); % x���Ͻ�
% 
% Griewank����
% x_low = -600*ones(1,30); % x���½�
% x_up = 600*ones(1,30); % x���Ͻ�

[x,fval,exitflag,output] = particleswarm(@Obj_fun3, narvs, x_low, x_up)  

%% ������ѵĺ���ֵ����������ı仯ͼ
options = optimoptions('particleswarm','PlotFcn','pswplotbestf')   
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% չʾ�����ĵ�������
options = optimoptions('particleswarm','Display','iter');
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% �޸�����������Ĭ�ϵ��ǣ�min(100,10*nvars)
options = optimoptions('particleswarm','SwarmSize',50);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% ������Ⱥ�㷨�õ��Ľ���Ϊ��ʼֵ���������������������к�����⣬hybrid  n.�����ϳ���; adj.��ϵ�; ���ֵ�; 
options = optimoptions('particleswarm','HybridFcn',@fmincon);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% ����Ȩ�صı仯��Χ��Ĭ�ϵ���0.1-1.1
options = optimoptions('particleswarm','InertiaRange',[0.2 1.2]);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% ����ѧϰ���ӣ�Ĭ�ϵ���1.49��ѹ�����ӣ�
options = optimoptions('particleswarm','SelfAdjustmentWeight',2);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% ���ѧϰ���ӣ�Ĭ�ϵ���1.49��ѹ�����ӣ�
options = optimoptions('particleswarm','SocialAdjustmentWeight',2);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% ���ĵ���������Ĭ�ϵ���200*nvars
options = optimoptions('particleswarm','MaxIterations',10000);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% ���������ӵı��� MinNeighborsFraction��Ĭ����0.25 
options = optimoptions('particleswarm','MinNeighborsFraction',0.2);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% �������̶�FunctionTolerance, Ĭ��1e-6, ���ڿ����Զ��˳������Ĳ���
options = optimoptions('particleswarm','FunctionTolerance',1e-8);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% ���ͣ�͵�����MaxStallIterations, Ĭ��20, ���ڿ����Զ��˳������Ĳ���
options = optimoptions('particleswarm','MaxStallIterations',50);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)

%% �����Ǽ���ʱ�䣬ͬʱ�޸��������Ƶ����˳��Ĳ���
tic
options = optimoptions('particleswarm','FunctionTolerance',1e-12,'MaxStallIterations',100,'MaxIterations',100000);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)
toc

%% ������Ⱥ��������������������л�����
tic
options = optimoptions('particleswarm','FunctionTolerance',1e-12,'MaxStallIterations',50,'MaxIterations',20000,'HybridFcn',@fmincon);
[x,fval] = particleswarm(@Obj_fun3, narvs, x_low, x_up, options)
toc