clc, clear
load Data;

x(:,[2,6]) = -x(:,[2,6]); % 把成本型指标转换成效益型指标，越小越好转换成越大越好
R = tiedrank(x); % 对每个指标值分别编秩，即对x的每一列分别编秩

[n,m] = size(R); % 计算矩阵R的维数
% 无权重
% RSR = mean(R,2)/n;  % 计算秩和比
% 有权重
W = repmat(w, n, 1);
WRSR = sum(R.*W,2)/n;  % 计算加权秩和比

[sWRSR,ind] = sort(WRSR); % 对加权秩和比排序 
p = (1:n)/n;    % 计算累积频率
p(n) = 1-1/(4*n); % 修正最后一个累积频率，最后一个累积频率按1-1/(4*n)估计

Probit = norminv(p,0,1)+5;  % 计算标准正态分布的p分位数+5
X = [ones(n,1), Probit'];  % 构造一元线性回归分析的数据矩阵
[b,bint,r,rint,stats] = regress(sWRSR, X);  % 一元线性回归分析 sWRSR因变量 X自变量
disp(stats) % R2 统计量、F 统计量及其 p 值，以及误差方差的估计值
WRSRfit = b(1)+b(2)*Probit;  % 计算WRSR的估计值
y = [1983:1992]'; 
xlswrite('result.xls',[y(ind), R(ind,:), sWRSR],1) % 加权秩和比排序结果，数据写入表单“Sheet1”中 
xlswrite('result.xls',[y(ind), ones(n,1), [1:n]', p', Probit', WRSRfit', [n:-1:1]'], 2) % 分档排序结果，数据写入表单“Sheet2”中 