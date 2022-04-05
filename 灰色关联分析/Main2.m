%% 灰色关联分析用于综合评价模型例题的讲解
clear;clc
load Data2.mat

%%  判断是否需要正向化
[row,column] = size(X);
Judge = input('是否有指标需要正向化处理，需要输入1，不需要输入0：');

if Judge == 1
    P_column = input('输入需要正向化处理的指标所在的列，如第1、2、3三列需要处理，那么输入[1,2,3]：'); 
    Type = input('指标类型（1：极小型， 2：中间型， 3：区间型）。如：第1列是极小型，第2列是区间型，第3列是中间型，就输入[1,3,2]：'); 
    for i = 1:size( P_column, 2)  %这里需要对这些列分别处理，即循环的次数
        X( :, P_column(i)) = Positive( P_column(i), Type(i), X( :, P_column(i)));
    end
    disp('正向化后的矩阵 =  ')
    disp(X)
end

%% 对正向化后的矩阵进行预处理
Mean = mean(X);  % 计算每一列的均值
row2 = size( X, 1);
X = X ./ repmat( Mean, row2, 1);  
disp('预处理后的矩阵为：'); 
disp(X)

%% 母序列和子序列
X_0 = max( X, [], 2);  % 母序列,为虚拟的，用每一行的最大值构成的列向量表示母序列
X_i = X;  % 子序列：预处理后的数据矩阵

%% 计算得分
ABS_X0_Xi = abs( X_i - repmat( X_0, 1, size( X_i, 2)))  % 计算|X0-Xi|矩阵
a = min(min(ABS_X0_Xi));    % 两级最小差a
b = max(max(ABS_X0_Xi));  % 两级最大差b
rho = 0.5; % 分辨系数取0.5

result = (a + rho*b) ./ (ABS_X0_Xi + rho*b)   % 计算关联系数
weight = mean(result) / sum(mean(result));  % 利用子序列中各个指标的灰色关联度,得到权重
row3 = size( X_i, 1);
Result = sum( X_i .* repmat( weight, row3, 1), 2);   % 得分

Normalization_R = Result / sum(Result);   % 得分归一化后
[sorted_R,index] = sort( Normalization_R, 'descend') % 进行排序