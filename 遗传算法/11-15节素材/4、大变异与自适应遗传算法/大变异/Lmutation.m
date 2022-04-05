function newpop2 = Lmutation(newpop1, Lpm, Bestindex)
[row, col] = size(newpop1);

newpop2 = zeros(size(newpop1));
for i = 1 : row
    r = rand;
    if r < Lpm && i~=Bestindex
        mpoint = randi([1 col]);
        newpop2(i,:) = ~newpop1(i, mpoint);
    else
        newpop2(i,:) = newpop1(i,:);
    end
end