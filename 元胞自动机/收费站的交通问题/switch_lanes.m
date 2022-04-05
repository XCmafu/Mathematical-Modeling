function [plaza, v, time] =  switch_lanes(plaza, v, time)
% switch_lanes  为避免碰撞换道
%        plaza = p收费区矩阵
%        1 = 有车, 0 = 为空, -1 = 非道路, -3 = 收费站
%        v = 速度矩阵
%        time = 时间矩阵
L = size(plaza, 1);
found = find(plaza==1); % 找到总道路中有车的位置并记录
if ~isempty(found) % 如果有车
    found = found(randperm(length(found))); % 随机排序，列向量
end
for k = found' % 按照随机的顺序进行循环
    if (plaza(k+1)~=0 || plaza(k-1)==1) && rem(k,L)~=floor(L/2) && rem(k,L)~=ceil(L/2) 
        % 从上向下:（前面有障碍或者后面有车）并且不在收费站的上一格数和收费站
        % rem求 k%L 的余数=在哪一行，rem(k,L)~=floor(L/2) 不等于收费站的上一格数
        if (rand < .5 ) % 0.5的概率优先左边换道
            if plaza(k+L) == 0 && plaza(k+L+1) == 0 % 车道的左边空，左前方为空
                plaza(k+L) = 1; % k车换至左边车道
                plaza(k) = 0;
                v(k+L) = v(k); % 将速度与时间状态转移
                v(k) = 0;
                time(k+L) = time(k);
                time(k) = 0;
            elseif plaza(k-L) == 0 && plaza(k-L+1) == 0
                plaza(k-L) = 1; % 换至右车道
                plaza(k) = 0;
                v(k-L) = v(k);
                v(k) = 0;
                time(k-L) = time(k);
                time(k) = 0;
            end
        else  % 0.5的概率优先右边换道
            if plaza(k-L) == 0 && plaza(k-L+1) == 0
                plaza(k-L) = 1;
                plaza(k) = 0;
                v(k-L) = v(k);
                v(k) = 0;
                time(k-L) = time(k);
                time(k) = 0;
            elseif plaza(k+L) == 0 && plaza(k+L+1) == 0
                plaza(k+L) = 1;
                plaza(k) = 0;
                v(k+L) = v(k);
                v(k) = 0;
                time(k+L) = time(k);
                time(k) = 0;
            end
        end
    end
end
