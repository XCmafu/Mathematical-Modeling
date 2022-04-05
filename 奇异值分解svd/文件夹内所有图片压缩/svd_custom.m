function [compress_A] = svd_custom( A, ratio)
    % �������ã�ʹ������ֵ�ֽ⽫����Aѹ����ָ������������
    
    %     A��Ҫѹ���ľ���
    %     ratio��Ҫ����ԭ�������������
    
    %     compress_A: ѹ����ľ���
    [U,S,V] = svd(A);  
    x = diag(S);  % diag�������Է���S�����Խ���Ԫ�أ�������A������ֵ�������䱣�浽��������
    SUM = sum(x);  % ������������ֵ���ܺ�
    temp = 0;   
    for  i = 1:length(x)  % ѭ��
        temp = temp+x(i);  % ÿѭ��һ�Σ��͸���temp��ֵΪԭ����tempֵ+��������һ������ֵ
        if (temp/SUM) > ratio  % ������ڵı���������ratio,���˳�ѭ��
            break
        end
    end
    disp(['ѹ����ʵ�ʱ���ԭ����ı�������Ϊ��',num2str(roundn(100*temp/SUM,-2)),'%'])  
    compress_A = U(:,1:i)*S(1:i,1:i)*V(:,1:i)';
end

