function [plaza, v, time, departurescount, departurestime] = clear_boundary(plaza, v, time)
% clear_boundary  最后一行车的移动
%        1 = 有车, 0 = 为空, -1 = 非道路, -3 = 收费站
%        v = 速度矩阵
%        time = 时间矩阵
departurescount = 0; % 出口离去车辆数
departurestime = []; % 离去车辆时刻
[L,W] = size(plaza);
for i =2:W-1
    if plaza(L,i) > 0
        departurescount = departurescount + 1;
        departurestime(departurescount) = time(L,i);
%         departurestime = [departurestime; time(L,i)];
        plaza(L,i) = 0;
        v(L,i) = 0;
        time(L,i) = 0;
    end
end
