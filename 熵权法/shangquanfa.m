function [W] = shangquanfa(M_Stand)
% 计算熵权
    [n,m] = size(M_Stand);
    X = zeros(1,m);  % 初始化
    for i = 1:m
        x = M_Stand(:,i);  
        p = x / sum(x);
        e = -sum(p .* fun_log(p)) / log(n); % 计算信息熵
        X(i) = 1- e; % 计算信息效用值
    end
    W = X ./ sum(X);  % 归一化得到权重    
end
