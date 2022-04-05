clear;clc
% load data1.mat   % ���ɷ־��࣬��xһά����
 load Data2.mat   % ���ɷֻع飬��x��y��ά����

[n,index] = size(x);  % n������������index��ָ�����

%% 
X = zscore(x);  % ��׼��ΪX

% ����Э�������
% R = cov(X);

% ֱ�Ӽ����������ϵ������
R = corrcoef(x);

disp('�������ϵ������Ϊ��')
disp(R)

%% ����R������ֵ����������
% R�ǶԳƾ���Matlab����Գƾ���ʱ���Ὣ����ֵ���մ�С��������
[V,D] = eig(R);  % V�������������� D������ֵ���ɵĶԽǾ���

%% �������ɷֹ����ʺ��ۼƹ�����
Eigen_value = diag(D);  % ����ֵ��diag�����õ���������Խ���Ԫ��ֵ(����������)
Eigen_value = Eigen_value( end: -1: 1);  % ת���ɴӴ�С����
disp('����ֵΪ��')
disp(Eigen_value')  
disp('������������Ϊ��')
V=rot90(V)';  % ���������ĸ���������ֵ��Ӧ
disp(V)

Contribution_rate = Eigen_value / sum(Eigen_value);  % ���㹱����
disp('���ԵĹ�����Ϊ��')
disp(Contribution_rate')

Contribution_rate_cum = cumsum(Eigen_value)/ sum(Eigen_value);   % �����ۼƹ�����
disp('�ۼƹ�����Ϊ��')
disp(Contribution_rate_cum')

%% �������ɷֵ�ֵ
k =input('����Ҫ��������ɷֵĸ���:  ');
F = zeros( n, k);  %��ʼ��
for i = 1:k
    eigen_i = V( :, i)';   % ����i����������ȡ������ת��Ϊ������
    Eigen_i = repmat( eigen_i, n, 1);   
    F( :, i) = sum( Eigen_i .* X, 2); 
end



%% (1)���ɷ־��� �� �����ɷ�ָ�����ڵ�F�����Ƶ�Excel���Ȼ������Spss���о���
% ��Excel��һ������ָ�����ƣ�F1,F2, ..., Fm��
% F,������������ݵ�Excel���
% ��������֮�󣬺����ķ����Ϳ�����Spss�н��С�

%% ��2�����ɷֻع飺��xʹ�����ɷֵõ����ɷ�ָ�꣬����y��׼�������ŵ�����Excel��Ȼ����ʹ��Stata�ع�
% Y = zscore(y);  % ��y���б�׼��
% ��Excel��һ������ָ�����ƣ�Y,F1, F2, ..., Fm��
% Matlab��Y��F,������������ݵ�Excel���
% ��������֮�󣬺����ķ����Ϳ�����Stata�н��С