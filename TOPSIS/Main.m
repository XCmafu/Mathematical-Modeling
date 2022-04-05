%%
clear;clc
load Data.mat

%%  判断是否需要正向化
[row,column] = size(M);
Judge = input('是否有指标需要正向化处理，需要输入1，不需要输入0：');

if Judge == 1
    P_column = input('输入需要正向化处理的指标所在的列，如第1、2、3三列需要处理，那么输入[1,2,3]：'); 
    Type = input('指标类型（1：极小型， 2：中间型， 3：区间型）。如：第1列是极小型，第2列是区间型，第3列是中间型，就输入[1,3,2]：'); 
    for i = 1:size( P_column, 2)  %这里需要对这些列分别处理，即循环的次数
        M_positive( :, P_column(i)) = Positive( P_column(i), Type(i), M( :, P_column(i)));
    end
    disp('正向化后的矩阵 =  ')
    disp(M_positive)
else
    M_positive = M;
end

%% 是否需要增加权重
disp("请输入是否需要增加权重向量，需要输入1，不需要输入0")
Judge = input('请输入是否需要增加权重： ');
if Judge == 1
    disp(['如果你有3个指标，你就需要输入3个权重，例如它们分别为0.25,0.25,0.5, 则你需要输入[0.25,0.25,0.5]']);
    weigh = input(['你需要输入' num2str(m) '个权数。' '请以行向量的形式输入这' num2str(m) '个权重: ']);
    OK = 0;  % 用来判断用户的输入格式是否正确
    while OK == 0 
        if abs(sum(weigh) - 1)<0.000001 && size(weigh,1) == 1 && size(weigh,2) == m   % 这里要注意浮点数的运算是不精准的。
             OK =1;
        else
            weigh = input('你输入的有误，请重新输入权重行向量: ');
        end
    end
else
    weigh = ones(1,m) ./ m ; %如果不需要加权重就默认权重都相同，即都为1/m
end

%% 对正向化后的矩阵进行标准化
M_Stand = M_positive ./ repmat( sum(M_positive.*M_positive) .^0.5, row, 1);
disp('标准化矩阵 = ')
disp(M_Stand)

%% 计算与最大值的距离和最小值的距离，并算出得分，再归一化
D_Max = sum(((M_Stand - repmat( max(M_Stand), row, 1)) .^2 ).* repmat(weigh,n,1),2) .^0.5;   % D+ 与最大值的距离向量
D_Min = sum(((M_Stand - repmat( min(M_Stand), row, 1)) .^2 ).* repmat(weigh,n,1),2) .^0.5;   % D- 与最小值的距离向量
S = D_Min ./ (D_Max+D_Min);    % 未归一化的得分

disp('归一化得分为：')
Normal_S = S / sum(S)

disp('降序排序结果：')
[sort_S,index] = sort( Normal_S , 'descend')


% sort(A)若A是向量不管是列还是行向量，默认都是对A进行升序排列。sort(A)是默认的升序，而sort(A,'descend')是降序排序。
% sort(A)若A是矩阵，默认对A的各列进行升序排列
% sort(A,dim)
% dim=1时等效sort(A)
% dim=2时表示对A中的各行元素升序排列