img=imread("bird2.jpg");



%_________Without builtin function_____
%{
img=imread("bird2.jpg");
img=imresize(img,[3,3]);
img=imrotate(img,90);
imshow(img);
%}


angle=input('Enter rotation degree 90 or 180 or 270 or 360 :');
[row,col,cp]=size(img); %cp =color part,3x3 matrix

%columns become rows
if angle==90
    rotate_img=zeros(row,col,cp,'uint8');
    for k=1:cp
      for i=1:row
        for j=1:col
            rotate_img(j,row-i+1,k)=img(i,j,k);
            %rotate_img(j,row+i+1,k)=img(i,j,k);


        end
     end
    end


elseif angle==270 || angle==-90
    rotate_img=zeros(row,col,cp,'uint8');
    for k=1:cp
      for i=1:row
        for j=1:col
            rotate_img(j,row+i+1,k)=img(i,j,k);


        end
     end
    end




%flipping both rows and columns
elseif angle==180 || angle==360
    rotate_img=zeros(row,col,cp,'uint8');
    for k=1:cp
      for i=1:row
        for j=1:col
            rotate_img(row-i+1,col-j+1,k)=img(i,j,k);
        end
       end
    end


else 
    error('enter 90 or 180 ');
end


figure;
subplot(2,2,1),imshow(img),title('original image');

if angle==90
    subplot(2,2,2),imshow(rotate_img),title('90 Degree image');
else
    subplot(2,2,2),imshow(rotate_img),title('180 Degree image');

end