function [distances,way] = Floyd(M)
%% ����Floydԭ�������������ڵ�֮������·��

%        M����֪Ȩ�صľ���

%        distances�����·��ֵ������Ԫ��dist_ij��ʾ��ʾi,j�����ڵ����̾���
%        way�����·��������Ԫ��path_ij��ʾ���Ϊi���յ�Ϊj�������ڵ�֮������·��Ҫ�����Ľڵ�

%% 
n = size(M,1);  % ����ڵ�ĸ���

distances = M;  % ��ʼ�����·��ֵ����

way = zeros(n);  % ��ʼ�����·������
for a = 1:n
    way( :, a) = a;   % ����i�е�Ԫ�ر�Ϊj
end
for b = 1:n
    way( b, b) = -1;  % ���Խ���Ԫ�ر�Ϊ-1
end

% Floyd�㷨ԭ��
for i = 1:n    
   for j = 1:n     
      for k = 1:n    
          if distances( j, k) > distances( j, i) + distances( i, k)  
              % �ж�j,k���ڵ�����·��ֵ�Ƿ� > i��j�����·��ֵ��i��k�����·��ֵ֮��
              % �����Ļ��������������϶̵ľ���֮��ȡ��j,k����֮������·��ֵ
             distances( j, k) = distances( j, i) + distances( i, k);  
             way( j, k) = way( j, i);   % ����way
          end
      end
   end
end

end

