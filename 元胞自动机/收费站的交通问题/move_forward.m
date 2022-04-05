function [plaza, v, time] = move_forward(plaza, v, time, vmax)
% move_forward   ��NS����ǰ��
% 1.һ�����ʣ����٣�k���ĳ�����ڵ�ǰ�ٶȣ���λʱ����ͨ���ľ��룩 & ����֮���ٶ�С������ٶ�
% 2.һ�������٣�k���ĳ���С�ڵ�λʱ����ͨ���ľ��� & ����֮���ٶȴ�����
% 3. һ�������������
% 4. �����շ�վ
%        1 = �г�, 0 = Ϊ��, -1 = �ǵ�·, -3 = �շ�վ
%        v = �ٶȾ���
%        time = ʱ�����
%        vmax = ����ٶ�
%%
Service = 0.8; % ������   exp(-Service*dt) = 0.8521
dt = 0.2; % ʱ��
probac = 0.7; % ���ٸ���
probdc = 1; % ���ٵĿ�����
probrd = 0.3; % ������ٵĿ�����
t_h = 1; % ʱ������
[L, W] = size(plaza);
gap = zeros(L, W);
found = find(plaza==1); % �ҵ��ܵ�·���г���λ�ò���¼
for k1=found'
    [i, j] = ind2sub([L, W], k1); % ��������kλ�ã���[i,j]��ʾ
    d = plaza(i+1:end, j); % k�����ڵ�· ǰ���г��ľ���
    gap(k1) = min( find([d~=0;1]) )-1; % �ҵ���k��ǰ������ĳ������շ�վ�ľ��룻
end
gap(end,:) = 0; % ���һ�о���Ϊ0 

%% �ٶȸ��¹���
% һ�����ʼ��٣���������ٶ�
k2 = find((gap(found) > v(found)*t_h) & (v(found) + 1 <= vmax) & (rand(size(found)) <= probac));
v(found(k2)) = v(found(k2)) + 1;
% һ������ 
k2 = find((v(found)*t_h > gap(found)) & (rand(size(found)) <= probdc));
v(found(k2)) = gap(found(k2))/t_h;
% һ�������������
k2 = find((rand(size(found)) <= probrd) & (v(found) + 1 >= 2));
v(found(k2)) = v(found(k2)) - 1;
% v(found(k2)) = max(v(found(k2)) - 1,0);

%% �շ�վ
booth_row = ceil(L/2); % �ҵ��շ�����λ��
for i = 2:W-1
    if (plaza(booth_row,i) ~= 1) % ������շ�վû��
        if (plaza(booth_row-1,i) == 1) % ����շ�վ֮ǰ�г�
            v(booth_row - 1 ,i) = 1; % �ó��ٶ�Ϊ1
        end
        plaza(booth_row,i) = -3;
    else % �շ�վ�г���
        if (plaza(booth_row+1,i) ~= 1) && (rand > exp(-Service*dt))
            % ������շ�վ�ĸ���û�������ұ������
            v(booth_row,i) = 1; % ��վ
        else
            v(booth_row,i) = 0;
        end
     end
end

%% ״̬����
for k = found'
    if rem(k,L)~=ceil(L/2)
        plaza(k) = 0;
    else
         plaza(k) = -3;
    end
end

plaza(found+v(found)) = 1;

time(found + v(found)) = time(found) + 1;
time(plaza~=1) = 0;

v(found + v(found)) = v(found);
v(plaza~=1)=0;

end