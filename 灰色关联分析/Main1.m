%% ��ɫ������������ϵͳ����
load Data1.mat

Mean = mean(Data);  % ����ÿһ�еľ�ֵ
row = size(Data,1);
Data = Data ./ repmat( Mean, row, 1);  % ��ӦԪ��������õ���������ݱ���ƽ��ֵ�ı�ֵ
disp('Ԥ�����ľ���Ϊ��'); 
disp(Data)
X_0 = Data( :, 1);  % ĸ����
X_i = Data( :, 2: end); % ������
ABS_X0_Xi = abs(X_i - repmat( X_0, 1, size( X_i, 2)))  % ����|X0-Xi|����
a = min(min(ABS_X0_Xi));    % ������С��a
b = max(max(ABS_X0_Xi));  % ��������b
rho = 0.5; % �ֱ�ϵ��ȡ0.5
result = (a + rho*b) ./ (ABS_X0_Xi + rho*b)  % �������ϵ��
disp('�������и���ָ��Ļ�ɫ�����ȷֱ�Ϊ��')
disp(mean(result))