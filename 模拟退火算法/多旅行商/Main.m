clear;clc

load data.mat
num = size(coord,1);  % ���е���Ŀ

d = zeros(num);   % ��ʼ���������еľ������ȫΪ0
for i = 2:num  
    x_i = coord(i,1); y_i = coord(i,2);
    for j = 1:i  
%         coord_i = coord(i,:);   x_i = coord_i(1);     y_i = coord_i(2);  % ����i�ĺ�����Ϊx_i��������Ϊy_i
%         coord_j = coord(j,:);   x_j = coord_j(1);     y_j = coord_j(2);  % ����j�ĺ�����Ϊx_j��������Ϊy_j
        x_j = coord(j,1); y_j = coord(j,2);
        d(i,j) = sqrt((x_i-x_j)^2 + (y_i-y_j)^2);   % �������i��j�ľ���
    end
end
d = d+d';   % ���ɾ������ĶԳƵ�һ��

%% ������ʼ��
T0 = 1000;   % ��ʼ�¶�
T = T0; % �������¶Ȼᷢ���ı䣬��һ�ε���ʱ�¶Ⱦ���T0
maxgen = 1000;  % ����������
Lk = 500;  % ÿ���¶��µĵ�������
alfa = 0.95;  % �¶�˥��ϵ��

%% ���ɳ�ʼ��
city_num = num-1; % ��ʾ�����ʵĳ�����������������ʼ���У�
salesman_num = 5; % ��ʾ���԰��ŷ������������������
path0 = randperm(city_num);  % �����������д����ʳ��е�һ������������
% �����������м����0��ʵ���Ͼ������ǵķָ�㣨���salesman_num�������̹�����
for i = 1:salesman_num-1 % ʹ��ѭ������path0���������car_num-1��0
    len = length(path0); % �����ʱpath0�ĳ��ȣ���Ϊ�ڲ��ϲ���0�����Գ��Ȼ᲻�����ӣ�
    ind = randi(len); % ����һ��1-len֮����������ind��ʾҪ����0��λ��
    path0 = [path0(1:ind),0,path0(ind+1:end)]; % ����0
end

for iter = 1 : maxgen  % ��ѭ��, ��������õ���ָ������������
    [cpath,k] = clear_path(path0,salesman_num);
    [cost,~] = calculate_mtsp_cost(cpath,k,d);
    iter_path(iter,:) = path0;
    iter_result(iter,:) = cost;
    result0 = cost;
    for i = 1 : Lk  %  ��ѭ������ÿ���¶��¿�ʼ����
%         [cpath,k] = clear_path(path0,salesman_num);
%         [cost,~] = calculate_mtsp_cost(cpath,k,d);
%         result0 = cost;
        path_new = gen_new_path(path0);
        [cpath,k] = clear_path(path_new,salesman_num);
        [cost,~] = calculate_mtsp_cost(cpath,k,d);
        result_new = cost;
        if result_new < result0    % �����·���ľ���С�ڵ�ǰ·���ľ���
            path0 = path_new; % ���µ�ǰ·��Ϊ��·��
            result0 = result_new;
            iter_path(iter,:) = path_new; % �����ҵ���path1��ӵ��м�����
            iter_result(iter,:) = result_new;  % �����ҵ���result1��ӵ��м�����
%             iter_path = [iter_path; path_new]; % �����ҵ���path1��ӵ��м�����
%             iter_result = [iter_result; result_new];  % �����ҵ���result1��ӵ��м�����
        else
            p = exp(-(result_new - result0)/T); % ����Metropolis׼�����һ������
            if rand(1) < p   % ����һ���������������ʱȽϣ�����������С���������
                path0 = path_new;  % ���µ�ǰ·��Ϊ��·��
            end
        end
    end
    T = alfa*T;   % �¶��½� 
end

[best_result, ind] = min(iter_result);  % �ҵ���С�ľ����ֵ���Լ����������е��±�
best_min_path = iter_path(ind,:); % �����±��ҵ���ʱ·��
disp('��ѵķ����ǣ�'); disp(best_min_path)
disp('��ʱ����ֵ�ǣ�'); disp(best_result)

%%
[cpath,k] = clear_path(best_min_path,salesman_num);
x = cell(5,1);
y = cell(5,1);
for i = 1:k
    best_path = [0,cpath{i},0];
    best_path = best_path+1;
    n = length(best_path);
    for a = 1:n
        x_a = coord(best_path(a),1); y_a = coord(best_path(a),2);
        x{i} = [x{i},x_a]; y{i} = [y{i},y_a];
    end
end

plot(coord(2:end,1),coord(2:end,2),'mo');
hold on
plot(coord(1,1),coord(1,2),'ms');
plot(x{1},y{1},'r-');
plot(x{2},y{2},'b-');
plot(x{3},y{3},'g-');
plot(x{4},y{4},'c-');
plot(x{5},y{5},'k-');