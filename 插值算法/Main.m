%% һ�����ʹ�ò�ֵ�㷨��Ԥ�����ݣ����û�ɫԤ�⡢���Ԥ���
clear;clc
%% �ֶ����ΰ������ز�ֵ
x1 = -pi:pi; 
y1 = sin(x1); 
x2 = -pi:0.1:pi;
y2 = pchip(x1,y1,x2);  %�ֶ����ΰ������ز�ֵ
figure(1);
plot( x1, y1, 'og', x2, y2, '-r')

%% ����������ֵ�ͷֶ����ΰ������ز�ֵ�ĶԱ�
x1 = -pi:pi; 
y1 = sin(x1); 
x2 = -pi:0.1:pi;
y2_pchip = pchip( x1, y1, x2);   %�ֶ����ΰ������ز�ֵ
y2_spline = spline( x1, y1, x2);  %����������ֵ
figure(2);
plot( x1, y1, 'og', x2, y2_pchip, '-r', x2, y2_spline, '-b')
legend( '������', '���ΰ������ز�ֵ', '����������ֵ', 'Location', 'SouthEast') %��ע

%% nά���ݵĲ�ֵ
x1 = -pi:pi; 
y1 = sin(x1); 
x2 = -pi:0.1:pi;
y2 = interpn ( x1, y1, x2, 'spline');
% �ȼ��� p = spline(x1, y1, x2);
figure(3);
plot( x1, y1, 'og', x2, y2, '-r')

%% ���⣺�˿�Ԥ��
population = [133126,133770,134413,135069,135738,136427,137122,137866,138639,139538];
year = 2009:2018;
x_pchip = 2019:2021;
x_spline = 2019:2021;
y_pchip = pchip( year, population, x_pchip)  %�ֶ����ΰ������ز�ֵԤ��
y_spline = spline( year, population, x_spline) %����������ֵԤ��
figure(4);
plot( year, population, 'o', x_pchip,y_pchip, 'r*-', x_spline, y_spline, 'bx-')
legend( '������', '���ΰ������ز�ֵԤ��', '����������ֵԤ��', 'Location','SouthEast')