function [] = Way_show( distances, way, a, b)
%% 显示从i到j经过的最短路径和最短路径值
%% 
if a == b
    warning('起点和终点相同')  
    return;  % 退出函数
end

if way( a, b) == b   % 如果way(a,b) = b，则有两种可能：
    % dist(a,b) 为 Inf , 从a到b没有路径可以到达
    if distances( a, b) == Inf
        disp([num2str(a),'到',num2str(b),'没有路径可以到达'])
    % dist(a,b)不为 Inf , 则从i到j可直接到达，且为最短路径
    else
        disp([num2str(a),'到',num2str(b),'的最短路径为：',num2str(a),' --> ',num2str(b)])
        disp(['最短路径值为：',num2str(distances( a, b))])
    end
else  % 如果way(i,j) ~= j，中间经过了其他节点：
    p = way( a, b);
    way_show = [ num2str(a), ' --> '];  % 将要最短路径经过的点保存在这里面
    while p ~= b  % p不等于b时
        way_show = [ way_show, num2str(p), ' --> ' ];  % 经过p这个节点处
        p = way( p, b);  % 将p换为下一个点
    end
    way_show = [ way_show, num2str(p)];
    disp([num2str(a),'到',num2str(b),'的最短路径为：',way_show])
    disp(['最短路径值为：',num2str(distances( a, b))])
end

end
