function newpop3 = eselection(newpop2, bestfitvalue, bestx)

global  n varnum lb ub L

spoint = cumsum([0 L]);
for i = 1:n
    for j = 1:varnum
        startpoint = spoint(j) + 1;
        endpoint = spoint(j+1);
        real(i,j) = decode(newpop2(i,startpoint:endpoint), lb(j), ub(j));
    end
end

fitvalue = fitnessfun(real);

[Gbestfitvalue, Gbestindex] = max(fitvalue);
[Gbadfitvalue, Gbadindex] = min(fitvalue);

if Gbestfitvalue < bestfitvalue
    newpop2(Gbadindex(1),:) = bestx;
end
newpop3 = newpop2;