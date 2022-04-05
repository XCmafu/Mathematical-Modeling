%%
% ����x��y��ֵ
load Data1.mat

plot(x,y,'o')
xlabel('x��ֵ');
ylabel('y��ֵ');

% y=kx+b
row = size(x,1);
k = (row*sum(x.*y)-sum(x)*sum(y))/(row*sum(x.*x)-sum(x)*sum(x))
b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/(row*sum(x.*x)-sum(x)*sum(x))
hold on % ������֮ǰ��ͼ��������ͼ��
grid on % ��ʾ������

%% ����y=kx+b�ĺ���ͼ��
%(����һ)
x2 = 4.2: 0.1 :6.9;  % ������õ�ԽС��������ͼ��Խ׼ȷ
y2 = k * x2 + b;  % k��b������ֵ֪
plot(x2,y2,'-')

%����������APP ���

%(������)����
% y2=@(x) k*x+b;
% fplot(y2,[min(x)-1,max(x)+1]);
% legend('��Ϻ���','location','SouthEast')


%% ��������Ŷ�
y_fit = k*x+b; % y�����ֵ
SSR = sum((y_fit-mean(y)).^2)  % �ع�ƽ����
SST = sum((y-mean(y)).^2) % ��ƫ��ƽ����
SSE = sum((y-y_fit).^2) % ���ƽ����
SST-SSE-SSR  % ����0
R = SSR / SST  % ����Ŷ�Խ�ӽ�1�����Խ��
R_2 = SSR / SST