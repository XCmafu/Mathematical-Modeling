%%
% 导入x，y的值
load Data1.mat

plot(x,y,'o')
xlabel('x的值');
ylabel('y的值');

% y=kx+b
row = size(x,1);
k = (row*sum(x.*y)-sum(x)*sum(y))/(row*sum(x.*x)-sum(x)*sum(x))
b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/(row*sum(x.*x)-sum(x)*sum(x))
hold on % 继续在之前的图形上来画图形
grid on % 显示网格线

%% 画出y=kx+b的函数图像
%(方法一)
x2 = 4.2: 0.1 :6.9;  % 间隔设置的越小画出来的图形越准确
y2 = k * x2 + b;  % k和b都是已知值
plot(x2,y2,'-')

%（方法二）APP 拟合

%(方法三)不熟
% y2=@(x) k*x+b;
% fplot(y2,[min(x)-1,max(x)+1]);
% legend('拟合函数','location','SouthEast')


%% 计算拟合优度
y_fit = k*x+b; % y的拟合值
SSR = sum((y_fit-mean(y)).^2)  % 回归平方和
SST = sum((y-mean(y)).^2) % 总偏差平方和
SSE = sum((y-y_fit).^2) % 误差平方和
SST-SSE-SSR  % 趋于0
R = SSR / SST  % 拟合优度越接近1，拟合越好
R_2 = SSR / SST