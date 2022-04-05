clear;clc
load Data.mat  % ��53�п�ʼ

%% ͳ��������Ҳ����Excel���ݷ�����SPSS-����-����ͳ��
MIN = min(Data);  % ÿһ�е���Сֵ
MAX = max(Data);   % ÿһ�е����ֵ
MEAN = mean(Data);  % ÿһ�еľ�ֵ
MEDIAN = median(Data);  % ÿһ�е���λ��
SKEWNESS = skewness(Data); % ÿһ�е�ƫ��
KURTOSIS = kurtosis(Data);  % ÿһ�еķ��
STD = std(Data);  % ÿһ�еı�׼��
Data_analysis = [ MIN; MAX; MEAN; MEDIAN; SKEWNESS; KURTOSIS; STD]  %����Щͳ�����ŵ�һ���������б�ʾ

%% �������֮������ϵ��
% �ڼ���Ƥ��ѷ���ϵ��֮ǰ,һ��Ҫ����ɢ��ͼ�����������֮���Ƿ������Թ�ϵ
% ����ʹ��Spss�ȽϷ���: ͼ�� - �ɶԻ��� - ɢ��ͼ/��ͼ - ����ɢ��ͼ

CORRCOEF_data = corrcoef(Data)  % ����Ƥ��ѷ���ϵ��

%% ������鲿��
x = -4:0.1:4;
y = tpdf( x, 28);  % ��t�ֲ��ĸ����ܶ�ֵ 28�����ɶ�  
figure(1)
plot( x, y, '-')
grid on  % ����������
hold on  % ����ԭ����ͼ

Tinv = tinv(0.975,28) %���ɶ�Ϊ28��t�ֲ� ������ˮƽΪ0.025���ĵ��ࣨ������ˮƽΪ0.05����˫�ࣩ���ٽ�ֵ

% ��ͼ�õ��ܾ���
plot( [-Tinv,-Tinv], [0,tpdf( -Tinv, 28)], 'r-')
plot( [Tinv,Tinv], [0,tpdf( Tinv, 28)], 'r-')
% ��������t���Ƚ��Ƿ������ھܾ���

%% ����pֵ
s = 0.5
n = 30
x = -4:0.1:4;
y = tpdf( x, n-2);  % ��t�ֲ��ĸ����ܶ�ֵ 28�����ɶ� 
figure(2)
plot( x, y, '-')
grid on 
hold on
% ���߶εķ���
t = s*(((n-2)/(1-s^2))^0.5) % sΪ��֪����ֵ��nΪ��������
plot( [-t,-t], [0,tpdf( -t, n-2)], 'r-')
plot( [t,t], [0,tpdf( t, n-2)], 'r-')

disp('pֵΪ��')
p = (1-tcdf(t,n-2))*2; % ˫������pֵҪ����2
disp(p)  
% p < x%����ʾ��1-x%������ˮƽ�Ͼܾ�ԭ����,��x%������ˮƽ�Ͻ���ԭ����

%% pֵ���飬����������Ƥ��ѷ���ϵ���Ƿ���������0��H0��CORRCOEF_date=0��
% �������֮���Ƥ��ѷ���ϵ���Լ�pֵ
[CORRCOEF_data,P_pearson] = corrcoef(Data)

% ����ǣ�p��������ˮƽ���ܾ�ԭ�������p�ĸ��ʳ���
P_pearson < 0.01  % ����Ժ�ǿ
(P_pearson < 0.05) & (P_pearson > 0.01) 
(P_pearson < 0.1) & (P_pearson > 0.05)



%% ��̬�ֲ����飬H0��������̬�ֲ�
% �����һ�������Ƿ�Ϊ��̬�ֲ�,JB����
[h,p] = jbtest( Data(:,1), 0.05) % ��Ĭ�ϣ���pֵ��0.05�Ƚϣ�����p<0.05��H=1�ܾ�ԭ���裬��������̬�ֲ���H=0������ԭ���裩
% [H,p] = jbtest( Date(:,1), 0.01)

% ��ѭ�����������е�����
column = size( Data, 2);  
H_jb = zeros(1,6);  
P_jb = zeros(1,6);
for i = 1:column
    [h,p] = jbtest( Data(:,i), 0.05);
    H_jb(i) = h;
    P_jb(i) = p;
end
disp(H_jb)
disp(P_jb)

% ��һ��Q-Qͼ
qqplot(Data(:,1))



%% ˹Ƥ�������ϵ��
X = [3 8 4 7 2]'  % ������������
Y = [5 10 9 10 6]'

% ����˹Ƥ�������ϵ��
% ��һ�ּ��㷽��
SPEARMAN = 1-6*(1+0.25+0.25+1)/5/24
% �ڶ��ּ��㷽��
SPEARMAN = corr( X, Y, 'type', 'Spearman')
% �����ּ��㷽��
RX = [2 5 3 4 1] % XԪ�صĵȼ�
RY = [1 4.5 3 4.5 2] % YԪ�صĵȼ�
SPEARMAN = corrcoef( RX, RY)

% ���������е�˹Ƥ�������ϵ��
SPEARMAN = corr( Data, 'type', 'Spearman')
% �������ֵ
disp(sqrt(590)*0.0301) % ��������591-1�� ��Ӧ˹Ƥ�������ϵ����0.0301
% ����pֵ
disp((1-normcdf(0.7311))*2) % normcdf���������׼��̬�ֲ����ۻ������ܶȺ����� ��Ӧ����ֵ��0.7311

% ֱ�Ӹ������ϵ����pֵ
[SPEARMAN,P_spearman] = corr( Data, 'type', 'Spearman')
