function [plaza, v, time] = create_plaza(B, L, plazalength)    % �����ܵ�·����
% 1 = �г�, 0 = Ϊ��, -1 = �ǵ�·, -3 = �շ�վ
% B = �շ�վ����
% L = ������
% plazalength = ģ��ĵ�·�ܳ���101��100�����ӣ�
plaza = zeros(plazalength, B+2); % 100*14 ģ���·ͼ��
v = zeros(plazalength, B+2); % �ٶ�״̬�����ʼ��
time = zeros(plazalength, B+2); % ʱ��״̬�����ʼ��

plaza(1:plazalength, [1,B+2]) = -1; % �������߽߱磬�ǵ�·
plaza(ceil(plazalength/2), [2:B+1]) = -3; % �����շ�վ��λ��
          
toptheta = 1.3; % ����
bottomtheta = 1.2; % �׽�
%���
%��
for col = 2:ceil(B/2-L/2)+1     % 2 3 4 
    for row = 1:(plazalength-1)/2 - floor(tan(toptheta) * (col-1))  
        % floor(tan(toptheta) * (col-1)   3 7 10 
        % row 1,2,3...47   1,2,3...43   1,2,3...40
        % col     2            3            4
        plaza(row, col) = -1;    %  �������������-1
    end
%��
    for row = 1:(plazalength-1)/2 - floor(tan(bottomtheta) * (col-1))
        % floor(tan(toptheta) * (col-1)   2 5 7
        % row 1,2,3...48   1,2,3...45   1,2,3...43
        % col     2            3            4
        plaza(plazalength+1-row, col) = -1;
    end
end
%�ұ�
%��
for col = B+1:-1:B+1-floor(B/2-L/2)+1    % 13 12 11
    for row = 1:(plazalength-1)/2 - floor(tan(toptheta) * ((B+3-col)-1))  
        % floor(tan(toptheta) * (col-1)   3 7 10 
        % row 1,2,3...47   1,2,3...43   1,2,3...40
        % col     13           12           11
        plaza(row, col) = -1;    %  �������������-1
    end
%��
    for row = 1:(plazalength-1)/2 - floor(tan(bottomtheta) * ((B+3-col)-1))
        % floor(tan(toptheta) * (col-1)   2 5 7
        % row 1,2,3...48   1,2,3...45   1,2,3...43
        % col     13           12           11
        plaza(plazalength+1-row, col) = -1;
    end
end
