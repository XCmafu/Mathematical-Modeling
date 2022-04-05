load Data;


%% Run DBSCAN Clustering Algorithm
epsilon = 0.5;  %�뾶
MinPts = 10;  %k�����پ���ĸ���
IDX = DBSCAN( X, epsilon, MinPts);


%% Plot Results
%���ֻҪ����ָ��Ļ��Ϳ��Ի�ͼ��
PlotClusterinResult( X, IDX);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);