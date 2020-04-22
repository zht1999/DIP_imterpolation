%% 请大家完成三个插值算法函数 myNearest.m、myBilinear.m、myCubic.m，然后将本主程序中的变量
%% filename设置为不同值（'lenna'、'cameraman'、'building'），运行main.m，即可得到插值结果
%%
clc; 
clear;
close all;

%%
ratio_1 = 0.5; % 缩放因子1
ratio_2 = 2;   % 缩放因子2
% filename = 'lenna'; %测试图像1
 filename = 'cameraman'; %测试图像2
% filename = 'building'; %测试图像3

im = imread([filename, '.jpg']);
[row, col, channel] = size(im); %得到图像尺寸
im_center = im(floor(row*3/8):floor(row*5/8), floor(col*3/8):floor(col*5/8), :); %截取中间图像块，用于图像放大

 %% 将图像长宽缩放为原图的 ratio_1 (<1)倍
 im1_n = myNearest(im, ratio_1);
 im1_b = myBilinear(im, ratio_1);
 im1_c = myBicubic(im, ratio_1);
 
%% 将图像长宽缩放为原图的 ratio_2 (>1)倍
im2_n = myNearest(im_center, ratio_2);
im2_b = myBilinear(im_center, ratio_2);
im2_c = myBicubic(im_center, ratio_2);

%% 将结果保存到当前目录下的result文件夹下
imwrite(im1_n, sprintf('result/_%s_%.1f_n.jpg', filename, ratio_1));
imwrite(im1_b, sprintf('result/_%s_%.1f_b.jpg', filename, ratio_1));
imwrite(im1_c, sprintf('result/_%s_%.1f_c.jpg', filename, ratio_1));
imwrite(im2_n, sprintf('result/_%s_%.1f_n.jpg', filename, ratio_2));
imwrite(im2_b, sprintf('result/_%s_%.1f_b.jpg', filename, ratio_2));
imwrite(im2_c, sprintf('result/_%s_%.1f_c.jpg', filename, ratio_2));

%% 显示结果
figure(1); 
subplot(221); imshow(im); title('原图'); axis on
subplot(222); imshow(im1_n); title('最近邻内插图像'); axis on
subplot(223); imshow(im1_b); title('双线性内插图像'); axis on
subplot(224); imshow(im1_c); title('双立方内插图像'); axis on

figure(2);
subplot(221); imshow(im_center); title('原图'); axis on
subplot(222); imshow(im2_n); title('最近邻内插图像'); axis on
subplot(223); imshow(im2_b); title('双线性内插图像'); axis on
subplot(224); imshow(im2_c); title('双立方内插图像'); axis on