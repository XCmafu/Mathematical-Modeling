%% 一般很少使用插值算法来预测数据，可用灰色预测、拟合预测等
clear;clc
%% 分段三次埃尔米特插值
x1 = -pi:pi; 
y1 = sin(x1); 
x2 = -pi:0.1:pi;
y2 = pchip(x1,y1,x2);  %分段三次埃尔米特插值
figure(1);
plot( x1, y1, 'og', x2, y2, '-r')

%% 三次样条插值和分段三次埃尔米特插值的对比
x1 = -pi:pi; 
y1 = sin(x1); 
x2 = -pi:0.1:pi;
y2_pchip = pchip( x1, y1, x2);   %分段三次埃尔米特插值
y2_spline = spline( x1, y1, x2);  %三次样条插值
figure(2);
plot( x1, y1, 'og', x2, y2_pchip, '-r', x2, y2_spline, '-b')
legend( '样本点', '三次埃尔米特插值', '三次样条插值', 'Location', 'SouthEast') %标注

%% n维数据的插值
x1 = -pi:pi; 
y1 = sin(x1); 
x2 = -pi:0.1:pi;
y2 = interpn ( x1, y1, x2, 'spline');
% 等价于 p = spline(x1, y1, x2);
figure(3);
plot( x1, y1, 'og', x2, y2, '-r')

%% 例题：人口预算
population = [133126,133770,134413,135069,135738,136427,137122,137866,138639,139538];
year = 2009:2018;
x_pchip = 2019:2021;
x_spline = 2019:2021;
y_pchip = pchip( year, population, x_pchip)  %分段三次埃尔米特插值预测
y_spline = spline( year, population, x_spline) %三次样条插值预测
figure(4);
plot( year, population, 'o', x_pchip,y_pchip, 'r*-', x_spline, y_spline, 'bx-')
legend( '样本点', '三次埃尔米特插值预测', '三次样条插值预测', 'Location','SouthEast')