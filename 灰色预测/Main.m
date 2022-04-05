%%  ����ԭʼ���ݲ�����ʱ������ͼ
clear;clc

year = [1995:1:2004]';  % �������ʾ��ݣ�д������������ʽ
x1 = [174,179,183,189,207,234,220.5,256,270,285]';  % ԭʼ�������У�д������������ʽ

% ����ԭʼ���ݵ�ʱ������ͼ
figure(1); 
plot( year, x1, 'o-'); 
grid on;
% set(gca,'xtick',year(1:1:end))  % ����x�������ļ��Ϊ1
xlabel('���');  ylabel('��������');  % ������ӱ�ǩ


%% GM(1,1)ģ�ͣ������������������϶̵ķǸ�ʱ������
n = length(x1);
ERROR = 0;  % ����һ������ָ�꣬�����Ϊ1
% % �ж��Ƿ��и���Ԫ��
% if sum(x1<0) > 0  
%     disp('��ɫԤ���ʱ���������и���')
%     ERROR = 1;
% end
% 
% % �ж��������Ƿ�̫��
% n = length(x1);  % ����ԭʼ���ݵĳ���
% disp(strcat('ԭʼ���ݵĳ���Ϊ',num2str(n)))    % strcat()�������ַ����ĺ�������һ��ѧ�ˣ��ɱ�����Ŷ
% if n<=3
%     disp('������̫С')
%     ERROR = 1;
% end
% 
% % ����̫��ʱ��ʾ�ɿ���ʹ������������������
% if n>10
%     disp('�������϶�')
% end


%% �ж������Ƿ�Ϊ��������������������������ת��Ϊ������
if size( x1, 1) == 1
    x1 = x1';
end
if size( year, 1) == 1
    year = year';
end


%% ��һ���ۼӺ�����ݽ���׼ָ�����ɵļ���(ע�⣬���������ʱ��ʹ��ͨ����Ҳ��һ���ܱ�֤Ԥ�����ǳ���)
if ERROR == 0   
    disp('׼ָ�����ɼ��飺')
    x2 = cumsum(x1);   % �ۼ�   
    rho = x1(2:end) ./ x2(1:end-1);   % ����⻬��rho(k) = x0(k)/x1(k-1)
    
    % �����⻬�ȵ�ͼ�Σ�������0.5��ֱ�ߣ���ʾ�ٽ�ֵ
    figure(2)
