function [plaza, v, time, departurescount, departurestime] = clear_boundary(plaza, v, time)
% clear_boundary  ���һ�г����ƶ�
%        1 = �г�, 0 = Ϊ��, -1 = �ǵ�·, -3 = �շ�վ
%        v = �ٶȾ���
%        time = ʱ�����
departurescount = 0; % ������ȥ������
departurestime = []; % ��ȥ����ʱ��
[L,W] = size(plaza);
for i =2:W-1
    if plaza(L,i) > 0
        departurescount = departurescount + 1;
        departurestime(departurescount) = time(L,i);
%         departurestime = [departurestime; time(L,i)];
        plaza(L,i) = 0;
        v(L,i) = 0;
        time(L,i) = 0;
    end
end
