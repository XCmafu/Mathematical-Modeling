%% ��ȡ��Ƶ
video = VideoReader('Ѹ����Ƶת����ת�������������.mp4');  
frame_number = video.NumberOfFrames; %��Ƶ����֡��

%% ����ͼƬ
for i = 1:30:frame_number   % ÿ30֡������һ��
    Photo = read( video, i);  % ������Ӧ֡��ͼƬ
    image_name = strcat( 'E:\��ģ\����\����ֵ�ֽ�svd\��Ƶѹ��\photo\', num2str(i), '.jpg');  % ָ��λ�ú�����
    imwrite( Photo, image_name);      % ͼƬ����
end