function [dad, mom] = selection(pop, fitvalue)
row = size(pop, 1);

PP = cumsum( fitvalue ./ sum(fitvalue) );
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

