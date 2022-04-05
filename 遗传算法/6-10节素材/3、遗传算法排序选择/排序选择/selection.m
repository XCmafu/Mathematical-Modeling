function [dad, mom] = selection(pop, fitvalue, q)

row = size(pop, 1);
[~,Sindex] = sort(fitvalue, 'descend');
pop = pop(Sindex,:);

P = q*(1-q).^((1:row) - 1)/(1- (1-q)^row);

PP = cumsum(P);
%% 选择出row个母代和父代
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

