function []= Photo_compress( photo_address, save_address, ratio, ifgray)
    % 函数作用：SVD对图形进行压缩
    
    %     photo_address：要压缩的图片存放的位置
    %     save_address：将压缩后的图片保存的位置
    %     ratio：要保留原矩阵的特征比例
    %     greycompress: 如果该值等于1，则会彩色的原图片转换为灰色图片后再压缩；默认值为0，表示不进行转换

    if nargin == 3  % 判断用户输入的参数，如果只输入了前三个参数，则greycompress=0
        ifgray = 0;
    end
    
    img = double(imread(photo_address));
    % 图片保存的对象是 'uint8' 类型，需要将其转换为double类型才能进行奇异值分解的操作
    % 注意:  img是图形的像素矩阵，如果是彩色图片则是三维矩阵，如果是灰色图片(R=G=B)则是二维矩阵
    % 灰色的图片，得到的img类型是[m×n]double
    % 彩色的图片，得到的img类型是[m×n×3]double
    % 灰色图片的只有两个维度，所以size(img ,3) == 1
 
    if (ifgray == 1) && (size(img ,3) == 3)  % 图片为彩色，greycompress=1，则彩色转换为灰色后再压缩
        img = double(rgb2gray(imread(photo_address)));    % rgb2gray函数将彩色图片转换为灰色图片, 注意：输入的变量要为默认的'uint8' 类型的图片对象
    end  

    if size( img, 3) == 3   % 彩色图片
        R = img(:,:,1);       % 红色
        G = img(:,:,2);       % 绿色
        B = img(:,:,3);       % 蓝色
        
        r = svd_custom( R, ratio);  % 调用自定义函数将R矩阵压缩成r
        g = svd_custom( G, ratio); % 调用自定义函数将G矩阵压缩成g
        b = svd_custom( B, ratio); % 调用自定义函数将B矩阵压缩成b
        
        compress_img = cat( 3, r, g, b);  % 根据三个RGB矩阵（压缩后的r、g、b）生成图片对象
        
    else  % 灰色图片
        compress_img = svd_custom( img, ratio);  %如果是灰色图片的话，直接压缩img矩阵就好了
    end

    % 将压缩后的图片保存
    imwrite( uint8(compress_img), save_address);   % 重新转换为uint8类型

end

