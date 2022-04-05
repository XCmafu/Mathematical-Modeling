function [dad, mom] = selection(pop, fit)
global sn
row = size(pop, 1);

%% ѡ���row��ĸ���͸���
for i = 1:row
    r = randi([1 row], sn, 1);
    [~,bestindex] = max(fit(r)); % ���������max����С������min
    dad(i,:) = pop(r(bestindex),:);
    mom(i,:) = pop(randi([1 row]),:);
end

