function h = show_plaza(plaza, h, n)
% show_plaza ���ܵ�·����ת��ΪͼƬ
% plaza = �ܵ�·����
% 1 = �г�, 0 = Ϊ��, -1 = �ǵ�·, -3 = �շ�վ
% h = ���
% n = ʱ����
[L,W] = size(plaza); % L:��·�ܳ��ȣ� W��14=12+2 
temp = plaza; % ������ʱ����
temp(temp==1) = 0; % ������

PLAZA(:,:,1) = plaza; % ������ά����
PLAZA(:,:,2) = plaza;
PLAZA(:,:,3) = temp;  

 PLAZA = 1-PLAZA; % ���Ҷȣ�0(Ŀǰû�У��г�����ɫ)��1���޳�����ɫ����2���ǵ�·����4���շ�վ��   
 PLAZA(PLAZA>1) = PLAZA(PLAZA>1)/6;  % 0(Ŀǰû�У��г�����ɫ)��1���޳�����ɫ����0.333���ǵ�·����0.666 ���շ�վ��
 
if ishandle(h) % ��Чͼ�β���
    set(h, 'CData', PLAZA)     
    pause(n)     % ��ʱִֹͣ��
else
    figure('position', [100,50,200,700] ) % ͼƬ��ʾ��λ�� [left bottom width height]
    h = image(PLAZA);  % RGB��ͼ 
    hold on
    % ��������
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k') 
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k')
%     axis image
%     set(gca, 'xtick', [], 'ytick', []);  
    pause(n)
end