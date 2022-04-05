function newpop2 = mutation(newpop1, pm, lb, ub)

[row,col] = size(newpop1);
newpop2 = zeros(row,col);

for i = 1:row
    if rand < pm
        mpoint = randi([1 col]);
        newpop1(i,mpoint) = lb(mpoint) + (ub(mpoint) - lb(mpoint))*rand;
        newpop2(i,:) = newpop1(i,:);
    else
        newpop2(i,:) = newpop1(i,:);
    end
end


