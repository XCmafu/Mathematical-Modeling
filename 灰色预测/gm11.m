function [result, x0_hat, relative_residuals, eta] = gm11( x0, predict_num)
    % �������ã�ʹ�ô�ͳ��GM(1,1)ģ�Ͷ����ݽ���Ԥ��
    %     x0��ҪԤ���ԭʼ����
    %     predict_num�� ���Ԥ�������

    %     result��Ԥ��ֵ
    %     x0_hat����ԭʼ���ݵ����ֵ
    %     relative_residuals�� ��ģ�ͽ�������ʱ����õ�����Բв�
    %     eta�� ��ģ�ͽ�������ʱ����õ��ļ���ƫ��

    n = length(x0); % ���ݵĳ���
    x1 = cumsum(x0); % ����һ���ۼ�ֵ
    z1 = (x1(1:end-1) + x1(2:end)) / 2;  % ������ھ�ֵ�������У�����Ϊn-1��
    % ���ӵڶ��ʼ��x0����y��z1����x��������һԪ�ع�  y = kx +b
    x = z1;
    y = x0(2:end); 
    
    k = ((n-1)*sum(x.*y)-sum(x)*sum(y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    b = (sum(x.*x)*sum(y)-sum(x)*sum(x.*y))/((n-1)*sum(x.*x)-sum(x)*sum(x));
    a = -k;  %k = -a
    % -a���Ƿ�չϵ��,  b���ǻ�������
    
    disp('GM(1,1)Ԥ���ԭʼ������: ')
    disp(mat2str(x0'))  % mat2str���Խ������������ת��Ϊ�ַ�����ʾ
    disp(strcat('��С���˷���ϵõ��ķ�չϵ��Ϊ',num2str(-a),'������������',num2str(b)))
    
    x0_hat = zeros( n, 1);  
    x0_hat(1) = x0(1);   % x0_hat���������洢��x0���е����ֵ�������Ƚ��г�ʼ��
    for i = 1:n-1
        x0_hat(i+1) = (1-exp(a))*(x0(1)-b/a)*exp(-a*i);
    end
    
    result = zeros( predict_num, 1);  % ��ʼ����������Ԥ��ֵ������
    for i = 1:predict_num
        result(i) = (1-exp(a))*(x0(1)-b/a)*exp(-a*(n+i-1)); % ���빫ʽֱ�Ӽ���
    end

    absolute_residuals = x0(2:end) - x0_hat(2:end);   % �ӵڶ��ʼ������Բв��Ϊ��һ������ͬ��
    relative_residuals = abs(absolute_residuals) ./ x0(2:end);  % ������Բвע�����Ҫ�Ӿ���ֵ������Ҫʹ�õ��

    class_ratio = x0(2:end) ./ x0(1:end-1) ;  % ���㼶�� sigma(k) = x0(k)/x0(k-1)
    eta = abs(1-(1-0.5*a)/(1+0.5*a)*(1./class_ratio));  % ���㼶��ƫ��
end