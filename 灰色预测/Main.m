%%  输入原始数据并做出时间序列图
clear;clc

year = [1995:1:2004]';  % 横坐标表示年份，写成列向量的形式
x1 = [174,179,183,189,207,234,220.5,256,270,285]';  % 原始数据序列，写成列向量的形式

% 画出原始数据的时间序列图
figure(1); 
plot( year, x1, 'o-'); 
grid on;
% set(gca,'xtick',year(1:1:end))  % 设置x轴横坐标的间隔为1
xlabel('年份');  ylabel('排污总量');  % 坐标轴加标签


%% GM(1,1)模型，其适用于数据期数较短的非负时间序列
n = length(x1);
ERROR = 0;  % 建立一个错误指标，出错就为1
% % 判断是否有负数元素
% if sum(x1<0) > 0  
%     disp('灰色预测的时间序列中有负数')
%     ERROR = 1;
% end
% 
% % 判断数据量是否太少
% n = length(x1);  % 计算原始数据的长度
% disp(strcat('原始数据的长度为',num2str(n)))    % strcat()是连接字符串的函数，第一讲学了，可别忘了哦
% if n<=3
%     disp('数据量太小')
%     ERROR = 1;
% end
% 
% % 数据太多时提示可考虑使用其他方法（不报错）
% if n>10
%     disp('数据量较多')
% end


%% 判断数据是否为列向量，如果输入的是行向量则转置为列向量
if size( x1, 1) == 1
    x1 = x1';
end
if size( year, 1) == 1
    year = year';
end


%% 对一次累加后的数据进行准指数规律的检验(注意，这个检验有时候即使能通过，也不一定能保证预测结果非常好)
if ERROR == 0   
    disp('准指数规律检验：')
    x2 = cumsum(x1);   % 累加   
    rho = x1(2:end) ./ x2(1:end-1);   % 计算光滑度rho(k) = x0(k)/x1(k-1)
    
    % 画出光滑度的图形，并画上0.5的直线，表示临界值
    figure(2)
%     rho1 = [0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5,0.5];
%     plot( year(2:end), rho, 'o-', year(2:end), rho1, '-');
    plot( year(2:end), rho, 'o-', [year(2),year(end)], [0.5,0.5], '-'); 
    grid on;
    text( year(end), 0.5, '临界线')
    % set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    xlabel('年份'); ylabel('原始数据的光滑度');  % 给坐标轴加上标签
    
    disp(strcat('指标1：光滑比小于0.5的数据占比为',num2str(sum(rho<0.5)/(n-1)*100),'%'))
    disp(strcat('指标2：除去前两个时期外，光滑比小于0.5的数据占比为',num2str(sum(rho(3:end)<0.5)/(n-3)*100),'%'))
%     P1 = sum(rho<0.5)/(n-1)*100;
%     P2 = sum(rho(3:end)<0.5)/(n-3)*100;
%     if P1>0.6 && P2>0.9
%         ERROR = 0;
%     else
%         ERROR = 1;
    
    judge = input('参考标准：指标1一般大于60%, 指标2大于90%。你认为本例数据可以通过检验吗？可以通过请输入1，不能请输入0：');
    if judge == 0
        disp('不认可，结束。')
        ERROR = 1;
    else
        disp('认可，继续下一步。')
    end
    
end
disp(' ')


%% 
if ERROR == 0   
    if  n > 4  % 数据量大于4时，将数据分为训练组和试验组(根据原数据量大小n来取，n为5-7个则取最后两年为试验组，n大于7则取最后三年为试验组)
       %% disp('因为原数据的期数大于4，所以我们可以将数据组分为训练组和试验组')
        
        if n > 7
            test_num = 3;
        else
            test_num = 2;
        end
        
        disp('训练数据是: ')
        train_x0 = x1(1:end-test_num)  % 训练数据 
        disp('试验数据是: ')
        test_x0 = x1(end-test_num+1:end) % 试验数据
        
        % 使用三种模型对训练数据进行训练，返回的result就是往后预测test_num期的数据
        disp(' ')
        disp('传统的GM(1,1)模型预测：')
        result_tradition = gm11( train_x0, test_num); % 传统的GM(1,1)模型对训练数据，并预测后test_num期的结果
        disp(' ')
        disp('新信息的GM(1,1)模型预测：')
        result_new_gm11 = new_gm11( train_x0, test_num); % 新信息GM(1,1)模型对训练数据，并预测后test_num期的结果
        disp(' ')
        disp('新陈代谢的GM(1,1)模型预测：')
        result_metabolism_gm11 = metabolism_gm11( train_x0, test_num); % 新陈代谢GM(1,1)模型对训练数据，并预测后test_num期的结果
        disp(' ')
        
        % 比较三种模型对于试验数据的预测结果，绘制试验数据进行预测的图形
        test_year = year(end-test_num+1:end);  % 试验组对应的年份
        figure(3)
        plot( test_year, test_x0, 'o-', test_year, result_tradition, '*-', test_year, result_new_gm11, '+-', test_year, result_metabolism_gm11, 'x-'); 
        grid on;
        % set(gca,'xtick',year(end-test_num+1): 1 :year(end))  % 设置x轴横坐标的间隔为1
        legend( '试验组的真实数据', '传统GM(1,1)预测结果', '新信息GM(1,1)预测结果', '新陈代谢GM(1,1)预测结果') 
        xlabel('年份');  ylabel('排污总量');  % 给坐标轴加上标签
        % 计算误差平方和SSE
        SSE_tradition = sum((test_x0-result_tradition).^2);
        SSE_new_gm11 = sum((test_x0-result_new_gm11).^2);
        SSE_metabolism_gm11 = sum((test_x0-result_metabolism_gm11).^2);
        disp(strcat( '传统GM(1,1)对于试验组预测的误差平方和为', num2str(SSE_tradition)))
        disp(strcat( '新信息GM(1,1)对于试验组预测的误差平方和为', num2str(SSE_new_gm11)))
        disp(strcat( '新陈代谢GM(1,1)对于试验组预测的误差平方和为', num2str(SSE_metabolism_gm11)))
        disp(' ')
        disp('综上得到：')
        if SSE_tradition < SSE_new_gm11
            if SSE_tradition < SSE_metabolism_gm11
                SSE_min = 1;
                disp(strcat('传统GM(1,1)模型的误差平方和最小，选择其进行预测'))
            else
                SSE_min = 3;
                disp(strcat('新陈代谢GM(1,1)模型的误差平方和最小，选择其进行预测'))
            end
        elseif SSE_new_gm11<SSE_metabolism_gm11
            SSE_min = 2;
            disp(strcat('新信息GM(1,1)模型的误差平方和最小，选择其进行预测'))
        else
            SSE_min = 3;
            disp(strcat('新陈代谢GM(1,1)模型的误差平方和最小，选择其进行预测'))
        end
        
        %% 选用误差最小的那个模型进行预测
        disp(' ')
        predict_num = input('请输入要预测的数量： ');
        
        % 计算使用传统GM模型的结果，用来得到另外的返回变量：x0_hat, 相对残差relative_residuals和级比偏差eta
        [result, x0_hat, relative_residuals, eta] = gm11( x1, predict_num);  % 先利用gm11函数得到对原数据拟合的详细结果
        disp(' ')
        
        % 如果是2或3，改变模型1计算出来的预测结果
        if SSE_min == 2
            result = new_gm11( x1, predict_num);
        end
        if SSE_min == 3
            result = metabolism_gm11( x1, predict_num);
        end
        
       %% 输出使用最佳的模型预测出来的结果
        disp(' ')
        disp('对原始数据的拟合结果：')
        for i = 1:n
            disp(strcat(num2str(year(i)), ' ： ',num2str(x0_hat(i))))
        end
        disp(strcat('往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result(i))))
        end
        
    else
       %% 如果只有四期数据，那么我们就没必要选择何种模型进行预测，直接对三种模型预测的结果求一个平均值~
        disp('因为只有4组数据，不需要分为测试组和实验组')
        predict_num = input('请输入要预测的数量： ');
        
        disp('传统的GM(1,1)模型预测')
        [result_tradition, x0_hat, relative_residuals, eta] = gm11( x1, predict_num);
        disp(' ')
        disp('新信息的GM(1,1)模型预测')
        result_new_gm11 = new_gm11( x1, predict_num);
        disp(' ')
        disp('新陈代谢的GM(1,1)模型预测')
        result_metabolism_gm11 = metabolism_gm11( x1, predict_num);
        disp(' ')
        
        result = (result_tradition+result_new_gm11+result_metabolism_gm11)/3;
        
        disp('对原始数据的拟合结果：')
        for i = 1:n
            disp(strcat(num2str(year(i)), ' ： ',num2str(x0_hat(i))))
        end
        disp(' ')
        disp(strcat('传统GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result_tradition(i))))
        end
        disp(strcat('新信息GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result_new_gm11(i))))
        end
        disp(strcat('新陈代谢GM(1,1)往后预测',num2str(predict_num),'期的得到的结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result_metabolism_gm11(i))))
        end
        disp(' ')
        disp('综上可得 ')
        disp(strcat('三种方法往后预测',num2str(predict_num),'期得到的平均结果：'))
        for i = 1:predict_num
            disp(strcat(num2str(year(end)+i), ' ： ',num2str(result(i))))
        end
    end
    
    %% 绘制相对残差和级比偏差的图形(注意：因为是对原始数据的拟合效果评估，所以三个模型都是一样的哦~~~)
    figure(4)
    subplot(2,1,1)  % 绘制子图（将图分块）
    plot( year(2:end), relative_residuals, '*-'); % 原数据中的各时期和相对残差
    grid on;   
    legend('相对残差'); xlabel('年份');
    % set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    subplot(2,1,2)
    plot( year(2:end), eta, 'o-');  % 原数据中的各时期和级比偏差
    grid on;  
    legend('级比偏差'); xlabel('年份');
    % set(gca,'xtick',year(2:1:end))  % 设置x轴横坐标的间隔为1
    
    %%
    disp(' ')
    disp('原数据拟合的评价结果')
    % 残差检验
    average_relative_residuals = mean(relative_residuals);  % 计算平均相对残差 mean函数用来均值
    disp(strcat('平均相对残差为',num2str(average_relative_residuals)))
    if average_relative_residuals<0.1
        disp('残差检验的结果表明：该模型对原数据的拟合程度很好')
    elseif average_relative_residuals<0.2
        disp('残差检验的结果表明：该模型对原数据的拟合程度一般')
    else
        disp('残差检验的结果表明：该模型对原数据的拟合程度不太好')
    end
    
    % 级比偏差检验
    average_eta = mean(eta);   % 计算平均级比偏差
    disp(strcat('平均级比偏差为',num2str(average_eta)))
    if average_eta<0.1
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度很好')
    elseif average_eta<0.2
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度一般')
    else
        disp('级比偏差检验的结果表明：该模型对原数据的拟合程度不太好')
    end
    
    % 绘制最终的预测效果图
    figure(5)  
    plot( year, x1, '-o',  year, x0_hat, '-*m',  year(end)+1:year(end)+predict_num, result, '-*b' );   
    grid on;
    hold on;
    plot( [year(end),year(end)+1], [x1(end),result(1)], '-*b')
    legend( '原始数据', '拟合数据', '预测数据') 
    % set(gca,'xtick',[year(1):1:year(end)+predict_num])  % 设置x轴横坐标的间隔为1
    xlabel('年份');  ylabel('排污总量');  % 给坐标轴加上标签
end

