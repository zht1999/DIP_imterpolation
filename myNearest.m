function im_n=myNearest(im,ratio)
[row, col, channel] = size(im); %�õ�ͼ��ߴ�
row_n=round(row*ratio); %������ͼ��ߴ�
col_n=round(col*ratio);
channel_n=channel;
im_n = zeros(row_n,col_n,channel_n); %�½��洢ͼ��ľ���
im_n = uint8(im_n); %����Ϊ8λ�޷�����������С�洢�ռ�
ratio_row = row/row_n; %��ʵ�����ű���
ratio_col = col/col_n;
%�Կռ任ȡʱ��
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
    map_row=round((i-0.5)*ratio_row+0.5); %�������ͼ��������һ������
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
