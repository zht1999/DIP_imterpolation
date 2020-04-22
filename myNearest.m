function im_n=myNearest(im,ratio)
[row, col, channel] = size(im); %得到图像尺寸
row_n=round(row*ratio); %处理后的图像尺寸
col_n=round(col*ratio);
channel_n=channel;
im_n = zeros(row_n,col_n,channel_n); %新建存储图像的矩阵
im_n = uint8(im_n); %设置为8位无符号整数，减小存储空间
ratio_row = row/row_n; %真实的缩放比例
ratio_col = col/col_n;
%以空间换取时间
map_col=zeros(col_n);
map_col=uint8(map_col);
for j=1:col_n
    map_col(j)=round((j-0.5)*ratio_col+0.5);
    if(map_col(j)<=0)
        map_col(j)=1;
    elseif(map_col(j)>col)
        map_col(j)=col;
    end
end
for i=1:row_n
    map_row=round((i-0.5)*ratio_row+0.5); %对数组和图像坐标做一个修正
    if(map_row<=0)
        map_row=1;
    elseif(map_row>row)
        map_row=row;
    end
    for j=1:col_n
%         map_col=round((j-0.5)*ratio_col+0.5);
%         if(map_col<=0)
%             map_col=1;
%         elseif(map_col>col)
%             map_col=col;
%         end
        for k=1:channel
            im_n(i,j,k)=im(map_row,map_col(j),k);
        end
    end
end
