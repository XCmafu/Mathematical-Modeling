clear;clc
load Data.mat  % 从53行开始

%% 统计描述，也可用Excel数据分析，SPSS-分析-描述统计
MIN = min(Data);  % 每一列的最小值
MAX = max(Data);   % 每一列的最大值
MEAN = mean(Data);  % 每一列的均值
MEDIAN = median(Data);  % 每一列的中位数
SKEWNESS = skewness(Data); % 每一列的偏度
KURTOSIS = kurtosis(Data);  % 每一列的峰度
STD = std(Data);  % 每一列的标准差
Data_analysis = [ MIN; MAX; MEAN; MEDIAN; SKEWNESS; KURTOSIS; STD]  %将这些统计量放到一个矩阵中中表示

%% 计算各列之间的相关系数
% 在计算皮尔逊相关系数之前,一定要做出散点图来看两组变量之间是否有线性关系
% 这里使用Spss比较方便: 图形 - 旧对话框 - 散点图/点图 - 矩阵散点图

CORRCOEF_data = corrcoef(Data)  % 计算皮尔逊相关系数

%% 假设检验部分
x = -4:0.1:4;
y = tpdf( x, 28);  % 求t分布的概率密度值 28是自由度  
figure(1)
plot( x, y, '-')
grid on  % 加上网格线
hold on  % 保留原来的图

Tinv = tinv(0.975,28) %自由度为28的t分布 显著性水平为0.025，的单侧（显著性水平为0.05，的双侧）的临界值

% 画图得到拒绝域
plot( [-Tinv,-Tinv], [0,tpdf( -Tinv, 28)], 'r-')
plot( [Tinv,Tinv], [0,tpdf( Tinv, 28)], 'r-')
% 与计算出的t，比较是否在落在拒绝域

%% 计算p值
s = 0.5
n = 30
x = -4:0.1:4;
y = tpdf( x, n-2);  % 求t分布的概率密度值 28是自由度 
figure(2)
plot( x, y, '-')
grid on 
hold on
% 画线段的方法
t = s*(((n-2)/(1-s^2))^0.5) % s为已知数据值，n为数据数量
plot( [-t,-t], [0,tpdf( -t, n-2)], 'r-')
plot( [t,t], [0,tpdf( t, n-2)], 'r-')

disp('p值为：')
p = (1-tcdf(t,n-2))*2; % 双侧检验的p值要乘以2
disp(p)  
% p < x%，表示在1-x%的置信水平上拒绝原假设,在x%的置信水平上接受原假设

%% p值检验，来求计算出的皮尔逊相关系数是否显著异于0，H0：CORRCOEF_date=0，
% 计算各列之间的皮尔逊相关系数以及p值
[CORRCOEF_data,P_pearson] = corrcoef(Data)

% 标记星，p：显著性水平，拒绝原假设会有p的概率出错
P_pearson < 0.01  % 相关性很强
(P_pearson < 0.05) & (P_pearson > 0.01) 
(P_pearson < 0.1) & (P_pearson > 0.05)



%% 正态分布检验，H0：服从正态分布
% 检验第一列数据是否为正态分布,JB检验
[h,p] = jbtest( Data(:,1), 0.05) % （默认）将p值与0.05比较，若：p<0.05，H=1拒绝原假设，不服从正态分布（H=0，接受原假设）
% [H,p] = jbtest( Date(:,1), 0.01)

% 用循环检验所有列的数据
column = size( Data, 2);  
H_jb = zeros(1,6);  
P_jb = zeros(1,6);
for i = 1:column
    [h,p] = jbtest( Data(:,i), 0.05);
    H_jb(i) = h;
    P_jb(i) = p;
end
disp(H_jb)
disp(P_jb)

% 第一列Q-Q图
qqplot(Data(:,1))



%% 斯皮尔曼相关系数
X = [3 8 4 7 2]'  % 必须是列向量
Y = [5 10 9 10 6]'

% 计算斯皮尔曼相关系数
% 第一种计算方法
SPEARMAN = 1-6*(1+0.25+0.25+1)/5/24
% 第二种计算方法
SPEARMAN = corr( X, Y, 'type', 'Spearman')
% 第三种计算方法
RX = [2 5 3 4 1] % X元素的等级
RY = [1 4.5 3 4.5 2] % Y元素的等级
SPEARMAN = corrcoef( RX, RY)

% 计算矩阵各列的斯皮尔曼相关系数
SPEARMAN = corr( Data, 'type', 'Spearman')
% 计算检验值
disp(sqrt(590)*0.0301) % 数据量：591-1。 对应斯皮尔曼相关系数：0.0301
% 计算p值
disp((1-normcdf(0.7311))*2) % normcdf用来计算标准正态分布的累积概率密度函数。 对应检验值：0.7311

% 直接给出相关系数和p值
[SPEARMAN,P_spearman] = corr( Data, 'type', 'Spearman')
