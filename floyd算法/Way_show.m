function [] = Way_show( distances, way, a, b)
%% ��ʾ��i��j���������·�������·��ֵ
%% 
if a == b
    warning('�����յ���ͬ')  
    return;  % �˳�����
end

if way( a, b) == b   % ���way(a,b) = b���������ֿ��ܣ�
    % dist(a,b) Ϊ Inf , ��a��bû��·�����Ե���
    if distances( a, b) == Inf
        disp([num2str(a),'��',num2str(b),'û��·�����Ե���'])
    % dist(a,b)��Ϊ Inf , ���i��j��ֱ�ӵ����Ϊ���·��
    else
        disp([num2str(a),'��',num2str(b),'�����·��Ϊ��',num2str(a),' --> ',num2str(b)])
        disp(['���·��ֵΪ��',num2str(distances( a, b))])
    end
else  % ���way(i,j) ~= j���м侭���������ڵ㣺
    p = way( a, b);
    way_show = [ num2str(a), ' --> '];  % ��Ҫ���·�������ĵ㱣����������
    while p ~= b  % p������bʱ
        way_show = [ way_show, num2str(p), ' --> ' ];  % ����p����ڵ㴦
        p = way( p, b);  % ��p��Ϊ��һ����
    end
    way_show = [ way_show, num2str(p)];
    disp([num2str(a),'��',num2str(b),'�����·��Ϊ��',way_show])
    disp(['���·��ֵΪ��',num2str(distances( a, b))])
end

end
