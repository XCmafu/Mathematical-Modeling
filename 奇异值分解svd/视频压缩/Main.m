%% 读取视频
video = VideoReader('迅捷视频转换器转换后的新闻联播.mp4');  
frame_number = video.NumberOfFrames; %视频的总帧数

%% 分离图片
for i = 1:30:frame_number   % 每30帧数保存一次
    Photo = read( video, i);  % 读出对应帧的图片
    image_name = strcat( 'E:\数模\代码\奇异值分解svd\视频压缩\photo\', num2str(i), '.jpg');  % 指定位置和名字
    imwrite( Photo, image_name);      % 图片保存
end