function [compress_A] = svd_custom( A, ratio)
    % 函数作用：使用奇异值分解将矩阵A压缩到指定的特征比例
    
    %     A：要压缩的矩阵
    %     ratio：要保留原矩阵的特征比例
    
    %     compress_A: 压缩后的矩阵
    [U,S,V] = svd(A);  
    x = diag(S);  % diag函数可以返回S的主对角线元素，即矩阵A的奇异值，并将其保存到列向量中
    SUM = sum(x);  % 计算所有奇异值的总和
    temp = 0;   
    for  i = 1:length(x)  % 循环
        temp = temp+x(i);  % 每循环一次，就更新temp的值为原来的temp值+接下来的一个奇异值
        if (temp/SUM) > ratio  % 如果现在的比例超过了ratio,就退出循环
            break
        end
    end
    disp(['压缩后实际保留原矩阵的比例特征为：',num2str(roundn(100*temp/SUM,-2)),'%'])  
    compress_A = U(:,1:i)*S(1:i,1:i)*V(:,1:i)';
end

