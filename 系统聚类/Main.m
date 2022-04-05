load Data;


%% Run DBSCAN Clustering Algorithm
epsilon = 0.5;  %半径
MinPts = 10;  %k，至少聚类的个数
IDX = DBSCAN( X, epsilon, MinPts);


%% Plot Results
%如果只要两个指标的话就可以画图啦
PlotClusterinResult( X, IDX);
title(['DBSCAN Clustering (\epsilon = ' num2str(epsilon) ', MinPts = ' num2str(MinPts) ')']);