clear;clc;
aus = load('2010120120101231');    %
[m,n] = size(aus);  %这个就是生成一组数据吧 然后通过这组数据去生成森林？


% 根据 aus 生成树
% 非=-1, 空地=0, 树燃烧=1, 正常树=2
S = 2*((rand(m,n)<sqrt(aus)) & (aus<1));   % 满足rand(m,n)<sqrt(aus)并且aus<1的为2*1
S(aus>1) = -1;   % 非澳大利亚的部分或水域

Plight = 1e-6;    % 自燃的概率  
Pgrowth = 0;      % 生长概率 

% 邻居方位d和点燃概率p 
% d = {[1,0], [0,1], [-1,0], [0,-1], [1,1], [-1,1], [-1,-1], [1,-1]};
% p = [ones(1,4), ones(1,4)*(sqrt(1/2)-1/2)];
% 考虑风的因素
d = {[1,0], [0,1], [-1,0], [0,-1], [1,1], [-1,1], [-1,-1], [1,-1], [0,-2]};
p = [ 0.80,  0.30,   0.80,   1.00,  0.12,   0.12,    0.30,   0.30,    0.8]; 

% 空地(E)= 0, 燃烧（F）= 1, 正常树（T）=2 ，非澳大利亚的部分或水域（U）= -1 
E = 0; F = 1; T = 2; U = -1; 
isE = (S==E); isF = (S==F); isT = (S==T); isU = (S==U);

R = isF+ isU;   % 火的部分
G = isT + isU;   % 树的部分
B = isU;        % 不是澳大利亚的部分
% isU=1（R,G,B）=(1,1,1)（白色）非澳大利亚的部分或水域
% isE=1（R,G,B）=(0,0,0)（黑色）空地
% （R,G,B）=(1,0,0)有火的地方；（R,G,B）=(0,1,0)正常树的地方；

imh = image([112,154],[-44,-10],(cat(3,R,G,B))); 
% hold on
% load coastlines   %就是确定海岸的轮廓
% plot(coastlon, coastlat, 'k', 'linewidth',0.2);
% axis image
% axis([112 154 -44 -10])
%  这几行就是刻画出来了澳大利亚的轮廓了

for t = 1:600       

    % 计算邻居中能传播着火的个数   
    sum = zeros(size(S));
    for j = 1:length(d)
        sum = sum + p(j) * (circshift(S,d{j})==F);
    end
    
    % 分别找出四种状态的元胞
    isE = (S==E); isF = (S==F); isT = (S==T); isU = (S==U);
    
    % 找出满足着火条件的元胞（被传播点燃的和自燃的）
    ignite = rand(m,n)<sum | (rand(m,n)<Plight);  
    
    % 规则1:着火
    Rule1 = T*(isT & ~ignite) + F*(isT & ignite);
    % 规则2: 燃尽
    Rule2 = F*isF - F*isF;
    % 规则3:新生
    Rule3 = T*(isE & rand(m,n)<Pgrowth);
    % 规则4: “非”不变   
    Rule4 = U*isU;
    
    S = Rule1 + Rule2 + Rule3 + Rule4;
    
    R = isF+ isU + R - 0.02.*(R>0&R<=1);  %红色的持续时间，也就相当与一个树木到底要烧多久 。
    R(R<0)=0; %这一段是不可以删去的，因为不可以让他减到复数，因为有可能成为-1.而成为“空”
    G = isT + isU; 
    set(imh, 'cdata', cat(3, R, G, B))   % flipud 因为要跟框框对上。 
%     set(imh, 'cdata', flipud(cat(3, R, G, B)) )   % flipud 因为要跟框框对上。 
    drawnow
end
