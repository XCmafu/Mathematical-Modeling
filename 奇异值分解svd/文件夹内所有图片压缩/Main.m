file_name = '��«�����ֵ�';  % �ļ��е�ַ����д���Ե�ַ 
file_save_name = 'E:\��ģ\����\����ֵ�ֽ�svd\�ļ���������ͼƬѹ��\��«�����ֵ�\Compress\';
dirOutput = dir(fullfile( file_name, '*.jpg'));  % ����Ϊfile_name���ļ������ҵ�������jpg��β���ļ� 

file = {dirOutput.name};  % �������е��ļ������浽һ��Ԫ��������
n = length(file);  % ͼƬ������
ratio = 0.9;  % Ҫ��������������

for i = 1:n 
    name = file(i);   
    Name = name{1};  
    
    photo_address = fullfile( file_name, Name);  % ͼƬ��ַ
    save_address = fullfile( file_save_name, strcat('compress_',Name));  % �����ַ
    
    Photo_compress( photo_address, save_address, ratio)
end