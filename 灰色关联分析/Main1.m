%% 灰色关联分析用于系统分析
load Data1.mat

Mean = mean(Data);  % 计算每一列的均值
row = size(Data,1);
Data = Data ./ repmat( Mean, row, 1);  % 对应元素相除，得到与各个数据本列平均值的比值
disp('预处理后的矩阵为：'); 
disp(Data)
X_0 = Data( :, 1);  % 母序列
X_i = Data( :, 2: end); % 子序列
ABS_X0_Xi = abs(X_i - repmat( X_0, 1, size( X_i, 2)))  % 计算|X0-Xi|矩阵
a = min(min(ABS_X0_Xi));    % 两级最小差a
b = max(max(ABS_X0_Xi));  % 两级最大差b
rho = 0.5; % 分辨系数取0.5
result = (a + rho*b) ./ (ABS_X0_Xi + rho*b)  % 计算关联系数
disp('子序列中各个指标的灰色关联度分别为：')
disp(mean(result))