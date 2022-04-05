%% л�ƶ����Ŵ�������
clc;clear all;close all
%%��������ͼ
figure(1);
hold on;
%%�����Ա�����Χ
Ib = 1; Ub = 2;
ezplot('sin(10*pi*X)/X',[Ib,Ub]);
xlabel('�Ա���/X')
ylabel('����ֵ/Y')

%%�����Ŵ��㷨����
NIND= 40;  %%��Ⱥ��С
MAXGEN = 50;  %%����Ŵ�����
PRECI = 20;  %%���峤��
GGAP = 0.95;  %%����
px = 0.7;  %%�������
pm = 0.01;  %%�������
trace = zeros(2,MAXGEN);  %%Ѱ�����Ž����ʼֵ
FieldD = [PRECI;Ib;Ub;1;0;1;1];  %%����������
Chrom = crtbp(NIND,PRECI);  %%����������ɢ�����Ⱥ
%%�Ż�
gen = 0;  %%��������
X = bs2rv(Chrom,FieldD);  %%��ʼ��Ⱥ��ʮ������ת��
ObjV = sin(10*pi*X)./X;  %%����Ŀ�꺯��ֵ
while gen<MAXGEN
    FitnV = ranking(ObjV);  %%������Ӧ��ֵ
    SelCh = select('sus',Chrom,FitnV,GGAP);  %%ѡ��
    selCh = recombin('xovsp',SelCh,px);  %%����
    SelCh = mut(SelCh,pm);  %%����
    X = bs2rv(SelCh,FieldD);  %%�Ӵ������ʮ����ת��
    ObjVSel = sin(10*pi*X)./X;  %%�����Ӵ���Ŀ�꺯��ֵ
    [Chrom,ObjV] = reins(Chrom,SelCh,1,1,ObjV,ObjVSel);  %%���²����Ӵ����������õ��µ���Ⱥ
    X = bs2rv(Chrom,FieldD);
    gen = gen + 1;  %%�Ӵ�����������
    %��ȡÿһ�������Ž⼰�����кţ�YΪ���Ž⣬IΪ�������
    [Y,I] = min(ObjV);  
    trace(1,gen) = X(I);  %%����ÿһ��������ֵ
    trace(2,gen) = Y;   %%����ÿһ��������ֵ
end
plot(trace(1,:),trace(2,:),'bo');  %%����ÿһ�������ŵ�
grid on;
plot(X,ObjV,'b*');  %%�������һ����Ⱥ
hold off;

%%������ͼ
figure(2);
plot(1:MAXGEN,trace(2,:));
grid on;
xlabel('�Ŵ�����')
ylabel('��ñ仯');
title('��������');
bestY = trace(2,end);
bestX = trace(1,end);
fprintf(['���Ž�:\nX=',num2str(bestX),'\nY=',num2str(bestY),'\n']);
