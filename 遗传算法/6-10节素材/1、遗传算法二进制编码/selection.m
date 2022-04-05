function [dad, mom] = selection(pop, fit)

%% �����ۼӸ���
PP = cumsum( fit ./ sum(fit) );

row = size(pop, 1);

%% ѡ���row��ĸ����row�����������̶ķ�
for i = 1:row
    for j = 1:row
        r = rand;
        if r <= PP(j)
            dad(i,:) = pop(j,:);
            break;
        end
    end
    mom(i,:) = pop(randi([1 row]),:);
end
            
    