function [plaza, v, time] = move_forward(plaza, v, time, vmax)
% move_forward   按NS规则前进
% 1.一定概率：加速，k车的车距大于当前速度（单位时间内通过的距离） & 加速之后速度小于最大速度
% 2.一定：减速，k车的车距小于单位时间内通过的距离 & 减速之后速度大于零
% 3. 一定概率随机慢化
% 4. 进出收费站
%        1 = 有车, 0 = 为空, -1 = 非道路, -3 = 收费站
%        v = 速度矩阵
%        time = 时间矩阵
%        vmax = 最大速度
%%
Service = 0.8; % 服务率   exp(-Service*dt) = 0.8521
dt = 0.2; % 时长
probac = 0.7; % 加速概率
probdc = 1; % 减速的可能性
probrd = 0.3; % 随机减速的可能性
t_h = 1; % 时间因素
[L, W] = size(plaza);
gap = zeros(L, W);
found = find(plaza==1); % 找到总道路中有车的位置并记录
for k1=found'
    [i, j] = ind2sub([L, W], k1); % 将矩阵中k位置，用[i,j]表示
    d = plaza(i+1:end, j); % k车所在道路 前面有车的矩阵
    gap(k1) = min( find([d~=0;1]) )-1; % 找到离k车前方最近的车或者收费站的距离；
end
gap(end,:) = 0; % 最后一行距离为0 

%% 速度更新规则
% 一定概率加速：间隔大于速度
k2 = find((gap(found) > v(found)*t_h) & (v(found) + 1 <= vmax) & (rand(size(found)) <= probac));
v(found(k2)) = v(found(k2)) + 1;
% 一定减速 
k2 = find((v(found)*t_h > gap(found)) & (rand(size(found)) <= probdc));
v(found(k2)) = gap(found(k2))/t_h;
% 一定概率随机减速
k2 = find((rand(size(found)) <= probrd) & (v(found) + 1 >= 2));
v(found(k2)) = v(found(k2)) - 1;
% v(found(k2)) = max(v(found(k2)) - 1,0);

%% 收费站
booth_row = ceil(L/2); % 找到收费区的位置
for i = 2:W-1
    if (plaza(booth_row,i) ~= 1) % 如果该收费站没车
        if (plaza(booth_row-1,i) == 1) % 如果收费站之前有车
            v(booth_row - 1 ,i) = 1; % 该车速度为1
        end
        plaza(booth_row,i) = -3;
    else % 收费站有车辆
        if (plaza(booth_row+1,i) ~= 1) && (rand > exp(-Service*dt))
            % 如果出收费站的格子没车，并且被服务过
            v(booth_row,i) = 1; % 出站
        else
            v(booth_row,i) = 0;
        end
     end
end

%% 状态更新
for k = found'
    if rem(k,L)~=ceil(L/2)
        plaza(k) = 0;
    else
         plaza(k) = -3;
    end
end

plaza(found+v(found)) = 1;

time(found + v(found)) = time(found) + 1;
time(plaza~=1) = 0;

v(found + v(found)) = v(found);
v(plaza~=1)=0;

end