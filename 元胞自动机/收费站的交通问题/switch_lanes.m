function [plaza, v, time] =  switch_lanes(plaza, v, time)
% switch_lanes  Ϊ������ײ����
%        plaza = p�շ�������
%        1 = �г�, 0 = Ϊ��, -1 = �ǵ�·, -3 = �շ�վ
%        v = �ٶȾ���
%        time = ʱ�����
L = size(plaza, 1);
found = find(plaza==1); % �ҵ��ܵ�·���г���λ�ò���¼
if ~isempty(found) % ����г�
    found = found(randperm(length(found))); % �������������
end
for k = found' % ���������˳�����ѭ��
    if (plaza(k+1)~=0 || plaza(k-1)==1) && rem(k,L)~=floor(L/2) && rem(k,L)~=ceil(L/2) 
        % ��������:��ǰ�����ϰ����ߺ����г������Ҳ����շ�վ����һ�������շ�վ
        % rem�� k%L ������=����һ�У�rem(k,L)~=floor(L/2) �������շ�վ����һ����
        if (rand < .5 ) % 0.5�ĸ���������߻���
            if plaza(k+L) == 0 && plaza(k+L+1) == 0 % ��������߿գ���ǰ��Ϊ��
                plaza(k+L) = 1; % k��������߳���
                plaza(k) = 0;
                v(k+L) = v(k); % ���ٶ���ʱ��״̬ת��
                v(k) = 0;
                time(k+L) = time(k);
                time(k) = 0;
            elseif plaza(k-L) == 0 && plaza(k-L+1) == 0
                plaza(k-L) = 1; % �����ҳ���
                plaza(k) = 0;
                v(k-L) = v(k);
                v(k) = 0;
                time(k-L) = time(k);
                time(k) = 0;
            end
        else  % 0.5�ĸ��������ұ߻���
            if plaza(k-L) == 0 && plaza(k-L+1) == 0
                plaza(k-L) = 1;
                plaza(k) = 0;
                v(k-L) = v(k);
                v(k) = 0;
                time(k-L) = time(k);
                time(k) = 0;
            elseif plaza(k+L) == 0 && plaza(k+L+1) == 0
                plaza(k+L) = 1;
                plaza(k) = 0;
                v(k+L) = v(k);
                v(k) = 0;
                time(k+L) = time(k);
                time(k) = 0;
            end
        end
    end
end
