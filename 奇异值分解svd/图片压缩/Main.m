% 自己定义要压缩的图片

Photo_compress( '赫本.jpg', 'compress_赫本1.jpg', 0.5);
Photo_compress( '赫本.jpg', 'compress_赫本2.jpg', 0.7);
Photo_compress( '赫本.jpg', 'compress_赫本3.jpg', 0.9);
Photo_compress( '千与千寻.jpg', 'compress_千与千寻.jpg', 0.8) ;
Photo_compress( '千与千寻.jpg', 'compress_gray_千与千寻.jpg', 0.8, 1); % 先转换为灰色图片后再压缩 

Photo_compress( '1.jpeg', 'compress_1.jpeg', 0.9);
Photo_compress( '2.jpeg', 'compress_2.jpeg', 0.9);
Photo_compress( '3.jpg', 'compress_3.jpg', 0.9);