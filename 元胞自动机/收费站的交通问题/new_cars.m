 function [plaza, v, number_cars] = new_cars(Arrival, dt, plaza, v, vmax)
% new_cars   在最顶行定义新进车辆
%        Arrival = 平均车流量
%        dt = 时间步长
%        plaza = 收费区矩阵
%        1 = 有车, 0 = 为空, -1 = 非车道, -3 = 收费站
%        v = 速度矩阵
%        vmax = 最大速度
unoccupied = find(plaza(1,:) == 0); % 找到第一行中为空的位置并记录
n = length(unoccupied); % 空车道的个数
% 车辆个数必须为整数，且不能超过最大空车道个数
number_cars = min( poissrnd(Arrival*dt,1), n); % 泊松随机分布;
if number_cars > 0 % 有空车道
    x = randperm(n); % 从1到n随机排列
    for i = 1:number_cars
         plaza(1, unoccupied(x(i))) = 1; % 确定新进车辆的位置
         v(1, unoccupied(i)) = ceil(vmax/2); % %新进的车辆以最大速度驶进！！！
    end
end
