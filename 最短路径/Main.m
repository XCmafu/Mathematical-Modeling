clear;clc
% Matlab�е�ͼ�ڵ�Ҫ��1��ʼ��ţ����������0ȫ����Ϊ��9
x = [9 9 1 1 2 2 2 7 7 6 6  5  5 4];
y = [1 7 7 2 8 3 5 8 6 8 5  3  4 3];
w = [4 8 3 8 2 7 4 1 6 6 2 14 10 9];
% x = [1 1 1 2 2 3 3 3 4 4 5 5 6 6 7]
% y = [2 3 4 3 5 4 5 6 6 7 6 8 7 8 8]
% w = [24 47 70 25 120 23 88 66 31 42 31 29 74 79 66]
G = graph( x, y, w);  % ������ͼ
plot( G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', []);  % ȥ��������
[point,dis] = shortestpath( G, 3, 1)  % �ӵ�9����4��  point�����·�������Ľڵ㣬dis�����·��ֵ
[point,dis] = shortestpath( G, 3, 2) 
[point,dis] = shortestpath( G, 3, 3) 
[point,dis] = shortestpath( G, 3, 4) 
[point,dis] = shortestpath( G, 3, 5) 
[point,dis] = shortestpath( G, 3, 6)
[point,dis] = shortestpath( G, 3, 7)
[point,dis] = shortestpath( G, 3, 8) 
highlight( plot( G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2), point, 'EdgeColor', 'r') % ��ͼ�и������·��


D = distances(G)  % ���������������·��ֵ���� 
D(3,1)
D(3,2)
D(3,4)
D(3,5)
D(3,6)
D(3,7)  % 1 -> 2�����·��ֵ
D(3,8)  % 9 -> 4�����·��ֵ

% �ҳ�������Χ�ڵ����е� nearest( G, p, d)������ G ����ڵ� p �ľ����� d ֮�ڵ����нڵ�
[point_near,dist] = nearest( G, 2, 10)   % point_near���ڵ㡣  dist������Ӧ�ڵ��·��ֵ
