%% ���㵱ǰ���Ӧ�ĳɱ�
% ����
% cpath����ǰ�⾭����ϴ��ֺ�õ���һ��Ԫ�����飬�����洢���������ÿ�������̾����ĳ���
% k���ж��������̹�����
% d��������󣨱����˵�һ��λ�ñ�ʾ��ʼ�ĳ��У�
% ����һ��n�����У���ô��ʼ����Ҫ���ڵ�һ��λ�ã�d��n*n�ľ������
% ���
% cost����ǰ���Ӧ���ܳɱ������������̵�·�̳��ȵ��ܺͣ�
% every_cost��ÿ�������̵ĳɱ���·�̣�

function [cost,every_cost] = calculate_mtsp_cost(cpath,k,d)
% Ҫ�������������̵�·�̳��ȵ��ܺͣ�������Ҫ���ȼ���ÿ�������̵�·�̳���
    every_cost = zeros(k,1);  % ��ʼ��ÿ�������̵�·�̳���ȫΪ0
    for i = 1:k % ��ÿ�������̿�ʼѭ�� 
        path_i = cpath{i};  % ��i����������������·��
        n = length(path_i); % ��i�������̾����ĳ��е�����
        for j = 1:n
            if j == 1
                every_cost(i) = every_cost(i) + d(1,path_i(j)+1);  % һ��Ҫע�⣬d�е�һ��λ�ñ�ʾ��ʼ�ĳ���
            else
                every_cost(i) = every_cost(i) + d(path_i(j-1)+1,path_i(j)+1);
            end
        end
        every_cost(i) = every_cost(i) + d(path_i(end)+1,1); % �����˼��ϴ����һ�����з��ص���ʼ���е�·��
        if n>10
            every_cost(i) = every_cost(i) + (n-10)*10000;
    end
%     cost = sum(every_cost);  % �����ܵĳɱ�
    cost = sum(every_cost)*10 + k*10000;
end
