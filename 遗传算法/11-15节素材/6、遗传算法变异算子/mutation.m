function newpop2 = mutation(newpop1, pm, lb, ub, iter, maxgen)
% iter ��ǰ��������
% maxgen ����������

[row,col] = size(newpop1);
newpop2 = zeros(row,col);

mut = {'���ȱ���','�߽����','�Ǿ��ȱ���','��˹����'};
switch mut{4}
    case '���ȱ���'
        for i = 1:row
            if rand < pm
                mpoint = randi([1 col]);
                newpop1(i,mpoint) = lb(mpoint) + (ub(mpoint) - lb(mpoint))*rand;
                newpop2(i,:) = newpop1(i,:);
            else
                newpop2(i,:) = newpop1(i,:);
            end
        end
    case '�߽����'
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
    case '�Ǿ��ȱ���'
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
    case '��˹����'
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
