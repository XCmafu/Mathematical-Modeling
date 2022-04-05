%   iterations      =  迭代次数即计算次数     100
%   B               =  收费站的个数     定义了12个
%   L               =  车道数            6
%   Arrival         =  平均车流量
%   plazalength     =  模拟的道路总长度101（100个格子）
%   Service         =  服务率         0.8
%   dt              =  时间步长   
%   plaza           =  收费区矩阵  
%   v               =  速度矩阵  
%   vmax            =  最大速度
%   time            =  时间矩阵
%   t_h             =  时间因素
%   departurescount =  在一次计算中流出的车数
%   departurestime  =  流出的车经过收费区所花费的时间
%   influx          =  进车矢量
%   outflux         =  出车矢量
%   timecost        =  所有车辆花费的时间
%   h               =  句柄
%   1 = 有车, 0 = 为空, -1 = 非道路, -3 = 收费站
clear;clc;
iterations = 100; % 迭代次数即计算次数
B = 6; % 收费站的个数
L = 4; % 车道数
% B>=L
Arrival = 5; % 平均车流量
plazalength = 100; % 模拟的道路总长度100
[plaza, v, time] = create_plaza(B, L, plazalength); % 子函数构建总道路矩阵     
h = show_plaza(plaza, NaN, 0.01); % 子函数将总道路矩阵转换为图片（NaN任意值）

Service = 0.8; % 服务率
dt = 0.2; % 时间步长
t_h = 1; % 时间因素
vmax = 5; % 最大速度
influx=[]; % 不同
outflux=[]; % 不同
timecost = [];

for i = 1:iterations
    % 进车
    [plaza, v, arrivalscount] = new_cars(Arrival, dt, plaza, v, vmax);
    %子函数3进车
    h = show_plaza(plaza, h, 1); % 更新图形 
    % 规则
    [plaza, v, time] = switch_lanes(plaza, v, time); % 子函数换道规则
    [plaza, v, time] = move_forward(plaza, v, time, vmax); % 子函数前进规则
    [plaza, v, time, departurescount, departurestime] = clear_boundary(plaza, v, time);
    %子函数计算流出的车数以及所花费的时间
    % 计算流量
%     influx(i) = arrivalscount; % 每次循环进车流量
    influx = [influx, arrivalscount];
%     outflux(i) = departurescount; % 每次循环流出的车辆数
    outflux = [outflux, departurescount];
    timecost = [timecost, departurestime]; % 出去的车辆花费的时间
end
h = show_plaza(plaza, h, 1);
% xlabel( {strcat('车道数：',num2str(B)), strcat('平均花费时间：', num2str(mean(timecost)))} )
xlabel( {['车道数：',num2str(B)]; ['流出车辆：',num2str(sum(outflux))]; ['平均花费时间：',num2str(mean(timecost))]})

