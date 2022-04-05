clc, clear
load Data;

x(:,[2,6]) = -x(:,[2,6]); % �ѳɱ���ָ��ת����Ч����ָ�꣬ԽСԽ��ת����Խ��Խ��
R = tiedrank(x); % ��ÿ��ָ��ֵ�ֱ���ȣ�����x��ÿһ�зֱ����

[n,m] = size(R); % �������R��ά��
% ��Ȩ��
% RSR = mean(R,2)/n;  % �����Ⱥͱ�
% ��Ȩ��
W = repmat(w, n, 1);
WRSR = sum(R.*W,2)/n;  % �����Ȩ�Ⱥͱ�

[sWRSR,ind] = sort(WRSR); % �Լ�Ȩ�Ⱥͱ����� 
p = (1:n)/n;    % �����ۻ�Ƶ��
p(n) = 1-1/(4*n); % �������һ���ۻ�Ƶ�ʣ����һ���ۻ�Ƶ�ʰ�1-1/(4*n)����

Probit = norminv(p,0,1)+5;  % �����׼��̬�ֲ���p��λ��+5
X = [ones(n,1), Probit'];  % ����һԪ���Իع���������ݾ���
[b,bint,r,rint,stats] = regress(sWRSR, X);  % һԪ���Իع���� sWRSR����� X�Ա���
disp(stats) % R2 ͳ������F ͳ�������� p ֵ���Լ�����Ĺ���ֵ
WRSRfit = b(1)+b(2)*Probit;  % ����WRSR�Ĺ���ֵ
y = [1983:1992]'; 
xlswrite('result.xls',[y(ind), R(ind,:), sWRSR],1) % ��Ȩ�Ⱥͱ�������������д�����Sheet1���� 
xlswrite('result.xls',[y(ind), ones(n,1), [1:n]', p', Probit', WRSRfit', [n:-1:1]'], 2) % �ֵ�������������д�����Sheet2���� 