%% �Ծ�����б�׼��
clear;clc
load data.mat

[row,column] = size(M);
M_Stand = M ./ repmat(sum(M.*M) .^ 0.5, row, 1);

% ��Ȩ
if sum(sum(M_Stand<0)) >0   % ��׼����ľ����д��ڸ����������¶�X���б�׼��
    disp('ԭ����׼���õ���Z�����д��ڸ�����������Ҫ��X���±�׼��')
    for i = 1:row
        for j = 1:column
            M_Stand(i,j) = (M(i,j) - min(M(:,j))) / (max(M(:,j)) - min(M(:,j)));
        end
    end
    disp('X���½��б�׼���õ��ı�׼������ZΪ:  ')
    disp(M_Stand)
end
weight = shangquanfa(M_Stand);
disp('��Ȩ��ȷ����Ȩ��Ϊ��')
disp(weight)