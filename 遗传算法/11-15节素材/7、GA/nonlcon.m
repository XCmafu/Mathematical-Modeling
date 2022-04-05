function [c, ceq]=nonlcon(x)
% x=u(1);
% y=u(2);
% z=u(3);
% c=[]; % 线性不等式约束
% ceq=x*y+x*z+y*z-75; % 线性等式约束


c=[]; % 线性不等式约束
ceq=x(1)*x(2)+x(1)*x(3)+x(2)*x(3)-75; % 线性等式约束
