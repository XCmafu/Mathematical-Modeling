%   iterations      =  �����������������     100
%   B               =  �շ�վ�ĸ���     ������12��
%   L               =  ������            6
%   Arrival         =  ƽ��������
%   plazalength     =  ģ��ĵ�·�ܳ���101��100�����ӣ�
%   Service         =  ������         0.8
%   dt              =  ʱ�䲽��   
%   plaza           =  �շ�������  
%   v               =  �ٶȾ���  
%   vmax            =  ����ٶ�
%   time            =  ʱ�����
%   t_h             =  ʱ������
%   departurescount =  ��һ�μ����������ĳ���
%   departurestime  =  �����ĳ������շ��������ѵ�ʱ��
%   influx          =  ����ʸ��
%   outflux         =  ����ʸ��
%   timecost        =  ���г������ѵ�ʱ��
%   h               =  ���
%   1 = �г�, 0 = Ϊ��, -1 = �ǵ�·, -3 = �շ�վ
clear;clc;
iterations = 100; % �����������������
B = 6; % �շ�վ�ĸ���
L = 4; % ������
% B>=L
Arrival = 5; % ƽ��������
plazalength = 100; % ģ��ĵ�·�ܳ���100
[plaza, v, time] = create_plaza(B, L, plazalength); % �Ӻ��������ܵ�·����     
h = show_plaza(plaza, NaN, 0.01); % �Ӻ������ܵ�·����ת��ΪͼƬ��NaN����ֵ��

Service = 0.8; % ������
dt = 0.2; % ʱ�䲽��
t_h = 1; % ʱ������
vmax = 5; % ����ٶ�
influx=[]; % ��ͬ
outflux=[]; % ��ͬ
timecost = [];

for i = 1:iterations
    % ����
    [plaza, v, arrivalscount] = new_cars(Arrival, dt, plaza, v, vmax);
    %�Ӻ���3����
    h = show_plaza(plaza, h, 1); % ����ͼ�� 
    % ����
    [plaza, v, time] = switch_lanes(plaza, v, time); % �Ӻ�����������
    [plaza, v, time] = move_forward(plaza, v, time, vmax); % �Ӻ���ǰ������
    [plaza, v, time, departurescount, departurestime] = clear_boundary(plaza, v, time);
    %�Ӻ������������ĳ����Լ������ѵ�ʱ��
    % ��������
%     influx(i) = arrivalscount; % ÿ��ѭ����������
    influx = [influx, arrivalscount];
%     outflux(i) = departurescount; % ÿ��ѭ�������ĳ�����
    outflux = [outflux, departurescount];
    timecost = [timecost, departurestime]; % ��ȥ�ĳ������ѵ�ʱ��
end
h = show_plaza(plaza, h, 1);
% xlabel( {strcat('��������',num2str(B)), strcat('ƽ������ʱ�䣺', num2str(mean(timecost)))} )
xlabel( {['��������',num2str(B)]; ['����������',num2str(sum(outflux))]; ['ƽ������ʱ�䣺',num2str(mean(timecost))]})

