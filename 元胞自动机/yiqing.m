clear
clc

m = 500;n = 500;      % 元胞自动机的空间大小
% 用1, 2, 3, 4分别表示 S, E, I, R. 无人区用 0 表示
%    S = 易感   ；  E = 潜伏  ；   I = 感染   ；   R = 治愈

[S, E, I, R] = deal(1,2,3,4);  %deal就是匹配输出 相互对应出来的 使其一一对应

rhoS = 0.95;          %初始易感人群密度
rhoE = 2758/11000000; % 初始潜伏人群密度

% X 为每一个元胞的状态
X = zeros(m,n);   % 先建立一个全零矩阵
X(rand(m,n)<rhoS) = S;   % 如果随机的一个是小于0.95的 那么就为1  也就是易感人群了
X(rand(m,n)<rhoE) = E;   %也是同上了    先定义上啊

time = zeros(m,n);    %计时： 用于计算潜伏时间和治疗时间      从 0 开始吗 ？
% 邻居方位
d = {[1,0], [0,1], [-1,0], [0,-1]};

T = 1;                % 平均潜伏时间
D = 3;                % 平均治愈时间
P = 3/(T*4);          % R0 = 3.6，潜伏期平均感染 3.6 个  就是在7天的时间里面一个在四个人里面感染3.6个人  我觉的是不合理的，也太大了
%    这样也是同样的 P = 3.6/(T*4)   这是软件的运算顺序呀
   
% 每一个元胞的潜伏期和治愈时间服从均值为 T 和 D 的正态分布
Tmn = normrnd(T,T/2,m,n); Dmn = normrnd(D,D/2,m,n);     %正态分布的表示方法

figure('position',[50,50,1200,400])     %表示画图的位置（position）    figure(只不过是创建一个画图窗口而已)

subplot(1,2,1)  %(第一小部分)
h1 = imagesc(X);      %imagesc只不过是有丰富一点颜色而已
colormap(jet(5))     %colormap是颜色查询表   jet(5)是一个色彩的代号，一共有三层
labels = {'无人','易感','潜伏','发病','移除'};
lcolorbar(labels);     %  lcolorbar附加带有文本标签的颜色条

subplot(1,2,2)   %第二部分
h2 = plot(0, [0,0,0,0]); axis([0,200,0,m*n])  ;
legend('易感','潜伏','发病','移除');


for t = 1:200  %就是循环450    这个450就是以天为单位的计量
    % 邻居中潜伏和发病的元胞数量   
    N = zeros(size(X));
    for j = 1:length(d)    %跟森林的差不多的一个
        N = N + (circshift(X,d{j})==E|circshift(X,d{j})==I);  %潜伏的与感染的都是具有传染性的  所以都算在这里面了
                %
    end
    
    % 分别找出四种状态的元胞
    isS = (X==S); isE = (X==E); isI = (X==I); isR = (X==R);
    
    % 将四种状态的元胞数量存到 Y中  
    Y(t,:) = sum([isS(:) isE(:) isI(:) isR(:)]);   
        
    % 计算已经潜伏的时间和已经治疗的时间
    time(isE|isI) = time(isE|isI) + 1;    %循环一次就是一天，时间自然就要加1  如果这里不是加1，那么就不是这样的
    
    % 规则一：如果S邻居有N个染病的，则S以概率N*P变为E，否则保持E
    ifS2E = rand(m,n)<(N*P);  
    Rule1 = E*(isS & ifS2E) + S*(isS & ~ifS2E);
    
    % 规则二：如果E达到潜伏期，则转变为I，否则保持为E
    ifE2I = time>Tmn;
    Rule2 = I*(isE & ifE2I) + E*(isE & ~ifE2I);
    time(isE & ifE2I) = 0;
    
    %  规 则 三： 如 果I达 到 治 愈 时 间， 则 转 变 为R， 否 则 保 持 为I 
    ifI2R = time>Dmn;
    Rule3 = I*(isI & ~ifI2R) + R*(isI & ifI2R);
    
    %  规 则 四： 已 经 治 愈R有 抗 体， 保 持 为R 
    Rule4 = R*isR;
    
    % 叠 加 所 有 规 则， 更 新 所 有 元 胞 状 态 
    X = Rule1 + Rule2 + Rule3 + Rule4;
    
    set(h1, 'CData', X);
    for i = 1:4; set(h2(i), 'XData', 1:t, 'YData', Y(1:t,i)); end
    drawnow
end
