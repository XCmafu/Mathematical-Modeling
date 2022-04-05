clear;clc
%% 确定x属于z1,z2...zn的哪一类

n = 2; % 类别数量
p_x = [0.9 0.1]; % z1,z2...zn发生的概率,先验概率  1*n
p_t = [0.2 0.4]; % p(x|z1),p(x|z2)... 条件概率 1*n

L = [1 6]; % 是非代价

for i = 1:n
    p_h(i) = p_t(i)*p_x(i)/sum(p_t .* p_x); % p(z1|x),p(z2|x)...
    R(i) = L(i)*p_h(i);
end

