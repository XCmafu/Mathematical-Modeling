function [result] = Positive( p_column, type, m)
% ���������������
% m����Ҫ���򻯴����ָ���Ӧ��ԭʼ������
% type�� ָ������ͣ�1����С�ͣ� 2���м��ͣ� 3�������ͣ�
% p_column: ���ڴ������ԭʼ�����е���һ��
% �������result��ʾ�����򻯺��������
    if type == 1  %��С��
        disp(['��' num2str(p_column) '�м�С������'] )
        result = Min_Max(m); 
        disp('-----')
    elseif type == 2  %�м���
        disp(['��' num2str(p_column) '���м�������'] )
        best = input('��������ѵ���һ��ֵ�� ');
        result = Mid_Max( m, best);
        disp('-----')
    elseif type == 3  %������
        disp(['��' num2str(p_column) '������������'] )
        up = input('������������Ͻ磺 ');
        low = input('������������½磺 '); 
        result = Interval_Max( m, up, low);
        disp('-----')
    end
end