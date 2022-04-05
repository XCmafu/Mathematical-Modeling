function newpop2 = mutation(newpop1, pm, lb, ub, iter, maxgen)
% iter 当前迭代次数
% maxgen 最大迭代次数

[row,col] = size(newpop1);
newpop2 = zeros(row,col);

mut = {'均匀变异','边界变异','非均匀变异','高斯变异'};
switch mut{4}
    case '均匀变异'
        for i = 1:row
            if rand < pm
                mpoint = randi([1 col]);
                newpop1(i,mpoint) = lb(mpoint) + (ub(mpoint) - lb(mpoint))*rand;
                newpop2(i,:) = newpop1(i,:);
            else
                newpop2(i,:) = newpop1(i,:);
            end
        end
    case '边界变异'
        for i = 1:row
            mpoint = randi([1 col]);
            if rand < pm
                if randi([0 1]) == 0
                    newpop1(i,mpoint) = lb(mpoint);
                end
                if randi([0 1]) == 1
                    newpop1(i,mpoint) = ub(mpoint);
                end
                newpop2(i,:) = newpop1(i,:);
            else
                newpop2(i,:) = newpop1(i,:);
            end
        end
    case '非均匀变异'
        for i = 1:row
            r = rand;
            a = (1-iter/maxgen);
            b = 5;% 2 - 5
            if rand < pm
                mpoint = randi([1 col]);
                if randi([0 1]) == 0
                    newpop1(i,mpoint) = newpop1(i,mpoint) + (ub(mpoint) - newpop1(i,mpoint))*(1-r^(a*b));
                end
                if randi([0 1]) == 1
                    newpop1(i,mpoint) = newpop1(i,mpoint) - (newpop1(i,mpoint) - lb(mpoint))*(1-r^(a*b));
                end
                newpop2(i,:) = newpop1(i,:);
            else
                newpop2(i,:) = newpop1(i,:);
            end
        end
    case '高斯变异'
        for i = 1:row
            if rand < pm
                mpoint = randi([1 col]);
                mvalue = inf;
                while mvalue < lb(mpoint) || mvalue > ub(mpoint)
                    mvalue = (lb(mpoint) + ub(mpoint))/2 + (ub(mpoint) - lb(mpoint))/6*randn;
                end
                newpop1(i,mpoint) = mvalue;
                newpop2(i,:) = newpop1(i,:);
            else
                newpop2(i,:) = newpop1(i,:);
            end
        end
end
