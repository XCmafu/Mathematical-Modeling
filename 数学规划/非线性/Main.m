% [x,fval] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,@nonlfun,option)
% @fun��ʾĿ�꺯��
% @nonlfun��ʾ������Լ���ĺ���
% x0��ʾ�����ĳ�ʼֵ����������������������ʾ����Ӧ��lb,ub����������������������
% option ��ʾ�������Թ滮ʹ�õķ���

% ʹ��interior point�㷨 ���ڵ㷨��
option = optimoptions('fmincon','Algorithm','interior-point')
% ʹ��SQP�㷨 �����ж��ι滮����
option = optimoptions('fmincon','Algorithm','sqp')
% ʹ��active set�㷨 ����Ч������
option = optimoptions('fmincon','Algorithm','active-set')
% ʹ��trust region reflective (���������㷨)
option = optimoptions('fmincon','Algorithm','trust-region-reflective')

x0 = [];  % ��������ĳ�ʼֵ 
A = [];   % ����ʽԼ��Ax<=b��ϵ������
b = []';  % ������������ʽԼ��Ax<=b�ĳ�����
Aeq = []; % ��ʽԼ��Aeq x=beq��ϵ������
beq = []; % ����������ʽԼ��Aeq x=beq�ĳ�����
lb = []'; % X������
ub = []'; % X������