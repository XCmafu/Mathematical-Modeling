clear;clc
load cityData.mat
doptimal = inf;
for j = 1: 100
    % �����ʼ��
    n = 38;
%     pop = randperm(n); % �������һ��·��
%     pop = pop(10); % ����ҵ�һ����
    pop = randi([1,n]);
    for i = 2: n % Ѱ�Һ���n-1����
        poptemp = pop;
        dmin = inf;
        for k = 1: n
            flag = 0;
            for k1 = 1: length(pop) % ������ǰ������ĵ�
                if k == pop(k1)
                    flag = 1;
                    break;
                end
            end
            if flag == 1
                flag = 0;
                continue;
            else % ������ǵ�ǰ��������ĵ�
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