%     rho1 = [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
%     plot( year(2:end), rho, 'o-', year(2:end), rho1, '-');
    plot( year(2:end), rho, 'o-', [year(2),year(end)], [0.5,0.5], '-'); 
    grid on;
    text( year(end), 0.5, '�ٽ���')
    % set(gca,'xtick',year(2:1:end))  % ����x�������ļ��Ϊ1
    xlabel('���'); ylabel('ԭʼ���ݵĹ⻬��');  % ����������ϱ�ǩ
    
    disp(strcat('ָ��1���⻬��С��0.5������ռ��Ϊ',num2str(sum(rho<0.5)/(n-1)*100),'%'))
    disp(strcat('ָ��2����ȥǰ����ʱ���⣬�⻬��С��0.5������ռ��Ϊ',num2str(sum(rho(3:end)<0.5)/(n-3)*100),'%'))
%     P1 = sum(rho<0.5)/(n-1)*100;
%     P2 = sum(rho(3:end)<0.5)/(n-3)*100;
%     if P1>0.6 && P2>0.9
%         ERROR = 0;
%     else
%         ERROR = 1;
    
    judge = input('�ο���׼��ָ��1һ�����60%, ָ��2����90%������Ϊ�������ݿ���ͨ�������𣿿���ͨ��������1������������0��');
    if judge == 0
        disp('���Ͽɣ�������')
        ERROR = 1;
    else
        disp('�Ͽɣ�������һ����')
    end
    
end
disp(' ')


%% 
if ERROR == 0   
    if  n > 4  % ����������4ʱ�������ݷ�Ϊѵ�����������(����ԭ��������Сn��ȡ��nΪ5-7����ȡ�������Ϊ�����飬n����7��ȡ�������Ϊ������)
       %% disp('��Ϊԭ���ݵ���������4���������ǿ��Խ��������Ϊѵ�����������')
        
        if n > 7
            test_num = 3;
        else
            test_num = 2;
        end
        
        disp('ѵ��������: ')
        train_x0 = x1(1:end-test_num)  % ѵ������ 
        disp('����������: ')
        test_x0 = x1(end-test_num+1:end) % ��������
        
        % ʹ������ģ�Ͷ�ѵ�����ݽ���ѵ�������ص�result��������Ԥ��test_num�ڵ�����
        disp(' ')
        disp('��ͳ��GM(1,1)ģ��Ԥ�⣺')
        result_tradition = gm11( train_x0, test_num); % ��ͳ��GM(1,1)ģ�Ͷ�ѵ�����ݣ���Ԥ���test_num�ڵĽ��
        disp(' ')
        disp('����Ϣ��GM(1,1)ģ��Ԥ�⣺')
        result_new_gm11 = new_gm11( train_x0, test_num); % ����ϢGM(1,1)ģ�Ͷ�ѵ�����ݣ���Ԥ���test_num�ڵĽ��
        disp(' ')
        disp('�³´�л��GM(1,1)ģ��Ԥ�⣺')
        result_metabolism_gm11 = metabolism_gm11( train_x0, test_num); % �³´�лGM(1,1)ģ�Ͷ�ѵ�����ݣ���Ԥ���test_num�ڵĽ��
        disp(' ')
        
        % �Ƚ�����ģ�Ͷ����������ݵ�Ԥ�����������������ݽ���Ԥ���ͼ��
        test_year = year(end-test_num+1:end);  % �������Ӧ�����
        figure(3)
        plot( test_year, test_x0, 'o-', test_year, result_tradition, '*-', test_year, result_new_gm11, '+-', test_year, result_metabolism_gm11, 'x-'); 
        grid on;
        % set(gca,'xtick',year(end-test_num+1): 1 :year(end))  % ����x�������ļ��Ϊ1
        legend( '���������ʵ����', '��ͳGM(1,1)Ԥ����', '����ϢGM(1,1)Ԥ����', '�³´�лGM(1,1)Ԥ����') 
        xlabel('���');  ylabel('��������');  % ����������ϱ�ǩ
        % �������ƽ����SSE
        SSE_tradition = sum((test_x0-result_tradition).^2);
        SSE_new_gm11 = sum((test_x0-result_new_gm11).^2);
        SSE_metabolism_gm11 = sum((test_x0-result_metabolism_gm11).^2);
        disp(strcat( '��ͳGM(1,1)����������Ԥ������ƽ����Ϊ', num2str(SSE_tradition)))
        disp(strcat( '����ϢGM(1,1)����������Ԥ������ƽ����Ϊ', num2str(SSE_new_gm11)))
        disp(strcat( '�³´�лGM(1,1)����������Ԥ������ƽ����Ϊ', num2str(SSE_metabolism_gm11)))
        disp(' ')
        disp('���ϵõ���')
        if SSE_tradition < SSE_new_gm11
            if SSE_tradition < SSE_metabolism_gm11
                SSE_min = 1;
                disp(strcat('��ͳGM(1,1)ģ�͵����ƽ������С��ѡ�������Ԥ��'))
            else
                SSE_min = 3;
                disp(strcat('�³´�лGM(1,1)ģ�͵����ƽ������С��ѡ�������Ԥ��'))
            end
        elseif SSE_new_gm11<SSE_metabolism_gm11
            SSE_min = 2;
            disp(strcat('����ϢGM(1,1)ģ�͵����ƽ������С��ѡ�������Ԥ��'))
        else
            SSE_min = 3;
            disp(strcat('�³´�лGM(1,1)ģ�͵����ƽ������С��ѡ�������Ԥ��'))
        end
        
        %% ѡ�������С���Ǹ�ģ�ͽ���Ԥ��
        disp(' ')
        predict_num = input('������ҪԤ��������� ');
        
        % ����ʹ�ô�ͳGMģ�͵Ľ���������õ�����ķ��ر�����x0_hat, ��Բв�relative_residuals�ͼ���ƫ��eta
        [result, x0_hat, relative_residuals, eta] = gm11( x1, predict_num);  % ������gm11�����õ���ԭ������ϵ���ϸ���
        disp(' ')
        
        % �����2��3���ı�ģ��1���������Ԥ����
        if SSE_min == 2
            result = new_gm11( x1, predict_num);
        end
        if SSE_min == 3
            result = metabolism_gm11( x1, predict_num);
        end
        
       %% ���ʹ����ѵ�ģ��Ԥ������Ľ��
        disp(' ')
        disp('��ԭʼ���ݵ���Ͻ����')
        for i = 1:n
            disp(strcat(num2str(year(i)), ' �� ',num2str(x0_hat(i))))
        end
        disp(strcat('����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' �� ',num2str(result(i))))
        end
        
    else
       %% ���ֻ���������ݣ���ô���Ǿ�û��Ҫѡ�����ģ�ͽ���Ԥ�⣬ֱ�Ӷ�����ģ��Ԥ��Ľ����һ��ƽ��ֵ~
        disp('��Ϊֻ��4�����ݣ�����Ҫ��Ϊ�������ʵ����')
        predict_num = input('������ҪԤ��������� ');
        
        disp('��ͳ��GM(1,1)ģ��Ԥ��')
        [result_tradition, x0_hat, relative_residuals, eta] = gm11( x1, predict_num);
        disp(' ')
        disp('����Ϣ��GM(1,1)ģ��Ԥ��')
        result_new_gm11 = new_gm11( x1, predict_num);
        disp(' ')
        disp('�³´�л��GM(1,1)ģ��Ԥ��')
        result_metabolism_gm11 = metabolism_gm11( x1, predict_num);
        disp(' ')
        
        result = (result_tradition+result_new_gm11+result_metabolism_gm11)/3;
        
        disp('��ԭʼ���ݵ���Ͻ����')
        for i = 1:n
            disp(strcat(num2str(year(i)), ' �� ',num2str(x0_hat(i))))
        end
        disp(' ')
        disp(strcat('��ͳGM(1,1)����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' �� ',num2str(result_tradition(i))))
        end
        disp(strcat('����ϢGM(1,1)����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' �� ',num2str(result_new_gm11(i))))
        end
        disp(strcat('�³´�лGM(1,1)����Ԥ��',num2str(predict_num),'�ڵĵõ��Ľ����'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' �� ',num2str(result_metabolism_gm11(i))))
        end
        disp(' ')
        disp('���Ͽɵ� ')
        disp(strcat('���ַ�������Ԥ��',num2str(predict_num),'�ڵõ���ƽ�������'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' �� ',num2str(result(i))))
        end
    end
    
    %% ������Բв�ͼ���ƫ���ͼ��(ע�⣺��Ϊ�Ƕ�ԭʼ���ݵ����Ч����������������ģ�Ͷ���һ����Ŷ~~~)
    figure(4)
    subplot(2,1,1)  % ������ͼ����ͼ�ֿ飩
    plot( year(2:end), relative_residuals, '*-'); % ԭ�����еĸ�ʱ�ں���Բв�
    grid on;   
    legend('��Բв�'); xlabel('���');
    % set(gca,'xtick',year(2:1:end))  % ����x�������ļ��Ϊ1
    subplot(2,1,2)
    plot( year(2:end), eta, 'o-');  % ԭ�����еĸ�ʱ�ںͼ���ƫ��
    grid on;  
    legend('����ƫ��'); xlabel('���');
    % set(gca,'xtick',year(2:1:end))  % ����x�������ļ��Ϊ1
    
    %%
    disp(' ')
    disp('ԭ������ϵ����۽��')
    % �в����
    average_relative_residuals = mean(relative_residuals);  % ����ƽ����Բв� mean����������ֵ
    disp(strcat('ƽ����Բв�Ϊ',num2str(average_relative_residuals)))
    if average_relative_residuals<0.1
        disp('�в����Ľ����������ģ�Ͷ�ԭ���ݵ���ϳ̶Ⱥܺ�')
    elseif average_relative_residuals<0.2
        disp('�в����Ľ����������ģ�Ͷ�ԭ���ݵ���ϳ̶�һ��')
    else
        disp('�в����Ľ����������ģ�Ͷ�ԭ���ݵ���ϳ̶Ȳ�̫��')
    end
    
    % ����ƫ�����
    average_eta = mean(eta);   % ����ƽ������ƫ��
    disp(strcat('ƽ������ƫ��Ϊ',num2str(average_eta)))
    if average_eta<0.1
        disp('����ƫ�����Ľ����������ģ�Ͷ�ԭ���ݵ���ϳ̶Ⱥܺ�')
    elseif average_eta<0.2
        disp('����ƫ�����Ľ����������ģ�Ͷ�ԭ���ݵ���ϳ̶�һ��')
    else
        disp('����ƫ�����Ľ����������ģ�Ͷ�ԭ���ݵ���ϳ̶Ȳ�̫��')
    end
    
    % �������յ�Ԥ��Ч��ͼ
    figure(5)  
    plot( year, x1, '-o',  year, x0_hat, '-*m',  year(end)+1:year(end)+predict_num, result, '-*b' );   
    grid on;
    hold on;
    plot( [year(end),year(end)+1], [x1(end),result(1)], '-*b')
    legend( 'ԭʼ����', '�������', 'Ԥ������') 
    % set(gca,'xtick',[year(1):1:year(end)+predict_num])  % ����x�������ļ��Ϊ1
    xlabel('���');  ylabel('��������');  % ����������ϱ�ǩ
end

