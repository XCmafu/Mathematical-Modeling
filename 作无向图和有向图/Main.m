% https://csacademy.com/app/graph_editor/   ��ͼ��վ


%% ������ͼ
% ��Ȩ�أ�ÿ���ߵ�Ȩ��Ĭ��Ϊ1��
% x��y���������ͬ��Ԫ��������Щ�ڵ���붼�Ǵ�1��ʼ���������������ַ���Ԫ�����顣 �������Ǵ�1��ʼ�������
x1 = [1,2,3,4];
y1 = [2,3,1,1];
G1 = graph(x1, y1);  % ��������Ȩͼ
% G1 = graph([1,2,3,4], [2,3,1,1]);
plot(G1)

% �ַ���Ԫ���������ô����Ű�������
x2 = {'ѧУ','��ӰԺ','����','�Ƶ�'};
y2 = {'��ӰԺ','�Ƶ�','�Ƶ�','KTV'};
G2 = graph(x2, y2);
plot(G2, 'linewidth', 2)  % �����ߵĿ��
set( gca, 'XTick', [], 'YTick', [] ); % ��ͼ����ʾ���� 

% ��Ȩ��
% ����graph(s,t,w)������ s �� t �еĶ�Ӧ�ڵ�֮����w��Ȩ�ش����ߣ�������һ��ͼ
x = [1,2,3,4];
y = [2,3,1,1];
w = [3,8,9,2];
G = graph(x, y, w);  % �������Ȩͼ
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] ); 


%% Matlab������ͼ
% ��Ȩͼ digraph(s,t)
x = [1,2,3,4,1];
y = [2,3,1,1,4];
G = digraph(x, y);  % ��������Ȩͼ
plot(G)
set( gca, 'XTick', [], 'YTick', [] );  

% ��Ȩͼ digraph(s,t,w)
x = [1,2,3,4];
y = [2,3,1,1];
w = [3,8,9,2];
G = digraph(x, y, w);  % �������Ȩͼ
plot(G, 'EdgeLabel', G.Edges.Weight, 'linewidth', 2) 
set( gca, 'XTick', [], 'YTick', [] );  