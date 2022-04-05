file_name = '葫芦娃七兄弟';  % 文件夹地址，可写绝对地址 
file_save_name = 'E:\数模\代码\奇异值分解svd\文件夹内所有图片压缩\葫芦娃七兄弟\Compress\';
dirOutput = dir(fullfile( file_name, '*.jpg'));  % 在名为file_name的文件夹下找到所有以jpg结尾的文件 

file = {dirOutput.name};  % 将数组中的文件名保存到一个元胞数组中
n = length(file);  % 图片的总数
ratio = 0.9;  % 要保留的特征比例

for i = 1:n 
    name = file(i);   
    Name = name{1};  
    
    photo_address = fullfile( file_name, Name);  % 图片地址
    save_address = fullfile( file_save_name, strcat('compress_',Name));  % 保存地址
    
    Photo_compress( photo_address, save_address, ratio)
end