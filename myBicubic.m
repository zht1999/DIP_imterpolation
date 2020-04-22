function im_c=myBicubic(im,ratio)
[row, col, channel] = size(im); %µÃµ½Í¼Ïñ³ß´ç
row_n=round(row*ratio);
col_n=round(col*ratio);
channel_n=channel;
im_c = zeros(row_n,col_n,channel_n);
im_c = uint8(im_c);
ratio_row = row/row_n;
ratio_col = col/col_n;
W=zeros(4,4,2);

for i=1:row_n
    map_row=(i-0.5)*ratio_row+0.5;
    up_row = ceil(map_row);
    
    down_row = up_row-1;
    y=map_row-down_row;
    W(1,:,1)=down_row-1;
    W(2,:,1)=down_row;
    W(3,:,1)=up_row;
    W(4,:,1)=up_row+1;
    for j=1:col_n
        map_col=(j-0.5)*ratio_col+0.5;
        up_col = ceil(map_col);
        
        down_col=up_col-1;
        x=map_col-down_col;
        W(:,1,2)=down_col-1;
        W(:,2,2)=down_col;
        W(:,3,2)=up_col;
        W(:,4,2)=up_col+1;
        for m=1:4
            for n=1:4
                if(W(m,n,1)<=0)
                    W(m,n,1)=1;
                elseif(W(m,n,1)>row)
                    W(m,n,1)=row;
                end
                if(W(m,n,2)<=0)
                    W(m,n,2)=1;
                elseif(W(m,n,2)>col)
                    W(m,n,2)=col;
                end     
            end
        end
        for k=1:channel
%             sum_ave=0;
%             for counter_row=1:4
%                 for counter_col=1:4
%                     if(W(counter_row,counter_col,1)>0&&W(counter_row,counter_col,2)>0&&W(counter_row,counter_col,1)<=row&&W(counter_row,counter_col,2)<=col)
%                         sum_ave = sum_ave+single(im(W(counter_row,counter_col,1),W(counter_row,counter_col,2),k))...
%                         *W_x(W(counter_row,counter_col,1)-map_row)*W_x(W(counter_row,counter_col,2)-map_col);
%                         %sum_ave=sum_ave+single(im(W(counter_row,counter_col,1),W(counter_row,counter_col,2),k))/16;
%                     end
%                     
%                 end
%             end
            z1=single(im(W(1,1,1),W(1,1,2),k));
            z2=single(im(W(1,2,1),W(1,2,2),k));
            z3=single(im(W(1,3,1),W(1,3,2),k));
            z4=single(im(W(1,4,1),W(1,4,2),k));
            z5=single(im(W(2,1,1),W(2,1,2),k));
            z6=single(im(W(2,2,1),W(2,2,2),k));
            z7=single(im(W(2,3,1),W(2,3,2),k));
            z8=single(im(W(2,4,1),W(2,4,2),k));
            z9=single(im(W(3,1,1),W(3,1,2),k));
            z10=single(im(W(3,2,1),W(3,2,2),k));
            z11=single(im(W(3,3,1),W(3,3,2),k));
            z12=single(im(W(3,4,1),W(3,4,2),k));
            z13=single(im(W(4,1,1),W(4,1,2),k));
            z14=single(im(W(4,2,1),W(4,2,2),k));
            z15=single(im(W(4,3,1),W(4,3,2),k));
            z16=single(im(W(4,4,1),W(4,4,2),k));
            im_c(i,j,k)=(z1/36 - z2/12 + z3/12 - z4/36 - z5/12 + z6/4 - z7/4 + z8/12 + z9/12 - z10/4 + z11/4 - z12/12 - z13/36 + z14/12 - z15/12 + z16/36)*x^3*y^3 + (z2/4 - z1/12 - z3/4 + z4/12 + z5/6 - z6/2 + z7/2 - z8/6 - z9/12 + z10/4 - z11/4 + z12/12)*x^3*y^2 + (z1/18 - z2/6 + z3/6 - z4/18 + z5/12 - z6/4 + z7/4 - z8/12 - z9/6 + z10/2 - z11/2 + z12/6 + z13/36 - z14/12 + z15/12 - z16/36)*x^3*y + (z6/2 - z5/6 - z7/2 + z8/6)*x^3 + (z2/6 - z1/12 - z3/12 + z5/4 - z6/2 + z7/4 - z9/4 + z10/2 - z11/4 + z13/12 - z14/6 + z15/12)*x^2*y^3 + (z1/4 - z2/2 + z3/4 - z5/2 + z6 - z7/2 + z9/4 - z10/2 + z11/4)*x^2*y^2 + (z2/3 - z1/6 - z3/6 - z5/4 + z6/2 - z7/4 + z9/2 - z10 + z11/2 - z13/12 + z14/6 - z15/12)*x^2*y + (z5/2 - z6 + z7/2)*x^2 + (z1/18 + z2/12 - z3/6 + z4/36 - z5/6 - z6/4 + z7/2 - z8/12 + z9/6 + z10/4 - z11/2 + z12/12 - z13/18 - z14/12 + z15/6 - z16/36)*x*y^3 + (z3/2 - z2/4 - z1/6 - z4/12 + z5/3 + z6/2 - z7 + z8/6 - z9/6 - z10/4 + z11/2 - z12/12)*x*y^2 + (z1/9 + z2/6 - z3/3 + z4/18 + z5/6 + z6/4 - z7/2 + z8/12 - z9/3 - z10/2 + z11 - z12/6 + z13/18 + z14/12 - z15/6 + z16/36)*x*y + (z7 - z6/2 - z5/3 - z8/6)*x + (z6/2 - z2/6 - z10/2 + z14/6)*y^3 + (z2/2 - z6 + z10/2)*y^2 + (z10 - z6/2 - z2/3 - z14/6)*y + z6;
        end
    end

end
