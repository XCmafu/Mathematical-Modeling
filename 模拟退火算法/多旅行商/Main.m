clear;clc

load data.mat
num = size(coord,1);  % 城市的数目

d = zeros(num);   % 初始化两个城市的距离矩阵全为0
for i = 2:num  
    x_i = coord(i,1); y_i = coord(i,2);
    for j = 1:i  
%         coord_i = coord(i,:);   x_i = coord_i(1);     y_i = coord_i(2);  % 城市i的横坐标为x_i，纵坐标为y_i
%         coord_j = coord(j,:);   x_j = coord_j(1);     y_j = coord_j(2);  % 城市j的横坐标为x_j，纵坐标为y_j
        x_j = coord(j,1); y_j = coord(j,2);
        d(i,j) = sqrt((x_i-x_j)^2 + (y_i-y_j)^2);   % 计算城市i和j的距离
    end
end
d = d+d';   % 生成距离矩阵的对称的一面

%% 参数初始化
T0 = 1000;   % 初始温度
T = T0; % 迭代中温度会发生改变，第一次迭代时温度就是T0
maxgen = 1000;  % 最大迭代次数
Lk = 500;  % 每个温度下的迭代次数
alfa = 0.95;  % 温度衰减系数

%% 生成初始解
city_num = num-1; % 表示待访问的城市数量（不包括起始城市）
salesman_num = 5; % 表示可以安排访问任务的旅行商数量
path0 = randperm(city_num);  % 首先生成所有待访问城市的一个随机组合序列
% 在上面的序号中间插入0，实际上就是我们的分割点（最多salesman_num个旅行商工作）
for i = 1:salesman_num-1 % 使用循环，在path0中随机插入car_num-1个0
    len = length(path0); % 计算此时path0的长度（因为在不断插入0，所以长度会不断增加）
    ind = randi(len); % 生产一个1-len之间的随机数，ind表示要插入0的位置
    path0 = [path0(1:ind),0,path0(ind+1:end)]; % 插入0
end

for iter = 1 : maxgen  % 外循环, 我这里采用的是指定最大迭代次数
    [cpath,k] = clear_path(path0,salesman_num);
    [cost,~] = calculate_mtsp_cost(cpath,k,d);
    iter_path(iter,:) = path0;
    iter_result(iter,:) = cost;
    result0 = cost;
    for i = 1 : Lk  %  内循环，在每个温度下开始迭代
%         [cpath,k] = clear_path(path0,salesman_num);
%         [cost,~] = calculate_mtsp_cost(cpath,k,d);
%         result0 = cost;
        path_new = gen_new_path(path0);
        [cpath,k] = clear_path(path_new,salesman_num);
        [cost,~] = calculate_mtsp_cost(cpath,k,d);
        result_new = cost;
        if result_new < result0    % 如果新路径的距离小于当前路径的距离
            path0 = path_new; % 更新当前路径为新路径
            result0 = result_new;
            iter_path(iter,:) = path_new; % 将新找到的path1添加到中间结果中
            iter_result(iter,:) = result_new;  % 将新找到的result1添加到中间结果中
%             iter_path = [iter_path; path_new]; % 将新找到的path1添加到中间结果中
%             iter_result = [iter_result; result_new];  % 将新找到的result1添加到中间结果中
        else
            p = exp(-(result_new - result0)/T); % 根据Metropolis准则计算一个概率
            if rand(1) < p   % 生成一个随机数和这个概率比较，如果该随机数小于这个概率
                path0 = path_new;  % 更新当前路径为新路径
            end
        end
    end
    T = alfa*T;   % 温度下降 
end

[best_result, ind] = min(iter_result);  % 找到最小的距离的值，以及其在向量中的下标
best_min_path = iter_path(ind,:); % 根据下标找到此时路径
disp('最佳的方案是：'); disp(best_min_path)
disp('此时最优值是：'); disp(best_result)

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