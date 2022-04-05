clear;clc

E = zeros(2,100); % 第一行为i，第二行为s
E(:,1) = [0.001,0.999]; % 初始化

Lambda = 1; % 一个病人每天的有效接触人数
u = 1/7; % 日治愈率

for i=1:99
    E(1, i+1) = E(1, i) + Lambda*E(1, i)*E(2, i) - u*E(1, i);
    E(2, i+1) = E(2, i) - Lambda*E(1, i)*E(2, i);
end