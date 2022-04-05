function [plaza, v, time] = create_plaza(B, L, plazalength)    % 构建总道路矩阵
% 1 = 有车, 0 = 为空, -1 = 非道路, -3 = 收费站
% B = 收费站个数
% L = 车道数
% plazalength = 模拟的道路总长度101（100个格子）
plaza = zeros(plazalength, B+2); % 100*14 模拟道路图像
v = zeros(plazalength, B+2); % 速度状态矩阵初始化
time = zeros(plazalength, B+2); % 时间状态矩阵初始化

plaza(1:plazalength, [1,B+2]) = -1; % 定义两边边界，非道路
plaza(ceil(plazalength/2), [2:B+1]) = -3; % 定义收费站的位置
          
toptheta = 1.3; % 顶角
bottomtheta = 1.2; % 底角
%左边
%上
for col = 2:ceil(B/2-L/2)+1     % 2 3 4 
    for row = 1:(plazalength-1)/2 - floor(tan(toptheta) * (col-1))  
        % floor(tan(toptheta) * (col-1)   3 7 10 
        % row 1,2,3...47   1,2,3...43   1,2,3...40
        % col     2            3            4
        plaza(row, col) = -1;    %  将上面的区域变成-1
    end
%下
    for row = 1:(plazalength-1)/2 - floor(tan(bottomtheta) * (col-1))
        % floor(tan(toptheta) * (col-1)   2 5 7
        % row 1,2,3...48   1,2,3...45   1,2,3...43
        % col     2            3            4
        plaza(plazalength+1-row, col) = -1;
    end
end
%右边
%上
for col = B+1:-1:B+1-floor(B/2-L/2)+1    % 13 12 11
    for row = 1:(plazalength-1)/2 - floor(tan(toptheta) * ((B+3-col)-1))  
        % floor(tan(toptheta) * (col-1)   3 7 10 
        % row 1,2,3...47   1,2,3...43   1,2,3...40
        % col     13           12           11
        plaza(row, col) = -1;    %  将上面的区域变成-1
    end
%下
    for row = 1:(plazalength-1)/2 - floor(tan(bottomtheta) * ((B+3-col)-1))
        % floor(tan(toptheta) * (col-1)   2 5 7
        % row 1,2,3...48   1,2,3...45   1,2,3...43
        % col     13           12           11
        plaza(plazalength+1-row, col) = -1;
    end
end
