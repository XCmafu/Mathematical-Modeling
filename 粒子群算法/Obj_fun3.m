function y = Obj_fun3(x)
% Sphere函数
%     y = sum(x.*x); 

% Rosenbrock函数
    temp1 = x(1:end-1);
    temp2 = x(2:end);
    y = sum(100 * (temp2-temp1.^2).^2 + (temp1-1).^2);

% Rastrigin函数
%     y = sum(x.^2-10*cos(2*pi*x)+10);

% Griewank函数
%     y = 1/4000*sum(x.*x)-prod(cos(x./sqrt(1:30)))+1;
end

