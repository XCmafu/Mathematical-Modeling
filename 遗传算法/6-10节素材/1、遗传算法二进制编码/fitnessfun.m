function fitvalue = fitnessfun(real)

Cmin = 0.01;
row = size(real,1);
for i = 1:row
    fval = objfun(real(i,:));  % ���������ɵ�10����������f
    if fval + Cmin > 0
        fitvalue(i) = fval + Cmin;
    else
        fitvalue(i) = 0;
    end
end





