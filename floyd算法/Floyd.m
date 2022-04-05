function [distances,way] = Floyd(M)
%% 利用Floyd原理求任意两个节点之间的最短路径

%        M：已知权重的矩阵

%        distances：最短路径值矩阵，其元素dist_ij表示表示i,j两个节点的最短距离
%        way：最短路径矩阵，其元素path_ij表示起点为i，终点为j的两个节点之间的最短路径要经过的节点

%% 
n = size(M,1);  % 计算节点的个数

distances = M;  % 初始化最短路径值矩阵

way = zeros(n);  % 初始化最短路径矩阵
for a = 1:n
    way( :, a) = a;   % 将第i列的元素变为j
end
for b = 1:n
    way( b, b) = -1;  % 主对角线元素变为-1
end

% Floyd算法原理
for i = 1:n    
   for j = 1:n     
      for k = 1:n    
          if distances( j, k) > distances( j, i) + distances( i, k)  
              % 判断j,k两节点的最短路径值是否 > i和j的最短路径值与i和k的最短路径值之和
              % 成立的话，就让这两个较短的距离之和取代j,k两点之间的最短路径值
             distances( j, k) = distances( j, i) + distances( i, k);  
             way( j, k) = way( j, i);   % 更新way
          end
      end
   end
end

end

