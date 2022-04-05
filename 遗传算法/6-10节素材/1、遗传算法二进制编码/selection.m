function [dad, mom] = selection(pop, fit)

%% 计算累加概率
PP = cumsum( fit ./ sum(fit) );

row = size(pop, 1);

%% 选择出row个母代和row个父代，轮盘赌法
for i = 1:row
    for j = 1:row
        r = rand;
        if r <= PP(j)
            dad(i,:) = pop(j,:);
            break;
        end
    end
    mom(i,:) = pop(randi([1 row]),:);
end
            
    