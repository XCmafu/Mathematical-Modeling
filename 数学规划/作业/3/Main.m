% [x,fval] = fmincon(@fun,x0,A,b,Aeq,beq,lb,ub,@nonlfun,option)

N = 1000000;
x1 = unifrnd(0, 3, N, 1);   % x1��0~3֮����ȷֲ�
x2 = unifrnd(-1, 10, N, 1);  % x2��-8~7֮����ȷֲ�
%
x3 = 2 - x1.^2;   
max = -inf; % ��ʼ��
for i = 1:N
    x = [x1(i), x2(i), x3(i)];  %����x����
    if (x(1)+2*x(1)^2+x(2)+2*x(2)^2+x(3)-10<=0) & (x(1)+x(1)^2+x(2)+x(2)^2-x(3)-50<=0) & (2*x(1)+x(1)^2+2*x(2)+x(3)-40<=0) & (x(1)+2*x(2)>=1)
        result = 2*x(1)+3*x(1)^2+3*x(2)+x(2)^2+x(3) ;  % ��������
        if  result > max  
            max = result;  
            x0 = x;
        end
    end
end
disp('���ؿ����㷨ѡȡ�ĳ�ʼֵΪ��')
x0 = x0';
disp(x0)

lb = [0 -inf -inf];

% option = optimoptions('fmincon','Algorithm','interior-point')
% % ʹ��SQP�㷨 �����ж��ι滮����
% option = optimoptions('fmincon','Algorithm','sqp')
% % ʹ��active set�㷨 ����Ч������
% option = optimoptions('fmincon','Algorithm','active-set')
% % ʹ��trust region reflective (���������㷨)
% option = optimoptions('fmincon','Algorithm','trust-region-reflective')


[x,fval] = fmincon(@fun, x0, [], [], [], [], lb, [], @nonlfun)
fval = -fval
