function im_b=myBilinear(im,ratio)
[row, col, channel] = size(im); %µÃµ½Í¼Ïñ³ß´ç
row_n=round(row*ratio);
col_n=round(col*ratio);
channel_n=channel;
im_b = zeros(row_n,col_n,channel_n);
im_b = uint8(im_b);

ratio_row = row/row_n;
ratio_col = col/col_n;
%map_col=zeros(col_n);
up_col=zeros(col_n);
up_col=uint8(up_col);
down_col=zeros(col_n);
down_col=uint8(down_col);
coef_left_col=zeros(col_n);
coef_left_col=single(coef_left_col);
%coef_right_col=zeros(col_n);
for j=1:col_n
    map_col=(j-0.5)*ratio_col+0.5;
    up_col(j) = ceil(map_col);
    if(up_col(j)>col)
        up_col(j)=col;
    end
    coef_left_col(j) = up_col(j) - map_col;
    down_col(j) = up_col(j)-1;
    if(down_col(j)<=0)
        down_col(j)=1;
    end
%    coef_right_col(j) = 1 - coef_left_col(j);
end

for i=1:row_n
    map_row=(i-0.5)*ratio_row+0.5;
    up_row = ceil(map_row);
    if(up_row>row)
        up_row=row;
    end
    coef_top_row = up_row - map_row;
    down_row = up_row-1;
    if(down_row<=0)
        down_row=1;
    end
%    coef_bottom_row = 1 - coef_top_row;
    for j=1:col_n
%         map_col=(j-0.5)*ratio_col+0.5;
%         up_col = ceil(map_col);
%         if(up_col>col)
%             up_col=col;
%         end
%         coef_left_col = up_col - map_col;
%         down_col = up_col-1;
%         if(down_col<=0)
%             down_col=1;
%         end
%         coef_right_col = 1 - coef_left_col;
        for k=1:channel
            value_lefttop = single(im(down_row,down_col(j),k));
            value_leftbottom = single(im(up_row,down_col(j),k));
            value_rightbottom = single(im(up_row,up_col(j),k));
            value_righttop = single(im(down_row,up_col(j),k));
%             a1=single(value_lefttop)*coef_left_col*coef_top_row;
%             a2=single(value_leftbottom)*coef_left_col*coef_bottom_row;
%             a3=single(value_rightbottom)*coef_bottom_row*coef_right_col;
%             a4=single(value_righttop)*coef_right_col*coef_top_row;
%             a=a1+a2+a3+a4;

%             im_b(i,j,k)=(single(value_lefttop)+single(value_leftbottom)+single(value_rightbottom)+single(value_righttop))/4;
%             im_b(i,j,k) = value_lefttop*cof_left_col*cof_top_row + value_leftbottom*cof_left_col*cof_bottom_row + value_rightbottom*cof_bottom_row*cof_right_col + value_righttop*cof_right_col*cof_top_row;
             im_b(i,j,k)=(value_lefttop+value_rightbottom-value_leftbottom-value_righttop)*coef_left_col(j)*coef_top_row...
                 +(value_leftbottom-value_rightbottom)*coef_left_col(j)...
                 +(value_righttop-value_rightbottom)*coef_top_row...
                 +value_rightbottom;
        end
    end
end
