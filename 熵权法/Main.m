%% 对矩阵进行标准化
clear;clc
load data.mat

[row,column] = size(M);
M_Stand = M ./ repmat(sum(M.*M) .^ 0.5, row, 1);

% 熵权
if sum(sum(M_Stand<0)) >0   % 标准化后的矩阵中存在负数，则重新对X进行标准化
    disp('原来标准化得到的Z矩阵中存在负数，所以需要对X重新标准化')
    for i = 1:row
        for j = 1:column
            M_Stand(i,j) = (M(i,j) - min(M(:,j))) / (max(M(:,j)) - min(M(:,j)));
        end
    end
    disp('X重新进行标准化得到的标准化矩阵Z为:  ')
    disp(M_Stand)
end
weight = shangquanfa(M_Stand);
disp('熵权法确定的权重为：')
disp(weight)