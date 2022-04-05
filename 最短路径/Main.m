clear;clc
% Matlab中的图节点要从1开始编号，所以这里把0全部改为了9
x = [9 9 1 1 2 2 2 7 7 6 6  5  5 4];
y = [1 7 7 2 8 3 5 8 6 8 5  3  4 3];
w = [4 8 3 8 2 7 4 1 6 6 2 14 10 9];
% x = [1 1 1 2 2 3 3 3 4 4 5 5 6 6 7]
% y = [2 3 4 3 5 4 5 6 6 7 6 8 7 8 8]
% w = [24 47 70 25 120 23 88 66 31 42 31 29 74 79 66]
G = graph( x, y, w);  % 做无向图
plot( G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', []);  % 去掉坐标轴
[point,dis] = shortestpath( G, 3, 1)  % 从点9到点4的  point：最短路径经过的节点，dis：最短路径值
[point,dis] = shortestpath( G, 3, 2) 
[point,dis] = shortestpath( G, 3, 3) 
[point,dis] = shortestpath( G, 3, 4) 
[point,dis] = shortestpath( G, 3, 5) 
[point,dis] = shortestpath( G, 3, 6)
[point,dis] = shortestpath( G, 3, 7)
[point,dis] = shortestpath( G, 3, 8) 
highlight( plot( G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2), point, 'EdgeColor', 'r') % 在图中高亮最短路径


D = distances(G)  % 求出任意两点的最短路径值矩阵 
D(3,1)
D(3,2)
D(3,4)
D(3,5)
D(3,6)
D(3,7)  % 1 -> 2的最短路径值
D(3,8)  % 9 -> 4的最短路径值

% 找出给定范围内的所有点 nearest( G, p, d)：返回 G 中与节点 p 的距离在 d 之内的所有节点
[point_near,dist] = nearest( G, 2, 10)   % point_near：节点。  dist：到对应节点的路径值
