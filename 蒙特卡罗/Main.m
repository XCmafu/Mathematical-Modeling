%% 蒙特卡洛模拟：内生性会造成回归系数的巨大误差
time = 300;  % 蒙特卡洛的次数
CORRCOEF = zeros( time, 1);  % 用来储存扰动项u和x1的相关系数
K = zeros( time, 1);  % 用来储存遗漏了x2之后，只用y对x1回归得到的回归系数
for i = 1:time
    n = 30;  % 样本数据量为n
    u1 = normrnd( 0, 5, n, 1) - rand( n, 1);  % 随机生成一组随机数
    
    x1 = -10 + rand( n, 1)*20;   % x1在-10和10上均匀分布，大小为30*1
    x2 = 0.3 * x1 + u1;   % x2与x1的相关性不确定， 因为我们设定了x2要加上u1这个随机数
    u2 = normrnd( 0, 1, n, 1);  % 扰动项u2服从标准正态分布
    y = 0.5 + 2 * x1 + 5 * x2 + u2 ;  % 构造y，假设的
    
    k = (n*sum(x1.*y)-sum(x1)*sum(y))/(n*sum(x1.*x1)-sum(x1)*sum(x1));  % y = k*x1+b+u3 回归估计出来的k
    K(i) = k;
    
    u3 = x2 + u2;  % 忽略u2后的扰动项
    Corrcoef_x1_u3 = corrcoef(x1,u3);  % 相关系数矩阵，皮尔逊相关系数
    CORRCOEF(i) = Corrcoef_x1_u3(2,1);
end
plot( CORRCOEF, K, '*')
xlabel("x_1和u'的相关系数");
ylabel("k的估计值");