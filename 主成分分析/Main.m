clear;clc
% load data1.mat   % 主成分聚类，含x一维数据
 load Data2.mat   % 主成分回归，含x、y二维数据

[n,index] = size(x);  % n：样本个数。index：指标个数

%% 
X = zscore(x);  % 标准化为X

% 计算协方差矩阵
% R = cov(X);

% 直接计算样本相关系数矩阵
R = corrcoef(x);

disp('样本相关系数矩阵为：')
disp(R)

%% 计算R的特征值和特征向量
% R是对称矩阵，Matlab计算对称矩阵时，会将特征值按照从小到大排列
[V,D] = eig(R);  % V：特征向量矩阵。 D：特征值构成的对角矩阵

%% 计算主成分贡献率和累计贡献率
Eigen_value = diag(D);  % 特征值，diag函数得到矩阵的主对角线元素值(返回列向量)
Eigen_value = Eigen_value( end: -1: 1);  % 转换成从大到小排列
disp('特征值为：')
disp(Eigen_value')  
disp('特征向量矩阵为：')
V=rot90(V)';  % 特征向量的各列与特征值对应
disp(V)

Contribution_rate = Eigen_value / sum(Eigen_value);  % 计算贡献率
disp('各自的贡献率为：')
disp(Contribution_rate')

Contribution_rate_cum = cumsum(Eigen_value)/ sum(Eigen_value);   % 计算累计贡献率
disp('累计贡献率为：')
disp(Contribution_rate_cum')

%% 计算主成分的值
k =input('输入要保存的主成分的个数:  ');
F = zeros( n, k);  %初始化
for i = 1:k
    eigen_i = V( :, i)';   % 将第i个特征向量取出，并转置为行向量
    Eigen_i = repmat( eigen_i, n, 1);   
    F( :, i) = sum( Eigen_i .* X, 2); 
end



%% (1)主成分聚类 ： 将主成分指标所在的F矩阵复制到Excel表格，然后再用Spss进行聚类
% 在Excel第一行输入指标名称（F1,F2, ..., Fm）
% F,复制里面的数据到Excel表格
% 导出数据之后，后续的分析就可以在Spss中进行。

%% （2）主成分回归：将x使用主成分得到主成分指标，并将y标准化，接着导出到Excel，然后再使用Stata回归
% Y = zscore(y);  % 将y进行标准化
% 在Excel第一行输入指标名称（Y,F1, F2, ..., Fm）
% Matlab的Y和F,复制里面的数据到Excel表格
% 导出数据之后，后续的分析就可以在Stata中进行。