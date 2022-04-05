%% ��ɫ�������������ۺ�����ģ������Ľ���
clear;clc
load Data2.mat

%%  �ж��Ƿ���Ҫ����
[row,column] = size(X);
Judge = input('�Ƿ���ָ����Ҫ���򻯴�����Ҫ����1������Ҫ����0��');

if Judge == 1
    P_column = input('������Ҫ���򻯴����ָ�����ڵ��У����1��2��3������Ҫ������ô����[1,2,3]��'); 
    Type = input('ָ�����ͣ�1����С�ͣ� 2���м��ͣ� 3�������ͣ����磺��1���Ǽ�С�ͣ���2���������ͣ���3�����м��ͣ�������[1,3,2]��'); 
    for i = 1:size( P_column, 2)  %������Ҫ����Щ�зֱ�����ѭ���Ĵ���
        X( :, P_column(i)) = Positive( P_column(i), Type(i), X( :, P_column(i)));
    end
    disp('���򻯺�ľ��� =  ')
    disp(X)
end

%% �����򻯺�ľ������Ԥ����
Mean = mean(X);  % ����ÿһ�еľ�ֵ
row2 = size( X, 1);
X = X ./ repmat( Mean, row2, 1);  
disp('Ԥ�����ľ���Ϊ��'); 
disp(X)

%% ĸ���к�������
X_0 = max( X, [], 2);  % ĸ����,Ϊ����ģ���ÿһ�е����ֵ���ɵ���������ʾĸ����
X_i = X;  % �����У�Ԥ���������ݾ���

%% ����÷�
ABS_X0_Xi = abs( X_i - repmat( X_0, 1, size( X_i, 2)))  % ����|X0-Xi|����
a = min(min(ABS_X0_Xi));    % ������С��a
b = max(max(ABS_X0_Xi));  % ��������b
rho = 0.5; % �ֱ�ϵ��ȡ0.5

result = (a + rho*b) ./ (ABS_X0_Xi + rho*b)   % �������ϵ��
weight = mean(result) / sum(mean(result));  % �����������и���ָ��Ļ�ɫ������,�õ�Ȩ��
row3 = size( X_i, 1);
Result = sum( X_i .* repmat( weight, row3, 1), 2);   % �÷�

Normalization_R = Result / sum(Result);   % �÷ֹ�һ����
[sorted_R,index] = sort( Normalization_R, 'descend') % ��������