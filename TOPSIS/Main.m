%%
clear;clc
load Data.mat

%%  �ж��Ƿ���Ҫ����
[row,column] = size(M);
Judge = input('�Ƿ���ָ����Ҫ���򻯴�����Ҫ����1������Ҫ����0��');

if Judge == 1
    P_column = input('������Ҫ���򻯴����ָ�����ڵ��У����1��2��3������Ҫ������ô����[1,2,3]��'); 
    Type = input('ָ�����ͣ�1����С�ͣ� 2���м��ͣ� 3�������ͣ����磺��1���Ǽ�С�ͣ���2���������ͣ���3�����м��ͣ�������[1,3,2]��'); 
    for i = 1:size( P_column, 2)  %������Ҫ����Щ�зֱ�����ѭ���Ĵ���
        M_positive( :, P_column(i)) = Positive( P_column(i), Type(i), M( :, P_column(i)));
    end
    disp('���򻯺�ľ��� =  ')
    disp(M_positive)
else
    M_positive = M;
end

%% �Ƿ���Ҫ����Ȩ��
disp("�������Ƿ���Ҫ����Ȩ����������Ҫ����1������Ҫ����0")
Judge = input('�������Ƿ���Ҫ����Ȩ�أ� ');
if Judge == 1
    disp(['�������3��ָ�꣬�����Ҫ����3��Ȩ�أ��������Ƿֱ�Ϊ0.25,0.25,0.5, ������Ҫ����[0.25,0.25,0.5]']);
    weigh = input(['����Ҫ����' num2str(m) '��Ȩ����' '��������������ʽ������' num2str(m) '��Ȩ��: ']);
    OK = 0;  % �����ж��û��������ʽ�Ƿ���ȷ
    while OK == 0 
        if abs(sum(weigh) - 1)<0.000001 && size(weigh,1) == 1 && size(weigh,2) == m   % ����Ҫע�⸡�����������ǲ���׼�ġ�
             OK =1;
        else
            weigh = input('���������������������Ȩ��������: ');
        end
    end
else
    weigh = ones(1,m) ./ m ; %�������Ҫ��Ȩ�ؾ�Ĭ��Ȩ�ض���ͬ������Ϊ1/m
end

%% �����򻯺�ľ�����б�׼��
M_Stand = M_positive ./ repmat( sum(M_positive.*M_positive) .^0.5, row, 1);
disp('��׼������ = ')
disp(M_Stand)

%% ���������ֵ�ľ������Сֵ�ľ��룬������÷֣��ٹ�һ��
D_Max = sum(((M_Stand - repmat( max(M_Stand), row, 1)) .^2 ).* repmat(weigh,n,1),2) .^0.5;   % D+ �����ֵ�ľ�������
D_Min = sum(((M_Stand - repmat( min(M_Stand), row, 1)) .^2 ).* repmat(weigh,n,1),2) .^0.5;   % D- ����Сֵ�ľ�������
S = D_Min ./ (D_Max+D_Min);    % δ��һ���ĵ÷�

disp('��һ���÷�Ϊ��')
Normal_S = S / sum(S)

disp('������������')
[sort_S,index] = sort( Normal_S , 'descend')


% sort(A)��A�������������л�����������Ĭ�϶��Ƕ�A�����������С�sort(A)��Ĭ�ϵ����򣬶�sort(A,'descend')�ǽ�������
% sort(A)��A�Ǿ���Ĭ�϶�A�ĸ��н�����������
% sort(A,dim)
% dim=1ʱ��Чsort(A)
% dim=2ʱ��ʾ��A�еĸ���Ԫ����������