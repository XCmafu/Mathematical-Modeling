clear;clc

n = input('输入节点数量：');  % 输入节点数量
judge = input('是否为有向图？有向图输入1，无向图输入0：');  % 判断是否为有向图
%% 
if judge == 1 % 有向图
    M = ones(n) ./ zeros(n);  % 全部点初始化为Inf
    for i = 1:n
    M(i,i) = 0;  % 主对角线元素为0
    end
    % 写入已知的权重
    M(1,2) = 3;
    M(1,3) = 8;
    M(1,5) = -4;
    M(2,5) = 7;
    M(2,4) = 1;
    M(3,2) = 4;
    M(4,3) = -5;
    M(5,4) = 6;
    M(4,1) = 2;
    
    [distances,way] = Floyd(M)  % 调用Floyd函数

    Way_show( distances, way, 2, 5)  % 1-->5之间的最短路径和最短路径值

    disp('任意两点之间的最短距离：')  % 所以点之间的最短路径和最短路径值
    Way_show_all( distances, way, n)
    
else % 无向图
    M = zeros(n);  % 全部点初始化为0
    % 写入已知的权重
    M(1,2) = 4; M(1,8) = 8; 
    M(2,8) = 3; M(2,3) = 8;
    M(8,9) = 1; M(8,7) = 6; 
    M(9,7) = 6; M(9,3) = 2;
    M(7,6) = 2; M(3,4) = 7; 
    M(3,6) = 4; M(6,4) = 14;
    M(4,5) = 9; M(6,5) = 10;
    
    M = M + M';   % 得到对称矩阵
    for i = 1:n
        for j = 1:n
            if (i ~= j) && (M(i,j) == 0)  
                M(i,j) = Inf;   % 将非主对角线上的0元素全部变为Inf
            end
        end
    end

    [distances,way] = Floyd(M)  % 调用Floyd函数
    
    Way_show( distances, way, 1, 5)  % 1-->5之间的最短路径和最短路径值

    disp('任意两点之间的最短距离：')  % 所有点之间的最短路径和最短路径值
    Way_show_all( distances, way, n)
    
end

   