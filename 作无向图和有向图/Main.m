% https://csacademy.com/app/graph_editor/   作图网站


%% 作无向图
% 无权重（每条边的权重默认为1）
% x和y必须具有相同的元素数；这些节点必须都是从1开始的正整数，或都是字符串元胞数组。 编号最好是从1开始连续编号
x1 = [1,2,3,4];
y1 = [2,3,1,1];
G1 = graph(x1, y1);  % 做无向无权图
% G1 = graph([1,2,3,4], [2,3,1,1]);
plot(G1)

% 字符串元胞数组是用大括号包起来的
x2 = {'学校','电影院','网吧','酒店'};
y2 = {'电影院','酒店','酒店','KTV'};
G2 = graph(x2, y2);
plot(G2, 'linewidth', 2)  % 设置线的宽度
set( gca, 'XTick', [], 'YTick', [] ); % 画图后不显示坐标 

% 有权重
% 函数graph(s,t,w)：可在 s 和 t 中的对应节点之间以w的权重创建边，并生成一个图
x = [1,2,3,4];
y = [2,3,1,1];
w = [3,8,9,2];
G = graph(x, y, w);  % 做无向加权图
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] ); 


%% Matlab作有向图
% 无权图 digraph(s,t)
x = [1,2,3,4,1];
y = [2,3,1,1,4];
G = digraph(x, y);  % 做有向无权图
plot(G)
set( gca, 'XTick', [], 'YTick', [] );  

% 有权图 digraph(s,t,w)
x = [1,2,3,4];
y = [2,3,1,1];
w = [3,8,9,2];
G = digraph(x, y, w);  % 做有向加权图
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] );  