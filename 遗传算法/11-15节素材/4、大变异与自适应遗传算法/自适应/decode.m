function real = decode(pop,lb,ub)
%% pop ÷÷»∫
col = size(pop, 2);

for j = col:-1:1
%     temp(j) = 2^(j-1)*pop(j);
    temp(j) = 2^(col-j)*pop(j);
end
temp = sum(temp);
real = lb + temp * (ub - lb)/(2^col-1);
end