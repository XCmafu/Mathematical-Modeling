function newpop2 = mutation(newpop1, pm1, pm2)
global  varnum L lb ub n

[row, col] = size(newpop1);
real = zeros(row, varnum);
spoint = cumsum([0 L]);
for i = 1:n
    for j = 1:varnum
        startpoint = spoint(j) + 1;
        endpoint = spoint(j+1);
        real(i,j) = decode(newpop1(i,startpoint:endpoint), lb(j), ub(j));
    end
end

%% 计算适应度值
fitvalue = fitnessfun(real);
Maxfitvalue = max(fitvalue);
Meanfitvalue = sum(fitvalue) / n;

newpop2 = zeros(row, col);
for i = 1:row
    f = fitvalue(i);
    if f >= Meanfitvalue
        pm = pm1*(Maxfitvalue - f )/(Maxfitvalue - Meanfitvalue);
    else
        pm = pm2;
    end
    
    if rand < pm
        mpoint = randi([1 col]);
        newpop2(i,:) = newpop1(i,:);
        newpop2(i, mpoint) = ~newpop1(i, mpoint);
    else
        newpop2(i,:) = newpop1(i,:);
    end
end