function fitvalue = fitnessfun(real)

Cmin = 0.01;
row = size(real,1);
for i = 1:row
    fval = objfun(real(i,:));  % 带入新生成的10进制数计算f
    if fval + Cmin > 0
        fitvalue(i) = fval + Cmin;
    else
        fitvalue(i) = 0;
    end
end





