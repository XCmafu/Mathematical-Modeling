%[x,fval]=intlinprog(c,intcon,A,b,Aeq,beq,lb,ub)

c = ones(6,1);

intcon = [1:6];

A = -[1 1 1 0 0 0;
    0 1 0 1 0 0;
    0 0 1 0 1 0;
    0 0 0 1 0 1;
    1 1 1 0 0 0;
    0 0 0 0 1 1;
    1 0 0 0 0 0;
    0 1 0 1 0 1];

b = -ones(8,1);

lb = zeros(6,1);
ub = ones(6,1);

[x,fval]=intlinprog(c, intcon, A, b, [], [], lb, ub)