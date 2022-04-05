function []= Photo_compress( photo_address, save_address, ratio, ifgray)
    % �������ã�SVD��ͼ�ν���ѹ��
    
    %     photo_address��Ҫѹ����ͼƬ��ŵ�λ��
    %     save_address����ѹ�����ͼƬ�����λ��
    %     ratio��Ҫ����ԭ�������������
    %     greycompress: �����ֵ����1������ɫ��ԭͼƬת��Ϊ��ɫͼƬ����ѹ����Ĭ��ֵΪ0����ʾ������ת��

    if nargin == 3  % �ж��û�����Ĳ��������ֻ������ǰ������������greycompress=0
        ifgray = 0;
    end
    
    img = double(imread(photo_address));
    % ͼƬ����Ķ����� 'uint8' ���ͣ���Ҫ����ת��Ϊdouble���Ͳ��ܽ�������ֵ�ֽ�Ĳ���
    % ע��:  img��ͼ�ε����ؾ�������ǲ�ɫͼƬ������ά��������ǻ�ɫͼƬ(R=G=B)���Ƕ�ά����
    % ��ɫ��ͼƬ���õ���img������[m��n]double
    % ��ɫ��ͼƬ���õ���img������[m��n��3]double
    % ��ɫͼƬ��ֻ������ά�ȣ�����size(img ,3) == 1
 
    if (ifgray == 1) && (size(img ,3) == 3)  % ͼƬΪ��ɫ��greycompress=1�����ɫת��Ϊ��ɫ����ѹ��
        img = double(rgb2gray(imread(photo_address)));    % rgb2gray��������ɫͼƬת��Ϊ��ɫͼƬ, ע�⣺����ı���ҪΪĬ�ϵ�'uint8' ���͵�ͼƬ����
    end  

    if size( img, 3) == 3   % ��ɫͼƬ
        R = img(:,:,1);       % ��ɫ
        G = img(:,:,2);       % ��ɫ
        B = img(:,:,3);       % ��ɫ
        
        r = svd_custom( R, ratio);  % �����Զ��庯����R����ѹ����r
        g = svd_custom( G, ratio); % �����Զ��庯����G����ѹ����g
        b = svd_custom( B, ratio); % �����Զ��庯����B����ѹ����b
        
        compress_img = cat( 3, r, g, b);  % ��������RGB����ѹ�����r��g��b������ͼƬ����
        
    else  % ��ɫͼƬ
        compress_img = svd_custom( img, ratio);  %����ǻ�ɫͼƬ�Ļ���ֱ��ѹ��img����ͺ���
    end

    % ��ѹ�����ͼƬ����
    imwrite( uint8(compress_img), save_address);   % ����ת��Ϊuint8����

end

