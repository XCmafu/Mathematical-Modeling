function h = show_plaza(plaza, h, n)
% show_plaza 将总道路矩阵转化为图片
% plaza = 总道路矩阵
% 1 = 有车, 0 = 为空, -1 = 非道路, -3 = 收费站
% h = 句柄
% n = 时间间隔
[L,W] = size(plaza); % L:道路总长度， W：14=12+2 
temp = plaza; % 构造临时矩阵
temp(temp==1) = 0; % ！！！

PLAZA(:,:,1) = plaza; % 构造三维矩阵
PLAZA(:,:,2) = plaza;
PLAZA(:,:,3) = temp;  

 PLAZA = 1-PLAZA; % 调灰度，0(目前没有，有车，蓝色)，1（无车，白色），2（非道路），4（收费站）   
 PLAZA(PLAZA>1) = PLAZA(PLAZA>1)/6;  % 0(目前没有，有车，蓝色)，1（无车，白色），0.333（非道路），0.666 （收费站）
 
if ishandle(h) % 有效图形测试
    set(h, 'CData', PLAZA)     
    pause(n)     % 暂时停止执行
else
    figure('position', [100,50,200,700] ) % 图片显示的位置 [left bottom width height]
    h = image(PLAZA);  % RGB画图 
    hold on
    % 画网格线
    plot([[0:W]',[0:W]']+0.5,[0,L]+0.5,'k') 
    plot([0,W]+0.5,[[0:L]',[0:L]']+0.5,'k')
%     axis image
%     set(gca, 'xtick', [], 'ytick', []);  
    pause(n)
end