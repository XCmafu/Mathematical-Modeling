function [result] = Positive( p_column, type, m)
% 输入变量有三个：
% m：需要正向化处理的指标对应的原始列向量
% type： 指标的类型（1：极小型， 2：中间型， 3：区间型）
% p_column: 正在处理的是原始矩阵中的哪一列
% 输出变量result表示：正向化后的列向量
    if type == 1  %极小型
        disp(['第' num2str(p_column) '列极小型正向化'] )
        result = Min_Max(m); 
        disp('-----')
    elseif type == 2  %中间型
        disp(['第' num2str(p_column) '列中间型正向化'] )
        best = input('请输入最佳的那一个值： ');
        result = Mid_Max( m, best);
        disp('-----')
    elseif type == 3  %区间型
        disp(['第' num2str(p_column) '列区间型正向化'] )
        up = input('请输入区间的上界： ');
        low = input('请输入区间的下界： '); 
        result = Interval_Max( m, up, low);
        disp('-----')
    end
end