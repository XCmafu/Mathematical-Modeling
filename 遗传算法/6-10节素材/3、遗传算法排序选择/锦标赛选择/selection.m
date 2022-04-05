function [dad, mom] = selection(pop, fit)
global sn
row = size(pop, 1);

%% 选择出row个母代和父代
for i = 1:row
    r = randi([1 row], sn, 1);
    [~,bestindex] = max(fit(r)); % 最大问题用max，最小问题用min
    dad(i,:) = pop(r(bestindex),:);
    mom(i,:) = pop(randi([1 row]),:);
end

