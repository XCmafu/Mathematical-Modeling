function newpop2 = mutation(newpop1, pm, Bestindex)

[row, col] = size(newpop1);
newpop2 = zeros(row, col);
for i = 1:row
    if rand < pm && i~=Bestindex
        mpoint = randi([1 col]);
        newpop2(i,:) = newpop1(i,:);
        newpop2(i, mpoint) = ~newpop1(i, mpoint);
    else
        newpop2(i,:) = newpop1(i,:);
    end
end