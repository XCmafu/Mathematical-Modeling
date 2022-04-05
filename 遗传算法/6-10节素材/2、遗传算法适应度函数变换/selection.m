function [dad, mom] = selection(pop, fitvalue)

%% �����ۼӸ���
PP = cumsum( fitvalue ./ sum(fitvalue) );

row = size(pop, 1);

%% ѡ���row��ĸ���͸���
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
            
end