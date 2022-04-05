%% 计算当前解对应的成本
% 输入
% cpath：当前解经过清洗拆分后得到的一个元胞数组，用来存储参与运输的每个旅行商经过的城市
% k：有多少旅行商工作了
% d：距离矩阵（别忘了第一个位置表示起始的城市）
% 例如一共n个城市，那么起始城市要放在第一个位置，d是n*n的距离矩阵
% 输出
% cost：当前解对应的总成本（所有旅行商的路程长度的总和）
% every_cost：每个旅行商的成本（路程）

function [cost,every_cost] = calculate_mtsp_cost(cpath,k,d)
% 要计算所有旅行商的路程长度的总和，我们需要首先计算每个旅行商的路程长度
    every_cost = zeros(k,1);  % 初始化每个旅行商的路程长度全为0
    for i = 1:k % 对每个旅行商开始循环 
        path_i = cpath{i};  % 第i个旅行商所经过的路线
        n = length(path_i); % 第i个旅行商经过的城市的数量
        for j = 1:n
            if j == 1
                every_cost(i) = every_cost(i) + d(1,path_i(j)+1);  % 一定要注意，d中第一个位置表示起始的城市
            else
                every_cost(i) = every_cost(i) + d(path_i(j-1)+1,path_i(j)+1);
            end
        end
        every_cost(i) = every_cost(i) + d(path_i(end)+1,1); % 别忘了加上从最后一个城市返回到起始城市的路程
        if n>10
            every_cost(i) = every_cost(i) + (n-10)*10000;
    end
%     cost = sum(every_cost);  % 计算总的成本
    cost = sum(every_cost)*10 + k*10000;
end
