function [W] = shangquanfa(M_Stand)
% ������Ȩ
    [n,m] = size(M_Stand);
    X = zeros(1,m);  % ��ʼ��
    for i = 1:m
        x = M_Stand(:,i);  
        p = x / sum(x);
        e = -sum(p .* fun_log(p)) / log(n); % ������Ϣ��
        X(i) = 1- e; % ������ϢЧ��ֵ
    end
    W = X ./ sum(X);  % ��һ���õ�Ȩ��    
end
