%% 
clc,clear
load data.mat

mu = mean(data); % ��ֵ��
sigma = std(data); % ��׼��
data_stand = zscore(data);
x = data_stand(:,[1:3]); % �Ա���
y = data_stand(:,[4:end]);  % �����
[XL,YL,XS,YS,BETA,PCTVAR,MSE,stats] = plsregress(x, y);

% ����PCTVAR
ncomp = 2;  
[XL2,YL2,XS2,YS2,BETA2,PCTVAR2,MSE2,stats2] = plsregress(x, y, ncomp);
n = size(x,2); m = size(y,2); % n�Ա�������, m���������
beta3(1,:) = mu(n+1:end)-mu(1:n)./sigma(1:n)*BETA2([2:end],:).*sigma(n+1:end); % ԭʼ���ݻع鷽�̵ĳ�����
beta3([2:n+1],:) = (1./sigma(1:n))'*sigma(n+1:end).*BETA2([2:end],:) % ����ԭʼ������ϵ��
bar(BETA2')   % ��ֱ��ͼ

% legend('sigma','2015SR','2015CY','2015HJ','2015WJ','2015SS','2015T')
% text(0.75,-0.03,'2020SR')
% text(1.75,-0.03,'2020CY')
% text(2.75,-0.03,'2020HJ')
% text(3.75,-0.03,'2020WJ')
% text(4.75,-0.03,'2020SS')
% text(5.75,-0.03,'2020T')
% 
% yhat=repmat(beta3(1,:),[size(x,1),1])+data(:,[1:n])*beta3([2:end],:); 
% figure, subplot(2,3,1)
% plot(yhat(:,1),data(:,n+1),'H',[-5:5],[-5:5],'Color','k')
% legend('SR'), xlabel('�ع�����'), ylabel('�۲�����')
% subplot(2,3,2)
% plot(yhat(:,2),data(:,n+2),'H',[-5:5],[-5:5],'Color','k')
% legend('CY'), xlabel('�ع�����'), ylabel('�۲�����')
% subplot(2,3,3)
% plot(yhat(:,3),data(:,n+3),'H',[-5:5],[-5:5],'Color','k')
% legend('HJ'), xlabel('�ع�����'), ylabel('�۲�����')
% subplot(2,3,4)
% plot(yhat(:,4),data(:,n+4),'H',[-5:5],[-5:5],'Color','k')
% legend('WJ'), xlabel('�ع�����'), ylabel('�۲�����')
% subplot(2,3,5)
% plot(yhat(:,5),data(:,n+5),'H',[-5:5],[-5:5],'Color','k')
% legend('SS'), xlabel('�ع�����'), ylabel('�۲�����')
% subplot(2,3,6)
% plot(yhat(:,6),data(:,n+6),'H',[-5:5],[-5:5],'Color','k')
% legend('TOTAL'), xlabel('�ع�����'), ylabel('�۲�����')