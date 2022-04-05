% [x fval] = linprog(c, A, b, Aeq, beq, lb,ub, x0)

x = [3100 3800 3500 2850]';
c = [];
for i = 1:4
    for j = 1:3
        c = [c; -x(i)];
    end
end

A = zeros(10,12);
for i = 1:4
%     A(i, 3*i-2) = 1;
%     A(i, 3*i-1) = 1;
    A(i: 3*i) = 1;
end
for i = 5:7
    A(i, i-4) = 1;
    A(i, i-1) = 1;
    A(i, i+2) = 1;
    A(i, i+5) = 1;
end
for i = 8:10
    A(i, i-7) = 480;
    A(i, i-4) = 650;
    A(i, i-1) = 580;
    A(i, i+2) = 390;
end

b = [18 15 23 12 10 16 8 6800 8700 5300]';

Aeq = zeros(2,12);
for i = 1:4
    Aeq(1, 3*i-2) = 1/10;
    Aeq(1, 3*i-1) = -1/16;
end
for i = 1:4
    Aeq(2, 3*i-2) = 1/10;
    Aeq(2, 3*i) = -1/8;
end

beq = [0 0]';

lb = zeros(12,1);

[x fval] = linprog(c, A, b, Aeq, beq, lb, []);
fval = -fval
    
