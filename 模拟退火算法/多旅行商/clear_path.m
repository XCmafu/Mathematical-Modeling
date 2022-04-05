%% clear_path函数用来对原来的解进行分割，中间的0就是分割的位置
% 输入
% path：原来的解，是一个向量，中间的0表示分割的位置
% salesman_num：旅行商数量（不一定都分配工作哦）
% 输出
% cpath：一个元胞数组，用来存储参与运输的每个旅行商经过的城市
% k：有多少旅行商工作了
function [cpath,k] = clear_path(path,salesman_num)
    cpath = cell(salesman_num,1);    % 新建一个元胞数组，用来存储参与工作的每个旅行商经过的城市
    ind = find(path==0);      % 找到所有分割点的位置
    k = 1;      % 初始化计数器，k表示参与工作的旅行商数
    for i = 1:salesman_num-1 % 一共salesman_num-1个分割点，我们开始循环
        if i == 1  % 如果是第1个分割点
            c = path(1:ind(i)-1);  % 提取第一个旅行商经过的城市
        else
            c = path(ind(i-1)+1:ind(i)-1);   % 提取中间的旅行商所经过的城市
        end
        if ~isempty(c)  % 只有c非空的话才保存到cpath中（注意～符号表示取反的意思）
            cpath{k} = c;  % 把c保存到元胞cpath的第k个位置
            k = k+1;       % 参与工作的旅行商数目加1
        end
    end
    % 别忘了从最后一个分割点哦，它和第1个分割点一样，需要单独讨论
    c = path(ind(end)+1:end);    % 提取最后一个旅行商经过的城市
    if ~isempty(c)  % 只有c非空的话才保存到cpath中
       cpath{k} = c;  % 把c保存到元胞cpath的第k个位置
    else
        k = k - 1;
    end
    cpath = cpath(1:k); % 只保留元胞中前k个非空的部分
end

