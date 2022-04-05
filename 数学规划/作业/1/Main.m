c = ones(6,1);
% c = [1 1 1 1 1 1]';

intcon = [1:6];

A = zeros(6,6);
for i = 2:6
    A(i,i-1) = -1;
    A(i,i) = -1;
end
A(1,6) = -1;
A(1,1) = -1;

b = -[60 70 60 50 20 30]';

lb = zeros(6,1);

[x fval] = intlinprog(c, intcon, A, b, [], [], lb, [])