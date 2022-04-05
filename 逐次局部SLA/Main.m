clear;clc
load cityData.mat
doptimal = inf;
for j = 1: 100
    % 随机初始化
    n = 38;
%     pop = randperm(n); % 随机生成一条路径
%     pop = pop(10); % 随机找第一个点
    pop = randi([1,n]);
    for i = 2: n % 寻找后面n-1个点
        poptemp = pop;
        dmin = inf;
        for k = 1: n
            flag = 0;
            for k1 = 1: length(pop) % 除掉当前序列里的点
                if k == pop(k1)
                    flag = 1;
                    break;
                end
            end
            if flag == 1
                flag = 0;
                continue;
            else % 如果不是当前序列里面的点
                poptemp(i) = k;
                di = 0;
                for k2 = 1: i-1
                  di = di + sqrt((cityData(poptemp(k2),1)-cityData(poptemp(k2+1),1))^2 + (cityData(poptemp(k2),2)-cityData(poptemp(k2+1),2))^2);
                end
                if di < dmin
                    dmin = di;
                    ktemp = k;
                    pop(i) = ktemp;
                end
            end
        end 
    end
    dmin = dmin + sqrt((cityData(pop(1),1)-cityData(pop(38),1))^2 + (cityData(pop(1),2)-cityData(pop(38),2))^2);
    if dmin < doptimal
        doptimal = dmin;
        popoptimal = pop;
    end
end
disp(doptimal)