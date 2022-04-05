%% ����ӦȨ�أ���ѹ�����ӵ�����Ⱥ�㷨PSO: ������ֲ�ͬ���Ժ�������Сֵ
% �����ֵ��Ȩ��w��Ҫ��һ��
clear; clc

%% ����Ⱥ�㷨�е�Ԥ����������������ò��ǹ̶��ģ������ʵ��޸ģ�
tic % ��ʼ��ʱ
n = 1000; % ��������
narvs = 30; % ��������
c1 = 2.05;  % ÿ�����ӵĸ���ѧϰ���ӣ�Ҳ��Ϊ������ٳ���
c2 = 2.05;  % ÿ�����ӵ����ѧϰ���ӣ�Ҳ��Ϊ�����ٳ���
C = c1+c2; 
fai = 2/abs((2-C-sqrt(C^2-4*C))); % ��������
w_max = 0.9;  % ������Ȩ�أ�ͨ��ȡ0.9
w_min = 0.4; % ��С����Ȩ�أ�ͨ��ȡ0.4
K = 1000;  % �����Ĵ���

% Sphere����
% vmax = 30*ones(1,30); % ���ӵ�����ٶ�
% x_low = -100*ones(1,30); % x���½�
% x_up = 100*ones(1,30); % x���Ͻ�
% 
% Rosenbrock����
vmax = 10*ones(1,30); % ���ӵ�����ٶ�
x_low = -30*ones(1,30); % x���½�
x_up = 30*ones(1,30); % x���Ͻ�
% 
% Rastrigin����
% vmax = 1.5*ones(1,30); % ���ӵ�����ٶ�
% x_low = -5.12*ones(1,30); % x���½�
% x_up = 5.12*ones(1,30); % x���Ͻ�
% 
% Griewank����
% vmax = 150*ones(1,30); % ���ӵ�����ٶ�
% x_low = -600*ones(1,30); % x���½�
% x_up = 600*ones(1,30); % x���Ͻ�

%% ��ʼ�����ӵ�λ�ú��ٶ�
x = zeros(n, narvs);
for i = 1: narvs
    x(:,i) = x_low(i) + (x_up(i)-x_low(i))*rand(n,1);    % �����ʼ���������ڵ�λ��
end
v = -vmax + 2*vmax .* rand(n, narvs);  % �����ʼ�����ӵ��ٶ�[-vmax,vmax]

%% ������Ӧ��
fit = zeros(n,1);  % ��ʼ����n�����ӵ���Ӧ��ȫΪ0
for i = 1:n  % ѭ����������Ⱥ������ÿһ�����ӵ���Ӧ��
    fit(i) = Obj_fun3(x(i,:));   % ����Obj_fun3������������Ӧ��
end 
pbest = x;   % ��ʼ����n����������Ϊֹ�ҵ������λ��
ind = find(fit == min(fit), 1);  % �ҵ���Ӧ����С���Ǹ����ӵ��±�
gbest = x(ind,:);  % ����������������Ϊֹ�ҵ������λ��

%% ����K���������ٶ���λ��
fitbest = ones(K,1);  % ��ʼ��ÿ�ε����õ�����ѵ���Ӧ��
for m = 1:K  % ��ʼ������һ������K��
    for i = 1:n   % ���θ��µ�i�����ӵ��ٶ���λ��
        f_i = fit(i);  % ȡ����i�����ӵ���Ӧ��
        f_avg = sum(fit)/n;  % �����ʱ��Ӧ�ȵ�ƽ��ֵ
        % ����Сֵ
        f_min = min(fit); % �����ʱ��Ӧ�ȵ���Сֵ
        if f_i <= f_avg  %����ӦȨ��
            w = w_min + (w_max - w_min)*(f_i - f_min)/(f_avg - f_min);
        else
            w = w_max;
        end
%         % �����ֵ
%         f_max = max(fit); % �����ʱ��Ӧ�ȵ���Сֵ
%         if f_i >= f_avg  %����ӦȨ��
%             w = w_min + (w_max - w_min)*(f_max - f_i)/(f_max - f_avg);
%         else
%             w = w_max;
%         end
        
        v(i,:) = fai * (w*v(i,:) + c1*rand(1)*(pbest(i,:) - x(i,:)) + c2*rand(1)*(gbest - x(i,:)));  % ���µ�i�����ӵ��ٶ�
        % ������ӵ��ٶȳ���������ٶ����ƣ��Ͷ�����е���
        for j = 1: narvs
            if v(i,j) < -vmax(j)
                v(i,j) = -vmax(j);
            elseif v(i,j) > vmax(j)
                v(i,j) = vmax(j);
            end
        end
        
        x(i,:) = x(i,:) + v(i,:); % ���µ�i�����ӵ�λ��
        % ������ӵ�λ�ó����˶����򣬾Ͷ�����е���
        for j = 1: narvs
            if x(i,j) < x_low(j)
                x(i,j) = x_low(j);
            elseif x(i,j) > x_up(j)
                x(i,j) = x_up(j);
            end
        end
        
        fit(i) = Obj_fun3(x(i,:));  % ���¼����i�����ӵ���Ӧ��
        if fit(i) < Obj_fun3(pbest(i,:))   % �����i�����ӵ���Ӧ��С�������������Ϊֹ�ҵ������λ�ö�Ӧ����Ӧ��
           pbest(i,:) = x(i,:);   % �Ǿ͸��µ�i����������Ϊֹ�ҵ������λ��
        end
        if  Obj_fun3(pbest(i,:)) < Obj_fun3(gbest)  % �����i�����ӵ���Ӧ��С�����е���������Ϊֹ�ҵ������λ�ö�Ӧ����Ӧ��
            gbest = pbest(i,:);   % �Ǿ͸���������������Ϊֹ�ҵ������λ��
        end
    end
    fitbest(m) = Obj_fun3(gbest);  % ���µ�d�ε����õ�����ѵ���Ӧ��
end

figure(2) 
plot(fitbest)  % ���Ƴ�ÿ�ε��������Ӧ�ȵı仯ͼ
xlabel('��������');
disp('��ѵ�λ���ǣ�'); disp(gbest)
disp('��ʱ����ֵ�ǣ�'); disp(Obj_fun3(gbest))

toc % ������ʱ